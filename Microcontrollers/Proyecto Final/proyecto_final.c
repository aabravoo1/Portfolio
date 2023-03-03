/*
 * File:   Proyecto_Final_Micros.c
 * Author: 
 * Andrés Antonio Bravo Orozco      A01630783
 * Jean Carlo Álvarez Guerra       A01635182
 * Rodrigo Serrano García          A01630978
 *
 * Created on 17 de mayo de 2021, 06:16 PM
 */


#include <xc.h>
#include <stdio.h>
#include <pic18f4585.h>

//OSCILLATOR SOURCE AND DIGITAL I/O CONFIGURATION BITS
//=====================================================
#pragma config OSC = IRCIO67
#pragma config MCLRE = ON
#pragma config PBADEN = OFF
#pragma config LVP = OFF

//PICIT-3 DEBUGGER SETUP CONFIGURATION BITS
//=========================================
#pragma config WDT = OFF


//For LCD
#define RS PORTAbits.RA3
#define RW PORTAbits.RA1
#define E PORTAbits.RA2
#define DATA PORTB
#define BUSY PORTBbits.RB7
//For PWM
#define valor_CCPRIL_1 31;
#define valor_CCPRIL_2 62;
#define valor_CCPRIL_3 93;
#define valor_CCPRIL_4 124;

#define valor_PR2_1 62; //1ms
#define valor_PR2_2 124;//2ms
#define valor_PR2_3 187;//3ms
#define valor_PR2_4 249;//4ms
//For ECCP1
#define TimerCount_high  0x00 
#define TimerCount_low   0x00
#define count_1 1008//64536
#define count_2 2000//63536
#define count_3 3008//62536
#define count_4 4000//61536
//For time count
#define TimerCount_high  0x0B //3036
#define TimerCount_low   0xDC

#pragma udata conversion = 0x00; 
unsigned int conversion = 0;
#pragma udata conversion = 0x10; 
unsigned int prev_conversion = 0;
#pragma udata heart_rate_mode = 0x12; 
unsigned char heart_rate_mode = 0;
#pragma udata check = 0x14; 
unsigned char check = 0;
#pragma udata compared_flag = 0x16; 
unsigned char compared_flag = 0;
#pragma udata data1 = 0x20; 
unsigned int data1 = 0;
#pragma udata data2 = 0x29; 
unsigned int data2 = 0;
#pragma udata total = 0x31; 
unsigned int total = 0;
#pragma udata prev_total = 0x36; 
unsigned int prev_total = 0;
#pragma udata calorias = 0x3F; 
unsigned int calorias = 0;
#pragma udata tiempo = 0x48; 
unsigned int tiempo = 0;
#pragma udata remadas = 0x50; 
unsigned int remadas = 0;
#pragma udata promedio = 0x58; 
unsigned int promedio = 0;
#pragma udata page = 0x60; 
unsigned char page = 0;

#pragma udata reloj = 0x62; 
unsigned char reloj = 0;
#pragma udata reloj2 = 0x64; 
unsigned char reloj2 = 0;
#pragma udata reloj3 = 0x66; 
unsigned char reloj3 = 0;
#pragma udata reloj4 = 0x68; 
unsigned char reloj4 = 0;
#pragma udata prev_RC0 = 0x6A; 
unsigned char prev_RC0 = 0;
#pragma udata of_count = 0x6D;
unsigned int of_count = 0;
#pragma udata prev_calorias = 0x70; 
unsigned int prev_calorias = 0;
#pragma udata on_flag = 0x78; 
unsigned char on_flag = 0;
#pragma udata done_remada = 0x7A; 
unsigned char done_remada = 0;
#pragma udata prev_remadas = 0x80; 
unsigned int prev_remadas = 0;
#pragma udata prev_promedio = 0x88; 
unsigned int prev_promedio = 0;
#pragma udata reloj_total = 0x90; 
unsigned int reloj_total = 0;
#pragma udata goal = 0x98; 
unsigned int goal = 10;
#pragma udata done_plus = 0x100; 
unsigned char done_plus = 0;
#pragma udata done_minus = 0x104; 
unsigned char done_minus = 0;
#pragma udata goal_count = 0x108; 
unsigned int goal_count = 10;
#pragma udata prev_goal = 0x110; 
unsigned int prev_goal = 0;
#pragma udata minute_count = 0x114; 
unsigned char minute_count = 0;



void __interrupt(high_priority) high_Isr(void);
void __interrupt(low_priority) low_Isr(void);

//Basic initialization
void init(void);
//For ADC
void ADC_init (void);
void adc_interrupt(void);
//For PWM
void PWM_init(void);
void pwm_interrupt(void);
//For ECCP1
void ECCP1_init(void);
void timer1_init(void);
void eccp1_interrupt(void);
//For Timer
void timer0_init(void);
void timer_interrupt(void);
//For LCD
void clear(void);
void show_currentTime(void);
void print(void);
void print_time(void);
void print_remadas(void);
void print_promedio(void);
void print_metas(void);
void show_total(unsigned int total);
void show_total_time(unsigned int total);
void shortDelay(void);
void longDelay(void);
void command(int instruction);
int ready(void);
void display(unsigned char data);
void lcdSetUp(void);
void sendString(unsigned char string[], int size);
void delay(unsigned int t);

void __interrupt(low_priority) low_Isr(void)
{   if(PIR2bits.ECCP1IF == 1){ 
        eccp1_interrupt();
    }if(INTCONbits.TMR0IF == 1){
        timer_interrupt();
    }
    
}

void __interrupt(high_priority) high_Isr(void)
{
    if(PIR1bits.ADIF == 1){
        adc_interrupt();
    }
}


void adc_interrupt(void){
    conversion =  ADRESH*256 + ADRESL;//obtener conversión analógo digital
    
   if (conversion != prev_conversion){
        prev_conversion = conversion;
        if(conversion > 768){//si está en el limite superior, modo de pwm en modo 4
            heart_rate_mode = 4; 
            check = '4';
            pwm_interrupt();
        }else if(conversion < 768 && conversion > 512){ //si resistencia está en 3/4, pwm en modo 3
            heart_rate_mode = 3;   
            check = '3';
            pwm_interrupt();
        }else if(conversion < 512 && conversion > 256){//si resistencia está en 1/2, pwm en modo 2
            heart_rate_mode = 2;     
            check = '2';
            pwm_interrupt();
        }else {
            heart_rate_mode = 1; //si resistencia está en 1/4, pwm en modo 1
            check = '1';
            pwm_interrupt();
        } 
   }
    
    ADC_init();
}

void pwm_interrupt(void){
   T2CONbits.TMR2ON = 0;
   //PR2 = valor_PR2_4;
   //CCPR1L = valor_CCPRIL_4;
   
   if (heart_rate_mode == 4){ //asignar la frecuencia deseada al pwm dependiendo del modo
       PR2 = valor_PR2_4;
       CCPR1L = valor_CCPRIL_4;
   }else if (heart_rate_mode == 3){
       PR2 = valor_PR2_3;
       CCPR1L = valor_CCPRIL_3;
   }else if (heart_rate_mode == 2){
       PR2 = valor_PR2_2;
       CCPR1L = valor_CCPRIL_2;
   }else {
      PR2 = valor_PR2_1;
      CCPR1L = valor_CCPRIL_1; 
   }
   
   PIR1bits.TMR2IF=0;
   T2CONbits.TMR2ON = 1; 
}

void eccp1_interrupt(void){
    
    if(compared_flag == 0){ //se realiza una comparación para determinar la duración de la señal pwm
        data1 = ECCPR1;
        compared_flag = 1;
    }else {
        data2 = ECCPR1;
        total = data2-data1;
        compared_flag = 0;
    }
    if(total != prev_total){
        prev_total = total;
        if(total == count_1){
            calorias = -55.0969 + 0.6309*180 + 15.904 + 5.0425/4.184*reloj_total/60;   //se calcula la quema de calorias en base al tiempo y al ritmo cardiaco
        }else if(total == count_2){
            calorias = -55.0969 + 0.6309*160 + 15.904 + 5.0425/4.184*reloj_total/60;
        }else if(total == count_3){
            calorias = -55.0969 + 0.6309*140 + 15.904 + 5.0425/4.184*reloj_total/60;
        }else if(total == count_4){
            calorias = -55.0969 + 0.6309*100 + 15.904 + 5.0425/4.184*reloj_total/60;
        }
    }
    
    PIR2bits.ECCP1IF = 0;
}

void timer_interrupt(void)
{ //interrupt code
    if(on_flag){         //rutina para desplegar la información necesaria en el LCD
        if (reloj == 0){ //si el reloj está en 0, desplegar calorias y tiempo
          page =0;
          print();
          page =1;  
          print();
        }else if (reloj > 0 && reloj < 5){ //si el reloj está entre 0 y 5, desplegar unicamente si hay cambios
            if(calorias != prev_calorias){
                prev_calorias = calorias;
                page =0;
                print();  
            }
          page =1;  
          print_time();      
        }else if(reloj == 5){//si el reloj está en 5, desplegar remadas, meta y promdio
            page =2;
            print();
            page =3;
            print();
        }else if(reloj > 5){//si el reloj es mayor a 5 desplegar unicamente si hay cambios
           if(remadas != prev_remadas){
                prev_remadas = remadas;
                page =2;
                print_remadas();  
            }
           if(goal != prev_goal){
                prev_goal = goal;
                page =2;
                print_metas();  
            }
        }
    }
    
    int of_count = of_count +1;
    if(reloj == 9){              //rutina para desplegar obtener el tiempo actual cada segundo
        if(reloj2==5){
            if(reloj3==9){
                if(reloj4==5){
                    reloj4=0;
                }else{
                    reloj4= reloj4+1;
                }
                reloj3=0;
                minute_count++;//si los minutos cambian actualizar el promedio
                promedio = remadas/minute_count; //formula para obtener el promedio
                print_promedio(); 
                
            }else{
                reloj3 = reloj3+1;
                minute_count++;//si los minutos cambian actualizar el promedio
                promedio = remadas/minute_count; //formula para obtener el promedio
                print_promedio(); 
            }
            reloj2 = 0;
        }else{
           reloj2 = reloj2+1; 
        }
        reloj = 0;
    }else{
        reloj = reloj+1;
    }
    reloj_total = 600*reloj4+60*reloj3+10*reloj2+reloj;//obtener cantidad total de tiempo
    
    
    //show_currentTime();
    
    T0CONbits.TMR0ON = 0;
    TMR0H = TimerCount_high;
    TMR0L = TimerCount_low; 
    INTCONbits.TMR0IF =    0;
    T0CONbits.TMR0ON = 1;

}


void main(void) {
    init(); //inicialización básica de los modulos
    lcdSetUp();
    ADC_init();
    PWM_init();
    timer0_init();
    //show_currentTime();
    //print();
    
    
    while(1){
        if(PORTCbits.RC0==1){ //rutina para prender el sistema y empezar a desplegar datos
            prev_RC0=prev_RC0+1; //de esta manera se sabe si el sistema está corriendo o en pausa
            if((prev_RC0%2)==0){//si está en pausa, apagar sistema
                on_flag =0;
                T0CONbits.TMR0ON = 0; //timer0 off
                PORTDbits.RD7 =0;
                
            }else{//si está prendido, habilitar sistema
                T0CONbits.TMR0ON = 1; //timer0 on 
                PORTDbits.RD7 =1;
                on_flag = 1;
                
            }
        }else if(PORTCbits.RC1==1){//si se oprime el reset, apagar y reiniciar variables
            T0CONbits.TMR0ON = 0;
            PORTDbits.RD7 =0;
            on_flag = 0;
            timer0_init();
            reloj=0;
            reloj2=0;
            reloj3=0;
            reloj4=0;
            prev_RC0=0;
            remadas = 0;
            goal = 10;
            goal_count = goal;
            minute_count = 0;
            clear();
            //show_currentTime();
        }
        
        if(on_flag){           //Unicamente aceptar inputs cuando el sistema esté prendido
            if (PORTDbits.RD6){//Para remadas
                if(!done_remada){//si no se ha realizado la remada y se detecta un 1 en la entrada, aumentar remadas y marcar com hecho
                    remadas ++;
                    done_remada = 1;
                    if(remadas == goal_count){//Usar buzzer, se compara con una suma de metas en vez de la meta per se, ya que si se supera la meta debe seguir indicando la siguiente
                        goal_count += goal;
                        PORTCbits.RC4 = 1;
                        longDelay();
                        PORTCbits.RC4 = 0;
                    }
                }
            }else if(!PORTDbits.RD6){//si se detecta un 0 en la entrada y se realizó una remada, habilitar que se pueda marcar una nueva
                if(done_remada){
                    done_remada = 0;
                }
            }

            if (PORTDbits.RD0){//Para incrementar meta
                if(!done_plus){ //mismo principio que con las remadas, se incrementa tanto la meta como el contador de meta
                    goal= goal+10;
                    goal_count += 10;
                    done_plus = 1;
                }
            }else if(!PORTDbits.RD0){
                if(done_plus){
                    done_plus = 0;
                }
            }

            if (PORTDbits.RD1){//Para disminuir meta
                if(!done_minus){ //mismo principio que rutinas anteriores
                    goal= goal-10;
                    goal_count -= 10;
                    done_minus = 1;
                    if(goal<0){
                        goal = 0;
                        goal_count =0;
                    }
                }
            }else if(!PORTDbits.RD1){
                if(done_minus){
                    done_minus = 0;
                }
            }
        }
        
    }
    
    return;
}

void init(void){
    //CLOCK FREQUENCY CONFIGURATION
    //=============================
    OSCCON = 0x60;   //4MHz internal clock
            
    //CONFIGURATION OF PORTS
    //===============================
            PORTA = 0x00; //initialize PORTA
            LATA = 0x00;  //Clear PORTA
            TRISA = 0x00; //PORTA as Outputs for LCD
            
            PORTB = 0x00; //initialize PORTA
            LATB = 0x00;  //Clear PORTA
            TRISB = 0x00; //PORTA as Outputs for LCD
            
            PORTAbits.RA0 = 0; //Initialize PORTA
            LATAbits.LATA0 = 0;  //Clear PORTA
            TRISAbits.TRISA0 = 1; //RA0 as Input for ADC
            
            TRISCbits.RC2 = 0; //RC2 as output for pwm
            PORTCbits.RC2 =0;
            LATCbits.LATC2 = 0;
            
            TRISDbits.RD4 = 1; //RD4 as input for ECCP1
            PORTDbits.RD4 =0;
            LATDbits.LATD4 = 0;
            
            TRISDbits.RD7 = 0; //RD7 as output for led
            PORTDbits.RD7 =0;
            LATDbits.LATD7 = 0;
                        
            PORTCbits.RC0 = 0; //Initialize PORTC0 for button
            PORTCbits.RC1 = 0; //Initialize PORTC0 for button
            LATCbits.LATC0 = 0;  //Clear PORTC
            LATCbits.LATC1 = 0;  //Clear PORTC
            TRISCbits.TRISC0 = 1; //PORTC as Inputs
            TRISCbits.TRISC1 = 1; //PORTC as Inputs
            
            TRISDbits.RD6 = 1; //RD6 as input for switch
            PORTDbits.RD6 =0;
            LATDbits.LATD6 = 0;
            
            TRISDbits.RD0 = 1; //RD0 as input for switch goals
            PORTDbits.RD0 =0;
            LATDbits.LATD0 = 0;
            TRISDbits.RD1 = 1; //RD1 as input for switch goals
            PORTDbits.RD1 =0;
            LATDbits.LATD1 = 0;
            
            TRISCbits.RC4 = 0; //RC4 as output for BUZZER
            PORTCbits.RC4 =0;
            LATCbits.LATC4 = 0;
            
    //CONFIGURATION OF Interrupts
    //===============================
            RCONbits.IPEN =        1; //enable priority level
            INTCONbits.PEIE_GIEL = 1; //enable peripheral
            
            PIR1bits.ADIF = 0; //clear interrupt request flag for ADC
            PIE1bits.ADIE = 1; //enable ADC interrupt
            IPR1bits.ADIP = 1;//high priority
            
            PIR2bits.ECCP1IF = 0; //Clear ECCP1 overflow flag
            PIE2bits.ECCP1IE = 1; //ECCP1 interrupt enabled
            IPR2bits.ECCP1IP = 0; //low priority
            
            INTCONbits.TMR0IF =    0; //clear oveflow flag
            INTCONbits.TMR0IE =    1; //enables TMR0 overflow interrupt
            INTCON2bits.TMR0IP =   0; //timer 0 as low priority
            
            INTCONbits.GIE_GIEH =  1; //enables all unmasked core interrupts      
            
            //ECCP1 MODULE
            ECCP1_init();
           
    //return;
}

void ADC_init (void){
    PIR1bits.ADIF = 0; //clear interrupt request flag
    ADCON0bits.CHS = 0b0000; //select channel AN0; 
    
    ADCON1bits.VCFG1 = 0; //AVss as reference
    ADCON1bits.VCFG0 = 0; //AVdd as reference
    ADCON1bits.PCFG = 0b1110; // Only AN0 as analog pin
    
    ADCON2bits.ADFM = 1; //Right justified
    ADCON2bits.ACQT = 0b010; //4 Tad acquisition time
    ADCON2bits.ADCS = 0b100; //Fosc/4 conversion clock
    
    ADCON0bits.ADON = 1; //Turn on AD module
    ADCON0bits.GODONE = 1;//start conversion 
    
}

void PWM_init(void){
    PR2 = valor_PR2_4; 
    T2CON = 0x07; //prescaler 16
    CCPR1L = valor_CCPRIL_4;
    CCP1CON = 0b00101100; //module ccp1 as pwm
    TMR2 = 0;
    T2CONbits.TMR2ON = 1;
}

void ECCP1_init(void){//pin P1A/RD4
    PIR2bits.ECCP1IF = 0;
    //ECCP1CONbits.ECCP1M = 0b0101; //capture mode, every rising edge
    ECCP1CON = 0b00000101;
    T3CONbits.T3ECCP1 = 0; //utliza el timer 1
    T3CONbits.T3CCP1 = 0;
    timer1_init();
}

void timer1_init(void){
    TMR1H = TimerCount_high;
    TMR1L = TimerCount_low; 
    
    T1CONbits.TMR1ON = 0; //timer 1 off
    T1CONbits.T1RUN = 0; //not clock from timer1
    T1CONbits.TMR1CS = 0; //internal clock Fosc/4
    T1CONbits.T1OSCEN = 0; //internal clock
    T1CONbits.RD16 = 1; //16 bit mode
    
    T1CONbits.T1CKPS = 0b00; //1:1 prescale value
    
    T1CONbits.TMR1ON = 1; //timer 1 on
}

void timer0_init(void){
    TMR0H = TimerCount_high;
    TMR0L = TimerCount_low; 
    
    T0CONbits.TMR0ON = 0; //timer 0 off
    T0CONbits.T08BIT = 0; //timer 0 in 16 bit mode
    T0CONbits.T0CS = 0; //internal clock 
    T0CONbits.PSA = 0; //timer 0 uses prescaler
    T0CONbits.T0PS0 = 1; // 1:16 prescaled value 0b011
    T0CONbits.T0PS1 = 1;
    T0CONbits.T0PS2 = 0;
     
    //T0CONbits.TMR0ON = 1; //timer 0 on
}

//***********************************************FOR LCD************************
void clear(void){
    unsigned char str_clear[] = "                "; //para limpiar el LCD
    command(0x80);
    sendString(str_clear, sizeof(str_clear));
    command(0xC0);
    sendString(str_clear, sizeof(str_clear));
}
void show_currentTime(void){ //rutina de prueba para imprimir tiempo
    command(0x84);
    ready();
    unsigned char colon[] = ":";
    unsigned char str_tiempo[] = "TIEMPO:";
    sendString(str_tiempo, sizeof(str_tiempo));
    command(0xC5);
    show_total_time(reloj4);
    show_total_time(reloj3);
    sendString(colon, sizeof(colon));
    show_total_time(reloj2);
    show_total_time(reloj);
}

void print(void){ //rutina para imprimir los valores en el LCD dependiendo del valor en page
    unsigned char espacio[] = "          ";
    
    if(page == 0){
        command(0x80);
        ready();
        unsigned char str_Cal[] = "Cal:";
        sendString(str_Cal, sizeof(str_Cal));
        show_total(calorias);
        sendString(espacio, sizeof(espacio));
    }else if (page == 1){    
        command(0xC0);
        ready();
        unsigned char colon[] = ":";
        unsigned char str_Time[] = "Tiempo:";
        sendString(str_Time, sizeof(str_Time));
        show_total_time(reloj4);
        show_total_time(reloj3);
        sendString(colon, sizeof(colon));
        show_total_time(reloj2);
        show_total_time(reloj);
        
    }else if(page == 2){
        command(0x80);
        ready();
        unsigned char str_Remadas[] = "Rem:";
        sendString(str_Remadas, sizeof(str_Remadas));
        if(remadas < 10){
            show_total_time(remadas);
        }else{
            show_total(remadas);  
        }
        unsigned char espacio2[] = "  ";
        sendString(espacio2, sizeof(espacio2));
        command(0x88);
        unsigned char str_Meta[] = "Meta:";
        sendString(str_Meta, sizeof(str_Meta));
        show_total(goal);
    }else{
        command(0xC0);
        ready();
        unsigned char str_Promedio[] = "Promedio:";
        sendString(str_Promedio, sizeof(str_Promedio));
        show_total(promedio);
    }
}

void print_time(void){ //rutinas para imprimir unicamente valores numéricos específicos
    command(0xCB);
    ready();
    show_total_time(reloj);
}

void print_remadas(void){
    command(0x84);
    ready();
    if(remadas < 10){
        show_total_time(remadas);
    }else{
        show_total(remadas);  
    }
}

void print_promedio(void){
    command(0xC9);
    ready();
    show_total(promedio);//desplegar el promedio
}

void print_metas(void){
    command(0x8D);
    ready();
    show_total(goal);
}

void show_total(unsigned int total){ //rutina para imprimir valores enteros 
    //command(0x80);
    ready();
    unsigned char str[4];
    snprintf(str, sizeof(str), "%d", total);
    //ftoa(total, sizeof(str), str);
    //itoa(total, str);
    sendString(str, sizeof(str));
}

void show_total_time(unsigned int total){ //rutina para imprimir valores enteros de 1 dígito
    //command(0x80);
    ready();
    unsigned char str[2];
    snprintf(str, sizeof(str), "%d", total);
    //ftoa(total, sizeof(str), str);
    //itoa(total, str);
    sendString(str, sizeof(str));
}

void shortDelay(void) { //delay solo para uso practico, no utiliza timers
    int i, j;
    for (i = 0; i < 1; i++)
        for (j = 0; j < 150; j++);
}

void longDelay(void) { //delay solo para uso practico, no utiliza timers
    int i, j;
    for (i = 0; i < 50; i++)
        for (j = 0; j < 150; j++);
}
//rutinas de inicialización para el LCD
void command(int instruction){
    DATA = instruction;
    RS = 0; //instruction reg
    RW = 0; //write
    
    E = 1;
    shortDelay();
    E = 0;
    return; 
}

int ready(void){
    TRISB = 0xFF; //PORTD as input
    
    RS = 0; //instruction reg
    RW = 1; //read
    
    E = 1;
    shortDelay();
    E = 0;
    
    while(BUSY == 1){ 
        E = 1;
        shortDelay();
        E = 0;
    }    
    TRISB = 0x00; //PORTD as output
    return 1;
}

void display(unsigned char data){
    DATA = data;
    
    RS = 1;//Data reg
    RW = 0;//Write
    
    E = 1;
    shortDelay();
    E = 0;
    
    return;
}

void lcdSetUp(void){
    E = 0;
    longDelay();
    command(0x38);
    longDelay();
    command(0x0F);
    ready();
    command(0x01);
    ready();
    return;
}

void sendString(unsigned char string[], int size){ //Rutina para mandar strings
    for(int i = 0; i<size-1 ; i++){
        display(string[i]);
        ready();
            }
}

void delay(unsigned int t) { //delay solo para uso practico, no utiliza timers
    int i, j;
    for (i = 0; i < t; i++)
        for (j = 0; j < 150; j++);
}