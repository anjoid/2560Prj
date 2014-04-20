#ifndef INCLUDE_H
#define INCLUDE_H
/*
包含文件声明    
be included files
*/
extern unsigned int Xsteps;
extern unsigned int Ysteps;


#include <delay.h>      
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>        
            
#include <mega2560.h>


/*
宏定义
MACROS
*/

#ifndef RXB8
#define RXB8 1
#endif

#ifndef TXB8
#define TXB8 0
#endif

#ifndef UPE
#define UPE 2
#endif

#ifndef DOR
#define DOR 3
#endif

#ifndef FE
#define FE 4
#endif

#ifndef UDRE
#define UDRE 5
#endif

#ifndef RXC
#define RXC 7
#endif

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)



#define ADC_VREF_TYPE 0x60






/*
IO Operating
端口操作
*/
#define LED_ON PORTD.7=0;      
#define LED_OFF PORTD.7=1;
                
#define SCLH PORTE.5=1
#define SCLL PORTE.5=0
#define SDAH PORTE.4=1
#define SDAL PORTE.4=0
 
//port to SLA7062M
#define XSTEPH PORTE.3 = 1
#define XDIRH PORTE.7 = 1
#define XRSTH PORTE.6 = 1
#define XSYNCH PORTH |= 0x20

#define XSTEPL PORTE.3 = 0
#define XDIRL PORTE.7 = 0
#define XRSTL PORTE.6 = 0
#define XSYNCL PORTH &= 0xDF

#define YSTEPH PORTH |= 0x08
#define YDIRH PORTH |= 0x80
#define YRSTH PORTH |= 0x40
#define YSYNCH PORTG.3=1

#define YSTEPL PORTH &= 0xF7
#define YDIRL PORTH &= 0x7F
#define YRSTL PORTH &= 0xBF
#define YSYNCL PORTG.3 = 1

//#define ZSTEP PORTB.5
//#define ZDIR PORTB.6
//#define ZRST PORTB.7
//#define ZSYNC PORTH.2
//#define ZSTEP PORTB.5
//#define ZDIR PORTB.6
//#define ZRST PORTB.7
//#define ZSYNC PORTH.2

//limit switch
#define LMTA PORTJ & 0x20
#define LMTB PORTJ & 0x40
 
#define EI        #asm("sei")
#define DI        #asm("cli")



#define AGC_ORG read_adc(11)
#define GYRO3 read_adc(13)
#define GYRO2 read_adc(14)
#define GYRO1 read_adc(15)

                                      
/*
各功能函数声明
functions declaration
*/
unsigned char read_adc(unsigned char adc_input);
char getchar1(void);
void putchar1(char c);              
char uprintf(const char *fmt, ...);

unsigned char locked(void);
void TunerRst(void);
unsigned char pll_lk(void); 
void STV0288Init(void);
unsigned char tuner(unsigned long F,float S); 
void SetSymbolRate(float sym_rate);    
char Get0288Register(char addr);
char tunerTest(char para); 
unsigned int GetAGC(void);

void Xcycle(char speed);
void Ymove(int steps,char speed);
void Xmove(int steps,char speed);
void Ystop(void);
void Xstop(void);
char motorTest(char cmd);
void motorInit(void);                        


#endif