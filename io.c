#include "include.h"      
#include <stdarg.h>

char uprintf(const char *fmt, ...)
{
    const char *s;
    int d;
    char buf[16],i,j,k;
    va_list ap;
    va_start(ap, fmt);
    while (*fmt) {
        if (*fmt != '%') {
            putchar1(*fmt++);
            continue;
        }
        switch (*++fmt) {
            case 's':
                s = va_arg(ap, const char *);
                for ( ; *s; s++) {
                    putchar1(*s);
                }
                break;
            case 'u':
                d = va_arg(ap, int);
                //itoa(d, buf, 10);
                i=0;        //转换成十进制字符 低位在前高位在后
                while(1)
                       {
                        buf[i] = d%10+'0';
                        d = d/10;
                        if(d==0)//全部转完只剩0 退出
                                break;         
                        i++;                                   
                      }
                      for(j=0;j<i;j++)//逆序
                      {
                              k=buf[j];
                              buf[j] = buf[i-j];
                              buf[i-j] = k;                                      
                      }
                      
                for ( s = buf; *s; s++) {
                    putchar1(*s);
                }
                break;
            case 'd':
                d = va_arg(ap, int);
                //itoa(d, buf, 10);
                i=0;        //转换成十进制字符 低位在前高位在后
                while(1)
                       {
                        buf[i] = d%10+'0';
                        d = d/10;
                        if(d==0)//全部转完只剩0 退出
                                break;         
                        i++;                                   
                      }
                for(j=0;j<i;j++)//逆序
                      {
                              k=buf[j];
                              buf[j] = buf[i-j];
                              buf[i-j] = k;                                      
                      }
//                if(d<0)	//if negative,add '-' ahead
//      	              {
//                        for(j=i;j>0;j--)//      	{
//                            {	
//                                buf[j+1] = buf[j];
//                            }
//                        buf[0]='-';		
//      	              }      
                for ( s = buf; *s; s++) {
                    putchar1(*s);
                }
                break;
           /* Add other specifiers here... */              
            default:  
                putchar1(*fmt);
                break;
        }
        fmt++;
    }
    va_end(ap);
    return 1;   /* Dummy return value */
}


// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=(adc_input & 0x1f) | (ADC_VREF_TYPE & 0xff);
if (adc_input & 0x20) ADCSRB |= 0x08;
else ADCSRB &= 0xf7;
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}   

                            
#pragma used+  
/**********************
发送单个字符
***********************/
void Tx0(unsigned char c)
{              
        UDR0 = c;
        while(!(UCSR0A & 0x40))
                ;
        UCSR0A |= 0x40;
        
}                         
#pragma used-

#pragma used+
/**********************
接收单个字符
***********************/    
unsigned char Rx0(void)
{              
        if(UCSR0A & 0x80)
           return UDR0;    
        else 
           return 0;
}                                   
#pragma used-
                                


// Get a character from the USART1 Receiver
#pragma used+
char getchar1(void)
{
char status,data;
while (1)
      {
      while (((status=UCSR1A) & RX_COMPLETE)==0);
      data=UDR1;
      if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
         return data;
      }
}
#pragma used-

// Write a character to the USART1 Transmitter
#pragma used+
void putchar1(char c)
{
while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
UDR1=c;
}
#pragma used-
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         