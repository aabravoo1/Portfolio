#include <stdio.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_err.h"
#include "esp_log.h"
#include "esp_partition.h"
#include "driver/i2s.h"
#include "driver/adc.h"
#include "fir_coeffs.h"
#include "esp_dsp.h"
#include <WebServer.h>
#include <WiFi.h>
#include <WiFiUdp.h>
#include "BluetoothSerial.h" 

#define PACKET_SIZE 100

int i;

// init Bluetooth
BluetoothSerial ESP_BT;

// WIFI connection
const char* ssid = "red";
const char* password = "password";
/*const char ssid = "INFINITUM8D9C_2.4";
const char* password = "97Dk6pfWTr";*/
/*const char ssid = "AndroidFer";
const char* password = "monstersinc";*/
WiFiUDP Udp;
unsigned int localUdpPort = 4210;  //  port to listen on
char incomingPacket[PACKET_SIZE];  // buffer for incoming packets
bool packet_ready = false;
char sample_data[3];
uint8_t channel_sel = 0;

// Data arrays
int i2s_read_len = PACKET_SIZE;
size_t bytes_read, bytes_written;
uint8_t i2s_read_buff[PACKET_SIZE];
uint8_t i2s_write_buff[PACKET_SIZE];
uint8_t i2s_temp_buff[PACKET_SIZE];

// FIR filter arrays
static fir_f32_t myfirL, myfirR;
static float fir_statesl[FIR_ORDER+1], fir_statesr[FIR_ORDER+1]; // DSP filters need that the state and coefficient vectors be the same length
static float templ[PACKET_SIZE], tempr[PACKET_SIZE], templ2[PACKET_SIZE], tempr2[PACKET_SIZE];
int16_t *temp = NULL;

/**
 * @brief I2S ADC/DAC mode init.
 */
void i2s_init(void)
{
     i2s_config_t i2s_config = {
        .mode = (i2s_mode_t)(I2S_MODE_MASTER | I2S_MODE_RX | I2S_MODE_TX | I2S_MODE_DAC_BUILT_IN | I2S_MODE_ADC_BUILT_IN),
        .sample_rate =  4000,
        .bits_per_sample = I2S_BITS_PER_SAMPLE_16BIT,
        .channel_format = I2S_CHANNEL_FMT_RIGHT_LEFT,
        .communication_format = I2S_COMM_FORMAT_STAND_MSB,
        .dma_buf_count = 16,
        .dma_buf_len = 128,
        .use_apll = 1
     };
     //install and start i2s driver
     i2s_driver_install(I2S_NUM_0, &i2s_config, 4, NULL);
     //init DAC pad
     i2s_set_dac_mode(I2S_DAC_CHANNEL_BOTH_EN);
     //init ADC pad
     i2s_set_adc_mode(ADC_UNIT_1, ADC1_CHANNEL_7);
     i2s_adc_enable(I2S_NUM_0);
}

/**
 * @brief debug buffer data
 */
void disp_buf(uint8_t* buf, int length)
{
    printf("======\n");
    for (int i = 0; i < length; i++) {
        //printf("%02x ", buf[i]);
        printf("%d ", buf[i]);
        if ((i + 1) % 8 == 0) {
            printf("\n");
        }
    }
    printf("======\n");
}

/**
 * @brief Scale data to 8bit for data from ADC.
 *        Data from ADC are 12bit width by default.
 *        DAC can only output 8 bit data.
 *        Scale each 12bit ADC data to 8bit DAC data.
 */
void i2s_adc_data_scale(uint8_t* d_buff, uint8_t* s_buff, uint32_t len)
{
    uint32_t j = 0;
    uint32_t dac_value = 0;
    for (int i = 0; i < len; i += 2) {
        dac_value = ((((uint16_t) (s_buff[i + 1] & 0xf) << 8) | ((s_buff[i + 0]))));
        d_buff[j++] = 0;
        d_buff[j++] = dac_value / 16;      
    }
}

void setup() {
    Serial.begin(115200);

    // Bluetooth connection
    ESP_BT.begin("ESP32_Control");

    int status = WL_IDLE_STATUS;
    WiFi.begin(ssid, password);
    Serial.println("");

    // Wait for WiFi connection
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("Connected to wifi");
    Udp.begin(localUdpPort);
    Serial.printf("Now listening at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);

    // Receive one packet so we can know its IP and port
    bool confirmation_packet = false;
    while (!confirmation_packet) {
        int packetSize = Udp.parsePacket();
        if (packetSize){
            // Receive incoming UDP packets
            Serial.printf("Received %d bytes from %s, port %d\n", packetSize, Udp.remoteIP().toString().c_str(), Udp.remotePort());
            int len = Udp.read(incomingPacket, PACKET_SIZE);
            if (len > 0){
                incomingPacket[len] = 0;
            }
            Serial.println("init_func");
            Serial.printf("UDP packet contents: %s\n", incomingPacket);
            confirmation_packet = true;
        }
    }

    i2s_init();

    dsps_fir_init_f32(&myfirL, fir_coeffs, fir_statesl, FIR_ORDER+1);
    dsps_fir_init_f32(&myfirR, fir_coeffs, fir_statesr, FIR_ORDER+1);
}

void loop() {

    if (ESP_BT.available()){
        channel_sel = ESP_BT.read(); //Read what we receive
    }

    // READ AND SCALE STAGE
    // read data from I2S bus, in this case, from ADC.
    i2s_read(I2S_NUM_0, (void *)i2s_read_buff, i2s_read_len, &bytes_read, portMAX_DELAY);
    //process data and scale to 8bit for I2S DAC
    i2s_adc_data_scale(i2s_temp_buff, i2s_read_buff, i2s_read_len);
    
    /*// FILTER STAGE
    // input coverted to separated float channels L and R
    for(i=0;i<i2s_read_len;i+=4){
        temp=(int16_t*)(&i2s_temp_buff[i]);
        templ[i>>2]=(float)(*(temp))/32768.0;
        tempr[i>>2]=(float)(*(temp+1))/32768.0;
    }
    dsps_fir_f32_ae32(&myfirL,templ,templ2,i2s_read_len>>2);
    dsps_fir_f32_ae32(&myfirL,templ,templ2,i2s_read_len>>2);

    // convert [-1,1] float to integer, i=f*32768 + 32768
    dsps_mulc_f32_ae32(templ2,templ,i2s_read_len>>2,32768.0,1,1);
    dsps_mulc_f32_ae32(tempr2,tempr,i2s_read_len>>2,32768.0,1,1);
    dsps_addc_f32_ae32(templ,templ2,i2s_read_len>>2,32768.0,1,1);
    dsps_addc_f32_ae32(tempr,tempr2,i2s_read_len>>2,32768.0,1,1);

    // output converted to merged interleaved LR output
    for(i=0;i<i2s_read_len;i+=4){
        temp=(int16_t*)(&i2s_temp_buff[i]);
        *temp=(int16_t)(templ2[i>>2]);
        *(temp+1)=(int16_t)(tempr2[i>>2]);
    }*/

    // TRANSMIT STAGE
    /*char udp_buffer_string[PACKET_SIZE*3];
    for(i=0;i<PACKET_SIZE;i++){
        sprintf(sample_data,"%03d",i2s_temp_buff[i]);
        udp_buffer_string[3*i] = sample_data[0];
        udp_buffer_string[3*i + 1] = sample_data[1];
        udp_buffer_string[3*i + 2] = sample_data[2];
        //Serial.println(sample_data);
    }
    Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
    Udp.printf(udp_buffer_string, PACKET_SIZE*3);
    Udp.endPacket();
    packet_ready = true;*/

    // TRANSMIT STAGE
    char udp_buffer_string[PACKET_SIZE*3+3];
    sprintf(sample_data,"%03d",channel_sel); //channel sel variable added for correct channel transmission
    udp_buffer_string[0] = sample_data[0];
    udp_buffer_string[1] = sample_data[1];
    udp_buffer_string[2] = sample_data[2];
    for(i=1;i<PACKET_SIZE+1;i++){
        sprintf(sample_data,"%03d",i2s_temp_buff[i-1]);
        udp_buffer_string[3*i] = sample_data[0];
        udp_buffer_string[3*i + 1] = sample_data[1];
        udp_buffer_string[3*i + 2] = sample_data[2];
        //Serial.println(sample_data);
    }
    Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
    Udp.printf(udp_buffer_string, PACKET_SIZE*3+3);
    Udp.endPacket();
    packet_ready = true;

    // RECEIVE AND PLAY STAGE
    //while (packet_ready) {
        /// Receive packet through UDP and use DAC
        int packetSize = Udp.parsePacket();
        if (packetSize) {
            // receive incoming UDP packets
            int len = Udp.read(incomingPacket, PACKET_SIZE);
            for (int i=0; i<len; i++) {
                i2s_write_buff[i] = incomingPacket[i];
            }
            //send data
            i2s_write(I2S_NUM_0, i2s_write_buff, i2s_read_len, &bytes_read, portMAX_DELAY);
            packet_ready = false;
        }
    //}
}