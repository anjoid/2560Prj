/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
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
unsigned int Xsteps;
unsigned int Ysteps;


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
    ADCSRA=0x87;

    // SPI initialization
    // SPI disabled
    SPCR=0x00;

    // TWI initialization
    // TWI disabled
    TWCR=0x00;  
    
    EI;                
}






void main(void)
{
// Declare your local variables here

    long int LNB_frequence; 
    long int sate_frequence;//
    unsigned long TunerFreq;
    float symbol_rate;    
    char str[16] = "jingle bells"; 
    unsigned int uint;
    signed int sint;       
    unsigned char uchar;    
    LNB_frequence =10750;//11300;      
    sate_frequence =11880; //92.2
    symbol_rate  =28800;   //
    TunerFreq = (labs(LNB_frequence-sate_frequence))*1000; 
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
           // Place your code here     
            LED_OFF; 
            switch (getchar1()) 
            {
                case 'H':  //¶ÁÈ¡tunerµÄAGCµçÑ¹ÖµºÍAGC2¼Ä´æÆ÷µÄÖµ
                    {     
                    	uprintf("AGC analog number & AGC register number & lock: ");
                        //tuner(TunerFreq,symbol_rate);          
                        uint = AGC_ORG;
                        uprintf("%d ",uint);
                        uint = GetAGC();
                        uprintf("%d %x\n",uint,tunerTest(0));
                    }
                    break;    
                case 'A':    //read analog voltage from gyro interface every 5 millisecond for 1000 times
                    {
                        LED_ON;
                        uchar = getchar1();
                        if(uchar == 'A')   
                         {
                                uint = AGC_ORG;
                                uprintf("AGC:%d\n",uint);
                         }
                       else if(uchar == 'X')
                         {
                               uint = GYRO1;
                               uprintf("X:%d\n",uint);       
                         }
                       else if(uchar == 'Y')
                         {
                               uint = GYRO2;
                               uprintf("Y:%d\n",uint);       
                         }  
                         
//                        Xcycle(uchar);
//                       	uint = 1000;
//                       	while(uint--)
//                        	{
//                        		delay_ms(5);
//                        		uprintf("gyro1:%d gyro2:%d AGC:%d\n",GYRO1,GYRO2,AGC_ORG); 
//                    		}
//                    	Xstop();	
                    }
                    break;   
                case 'B': 
                    {
                        LED_ON;
                        uprintf("gyro1:%d gyro2:%d AGC:%d\n",GYRO1,GYRO2,AGC_ORG); 
                    }
                    break;   
                case 'C': 
                    {
                        LED_ON;
                        uprintf("tuner initiation..."); 
                        tuner(TunerFreq,symbol_rate);                         
                        uprintf("lock = %x...done!\n",tunerTest(0));
                        for(uchar=0;uchar<25;uchar++)
                            {
                               //putchar1('A');
                                uprintf("%d:",uchar);
                                for(sint=0;sint<25;sint++)
                                    {
                                        //putchar1('B');
                                        Ymove(100,10);
                                        uprintf("%d ",GetAGC);   
                                        delay_ms(300);       
                                    }    
                                Ymove(-1500,13);  
                                Xmove(100,10);
                                delay_ms(1600);  
                                putchar1('\n');
                            }
                    }
                    break;
                case 'M': //motor control commands in 2 bytes 
                    {
                       LED_ON;
                       uchar = getchar1();
                       uprintf("motor test with \"");
                       putchar1(uchar);
                       uprintf("\"\n"); 
                       if(uchar == 'U')   
                         Ymove(190,10);
                       else if(uchar == 'D')
                         Ymove(-220,13);
                       else if(uchar == 'R')
                         Xmove(200,13);
                       else if(uchar == 'L')
                         Xmove(-200,13);    
                       else if(uchar == 'T')
                         motorTest(0x69); 
                       else if(uchar == 'I')   
                         motorInit();
                       else if(uchar == '1')
                         Ymove(1220,13);   
                       else if(uchar == '2')
                         Ymove(-1220,5);   
                       else if(uchar == '3')
                         Xmove(1220,13);   
                       else if(uchar == '4')
                         Xmove(-1220,5);   
                       else 
                         {
                            Xstop();
                            Ystop();
                         } 
                    }
                    break;              
                case 'L': 
                    {     
                       Ymove(-220,8);
                       delay_ms(5);
                       uprintf("4-%d ",Ysteps); 
                       delay_ms(5);
                       uprintf("5-%d ",Ysteps);
                       delay_ms(5);
                       uprintf("6-%d.TCCR4-0x%x0x%x,TIMSK4-0x%x \n",Ysteps,TCCR4A,TCCR4B,TIMSK4); 
                    }
                    break;   
                case 'R':   //get register value from stv0288
                    {     
                        LED_ON;
                        uprintf("Enter register addr:");
                        uchar = getchar1();  
                        Get0288Register(uchar);
                        //uprintf("Register 0x%x value is 0x%x\n",uchar,Get0288Register(uchar));                             
                    }
                    break; 
                case 'S': 
                    { 
                      uprintf("tuner test...");   
                      tunerTest(0);         
                      uprintf("...done\n");                      
                    }
                    break;     
                case 'T':     //set tuner 
                    {  
                     LED_ON;   
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
