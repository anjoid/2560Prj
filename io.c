#include "include.h"      
#include <stdarg.h>

char uprintf(const char *fmt, ...)
{
    const char *s;
    int d;
    char buf[16],i;
    va_list ap;
    va_start(ap, fmt);
    while (*fmt) {
        if (*fmt != '%') {
            putchar1(*fmt++);
            continue;
        }
        switch (*++fmt) {
            case 's':
               {
                s = va_arg(ap, char *);
                for ( ; *s; s++) 
                    {
                    putchar1(*s);
                    }
                }
                break;
            case 'u':   
                {
                    d = va_arg(ap,unsigned int);   //0~4294967295
                    i=0;        //turn d into decimal,low digit first
                    while(1)
                      {
                        buf[i] = d%10+'0';  //ASICII character
                        d = d/10;
                        if(d==0)//done
                                break;         
                        i++;                                   
                      }      
                    while(i)		//i point to the max digit,output till buf[0]
                        {
                                putchar1(buf[i]);
                                i--;               	
                        } 
                    putchar1(buf[0]);         
                }
                break;
            case 'd':
                {
                    d = va_arg(ap,signed long int);  //-2147483648~2147483647
                    
                    if(d<0)	//negative output a minus
                            putchar1('-');
                    d = abs(d);
                    i=0;        
                    while(1)
                           {
                            buf[i] = d%10+'0';
                            d = d/10;
                            if(d==0)
                                    break;         
                            i++;                                   
                          }                                               
                     while(i)
	                {
                            putchar1(buf[i]);
                            i--;               	
                	}  
                     putchar1(buf[0]);             
                }
                break;   
            case 'x':
                {
                    d = va_arg(ap,char);  //
                    buf[1] = d%0x10+'0';
                    buf[0] = d/0x10+'0';
                    if(buf[1]>'9')
                        buf[1] += 7;    
                    if(buf[0]>'9')
                        buf[0] += 7;
                    putchar1(buf[0]);
                    putchar1(buf[1]);             
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
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         