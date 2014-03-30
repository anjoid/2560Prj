#include "include.h"

// Timer3 output compare A interrupt service routine
interrupt [TIM3_COMPA] void timer3_compa_isr(void)
{
// Place your code here

}

// Timer4 output compare A interrupt service routine
interrupt [TIM4_COMPA] void timer4_compa_isr(void)
{
// Place your code here

}

/***************************************/

void Xcycle(char speed)
{
    //int steps;
/* Timer/Counter 3 initialization
Clock value: 250.000 kHz
Mode: CTC top=OCR3A
OC3A output: Set
Compare A Match Interrupt: On  */
    TCCR3A=0xC1;
    TCCR3B=0x0B;
    TCNT3H=0x00;
    TCNT3L=speed;
    ICR3H=0x00;
    ICR3L=0x00;
    OCR3AH=0x00;
    OCR3AL=0xF6;
    OCR3BH=0x00;
    OCR3BL=0x00;
    OCR3CH=0x00;
    OCR3CL=0x00;

    
    
    
//    PORTH6 = 1;
//    XSYNC=0;
//    XDIR=0;
//    XSTEP=0;
//
//    delay_ms(50);
//    XRST=0;
//    delay_ms(5);
//    XRST=1;
//
//    delay_ms(50);
//    XSYNC=1;
//    delay_ms(10);
//    XSYNC=1;
//
//    steps = 100;
//    while(steps--)
//    {
//        XSTEP=1;
//        delay_ms(2);
//        XSTEP=0;
//        delay_ms(speed);
//    }
//    
//    delay_ms(50);
//    
//    XDIR=1;
//    steps = 100;
//    while(steps--)
//    {
//        XSTEP=1;
//        delay_ms(2);
//        XSTEP=0;
//        delay_ms(speed);
//    }

}


void Ymove(int steps,char speed)
{
    Ysteps = steps;
    /*Clock value: 250.000 kHz
    // Mode: Ph. & fr. cor. PWM top=ICR4
    // OC4A output: Inverted
    // Compare A Match Interrupt: On   */
    TCCR4A=0xC0;
    TCCR4B=0x0b;
    TCNT4H=0x00;
    TCNT4L=0x08;
    ICR4H=0x00;
    ICR4L=speed;
    OCR4AH=0x00;
    OCR4AL=0x26;
    OCR4BH=0x00;
    OCR4BL=0x00;
    OCR4CH=0x00;
    OCR4CL=0x00;






//    
//    YRST=1;
//    YSYNC=0;
//    YDIR=0;
//    YSTEP=0;
//
//    delay_ms(50);
//    YRST=0;
//    delay_ms(5);
//    YRST=1;
//
//    delay_ms(50);
//    YSYNC=1;
//    delay_ms(10);
//    YSYNC=0;
//
//    steps = 100;
//    while(step--)
//    {
//        YSTEP=1;
//        delay_ms(2);
//        YSTEP=0;
//        delay_ms(speed);
//    }
//    
//    delay_ms(50);
//    
//    YDIR=1;
//    steps = 100;
//    while(step--)
//    {
//        YSTEP=1;
//        delay_ms(2);
//        YSTEP=0;
//        delay_ms(speed);
//    }                            
}


void Xmove(int steps,char speed)
{
   
}

void Ystop(void)
{
    TCCR4A=0x0;
    TCCR4B=0x0;
}

void Xstop(void)
{
    TCCR3A=0x0;
    TCCR3B=0x0;
}




char motorTest(char cmd)
{
    if(cmd & 0x80)
            {
             Xcycle(cmd & 0x0F);
            }        
    if(cmd & 0x40)
            {
             Ymove(10000,cmd & 0x0F);               
            }        
    if(cmd & 0x20)
            {
            
            
            }
    if(cmd & 0x10)
            {
             Xstop();
             Ystop();
            }
    return 1; 
}