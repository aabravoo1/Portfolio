/*
   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/

#include <stdint.h>
#include <string.h>
#include <stdbool.h>
#include "freertos/xtensa_api.h"
#include "freertos/FreeRTOSConfig.h"
#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"
#include "freertos/task.h"
#include "esp_log.h"
#include "bt_app_core.h"
#include "driver/i2s.h"
#include "freertos/ringbuf.h"
#include <math.h>
#include "esp_dsp.h"
#include "fdacoefs.h"
#include "coeff.h"


static void bt_app_task_handler(void *arg);
static bool bt_app_send_msg(bt_app_msg_t *msg);
static void bt_app_work_dispatched(bt_app_msg_t *msg);

static xQueueHandle s_bt_app_task_queue = NULL;
static xTaskHandle s_bt_app_task_handle = NULL;
static xTaskHandle s_bt_i2s_task_handle = NULL;
static xTaskHandle s_i2s_dac_writter_task = NULL;
static RingbufHandle_t s_ringbuf_i2s = NULL;

static fir_f32_t myfirL, myfirR;

//static float statesl[51], statesr[51];
static float statesl[COEFF_L], statesr[COEFF_L];

static float tempinl[2048], tempoutl[2048];
static float tempinr[2048], tempoutr[2048];

bool bt_app_work_dispatch(bt_app_cb_t p_cback, uint16_t event, void *p_params, int param_len, bt_app_copy_cb_t p_copy_cback)
{
    ESP_LOGD(BT_APP_CORE_TAG, "%s event 0x%x, param len %d", __func__, event, param_len);

    bt_app_msg_t msg;
    memset(&msg, 0, sizeof(bt_app_msg_t));

    msg.sig = BT_APP_SIG_WORK_DISPATCH;
    msg.event = event;
    msg.cb = p_cback;

    if (param_len == 0) {
        return bt_app_send_msg(&msg);
    } else if (p_params && param_len > 0) {
        if ((msg.param = malloc(param_len)) != NULL) {
            memcpy(msg.param, p_params, param_len);
            /* check if caller has provided a copy callback to do the deep copy */
            if (p_copy_cback) {
                p_copy_cback(&msg, msg.param, p_params);
            }
            return bt_app_send_msg(&msg);
        }
    }

    return false;
}

static bool bt_app_send_msg(bt_app_msg_t *msg)
{
    if (msg == NULL) {
        return false;
    }

    if (xQueueSend(s_bt_app_task_queue, msg, 10 / portTICK_RATE_MS) != pdTRUE) {
        ESP_LOGE(BT_APP_CORE_TAG, "%s xQueue send failed", __func__);
        return false;
    }
    return true;
}

static void bt_app_work_dispatched(bt_app_msg_t *msg)
{
    if (msg->cb) {
        msg->cb(msg->event, msg->param);
    }
}

static void bt_app_task_handler(void *arg)
{
    bt_app_msg_t msg;
    for (;;) {
        if (pdTRUE == xQueueReceive(s_bt_app_task_queue, &msg, (portTickType)portMAX_DELAY)) {
            ESP_LOGD(BT_APP_CORE_TAG, "%s, sig 0x%x, 0x%x", __func__, msg.sig, msg.event);
            switch (msg.sig) {
            case BT_APP_SIG_WORK_DISPATCH:
                bt_app_work_dispatched(&msg);
                break;
            default:
                ESP_LOGW(BT_APP_CORE_TAG, "%s, unhandled sig: %d", __func__, msg.sig);
                break;
            } // switch (msg.sig)

            if (msg.param) {
                free(msg.param);
            }
        }
    }
}

void bt_app_task_start_up(void)
{
    s_bt_app_task_queue = xQueueCreate(10, sizeof(bt_app_msg_t));
    xTaskCreate(bt_app_task_handler, "BtAppT", 3072, NULL, configMAX_PRIORITIES - 3, &s_bt_app_task_handle);
    return;
}

void bt_app_task_shut_down(void)
{
    if (s_bt_app_task_handle) {
        vTaskDelete(s_bt_app_task_handle);
        s_bt_app_task_handle = NULL;
    }
    if (s_bt_app_task_queue) {
        vQueueDelete(s_bt_app_task_queue);
        s_bt_app_task_queue = NULL;
    }
}

static void IRAM_ATTR bt_i2s_task_handler(void *arg)
{
    uint8_t *data = NULL;
    int16_t *temp = NULL;
    size_t item_size = 0, i = 0;
    size_t bytes_written = 0;
    uint16_t received_pack=0;
    uint8_t z = 0;
    uint8_t flag = 0;


    //dsps_fir_init_f32(&myfirL, coefficients, statesl, 51);
    //dsps_fir_init_f32(&myfirR, coefficients, statesr, 51);
    dsps_fir_init_f32(&myfirL, (float *)&left[z*COEFF_L], statesl, COEFF_L);
    dsps_fir_init_f32(&myfirR, (float *)&right[z*COEFF_L], statesr, COEFF_L);


    for (;;) {
        data = (uint8_t *)xRingbufferReceive(s_ringbuf_i2s, &item_size, (portTickType)portMAX_DELAY);
        if (item_size != 0){
            received_pack++;
           
           if ( received_pack % 15 == 0 ){
               z++;
               if(z == 37){
                   z = 1;
                   if(flag == 0){
                       flag = 1;
                   }else{
                       flag = 0;
                   }
               }
                //*/
                //Do something each 500 received items
                    
                if(!flag){
                    printf("azimuth: %d°\n", z*5);
                    myfirL.coeffs = (float *)&left[z*COEFF_L];
                    myfirR.coeffs = (float *)&right[z*COEFF_L];
                } else{
                    printf("azimuth: %d°\n", 180+z*5);
                    myfirL.coeffs = (float *)&left[(36-z)*COEFF_L];
                    myfirR.coeffs = (float *)&right[(36-z)*COEFF_L];
                }
                

           }

            //input coverted to separated float channels L and R
            for(i=0;i<item_size;i+=4){
                temp=(int16_t*)(&data[i]);
                tempinl[i>>2]=(float)(*(temp))/32768.0;
                tempinr[i>>2]=(float)(*(temp+1))/32768.0;
            }

            //Filter
            if(!flag){
                dsps_fir_f32_ae32(&myfirL,tempinl,tempoutl,item_size>>2);
                dsps_fir_f32_ae32(&myfirR,tempinr,tempoutr,item_size>>2);
            }else{
                dsps_fir_f32_ae32(&myfirR,tempinl,tempoutl,item_size>>2);
                dsps_fir_f32_ae32(&myfirL,tempinr,tempoutr,item_size>>2);
            }
            //dsps_fir_f32_ae32(&myfirL,tempinl,tempoutl,item_size>>2);
            //dsps_fir_f32_ae32(&myfirR,tempinr,tempoutr,item_size>>2);
            

           //Bypass
            
            /*for(i=0;i<item_size/4;i++){
                tempoutr[i]=tempinr[i];
                tempoutl[i]=tempinl[i];
            }*/

            //convert [-1,1] float to integer, i=f*32768 + 32768 
            dsps_mulc_f32_ae32(tempoutl,tempinl,item_size>>2,32768.0,1,1);
            dsps_mulc_f32_ae32(tempoutr,tempinr,item_size>>2,32768.0,1,1);
            dsps_addc_f32_ae32(tempinl,tempoutl,item_size>>2,32768.0,1,1);
            dsps_addc_f32_ae32(tempinr,tempoutr,item_size>>2,32768.0,1,1);
       
            //Output converted to merged interleaved LR output
            for(i=0;i<item_size;i+=4){
                temp=(int16_t*)(&data[i]);
                *temp=(int16_t)(tempoutl[i>>2]);
                *(temp+1)=(int16_t)(tempoutr[i>>2]);
            }
            i2s_write(0, data, item_size, &bytes_written, portMAX_DELAY);
            //i2s_write_expand(0, data, item_size, 8, 32, &bytes_written, portMAX_DELAY);
            
            vRingbufferReturnItem(s_ringbuf_i2s,(void *)data);
        }
    }
}

void bt_i2s_task_start_up(void)
{
    s_ringbuf_i2s = xRingbufferCreate(8 * 1024, RINGBUF_TYPE_BYTEBUF);
    if(s_ringbuf_i2s == NULL){
        return;
    }
   // dsps_fir_init_f32(&myfir, coefficients, states, 51);
    xTaskCreate(bt_i2s_task_handler, "BtI2ST", 8*1024, NULL, configMAX_PRIORITIES - 3, &s_bt_i2s_task_handle);
    return;
}

void bt_i2s_task_shut_down(void)
{
    if (s_bt_i2s_task_handle) {
        vTaskDelete(s_bt_i2s_task_handle);
        s_bt_i2s_task_handle = NULL;
    }
    if (s_i2s_dac_writter_task) {
        vTaskDelete(s_i2s_dac_writter_task);
        s_i2s_dac_writter_task = NULL;
    }
    if (s_ringbuf_i2s) {
        vRingbufferDelete(s_ringbuf_i2s);
        s_ringbuf_i2s = NULL;
    }
}

size_t write_ringbuf(const uint8_t *data, size_t size)
{
    BaseType_t done = xRingbufferSend(s_ringbuf_i2s, (void *)data, size, (portTickType)portMAX_DELAY);
    if(done){
        return size;
    } else {
        return 0;
    }
}