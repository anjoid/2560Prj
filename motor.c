#include "include.h"

/***************************************/

void Xcycle(char speed)
{
    int steps;
    
    PORTH6 = 1;
    XSYNC=0;
    XDIR=0;
    XSTEP=0;

    delay_ms(50);
    XRST=0;
    delay_ms(5);
    XRST=1;

    delay_ms(50);
    XSYNC=1;
    delay_ms(10);
    XSYNC=1;

    steps = 100;
    while(steps--)
    {
        XSTEP=1;
        delay_ms(2);
        XSTEP=0;
        delay_ms(speed);
    }
    
    delay_ms(50);
    
    XDIR=1;
    steps = 100;
    while(steps--)
    {
        XSTEP=1;
        delay_ms(2);
        XSTEP=0;
        delay_ms(speed);
    }

}


void Ymove(int steps,char speed)
{
    int step = steps;
    
    YRST=1;
    YSYNC=0;
    YDIR=0;
    YSTEP=0;

    delay_ms(50);
    YRST=0;
    delay_ms(5);
    YRST=1;

    delay_ms(50);
    YSYNC=1;
    delay_ms(10);
    YSYNC=0;

    steps = 100;
    while(step--)
    {
        YSTEP=1;
        delay_ms(2);
        YSTEP=0;
        delay_ms(speed);
    }
    
    delay_ms(50);
    
    YDIR=1;
    steps = 100;
    while(step--)
    {
        YSTEP=1;
        delay_ms(2);
        YSTEP=0;
        delay_ms(speed);
    }                    	
}


void Xmove(int steps,char speed)
{
   
}

void Ystop(void)
{
	
}

void Xstop(void)
{
	
}




char motorTest(char cmd)
{
    if(cmd & 0x80)
    	{
    	 Xcycle(2);
    	}	
    if(cmd & 0x40)
    	{
    	 Ymove(100,2);       	
    	}	
    if(cmd & 0x20)
    	{
    	
    	
    	}
    if(cmd & 0x10)
    	{
    	
    	
    	}
    return 1; 
}