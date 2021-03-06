/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
� Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 2014-3-21
Author  : zhangjing
Company : zhangjing
Comments: 
1st edition for 2560 control board
USART1 Baud Rate: 9600

Chip type               : ATmega2560
Program type            : Application
AVR Core Clock frequency: 16.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 2048
*****************************************************/

#include "include.h"      
 
// Declare your global variables here
unsigned int tick;
unsigned int Xsteps;
unsigned int Ysteps;
//unsigned int AGCdata,last_AGCdata;
//unsigned int Xdata,last_Xdata,Ydata,last_Ydata;

void init(void)
{
      
    // Crystal Oscillator division factor: 1
    #pragma optsize-
    CLKPR=0x80;
    CLKPR=0x00;
    #ifdef _OPTIMIZE_SIZE_
    #pragma optsize+
    #endif

    // Input/Output Ports initialization
    // Port A initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
    PORTA=0x00;
    DDRA=0x00;

    // Port B initialization
    // Func7=In Func6=Out Func5=Out Func4=In Func3=In Func2=In Func1=In Func0=In 
    // State7=T State6=0 State5=0 State4=T State3=T State2=T State1=T State0=T 
    PORTB=0x00;
    DDRB=0x60;

    // Port C initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
    PORTC=0x00;
    DDRC=0x00;

    // Port D initialization
    // Func7=Out Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
    // State7=0 State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
    PORTD=0x00;
    DDRD=0x80;

    // Port E initialization
    // Func7=Out Func6=In Func5=Out Func4=Out Func3=Out Func2=In Func1=In Func0=In 
    // State7=0 State6=T State5=0 State4=0 State3=0 State2=T State1=T State0=T 
    PORTE=0x00;
    DDRE=0xBC;

    // Port F initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
    PORTF=0x00;
    DDRF=0x00;

    // Port G initialization
    // Func5=In Func4=In Func3=Out Func2=In Func1=In Func0=In 
    // State5=T State4=T State3=0 State2=T State1=T State0=T 
    PORTG=0x00;
    DDRG=0x08;

    // Port H initialization
    // Func7=Out Func6=In Func5=Out Func4=In Func3=Out Func2=Out Func1=In Func0=In 
    // State7=0 State6=T State5=0 State4=T State3=0 State2=0 State1=T State0=T 
    PORTH=0x00;
    DDRH=0xAC;

    // Port J initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
    PORTJ=0x00;
    DDRJ=0x00;

    // Port K initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
    PORTK=0x00;
    DDRK=0x00;

    // Port L initialization
    // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
    // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
    PORTL=0x00;
    DDRL=0x00;

    // Timer/Counter 0 initialization
    // Clock source: System Clock
    // Clock value: Timer 0 Stopped
    // Mode: Normal top=0xFF
    // OC0A output: Disconnected
    // OC0B output: Disconnected
    TCCR0A=0x00;
    TCCR0B=0x00;
    TCNT0=0x00;
    OCR0A=0x00;
    OCR0B=0x00;

    // Timer/Counter 1 initialization
    // Clock source: System Clock
    // Clock value: Timer1 Stopped
    // Mode: Normal top=0xFFFF
    // OC1A output: Discon.
    // OC1B output: Discon.
    // OC1C output: Discon.
    // Noise Canceler: Off
    // Input Capture on Falling Edge
    // Timer1 Overflow Interrupt: Off
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    // Compare C Match Interrupt: Off
    TCCR1A=0x00;
    TCCR1B=0x00;
    TCNT1H=0x00;
    TCNT1L=0x00;
    ICR1H=0x00;
    ICR1L=0x00;
    OCR1AH=0x00;
    OCR1AL=0x00;
    OCR1BH=0x00;
    OCR1BL=0x00;
    OCR1CH=0x00;
    OCR1CL=0x00;

    // Timer/Counter 2 initialization
    // Clock source: System Clock
    // Clock value: Timer2 Stopped
    // Mode: Normal top=0xFF
    // OC2A output: Disconnected
    // OC2B output: Disconnected
    ASSR=0x00;
    TCCR2A=0x00;
    TCCR2B=0x00;
    TCNT2=0x00;
    OCR2A=0x00;
    OCR2B=0x00;

    // Timer/Counter 3 initialization
    // Clock source: System Clock
    // Clock value: Timer3 Stopped
    // Mode: Normal top=0xFFFF
    // OC3A output: Discon.
    // OC3B output: Discon.
    // OC3C output: Discon.
    // Noise Canceler: Off
    // Input Capture on Falling Edge
    // Timer3 Overflow Interrupt: Off
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    // Compare C Match Interrupt: Off
    TCCR3A=0x00;
    TCCR3B=0x00;
    TCNT3H=0x00;
    TCNT3L=0x00;
    ICR3H=0x00;
    ICR3L=0x00;
    OCR3AH=0x00;
    OCR3AL=0x00;
    OCR3BH=0x00;
    OCR3BL=0x00;
    OCR3CH=0x00;
    OCR3CL=0x00;

    // Timer/Counter 4 initialization
    // Clock source: System Clock
    // Clock value: Timer4 Stopped
    // Mode: Normal top=0xFFFF
    // OC4A output: Discon.
    // OC4B output: Discon.
    // OC4C output: Discon.
    // Noise Canceler: Off
    // Input Capture on Falling Edge
    // Timer4 Overflow Interrupt: Off
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    // Compare C Match Interrupt: Off
    TCCR4A=0x00;
    TCCR4B=0x00;
    TCNT4H=0x00;
    TCNT4L=0x00;
    ICR4H=0x00;
    ICR4L=0x00;
    OCR4AH=0x00;
    OCR4AL=0x00;
    OCR4BH=0x00;
    OCR4BL=0x00;
    OCR4CH=0x00;
    OCR4CL=0x00;

    // Timer/Counter 5 initialization
    // Clock source: System Clock
    // Clock value: Timer5 Stopped
    // Mode: Normal top=0xFFFF
    // OC5A output: Discon.
    // OC5B output: Discon.
    // OC5C output: Discon.
    // Noise Canceler: Off
    // Input Capture on Falling Edge
    // Timer5 Overflow Interrupt: Off
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    // Compare C Match Interrupt: Off
    TCCR5A=0x00;
    TCCR5B=0x00;
    TCNT5H=0x00;
    TCNT5L=0x00;
    ICR5H=0x00;
    ICR5L=0x00;
    OCR5AH=0x00;
    OCR5AL=0x00;
    OCR5BH=0x00;
    OCR5BL=0x00;
    OCR5CH=0x00;
    OCR5CL=0x00;

    // External Interrupt(s) initialization
    // INT0: Off
    // INT1: Off
    // INT2: Off
    // INT3: Off
    // INT4: Off
    // INT5: Off
    // INT6: Off
    // INT7: Off
    EICRA=0x00;
    EICRB=0x00;
    EIMSK=0x00;
    // PCINT0 interrupt: Off
    // PCINT1 interrupt: Off
    // PCINT2 interrupt: Off
    // PCINT3 interrupt: Off
    // PCINT4 interrupt: Off
    // PCINT5 interrupt: Off
    // PCINT6 interrupt: Off
    // PCINT7 interrupt: Off
    // PCINT8 interrupt: Off
    // PCINT9 interrupt: Off
    // PCINT10 interrupt: Off
    // PCINT11 interrupt: Off
    // PCINT12 interrupt: Off
    // PCINT13 interrupt: Off
    // PCINT14 interrupt: Off
    // PCINT15 interrupt: Off
    // PCINT16 interrupt: Off
    // PCINT17 interrupt: Off
    // PCINT18 interrupt: Off
    // PCINT19 interrupt: Off
    // PCINT20 interrupt: Off
    // PCINT21 interrupt: Off
    // PCINT22 interrupt: Off
    // PCINT23 interrupt: Off
    PCMSK0=0x00;
    PCMSK1=0x00;
    PCMSK2=0x00;
    PCICR=0x00;

    // Timer/Counter 0 Interrupt(s) initialization
    TIMSK0=0x00;

    // Timer/Counter 1 Interrupt(s) initialization
    TIMSK1=0x00;

    // Timer/Counter 2 Interrupt(s) initialization
    TIMSK2=0x00;

    // Timer/Counter 3 Interrupt(s) initialization
    TIMSK3=0x00;

    // Timer/Counter 4 Interrupt(s) initialization
    TIMSK4=0x00;

    // Timer/Counter 5 Interrupt(s) initialization
    TIMSK5=0x00;

    // USART0 initialization
    // USART0 disabled
 
    UCSR0B=0x0;

    // USART1 initialization
    // Communication Parameters: 8 Data, 1 Stop, No Parity
    // USART1 Receiver: On
    // USART1 Transmitter: On
    // USART1 Mode: Asynchronous
    // USART1 Baud Rate: 9600
    UCSR1A=0x00;
    UCSR1B=0x18;
    UCSR1C=0x06;
    UBRR1H=0x00;
    UBRR1L=0x67;

    // USART2 initialization
    // USART2 disabled
    UCSR2B=0x00;

    // USART3 initialization
    // USART3 disabled
    UCSR3B=0x00;

    // Analog Comparator initialization
    // Analog Comparator: Off
    // Analog Comparator Input Capture by Timer/Counter 1: Off
    ACSR=0x80;
    ADCSRB=0x00;
    //DIDR1=0x00;
    DIDR0=0x00;
    // Digital input buffers on ADC8: On, ADC9: On, ADC10: On, ADC11: Off
    // ADC12: Off, ADC13: Off, ADC14: On, ADC15: On
    DIDR2=0xFF;
    ADMUX=ADC_VREF_TYPE & 0xff;
    ADCSRA=0x83;      //ADPS=111  division factor 128,adc source clock equals to 125khz

    // SPI initialization
    // SPI disabled
    SPCR=0x00;

    // TWI initialization
    // TWI disabled
    TWCR=0x00;  
    
    EI;                
}


void track(void)
{  
 unsigned int lastTick,firstTick; 
 unsigned int data[500][3]; 
 unsigned char pp[500]={0};
 unsigned int kk;
     /*
     generate 50 hz interrupt 
     */              
    TCCR1B=0x0C;
    OCR1AH=0x04;      //0x4e2=1250    62.5khz/1250=50hz
    OCR1AL=0xE2;       
    TIMSK1=0x02;      // Timer/Counter 1 Interrupt(s) initialization
    
    tick=5;
    //AGCdata= Xdata =Ydata =0;  
    kk = 0;
    lastTick = tick;
    firstTick = lastTick;
    do
        {
           while(lastTick == tick)
                ;           
           data[kk][0] = AGC_ORG;                     //AGC
           data[kk][1] = GYROX;                       //X gyro
           data[kk][2] = GYROY;                       //Y gyro
           //pp[kk] = (Xsteps>0) | (Ysteps>0);
//           if(Xsteps>1)
//            pp[kk] |= 0xf0;
//           else
//            pp[kk] &= 0x0f;
//           if(Ysteps>1)
//            pp[kk] |= 0x0f;
//           else
//            pp[kk] &= 0xf0;
            pp[kk] = TIMSK3;     //pulse state
             
           if(tick == (firstTick+50))     //at 1st second
                {
                 LED_OFF;
                 Xmove(6933,10);      //clockwise 60degree 
                }
           else if(tick == (firstTick+100))//at 2nd second
                {
                 LED_ON;
                 //Ymove(2400,10);          //30degree upward
                 }      
           else if(tick == (firstTick+200))//at 4th second
                {
                 LED_OFF; 
                 Xmove(-10400,8);   // 90degree counterclockwise
                 } 
           else if(tick == (firstTick+275))//at 5.5 second
                 {
                 LED_ON;
                 //Ymove(-2400,8); 
                 }       
           else if(tick == (firstTick+400))//at 8th second
                {
                 LED_OFF; 
                 Xmove(3467,8);   // 30degree clockwise
                 }    
           kk++;
           lastTick = tick;    
        }
    while(tick<=firstTick+500);       //500 ticks mean 10s     
    
    LED_OFF;  
    TIMSK1=0x00;        //stop timer 1
    TCCR1B=0x00;
    uprintf("read done!%d %d\n",firstTick,tick);
    while(getchar1()!= 'K')
        ;
    LED_ON;         
    for(kk=0;kk<500;kk++)
        {
            uprintf("AXY %d : %d %d %d\n",pp[kk],data[kk][0],data[kk][1],data[kk][2]);                
        }
    
//    for(cnt=0;cnt<5;cnt++)        
//     {
//       AGCdata = AGCdata + AGC_ORG;        //read  AGC 5 times
//       Xdata = Xdata + GYROX;            //read X gyro 5 times
//       Ydata = Ydata + GYROY;           //read Y gyro 5 times
//     }
//     
//    if (AGCdata<last_AGCdata)    //if AGC decreased
//      {
//        if(Xdata<512*5)      //clock wise 
//            {
//                   Xmove(50,10);
//            }
//        else
//            {
//            
//            }
//        if(Ydata<last_Ydata)
//            {
//            
//            }
//        else
//            {
//                    
//            } 
//      }
//     
//     
//    last_Xdata = Xdata;
//    last_Ydata = Ydata;
//    last_AGCdata = AGCdata;
}


/*
��ƽ̨��ֹ���Ѿ���ȡ��AGC�ź�������ͨ����������ɨ��Ѱ��AGC���λ��
*/

void maxAGC(void)
{
 char cnt;   
 
 unsigned int AGCpre,AGCpost,AGCprsnt;
 
 do
 {    
     AGCpre=AGCpost=AGCprsnt=0; 
     for(cnt=0;cnt<10;cnt++)        
       {
            AGCprsnt = AGCprsnt + AGC_ORG;        //read  pesent AGC 10 times
       }         
       
     Xmove(50,10);          // move RIGHT 1 step
     while(XMOVING)
            ;                
     delay_ms(100);       
     for(cnt=0;cnt<10;cnt++)        
       {
            AGCpre = AGCpre + AGC_ORG;        //read  left AGC 10 times
       }  
     
     Xmove(-100,10);          // move LEFT 2 steps
     while(XMOVING)
            ;             
     delay_ms(100);            
     for(cnt=0;cnt<10;cnt++)        
       {
            AGCpost = AGCpost + AGC_ORG;        //read  right AGC 10 times
       }                           
                                   
     /*        
     ignore sample error  
     */  
     AGCprsnt &= AGCprsnt & 0xFFF0;  
     AGCpre &= AGCpre & 0xFFF0;
     AGCpost &= AGCpost & 0xFFF0;
       
     if(AGCpre>AGCprsnt)         //if left stronger than present,move left 2steps and do this again
        {
           Xmove(100,10);
           cnt = 2;
        }   
     else if(AGCpost>AGCprsnt)    //if right stronger than present, do this again
        {
           cnt = 1;     
        }  
       
     if(AGCprsnt>=AGCpre && AGCprsnt>=AGCpost)   //if present is strongest, move left 1 step back
        {
           cnt=0;
           Xmove(50,10);
        }   
      
     uprintf("RML: %d %d %d %d\n",AGCpre,AGCprsnt,AGCpost,cnt);  
     if(getchar1()=='X')
        return ; //wait until next cmd  
               
  }
  while(cnt);          
   
 do
 {    
     AGCpre=AGCpost=AGCprsnt=0; 
     for(cnt=0;cnt<10;cnt++)        
       {
            AGCprsnt = AGCprsnt + AGC_ORG;        //read  present AGC 10 times
       }   
       
     Ymove(50,10);          // move up 1 step
     while(YMOVING)
            ;           
     delay_ms(100);
     for(cnt=0;cnt<10;cnt++)        
       {
            AGCpre = AGCpre + AGC_ORG;        //read  up AGC 10 times
       }  
     
     Ymove(-100,10);          // move down 2 steps
     while(YMOVING)
            ;             
     delay_ms(100);
     for(cnt=0;cnt<10;cnt++)        
       {
            AGCpost = AGCpost + AGC_ORG;        //read  down AGC 10 times
       }                                                                
     /*        
     ignore sample error  
     */  
     AGCprsnt &= AGCprsnt & 0xFFF0;  
     AGCpre &= AGCpre & 0xFFF0;
     AGCpost &= AGCpost & 0xFFF0;       
       
     if(AGCpre>AGCprsnt)         //if up stronger than present,move up 2steps back and do this again
        {
           Ymove(100,10);
           cnt = 2;
        }   
     else if(AGCpost>AGCprsnt)    //if down stronger than present, do this again
        {
           cnt = 1;     
        }  
     if(AGCprsnt>=AGCpre && AGCprsnt>=AGCpost)   //if present is strongest, move up 1 step back
        {
           cnt=0;
           Ymove(50,10);
        } 
     uprintf("UMD: %d %d %d %d\n",AGCpre,AGCprsnt,AGCpost,cnt);   
     if(getchar1()=='X')
        return ; //wait until next cmd                
  }
  while(cnt);  
  uprintf("Max AGC Found!\n"); 
}
 

void main(void)
{
// Declare your local variables here

    long int LNB_frequence; 
    long int sate_frequence;//
    unsigned long TunerFreq;
    long int symbol_rate;    
    char str[16] = "jingle bells"; 
    unsigned int uint;
    signed int sint;       
    unsigned char uchar;    
    unsigned int adc[3];
    unsigned int adcbuf[3];
    
    LNB_frequence =10750;//11300;     
    
    
    /*
    11892 08800   L    
    12100 28800   R
    12140 28800   R
    */ 
    sate_frequence =11892;//11880; //92.2
    symbol_rate  =8800;//28800;   //
    
    init();          
    
    LED_ON;
    delay_ms(200);
    LED_OFF;
    delay_ms(200);   
    LED_ON;
    delay_ms(200);
    LED_OFF;
    delay_ms(200);
    LED_ON;
    delay_ms(200);
    LED_OFF;
    delay_ms(500);
    putchar1('A');
    putchar1('B');
    putchar1('C'); 
    
    while (1)
          {  
            LED_OFF; 
            switch (getchar1()) 
            {
                case 'H':  //��ȡtuner��AGC��ѹֵ��AGC2�Ĵ�����ֵ
                    {     
                    	uprintf("AGC/AGC1/AGC2: ");
                        //tuner(TunerFreq,symbol_rate);          
                        uint = AGC_ORG;
                        uprintf("%d ",uint);
                        uint = Get0288Register(0x10);
                        uprintf("%d ",uint);
                        uint = GetAGC();
                        uprintf("%d\n",uint);
                    }
                    break;    
                case 'A':    //read analog voltage from gyro interface every 5 millisecond for 1000 times
                    {
                        LED_ON;
                        uchar = getchar1();
                        if(uchar == 'A')   
                         {
                                uint = AGC_ORG;
                                uprintf("AGC: %d\n",uint);
                         }
                       else if(uchar == 'X')
                         {
                               uint = GYROX;
                               uprintf("X: %d\n",uint);       
                         }
                       else if(uchar == 'Y')
                         {
                               uint = GYROY;
                               uprintf("Y: %d\n",uint);       
                         }  
                       else if(uchar == 'W')
                         {
                               uprintf("AGC/X/Y: ");
                               uint = AGC_ORG;
                               uprintf(" %d",uint); 
                               uint = GYROX;
                               uprintf(" %d",uint);
                               uint = GYROY;
                               uprintf(" %d\n",uint);      
                         }  
                    }
                    break;   
                case 'B': 
                    {
                        LED_ON;
                        uchar = getchar1(); //0~9
                        if(uchar < '5')
                                Xmove(2300,(uchar-0x2A));
                        else
                                Xmove(-2300,(uchar-0x2F));
                        uchar=50;
                        while(uchar--)
                            {
                                delay_ms(10);
                                uprintf("gyroX/gyroY: %d %d \n",GYROX,GYROY);   
                            }
                    }
                    break;   
                case 'C': 
                    {

                        LED_ON;
                        uchar = getchar1(); //0~9
                        if(uchar < '5')
                                Ymove(2300,(uchar-0x2A));
                        else
                                Ymove(-2300,(uchar-0x2F));
                        uchar=50;
                        while(uchar--)
                            {
                                delay_ms(10);
                                uprintf("gyroX/gyroY: %d %d \n",GYROX,GYROY);   
                            }
                    }
                    break;   
                case 'F': 
                    { 
                      maxAGC();                   
                    }  
                    break;
                case 'M': //motor control commands in 2 bytes 
                    {
                       LED_ON;
                       uchar = getchar1();
                       uprintf("motor test with \"");
                       putchar1(uchar);
                       if(uchar == 'U')   
                         Ymove(140,10);
                       else if(uchar == 'D')
                         Ymove(-140,10);
                       else if(uchar == 'R')
                         Xmove(140,13);
                       else if(uchar == 'L')
                         Xmove(-140,13);    
                       else if(uchar == 'T')
                         motorTest(0x69); 
                       else if(uchar == 'I')   
                         motorInit();
                       else if(uchar == '1')
                         Ymove(1220,13);   
                       else if(uchar == '2')
                         Ymove(-1220,8);   
                       else if(uchar == '3')
                         Xmove(1220,8);   
                       else if(uchar == '4')
                         Xmove(-1220,8);   
                       else 
                         {
                            Xstop();
                            Ystop();
                         } 
                       uint = AGC_ORG;
                       uprintf("///AGC: %d\n",uint);
                    }
                    break;              
                case 'm': 
                    {     
                       LED_ON;
                       uprintf("Enter Xx or Yy:");
                       str[0] = getchar1();
                       putchar1(str[0]);
                       uprintf(".Enter speed 0~9:");
                       str[1] = getchar1();
                       putchar1(str[1]);  
                       str[1] = str[1]-0x2A;                       
                       uprintf(".Enter angles in hex:");
                       str[2] = getchar1();
                       uprintf("%d GO!\n",str[2]);
                       
                       //start tick
                       TCCR1B=0x0C;
                       OCR1AH=0x04;       //0x4e2=1250    62.5khz/1250=50hz
                       OCR1AL=0xE2;
                       TIMSK1=0x02;
                       tick=0;             
                       
                       if(str[0] == 'X')
                        {
                         sint = str[2] * 115;        
                         Xmove(sint,str[1]);
                        }
                       else if(str[0] == 'x')
                        {
                         sint = (-1) * str[2] * 115;        
                         Xmove(sint,str[1]);
                        }
                       else if(str[0] == 'Y')
                        {
                         sint = str[2] * 80;
                         Ymove(sint,str[1]);
                        } 
                       else if(str[0] == 'y')
                        {
                         sint = (-1) * str[2] * 80;
                         Ymove(sint,str[1]);
                        }                  
                        
                        while((Xsteps>0) ||(Ysteps>0))
                        ;
                        uchar = tick; 
                        
                        
                        //stop tick
                        TCCR1B=0x00;
                        TIMSK1=0x00;
                        
                        uprintf("move %d degree at speed %d use %d ticks\n",str[2],str[1],uchar);
                    }
                    break;   
                case 'R':   //get register value from stv0288
                    {     
                        LED_ON;
                        uprintf("Enter register addr:");
                        uchar = getchar1();  
                        //Get0288Register(uchar);
                        uprintf("Register 0x%x value is 0x%x\n",uchar,Get0288Register(uchar));                             
                    }
                    break; 
                case 'S': 
                    { 
                      tunerTest(0x0A);                   
                    }
                    break;   
                case 'K': 
                    { 
                     LED_ON; 
                     track();                   
                    }
                    break;  
                case 'k': 
                    { 
                     LED_ON; 
                     /*
                     generate 10 hz interrupt 
                     */              
                     TCCR1B=0x0C;
                     OCR1AH=0x18;      //0x186A=6250    62.5khz/6250=10hz
                     OCR1AL=0x6A;       
                     TIMSK1=0x02;      // Timer/Counter 1 Interrupt(s) initialization
                     tick=0;    
                    
                    uint = tick;
                    do
                        {
                           while(uint == tick)
                                ; 
                           adc[0] = AGC_ORG;
                           adc[1] = GYROX;
                           adc[2] = GYROY;  
                           uprintf("AGC/X/Y: %d %d %d  ",adc[0],adc[1],adc[2]);
                           
                           if(uint == 0)
                                adcbuf[0] = adc[0];     //at first time,set the highest agc as present value   
                                    
                           if( adc[0] < (adcbuf[0]-3) )  //agc turn weak obviously
                            {
                                    uprintf("Weak, ");
                                   
                                   if(adc[1]<507)
                                    {
                                         uprintf("RightMoving, 600 ");
                                    }                                   
                                   else if(adc[1]>517)
                                   {
                                         uprintf("LeftMoving, 400 ");
                                   }
                                   else
                                         uprintf(" M 500 ");
                                   if(adc[2]>517)
                                    {
                                        uprintf("Downwards 400 ");
                                    }                                   
                                   else if(adc[2]<507)
                                   {
                                       uprintf("upwards 600 ");
                                   }  
                                   else
                                         uprintf("M 500 ");
                            }          
                           else if( adc[0] > (adcbuf[0]) )   //if agc higher than present highest value, update it smoothly
                            {
                                 adcbuf[0] = (adc[0] + adcbuf[0])/2;  
                                 uprintf("new highest agc: %d ",adcbuf[0]);
                            } 
                           //adc[3] = (adc[0]+adc[3])/2;  //adc[3] save the smoothed agc value   (agc+last_agc)/2
                           if(tick > 20000)
                                tick = 1;   //avoid tick overflow
                           uint = tick;  
                           putchar1('\n');
                        }
                    while(UDR1!='x');    



                    } 
                    break;       
                case 't': 
                    { 
                     LED_ON; 
//                     /*
//                     generate 10 hz interrupt 
//                     */              
//                        TCCR1B=0x0C;
//                        OCR1AH=0x18;      //0x186A=6250    62.5khz/6250=10hz
//                        OCR1AL=0x6A;       
//                        TIMSK1=0x02;      // Timer/Counter 1 Interrupt(s) initialization
//                        tick=0;  
                     for(uint=0;uint<25;uint++)
                        {
                         for(uchar=0;uchar<30;uchar++)
                                {
                                    Xmove(115,14);              //1 degree right
                                    delay_ms(700);
                                    uprintf("%d ",AGC_ORG);
                                } 
                         Xmove(-3480,8);        //30 degrees 
                         putchar1('\n');   
                         Ymove(80,10);    //0.5 degree up
                         delay_ms(2000);  
                        } 
                     uprintf("DONE!\n");                      
                    }
                    break;
                case 'T':     //set tuner 
                    {  
                     LED_ON; 
                     uchar = getchar1();
                     //uprintf("\"\n");            
                     
                     if(uchar == '0')    
                         {
                                sate_frequence =12100;
                                symbol_rate  =28800;   
                         }
                     else if(uchar == '1')    
                         {
                                sate_frequence =11892;
                                symbol_rate  =8800;   
                         }
                     else if(uchar == '2')
                         {
                                sate_frequence =11920;
                                symbol_rate  =28800;   
                         }                                                                 
                     else if(uchar == '3')                            
                         {
                                sate_frequence =11960;
                                symbol_rate  =28800;   
                         }                                                                 
                     else if(uchar == '4')                            
                         {
                                sate_frequence =11980;
                                symbol_rate  =28800;   
                         }                                                            
                     else if(uchar == '5')                            
                         {
                                sate_frequence =12020;
                                symbol_rate  =28800;   
                         }                                                            
                     else if(uchar == '6')                            
                         {
                                sate_frequence =12060;
                                symbol_rate  =28800;   
                         }                                                            
                     else if(uchar == '7')                            
                         {
                                sate_frequence =11940;
                                symbol_rate  =28800;   
                         }
                     
                     
                     uprintf("tuner set %d - %d\n",sate_frequence,symbol_rate);
                        
                     TunerFreq = (labs(sate_frequence-LNB_frequence))*1000;  
                     if(tuner(TunerFreq,symbol_rate))
                        putchar1('L');
                     else
                        putchar1('l');   
                    }
                    break;               
                case 'U': 
                    {         
                       uprintf("string means %s\n",str);   
                       uchar = 0x33;
                       uprintf("hex 0x%x 0x%x\n",uchar,uchar+16);        
                       uchar = 0xEC;
                       uprintf("hex 0x%x\n",uchar);
                                              
                       uint = 32879;
                       sint = -23456;
                       uprintf("unsigned & signed int number:%u %d\n",uint,sint);
                       uint = -2561;
                       sint = 13456;
                       uprintf("unsigned & signed int number:%u %d\n",uint,sint); 
                       uint = 105;
                       sint = -123;
                       uprintf("unsigned & signed int number:%u %d\n",uint,sint);                      
                    }
                    break;    
            default:
            };
                        
          }
}
