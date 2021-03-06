#include "include.h"
/*
可以发送数量可调的脉冲，但会多一个
Apr 2

16th-steps
步进角1.8

方位1:13传动比
旋转一圈需要360/1.8*13*16=41600个脉冲
运动1度需要41600/360=115.55……

俯仰传动比1：9
旋转一圈需要360/1.8*9*16=28800个脉冲
运动1度需要28800/360=80
*/
          

void Ystop(void)
{
    TCCR4A=0x0;
    TCCR4B=0x0;
    TIMSK4 =0;
}

void Xstop(void)
{
    TCCR3A=0x0;
    TCCR3B=0x0;  
    TIMSK3 =0;
}


                                                                          
// Timer4 overflow interrupt service routine
interrupt [TIM4_OVF] void timer4_ovf_isr(void)
{
   if(Ysteps-- == 1)
        {
           Ystop();
        }  
}

// Timer3 overflow interrupt service routine
interrupt [TIM3_OVF] void timer3_ovf_isr(void)
{
   if(Xsteps-- == 1)
        {
           Xstop();
        }  
}





/***************************************/
void motorInit(void)
{
	XSTEPL; 
	YSTEPL;
	
	XDIRL;
	YDIRL;
	
	XRSTH;
	YRSTH;
	delay_us(20);   //reset 
	XRSTL;
	YRSTL;
	
	XSYNCL;   //disable sync
	YSYNCL;	
}

void Xcycle(char speed)
{
    //int steps;
/* Timer/Counter 3 initialization
Clock value: 250.000 kHz
Mode: CTC top=OCR3A
OC3A output: Set
Compare A Match Interrupt: On  */
    TCCR3A=0x80;
    TCCR3B=0x13;
    TCNT3H=0x00;
    TCNT3L=0x00;
    ICR3H=0x00;
    ICR3L=speed<<2;
    OCR3AH=0x00;
    OCR3AL=0x02;
    OCR3BH=0x00;
    OCR3BL=0x00;
    OCR3CH=0x00;
    OCR3CL=0x00;
}

void Xmove(int steps,char speed)
{
    Xsteps = abs(steps);
    if(steps>0)
        XDIRH;
    else
        XDIRL;
    TCNT3H=0x00;
    TCNT3L=0x00;
    ICR3H=0x00;
    ICR3L=speed<<2;
    OCR3AH=0x00;
    OCR3AL=0x04;
    OCR3BH=0x00;
    OCR3BL=0x00;
    OCR3CH=0x00;
    OCR3CL=0x00;     
    
    TCCR3A=0x80;
    TCCR3B=0x13;
    
    TIMSK3=0x01;
}

void Ymove(int steps,char speed)
{
    Ysteps = abs(steps); 
    if(steps>0)
        YDIRL;
    else
        YDIRH;                  
// Timer/Counter 4 initialization
// Clock source: System Clock
// Clock value: 250.000 kHz
// Mode: Ph. & fr. cor. PWM top=ICR4
// OC4A output: Non-Inv.
// OC4B output: Discon.
// OC4C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer4 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
    //TCCR4C=0x00;
    TCNT4H=0x00;
    TCNT4L=0x00;
    ICR4H=0x00;
    ICR4L=speed<<2;    //ICR=32时脉冲周期256us，4us*32*2=256us
    OCR4AH=0x00;
    OCR4AL=0x04;       //OCR=4，高电平时间32us。时钟为4us计数2*4次得32us
    OCR4BH=0x00;
    OCR4BL=0x00;
    OCR4CH=0x00;
    OCR4CL=0x00;     
    
    TCCR4A=0x80;      //
    TCCR4B=0x13;
    
    TIMSK4=0x01;     
}



char motorTest(char cmd)
{
    if(cmd & 0x80)
            {
             Xcycle(0x08);
            }        
    if(cmd & 0x40)
            {
             Ymove(200,cmd & 0x0F);               
            }        
    if(cmd & 0x20)
            {
             Xmove(300,cmd & 0x0F);            
            }
    if(cmd & 0x10)
            {
             Xstop();
             Ystop();
            }
    return 1; 
}