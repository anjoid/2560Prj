#ifndef INCLUDE_H
#define INCLUDE_H
/*
包含文件声明    
be included files
*/

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



#define ADC_VREF_TYPE 0x40






/*
IO Operating
端口操作
*/
#define LED_ON PORTD.7=0;      
#define LED_OFF PORTD.7=1;
                

 



 
#define EI	#asm("sei")
#define DI	#asm("cli")



#define AGC_ORG read_adc(11)


                                      
/*
各功能函数声明
functions declaration
*/
unsigned int read_adc(unsigned char adc_input);
void Tx0(unsigned char c);
unsigned char Rx0(void);

unsigned char locked(void);
void TunerRst(void);
unsigned char pll_lk(void); 
void STV0288Init(void);
unsigned char tuner(unsigned long F,float S); 
void SetSymbolRate(float sym_rate);    
char Get0288Register(char addr);
char getchar1(void);
void putchar1(char c);              


                        
#endif