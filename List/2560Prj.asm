
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega2560
;Program type             : Application
;Clock frequency          : 16.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 2048 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega2560
	#pragma AVRPART MEMORY PROG_FLASH 262144
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 8703
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x200

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x74
	.EQU XMCRB=0x75
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0200
	.EQU __SRAM_END=0x21FF
	.EQU __DSTACK_SIZE=0x0800
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_LVCO_FREQS:
	.DB  0xF0,0x7E,0xE,0x0,0x10,0xCD,0xE,0x0
	.DB  0x10,0xCD,0xE,0x0,0x28,0x40,0x10,0x0
	.DB  0x28,0x40,0x10,0x0,0x50,0xDA,0x11,0x0
_HVCO_FREQS:
	.DB  0x50,0xDA,0x11,0x0,0x20,0xD6,0x13,0x0
	.DB  0x20,0xD6,0x13,0x0,0x88,0xC,0x16,0x0
	.DB  0x88,0xC,0x16,0x0,0x58,0x85,0x18,0x0
	.DB  0x58,0x85,0x18,0x0,0x50,0x21,0x1B,0x0
	.DB  0x50,0x21,0x1B,0x0,0xF0,0xA1,0x1D,0x0
	.DB  0xF0,0xA1,0x1D,0x0,0x38,0x84,0x20,0x0
	.DB  0x38,0x84,0x20,0x0,0x70,0xCE,0x20,0x0
_tbl10_G103:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G103:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x3:
	.DB  0x6A,0x69,0x6E,0x67,0x6C,0x65,0x20,0x62
	.DB  0x65,0x6C,0x6C,0x73,0x0,0x0,0x0,0x0
_0x0:
	.DB  0x45,0x6E,0x74,0x65,0x72,0x20,0x72,0x65
	.DB  0x67,0x69,0x73,0x74,0x65,0x72,0x20,0x61
	.DB  0x64,0x64,0x72,0x3A,0x0,0x74,0x75,0x6E
	.DB  0x65,0x72,0x20,0x74,0x65,0x73,0x74,0x2E
	.DB  0x2E,0x2E,0x0,0x2E,0x2E,0x2E,0x64,0x6F
	.DB  0x6E,0x65,0xA,0x0,0x73,0x74,0x72,0x69
	.DB  0x6E,0x67,0x20,0x6D,0x65,0x61,0x6E,0x73
	.DB  0x20,0x25,0x73,0xA,0x0,0x68,0x65,0x78
	.DB  0x20,0x30,0x78,0x25,0x78,0x20,0x30,0x78
	.DB  0x25,0x78,0xA,0x0,0x68,0x65,0x78,0x20
	.DB  0x30,0x78,0x25,0x78,0xA,0x0,0x75,0x6E
	.DB  0x73,0x69,0x67,0x6E,0x65,0x64,0x20,0x26
	.DB  0x20,0x73,0x69,0x67,0x6E,0x65,0x64,0x20
	.DB  0x69,0x6E,0x74,0x20,0x6E,0x75,0x6D,0x62
	.DB  0x65,0x72,0x3A,0x25,0x75,0x20,0x25,0x64
	.DB  0xA,0x0
_0x2004E:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_0x20000:
	.DB  0x41,0x47,0x43,0x20,0x25,0x64,0x20,0x30
	.DB  0x78,0x25,0x78,0x25,0x78,0x0,0x30,0x78
	.DB  0x25,0x78,0x2C,0x30,0x78,0x25,0x78,0xA
	.DB  0x0,0x72,0x65,0x61,0x64,0x20,0x74,0x75
	.DB  0x6E,0x65,0x72,0x3A,0x25,0x78,0xA,0x0
_0x2040060:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x15
	.DW  _0x2B
	.DW  _0x0*2

	.DW  0x0E
	.DW  _0x2B+21
	.DW  _0x0*2+21

	.DW  0x09
	.DW  _0x2B+35
	.DW  _0x0*2+35

	.DW  0x11
	.DW  _0x2B+44
	.DW  _0x0*2+44

	.DW  0x0F
	.DW  _0x2B+61
	.DW  _0x0*2+61

	.DW  0x0A
	.DW  _0x2B+76
	.DW  _0x0*2+76

	.DW  0x24
	.DW  _0x2B+86
	.DW  _0x0*2+86

	.DW  0x24
	.DW  _0x2B+122
	.DW  _0x0*2+86

	.DW  0x24
	.DW  _0x2B+158
	.DW  _0x0*2+86

	.DW  0x0E
	.DW  _0x2006D
	.DW  _0x20000*2

	.DW  0x0B
	.DW  _0x20070
	.DW  _0x20000*2+14

	.DW  0x0F
	.DW  _0x20074
	.DW  _0x20000*2+25

	.DW  0x01
	.DW  __seed_G102
	.DW  _0x2040060*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRA,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

	OUT  EIND,R24

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xA00

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.0 Professional
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 2014-3-21
;Author  : zhangjing
;Company : zhangjing
;Comments:
;1st edition for 2560 control board
;USART1 Baud Rate: 9600
;
;Chip type               : ATmega2560
;Program type            : Application
;AVR Core Clock frequency: 16.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 2048
;*****************************************************/
;
;#include "include.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;
;// Declare your global variables here
;
;
;
;void init(void)
; 0000 0020 {

	.CSEG
_init:
; 0000 0021 
; 0000 0022     // Crystal Oscillator division factor: 1
; 0000 0023     #pragma optsize-
; 0000 0024     CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0025     CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0026     #ifdef _OPTIMIZE_SIZE_
; 0000 0027     #pragma optsize+
; 0000 0028     #endif
; 0000 0029 
; 0000 002A     // Input/Output Ports initialization
; 0000 002B     // Port A initialization
; 0000 002C     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 002D     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 002E     PORTA=0x00;
	OUT  0x2,R30
; 0000 002F     DDRA=0x00;
	OUT  0x1,R30
; 0000 0030 
; 0000 0031     // Port B initialization
; 0000 0032     // Func7=In Func6=Out Func5=Out Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0033     // State7=T State6=0 State5=0 State4=T State3=T State2=T State1=T State0=T
; 0000 0034     PORTB=0x00;
	OUT  0x5,R30
; 0000 0035     DDRB=0x60;
	LDI  R30,LOW(96)
	OUT  0x4,R30
; 0000 0036 
; 0000 0037     // Port C initialization
; 0000 0038     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0039     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 003A     PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x8,R30
; 0000 003B     DDRC=0x00;
	OUT  0x7,R30
; 0000 003C 
; 0000 003D     // Port D initialization
; 0000 003E     // Func7=Out Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 003F     // State7=0 State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0040     PORTD=0x00;
	OUT  0xB,R30
; 0000 0041     DDRD=0x80;
	LDI  R30,LOW(128)
	OUT  0xA,R30
; 0000 0042 
; 0000 0043     // Port E initialization
; 0000 0044     // Func7=Out Func6=In Func5=Out Func4=Out Func3=Out Func2=In Func1=In Func0=In
; 0000 0045     // State7=0 State6=T State5=0 State4=0 State3=0 State2=T State1=T State0=T
; 0000 0046     PORTE=0x00;
	LDI  R30,LOW(0)
	OUT  0xE,R30
; 0000 0047     DDRE=0xBC;
	LDI  R30,LOW(188)
	OUT  0xD,R30
; 0000 0048 
; 0000 0049     // Port F initialization
; 0000 004A     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 004B     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 004C     PORTF=0x00;
	LDI  R30,LOW(0)
	OUT  0x11,R30
; 0000 004D     DDRF=0x00;
	OUT  0x10,R30
; 0000 004E 
; 0000 004F     // Port G initialization
; 0000 0050     // Func5=In Func4=In Func3=Out Func2=In Func1=In Func0=In
; 0000 0051     // State5=T State4=T State3=0 State2=T State1=T State0=T
; 0000 0052     PORTG=0x00;
	OUT  0x14,R30
; 0000 0053     DDRG=0x08;
	LDI  R30,LOW(8)
	OUT  0x13,R30
; 0000 0054 
; 0000 0055     // Port H initialization
; 0000 0056     // Func7=Out Func6=In Func5=Out Func4=In Func3=Out Func2=Out Func1=In Func0=In
; 0000 0057     // State7=0 State6=T State5=0 State4=T State3=0 State2=0 State1=T State0=T
; 0000 0058     PORTH=0x00;
	LDI  R30,LOW(0)
	STS  258,R30
; 0000 0059     DDRH=0xAC;
	LDI  R30,LOW(172)
	STS  257,R30
; 0000 005A 
; 0000 005B     // Port J initialization
; 0000 005C     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 005D     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 005E     PORTJ=0x00;
	LDI  R30,LOW(0)
	STS  261,R30
; 0000 005F     DDRJ=0x00;
	STS  260,R30
; 0000 0060 
; 0000 0061     // Port K initialization
; 0000 0062     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0063     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0064     PORTK=0x00;
	STS  264,R30
; 0000 0065     DDRK=0x00;
	STS  263,R30
; 0000 0066 
; 0000 0067     // Port L initialization
; 0000 0068     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0069     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 006A     PORTL=0x00;
	STS  267,R30
; 0000 006B     DDRL=0x00;
	STS  266,R30
; 0000 006C 
; 0000 006D     // Timer/Counter 0 initialization
; 0000 006E     // Clock source: System Clock
; 0000 006F     // Clock value: Timer 0 Stopped
; 0000 0070     // Mode: Normal top=0xFF
; 0000 0071     // OC0A output: Disconnected
; 0000 0072     // OC0B output: Disconnected
; 0000 0073     TCCR0A=0x00;
	OUT  0x24,R30
; 0000 0074     TCCR0B=0x00;
	OUT  0x25,R30
; 0000 0075     TCNT0=0x00;
	OUT  0x26,R30
; 0000 0076     OCR0A=0x00;
	OUT  0x27,R30
; 0000 0077     OCR0B=0x00;
	OUT  0x28,R30
; 0000 0078 
; 0000 0079     // Timer/Counter 1 initialization
; 0000 007A     // Clock source: System Clock
; 0000 007B     // Clock value: Timer1 Stopped
; 0000 007C     // Mode: Normal top=0xFFFF
; 0000 007D     // OC1A output: Discon.
; 0000 007E     // OC1B output: Discon.
; 0000 007F     // OC1C output: Discon.
; 0000 0080     // Noise Canceler: Off
; 0000 0081     // Input Capture on Falling Edge
; 0000 0082     // Timer1 Overflow Interrupt: Off
; 0000 0083     // Input Capture Interrupt: Off
; 0000 0084     // Compare A Match Interrupt: Off
; 0000 0085     // Compare B Match Interrupt: Off
; 0000 0086     // Compare C Match Interrupt: Off
; 0000 0087     TCCR1A=0x00;
	STS  128,R30
; 0000 0088     TCCR1B=0x00;
	STS  129,R30
; 0000 0089     TCNT1H=0x00;
	STS  133,R30
; 0000 008A     TCNT1L=0x00;
	STS  132,R30
; 0000 008B     ICR1H=0x00;
	STS  135,R30
; 0000 008C     ICR1L=0x00;
	STS  134,R30
; 0000 008D     OCR1AH=0x00;
	STS  137,R30
; 0000 008E     OCR1AL=0x00;
	STS  136,R30
; 0000 008F     OCR1BH=0x00;
	STS  139,R30
; 0000 0090     OCR1BL=0x00;
	STS  138,R30
; 0000 0091     OCR1CH=0x00;
	STS  141,R30
; 0000 0092     OCR1CL=0x00;
	STS  140,R30
; 0000 0093 
; 0000 0094     // Timer/Counter 2 initialization
; 0000 0095     // Clock source: System Clock
; 0000 0096     // Clock value: Timer2 Stopped
; 0000 0097     // Mode: Normal top=0xFF
; 0000 0098     // OC2A output: Disconnected
; 0000 0099     // OC2B output: Disconnected
; 0000 009A     ASSR=0x00;
	STS  182,R30
; 0000 009B     TCCR2A=0x00;
	STS  176,R30
; 0000 009C     TCCR2B=0x00;
	STS  177,R30
; 0000 009D     TCNT2=0x00;
	STS  178,R30
; 0000 009E     OCR2A=0x00;
	STS  179,R30
; 0000 009F     OCR2B=0x00;
	STS  180,R30
; 0000 00A0 
; 0000 00A1     // Timer/Counter 3 initialization
; 0000 00A2     // Clock source: System Clock
; 0000 00A3     // Clock value: Timer3 Stopped
; 0000 00A4     // Mode: Normal top=0xFFFF
; 0000 00A5     // OC3A output: Discon.
; 0000 00A6     // OC3B output: Discon.
; 0000 00A7     // OC3C output: Discon.
; 0000 00A8     // Noise Canceler: Off
; 0000 00A9     // Input Capture on Falling Edge
; 0000 00AA     // Timer3 Overflow Interrupt: Off
; 0000 00AB     // Input Capture Interrupt: Off
; 0000 00AC     // Compare A Match Interrupt: Off
; 0000 00AD     // Compare B Match Interrupt: Off
; 0000 00AE     // Compare C Match Interrupt: Off
; 0000 00AF     TCCR3A=0x00;
	STS  144,R30
; 0000 00B0     TCCR3B=0x00;
	STS  145,R30
; 0000 00B1     TCNT3H=0x00;
	STS  149,R30
; 0000 00B2     TCNT3L=0x00;
	STS  148,R30
; 0000 00B3     ICR3H=0x00;
	STS  151,R30
; 0000 00B4     ICR3L=0x00;
	STS  150,R30
; 0000 00B5     OCR3AH=0x00;
	STS  153,R30
; 0000 00B6     OCR3AL=0x00;
	STS  152,R30
; 0000 00B7     OCR3BH=0x00;
	STS  155,R30
; 0000 00B8     OCR3BL=0x00;
	STS  154,R30
; 0000 00B9     OCR3CH=0x00;
	STS  157,R30
; 0000 00BA     OCR3CL=0x00;
	STS  156,R30
; 0000 00BB 
; 0000 00BC     // Timer/Counter 4 initialization
; 0000 00BD     // Clock source: System Clock
; 0000 00BE     // Clock value: Timer4 Stopped
; 0000 00BF     // Mode: Normal top=0xFFFF
; 0000 00C0     // OC4A output: Discon.
; 0000 00C1     // OC4B output: Discon.
; 0000 00C2     // OC4C output: Discon.
; 0000 00C3     // Noise Canceler: Off
; 0000 00C4     // Input Capture on Falling Edge
; 0000 00C5     // Timer4 Overflow Interrupt: Off
; 0000 00C6     // Input Capture Interrupt: Off
; 0000 00C7     // Compare A Match Interrupt: Off
; 0000 00C8     // Compare B Match Interrupt: Off
; 0000 00C9     // Compare C Match Interrupt: Off
; 0000 00CA     TCCR4A=0x00;
	STS  160,R30
; 0000 00CB     TCCR4B=0x00;
	STS  161,R30
; 0000 00CC     TCNT4H=0x00;
	STS  165,R30
; 0000 00CD     TCNT4L=0x00;
	STS  164,R30
; 0000 00CE     ICR4H=0x00;
	STS  167,R30
; 0000 00CF     ICR4L=0x00;
	STS  166,R30
; 0000 00D0     OCR4AH=0x00;
	STS  169,R30
; 0000 00D1     OCR4AL=0x00;
	STS  168,R30
; 0000 00D2     OCR4BH=0x00;
	STS  171,R30
; 0000 00D3     OCR4BL=0x00;
	STS  170,R30
; 0000 00D4     OCR4CH=0x00;
	STS  173,R30
; 0000 00D5     OCR4CL=0x00;
	STS  172,R30
; 0000 00D6 
; 0000 00D7     // Timer/Counter 5 initialization
; 0000 00D8     // Clock source: System Clock
; 0000 00D9     // Clock value: Timer5 Stopped
; 0000 00DA     // Mode: Normal top=0xFFFF
; 0000 00DB     // OC5A output: Discon.
; 0000 00DC     // OC5B output: Discon.
; 0000 00DD     // OC5C output: Discon.
; 0000 00DE     // Noise Canceler: Off
; 0000 00DF     // Input Capture on Falling Edge
; 0000 00E0     // Timer5 Overflow Interrupt: Off
; 0000 00E1     // Input Capture Interrupt: Off
; 0000 00E2     // Compare A Match Interrupt: Off
; 0000 00E3     // Compare B Match Interrupt: Off
; 0000 00E4     // Compare C Match Interrupt: Off
; 0000 00E5     TCCR5A=0x00;
	STS  288,R30
; 0000 00E6     TCCR5B=0x00;
	STS  289,R30
; 0000 00E7     TCNT5H=0x00;
	STS  293,R30
; 0000 00E8     TCNT5L=0x00;
	STS  292,R30
; 0000 00E9     ICR5H=0x00;
	STS  295,R30
; 0000 00EA     ICR5L=0x00;
	STS  294,R30
; 0000 00EB     OCR5AH=0x00;
	STS  297,R30
; 0000 00EC     OCR5AL=0x00;
	STS  296,R30
; 0000 00ED     OCR5BH=0x00;
	STS  299,R30
; 0000 00EE     OCR5BL=0x00;
	STS  298,R30
; 0000 00EF     OCR5CH=0x00;
	STS  301,R30
; 0000 00F0     OCR5CL=0x00;
	STS  300,R30
; 0000 00F1 
; 0000 00F2     // External Interrupt(s) initialization
; 0000 00F3     // INT0: Off
; 0000 00F4     // INT1: Off
; 0000 00F5     // INT2: Off
; 0000 00F6     // INT3: Off
; 0000 00F7     // INT4: Off
; 0000 00F8     // INT5: Off
; 0000 00F9     // INT6: Off
; 0000 00FA     // INT7: Off
; 0000 00FB     EICRA=0x00;
	STS  105,R30
; 0000 00FC     EICRB=0x00;
	STS  106,R30
; 0000 00FD     EIMSK=0x00;
	OUT  0x1D,R30
; 0000 00FE     // PCINT0 interrupt: Off
; 0000 00FF     // PCINT1 interrupt: Off
; 0000 0100     // PCINT2 interrupt: Off
; 0000 0101     // PCINT3 interrupt: Off
; 0000 0102     // PCINT4 interrupt: Off
; 0000 0103     // PCINT5 interrupt: Off
; 0000 0104     // PCINT6 interrupt: Off
; 0000 0105     // PCINT7 interrupt: Off
; 0000 0106     // PCINT8 interrupt: Off
; 0000 0107     // PCINT9 interrupt: Off
; 0000 0108     // PCINT10 interrupt: Off
; 0000 0109     // PCINT11 interrupt: Off
; 0000 010A     // PCINT12 interrupt: Off
; 0000 010B     // PCINT13 interrupt: Off
; 0000 010C     // PCINT14 interrupt: Off
; 0000 010D     // PCINT15 interrupt: Off
; 0000 010E     // PCINT16 interrupt: Off
; 0000 010F     // PCINT17 interrupt: Off
; 0000 0110     // PCINT18 interrupt: Off
; 0000 0111     // PCINT19 interrupt: Off
; 0000 0112     // PCINT20 interrupt: Off
; 0000 0113     // PCINT21 interrupt: Off
; 0000 0114     // PCINT22 interrupt: Off
; 0000 0115     // PCINT23 interrupt: Off
; 0000 0116     PCMSK0=0x00;
	STS  107,R30
; 0000 0117     PCMSK1=0x00;
	STS  108,R30
; 0000 0118     PCMSK2=0x00;
	STS  109,R30
; 0000 0119     PCICR=0x00;
	STS  104,R30
; 0000 011A 
; 0000 011B     // Timer/Counter 0 Interrupt(s) initialization
; 0000 011C     TIMSK0=0x00;
	STS  110,R30
; 0000 011D 
; 0000 011E     // Timer/Counter 1 Interrupt(s) initialization
; 0000 011F     TIMSK1=0x00;
	STS  111,R30
; 0000 0120 
; 0000 0121     // Timer/Counter 2 Interrupt(s) initialization
; 0000 0122     TIMSK2=0x00;
	STS  112,R30
; 0000 0123 
; 0000 0124     // Timer/Counter 3 Interrupt(s) initialization
; 0000 0125     TIMSK3=0x00;
	STS  113,R30
; 0000 0126 
; 0000 0127     // Timer/Counter 4 Interrupt(s) initialization
; 0000 0128     TIMSK4=0x00;
	STS  114,R30
; 0000 0129 
; 0000 012A     // Timer/Counter 5 Interrupt(s) initialization
; 0000 012B     TIMSK5=0x00;
	STS  115,R30
; 0000 012C 
; 0000 012D     // USART0 initialization
; 0000 012E     // USART0 disabled
; 0000 012F 
; 0000 0130     UCSR0B=0x0;
	STS  193,R30
; 0000 0131 
; 0000 0132     // USART1 initialization
; 0000 0133     // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0134     // USART1 Receiver: On
; 0000 0135     // USART1 Transmitter: On
; 0000 0136     // USART1 Mode: Asynchronous
; 0000 0137     // USART1 Baud Rate: 9600
; 0000 0138     UCSR1A=0x00;
	STS  200,R30
; 0000 0139     UCSR1B=0x18;
	LDI  R30,LOW(24)
	STS  201,R30
; 0000 013A     UCSR1C=0x06;
	LDI  R30,LOW(6)
	STS  202,R30
; 0000 013B     UBRR1H=0x00;
	LDI  R30,LOW(0)
	STS  205,R30
; 0000 013C     UBRR1L=0x67;
	LDI  R30,LOW(103)
	STS  204,R30
; 0000 013D 
; 0000 013E     // USART2 initialization
; 0000 013F     // USART2 disabled
; 0000 0140     UCSR2B=0x00;
	LDI  R30,LOW(0)
	STS  209,R30
; 0000 0141 
; 0000 0142     // USART3 initialization
; 0000 0143     // USART3 disabled
; 0000 0144     UCSR3B=0x00;
	STS  305,R30
; 0000 0145 
; 0000 0146     // Analog Comparator initialization
; 0000 0147     // Analog Comparator: Off
; 0000 0148     // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 0149     ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 014A     ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 014B     DIDR1=0x00;
	STS  127,R30
; 0000 014C 
; 0000 014D     // ADC initialization
; 0000 014E     // ADC disabled
; 0000 014F     ADCSRA=0x00;
	STS  122,R30
; 0000 0150 
; 0000 0151     // SPI initialization
; 0000 0152     // SPI disabled
; 0000 0153     SPCR=0x00;
	OUT  0x2C,R30
; 0000 0154 
; 0000 0155     // TWI initialization
; 0000 0156     // TWI disabled
; 0000 0157     TWCR=0x00;
	STS  188,R30
; 0000 0158 }
	RET
;
;
;
;
;
;
;void main(void)
; 0000 0160 {
_main:
; 0000 0161 // Declare your local variables here
; 0000 0162 
; 0000 0163     long int LNB_frequence;
; 0000 0164     long int sate_frequence;//
; 0000 0165     unsigned long TunerFreq;
; 0000 0166     float symbol_rate;
; 0000 0167     char str[16] = "jingle bells";
; 0000 0168     unsigned int uint;
; 0000 0169     signed int sint;
; 0000 016A     unsigned char uchar;
; 0000 016B     LNB_frequence =10750;//11300;
	SBIW R28,32
	LDI  R24,16
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x3*2)
	LDI  R31,HIGH(_0x3*2)
	CALL __INITLOCB
;	LNB_frequence -> Y+28
;	sate_frequence -> Y+24
;	TunerFreq -> Y+20
;	symbol_rate -> Y+16
;	str -> Y+0
;	uint -> R16,R17
;	sint -> R18,R19
;	uchar -> R21
	__GETD1N 0x29FE
	__PUTD1S 28
; 0000 016C     sate_frequence =11880; //92.2
	__GETD1N 0x2E68
	__PUTD1S 24
; 0000 016D     symbol_rate  =28800;   //
	__GETD1N 0x46E10000
	__PUTD1S 16
; 0000 016E     TunerFreq = (labs(LNB_frequence-sate_frequence))*1000;
	__GETD2S 24
	__GETD1S 28
	CALL __SUBD12
	CALL __PUTPARD1
	CALL _labs
	__GETD2N 0x3E8
	CALL __MULD12U
	__PUTD1S 20
; 0000 016F     init();
	RCALL _init
; 0000 0170 
; 0000 0171     LED_ON;
	CALL SUBOPT_0x0
; 0000 0172     delay_ms(200);
; 0000 0173     LED_OFF;
; 0000 0174     delay_ms(200);
; 0000 0175     LED_ON;
	CALL SUBOPT_0x0
; 0000 0176     delay_ms(200);
; 0000 0177     LED_OFF;
; 0000 0178     delay_ms(200);
; 0000 0179     LED_ON;
	CBI  0xB,7
; 0000 017A     delay_ms(200);
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CALL SUBOPT_0x1
; 0000 017B     LED_OFF;
	SBI  0xB,7
; 0000 017C     delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	CALL SUBOPT_0x1
; 0000 017D     putchar1('A');
	LDI  R30,LOW(65)
	ST   -Y,R30
	CALL _putchar1
; 0000 017E     putchar1('B');
	LDI  R30,LOW(66)
	ST   -Y,R30
	CALL _putchar1
; 0000 017F 
; 0000 0180     /*LED_ON;
; 0000 0181     delay_ms(500);
; 0000 0182     LED_OFF;
; 0000 0183     delay_ms(500); */
; 0000 0184 
; 0000 0185     //tuner(TunerFreq,symbol_rate);
; 0000 0186     putchar1('C');
	LDI  R30,LOW(67)
	ST   -Y,R30
	CALL _putchar1
; 0000 0187 
; 0000 0188     while (1)
_0x10:
; 0000 0189           {
; 0000 018A            // Place your code here
; 0000 018B             LED_OFF;
	SBI  0xB,7
; 0000 018C             switch (getchar1())
	CALL _getchar1
; 0000 018D             {
; 0000 018E                 case 'H':
	CPI  R30,LOW(0x48)
	BRNE _0x18
; 0000 018F                     {
; 0000 0190                         DDRE |= 0x30;
	IN   R30,0xD
	ORI  R30,LOW(0x30)
	OUT  0xD,R30
; 0000 0191                         SCLH;
	SBI  0xE,5
; 0000 0192                         SDAL;
	CBI  0xE,4
; 0000 0193                         putchar1('H');
	LDI  R30,LOW(72)
	ST   -Y,R30
	CALL _putchar1
; 0000 0194                     }
; 0000 0195                     break;
	RJMP _0x17
; 0000 0196                 case 'A':
_0x18:
	CPI  R30,LOW(0x41)
	BRNE _0x1D
; 0000 0197                     {
; 0000 0198                         putchar1('D');
	LDI  R30,LOW(68)
	ST   -Y,R30
	CALL _putchar1
; 0000 0199                         LED_ON;
	CBI  0xB,7
; 0000 019A                         delay_ms(1000);
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CALL SUBOPT_0x1
; 0000 019B                         LED_OFF;
	SBI  0xB,7
; 0000 019C                         delay_ms(1000);
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CALL SUBOPT_0x1
; 0000 019D                         putchar1('A');
	LDI  R30,LOW(65)
	ST   -Y,R30
	CALL _putchar1
; 0000 019E                     }
; 0000 019F                     break;
	RJMP _0x17
; 0000 01A0                  case 'G':
_0x1D:
	CPI  R30,LOW(0x47)
	BRNE _0x22
; 0000 01A1                     {
; 0000 01A2 
; 0000 01A3                     }
; 0000 01A4                     break;
	RJMP _0x17
; 0000 01A5                 case 'L':
_0x22:
	CPI  R30,LOW(0x4C)
	BRNE _0x23
; 0000 01A6                     {
; 0000 01A7                        DDRE |= 0x30;
	IN   R30,0xD
	ORI  R30,LOW(0x30)
	OUT  0xD,R30
; 0000 01A8                        SCLL;
	CBI  0xE,5
; 0000 01A9                        SDAH;
	SBI  0xE,4
; 0000 01AA                        putchar1('L');
	LDI  R30,LOW(76)
	ST   -Y,R30
	CALL _putchar1
; 0000 01AB                     }
; 0000 01AC                     break;
	RJMP _0x17
; 0000 01AD                 case 'R':
_0x23:
	CPI  R30,LOW(0x52)
	BRNE _0x28
; 0000 01AE                     {
; 0000 01AF                         LED_ON;
	CBI  0xB,7
; 0000 01B0                         uprintf("Enter register addr:");
	__POINTW1MN _0x2B,0
	CALL SUBOPT_0x2
; 0000 01B1                         uchar = getchar1();
	CALL _getchar1
	MOV  R21,R30
; 0000 01B2                         Get0288Register(uchar);
	ST   -Y,R21
	CALL _Get0288Register
; 0000 01B3                         //uprintf("Register 0x%x value is 0x%x\n",uchar,Get0288Register(uchar));
; 0000 01B4                     }
; 0000 01B5                     break;
	RJMP _0x17
; 0000 01B6                 case 'S':
_0x28:
	CPI  R30,LOW(0x53)
	BRNE _0x2C
; 0000 01B7                     {
; 0000 01B8                       uprintf("tuner test...");
	__POINTW1MN _0x2B,21
	CALL SUBOPT_0x2
; 0000 01B9                       tunerTest(0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _tunerTest
; 0000 01BA                       uprintf("...done\n");
	__POINTW1MN _0x2B,35
	CALL SUBOPT_0x2
; 0000 01BB                     }
; 0000 01BC                     break;
	RJMP _0x17
; 0000 01BD                 case 'T':
_0x2C:
	CPI  R30,LOW(0x54)
	BRNE _0x2D
; 0000 01BE                     {
; 0000 01BF                      LED_ON;
	CBI  0xB,7
; 0000 01C0                      putchar1('t');
	LDI  R30,LOW(116)
	ST   -Y,R30
	CALL _putchar1
; 0000 01C1                      tuner(TunerFreq,symbol_rate);
	CALL SUBOPT_0x3
	CALL SUBOPT_0x3
	RCALL _tuner
; 0000 01C2                     }
; 0000 01C3                     break;
	RJMP _0x17
; 0000 01C4                 case 'U':
_0x2D:
	CPI  R30,LOW(0x55)
	BRNE _0x31
; 0000 01C5                     {
; 0000 01C6                        uprintf("string means %s\n",str);
	__POINTW1MN _0x2B,44
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,2
	CALL SUBOPT_0x4
	CALL SUBOPT_0x5
; 0000 01C7                        uchar = 0x33;
	LDI  R21,LOW(51)
; 0000 01C8                        uprintf("hex 0x%x 0x%x\n",uchar,uchar+16);
	__POINTW1MN _0x2B,61
	CALL SUBOPT_0x6
	CALL SUBOPT_0x7
	ADIW R30,16
	CALL SUBOPT_0x8
; 0000 01C9                        uchar = 0xEC;
	LDI  R21,LOW(236)
; 0000 01CA                        uprintf("hex 0x%x\n",uchar);
	__POINTW1MN _0x2B,76
	CALL SUBOPT_0x6
	CALL SUBOPT_0x5
; 0000 01CB 
; 0000 01CC                        uint = 32879;
	__GETWRN 16,17,-32657
; 0000 01CD                        sint = -23456;
	__GETWRN 18,19,-23456
; 0000 01CE                        uprintf("unsigned & signed int number:%u %d\n",uint,sint);
	__POINTW1MN _0x2B,86
	CALL SUBOPT_0x9
	MOVW R30,R18
	CALL SUBOPT_0x8
; 0000 01CF                        uint = -2561;
	__GETWRN 16,17,-2561
; 0000 01D0                        sint = 13456;
	__GETWRN 18,19,13456
; 0000 01D1                        uprintf("unsigned & signed int number:%u %d\n",uint,sint);
	__POINTW1MN _0x2B,122
	CALL SUBOPT_0x9
	MOVW R30,R18
	CALL SUBOPT_0x8
; 0000 01D2                        uint = 105;
	__GETWRN 16,17,105
; 0000 01D3                        sint = -123;
	__GETWRN 18,19,-123
; 0000 01D4                        uprintf("unsigned & signed int number:%u %d\n",uint,sint);
	__POINTW1MN _0x2B,158
	CALL SUBOPT_0x9
	MOVW R30,R18
	CALL SUBOPT_0x8
; 0000 01D5                     }
; 0000 01D6                     break;
; 0000 01D7             default:
_0x31:
; 0000 01D8             };
_0x17:
; 0000 01D9 
; 0000 01DA           }
	RJMP _0x10
; 0000 01DB }
_0x32:
	RJMP _0x32

	.DSEG
_0x2B:
	.BYTE 0xC2
;#include "include.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;
;
;flash unsigned long LVCO_FREQS[3][2] =
;{
;	{950000,970000},
;	{970000,1065000},
;	{1065000,1170000}
;};
;flash unsigned long HVCO_FREQS[7][2] =
;{
;	{1170000,1300000},
;	{1300000,1445000},
;	{1445000,1607000},
;	{1607000,1778000},
;	{1778000,1942000},
;	{1942000,2131000},
;	{2131000,2150000}
;};
;
;
;void TunerRst(void)
; 0001 0017 {

	.CSEG
_TunerRst:
; 0001 0018         PORTE.2=0;
	CBI  0xE,2
; 0001 0019         delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	CALL SUBOPT_0x1
; 0001 001A         PORTE.2=1;
	SBI  0xE,2
; 0001 001B }
	RET
;
;
;/***********************************
;I2C¿ªÊ¼Î»  SDA SCLÉèÎªÊä³ö
;SDAÔÚSCLÎª¸ßÊ±´Ó¸ß±äÎªµÍ
;***********************************/
;void i2c_sta(void)
; 0001 0023 {
_i2c_sta:
; 0001 0024         DDRE |= 0x30;      //PE5 PE4(SCL SDA) as output
	IN   R30,0xD
	ORI  R30,LOW(0x30)
	OUT  0xD,R30
; 0001 0025         SDAH;
	SBI  0xE,4
; 0001 0026         SCLH;
	SBI  0xE,5
; 0001 0027         delay_us(8);
	__DELAY_USB 43
; 0001 0028         SDAL;
	CBI  0xE,4
; 0001 0029         delay_us(2);
	__DELAY_USB 11
; 0001 002A }
	RET
;
;/******************************
;I2C½áÊøÎ»  SDA SCLÉèÎªÊä³ö
;SDAÔÚSCLÎª¸ßÊ±±äÎª¸ß
;*******************************/
;void i2c_stp(void)
; 0001 0031 {
_i2c_stp:
; 0001 0032         DDRE |= 0x30;
	IN   R30,0xD
	ORI  R30,LOW(0x30)
	OUT  0xD,R30
; 0001 0033 
; 0001 0034         SDAH;
	SBI  0xE,4
; 0001 0035         delay_us(2);
	__DELAY_USB 11
; 0001 0036         SCLH;
	CALL SUBOPT_0xA
; 0001 0037 
; 0001 0038         delay_us(2);
; 0001 0039         SDAL;
	CBI  0xE,4
; 0001 003A 
; 0001 003B         delay_us(2);
	__DELAY_USB 11
; 0001 003C         SDAH;
	SBI  0xE,4
; 0001 003D 
; 0001 003E 
; 0001 003F         delay_us(4);
	__DELAY_USB 21
; 0001 0040         SCLH;
	SBI  0xE,5
; 0001 0041 }
	RET
;
;
;/*****************************
;¶ÁÈ¡ACK  ÔÚSCL±ä¸ßºó2us¶ÁÈ¡SDA
;´Ó»ú½«SDAÀ­µÍÎªACKÏìÓ¦
;ÓÐACK·µ»Ø1  ÎÞACK·µ»Ø0
;******************************/
;char SDA_in(void)
; 0001 004A {
_SDA_in:
; 0001 004B 
; 0001 004C DDRE &=0xEF;       //SDA  input
	CBI  0xD,4
; 0001 004D PORTE |= 0x10;       //SDA pull-up
	SBI  0xE,4
; 0001 004E delay_us(4);
	__DELAY_USB 21
; 0001 004F SCLH;
	CALL SUBOPT_0xA
; 0001 0050 delay_us(2);
; 0001 0051 if(PINE.4==0)
	SBIC 0xC,4
	RJMP _0x20019
; 0001 0052   {
; 0001 0053       delay_us(2);
	__DELAY_USB 11
; 0001 0054       SCLL;
	CBI  0xE,5
; 0001 0055       DDRE |=0x10;          //SDA output
	SBI  0xD,4
; 0001 0056       //PORTE.4=1;            //SDA high
; 0001 0057       //putchar1('&');
; 0001 0058       return 1;
	LDI  R30,LOW(1)
	RET
; 0001 0059   }
; 0001 005A else
_0x20019:
; 0001 005B     {
; 0001 005C      //temp_para++;
; 0001 005D      //Tx0('X');
; 0001 005E      DDRE |=0x10;             //SDA output
	SBI  0xD,4
; 0001 005F      putchar1('X');
	LDI  R30,LOW(88)
	ST   -Y,R30
	CALL _putchar1
; 0001 0060      return 0;
	LDI  R30,LOW(0)
	RET
; 0001 0061     }
; 0001 0062 }
	RET
;
;
;/**************************************
;·¢ËÍÒ»¸ö×Ö½ÚµÄÊý¾Ý£¬·¢ËÍÍê³ÉÊÕµ½ACK·µ»Ø1  ·ñÔò·µ»Ø0
;***************************************/
;char i2c_send(unsigned char data)
; 0001 0069 {
_i2c_send:
; 0001 006A         char i;
; 0001 006B 
; 0001 006C         for(i=0;i<8;i++)
	ST   -Y,R17
;	data -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
_0x2001E:
	CPI  R17,8
	BRSH _0x2001F
; 0001 006D         {
; 0001 006E                 SCLL;
	CBI  0xE,5
; 0001 006F                 delay_us(2);
	__DELAY_USB 11
; 0001 0070                 if(data & 0x80)
	LDD  R30,Y+1
	ANDI R30,LOW(0x80)
	BREQ _0x20022
; 0001 0071                         SDAH;
	SBI  0xE,4
; 0001 0072                 else
	RJMP _0x20025
_0x20022:
; 0001 0073                         SDAL;
	CBI  0xE,4
; 0001 0074                 data=(data<<1);
_0x20025:
	LDD  R30,Y+1
	LSL  R30
	STD  Y+1,R30
; 0001 0075 
; 0001 0076 
; 0001 0077                 delay_us(2);
	__DELAY_USB 11
; 0001 0078                 SCLH;
	SBI  0xE,5
; 0001 0079                 delay_us(4);
	__DELAY_USB 21
; 0001 007A         }
	SUBI R17,-1
	RJMP _0x2001E
_0x2001F:
; 0001 007B         SCLL;
	CBI  0xE,5
; 0001 007C 
; 0001 007D         if(SDA_in()==1)
	RCALL _SDA_in
	CPI  R30,LOW(0x1)
	BRNE _0x2002C
; 0001 007E                 {
; 0001 007F                 delay_us(4);
	__DELAY_USB 21
; 0001 0080                 return 1;
	LDI  R30,LOW(1)
	RJMP _0x20A0002
; 0001 0081                 }
; 0001 0082         else
_0x2002C:
; 0001 0083                 {
; 0001 0084                 delay_us(2);
	__DELAY_USB 11
; 0001 0085                 return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0002
; 0001 0086                 }
; 0001 0087 
; 0001 0088 }
;
;///****************************************
;//¶ÁÈ¡Ò»¸ö×Ö½ÚµÄÊý¾Ý²¢·µ»Ø¸Ã×Ö½Ú
;//****************************************/
;//unsigned char i2c_byte_read(void)
;//{
;//
;//}
;
;
;
;///******************************************************
;//Ö÷»ú¶ÁÈ¡I2C  ²ÎÊý·Ö±ðÎª ´Ó»úµØÖ·£¬¶Á»ØµÄ×Ö½Ú´æ·ÅµÄÊý×éÖ¸Õë£¬¶Á»ØµÄ×Ö½ÚÊý
;//slave address,pointer to be written,number to be read
;//´Ó»úÏìÓ¦ÁËµØÖ··µ»Ø1 ·ñÔò·µ»Ø0
;//*******************************************************/
;//char i2c_rd(unsigned char addr,unsigned char *ddata,unsigned char counter)
;//{
;// unsigned char i;
;// unsigned char *pdata;
;// i=counter;
;// pdata=ddata;
;// i2c_sta();
;// if(i2c_send(addr|0x01)==1)
;//   {
;//         while(i)
;//            {
;//                *pdata=i2c_byte_read();
;//                pdata++;
;//                if(i--)
;//                    {
;//                        DDRE.4=1;
;//                        SDAL;     //ACK to slave
;//                        SCLH;
;//                        delay_us(2);
;//                        SCLL;
;//                        delay_us(4);
;//                    }
;//            }
;//         i2c_stp();
;//         return 1;
;//    }
;// else
;//        return 0;
;//
;//}
;
;/******************************************************
;Ö÷»ú¶ÁÈ¡I2C  ²ÎÊý·Ö±ðÎª ´Ó»úµØÖ·£¬¶Á»ØµÄ×Ö½Ú´æ·ÅµÄÊý×éÖ¸Õë£¬¶Á»ØµÄ×Ö½ÚÊý
;slave address,pointer to be written,number to be read
;´Ó»úÏìÓ¦ÁËµØÖ··µ»Ø1 ·ñÔò·µ»Ø0
;*******************************************************/
;char i2c_rd(unsigned char addr,unsigned char *ddata,unsigned char counter)
; 0001 00BE {
_i2c_rd:
; 0001 00BF  unsigned char i,bitc;
; 0001 00C0  unsigned char *pdata;
; 0001 00C1  unsigned char data;
; 0001 00C2  i=counter;
	CALL __SAVELOCR6
;	addr -> Y+9
;	*ddata -> Y+7
;	counter -> Y+6
;	i -> R17
;	bitc -> R16
;	*pdata -> R18,R19
;	data -> R21
	LDD  R17,Y+6
; 0001 00C3  pdata=ddata;
	__GETWRS 18,19,7
; 0001 00C4  i2c_sta();
	RCALL _i2c_sta
; 0001 00C5  if(i2c_send(addr|0x01)==1)
	LDD  R30,Y+9
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_send
	CPI  R30,LOW(0x1)
	BRNE _0x2002E
; 0001 00C6    {
; 0001 00C7          DDRE.4=0;
	CBI  0xD,4
; 0001 00C8          while(i--)
_0x20031:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x20033
; 0001 00C9             {
; 0001 00CA               data = 0;
	LDI  R21,LOW(0)
; 0001 00CB               delay_us(8);
	__DELAY_USB 43
; 0001 00CC               SDAH;         //pull up
	SBI  0xE,4
; 0001 00CD               for(bitc=0;bitc<8;bitc++)
	LDI  R16,LOW(0)
_0x20037:
	CPI  R16,8
	BRSH _0x20038
; 0001 00CE                        {
; 0001 00CF                           delay_us(4);
	__DELAY_USB 21
; 0001 00D0                           SCLH;
	CALL SUBOPT_0xA
; 0001 00D1                           delay_us(2);
; 0001 00D2                           data=data<<1;
	LSL  R21
; 0001 00D3                           if(PINE & 0x10)
	SBIC 0xC,4
; 0001 00D4                              data = data + 1;
	SUBI R21,-LOW(1)
; 0001 00D5                           //data = (data | (PINE & 0x10));
; 0001 00D6                           delay_us(2);
	__DELAY_USB 11
; 0001 00D7                           SCLL;
	CBI  0xE,5
; 0001 00D8 
; 0001 00D9                        }
	SUBI R16,-1
	RJMP _0x20037
_0x20038:
; 0001 00DA                 *pdata=data;
	MOV  R30,R21
	MOVW R26,R18
	ST   X,R30
; 0001 00DB                 pdata++;
	__ADDWRN 18,19,1
; 0001 00DC                 delay_us(4);
	__DELAY_USB 21
; 0001 00DD                 SDAL;     //ACK to slave
	CBI  0xE,4
; 0001 00DE                 DDRE.4=1;
	SBI  0xD,4
; 0001 00DF                 SCLH;
	SBI  0xE,5
; 0001 00E0                 delay_us(4);
	__DELAY_USB 21
; 0001 00E1                 SCLL;
	CBI  0xE,5
; 0001 00E2                 DDRE.4=0;
	CBI  0xD,4
; 0001 00E3                 //uprintf("*%x*",data);
; 0001 00E4                 delay_us(10);
	__DELAY_USB 53
; 0001 00E5                 /*if(i--) //if not the last byte,send ack
; 0001 00E6                     {
; 0001 00E7                         SDAL;     //ACK to slave
; 0001 00E8                         DDRE.4=1;
; 0001 00E9                         SCLH;
; 0001 00EA                         delay_us(4);
; 0001 00EB                         SCLL;
; 0001 00EC                         delay_us(6);
; 0001 00ED                     }  */
; 0001 00EE             }
	RJMP _0x20031
_0x20033:
; 0001 00EF //         SCLH;
; 0001 00F0 //         DDRE.4=1;
; 0001 00F1 //         SDAL;
; 0001 00F2 //         delay_us(2);        //stop
; 0001 00F3 //         SDAH;
; 0001 00F4          i2c_stp();
	RCALL _i2c_stp
; 0001 00F5          return 1;
	LDI  R30,LOW(1)
	RJMP _0x20A0008
; 0001 00F6     }
; 0001 00F7  else
_0x2002E:
; 0001 00F8         return 0;
	LDI  R30,LOW(0)
; 0001 00F9 }
_0x20A0008:
	CALL __LOADLOCR6
	ADIW R28,10
	RET
;
;
;
;/**********************************************
;·¢ËÍÒ»×é×Ö½Úµ½´Ó»ú
;pointer to the first byte,number to be written
;·¢ËÍÍê³É·µ»Ø1  ·ñÔò·µ»Ø0
;**********************************************/
;char i2c_SendStr(char *data,char num)
; 0001 0103 {
_i2c_SendStr:
; 0001 0104     char i;
; 0001 0105     i2c_sta();
	ST   -Y,R17
;	*data -> Y+2
;	num -> Y+1
;	i -> R17
	RCALL _i2c_sta
; 0001 0106     for(i=0;i<num;i++)
	LDI  R17,LOW(0)
_0x2004A:
	LDD  R30,Y+1
	CP   R17,R30
	BRSH _0x2004B
; 0001 0107     {
; 0001 0108         if(i2c_send(*data))
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R30,X
	ST   -Y,R30
	RCALL _i2c_send
	CPI  R30,0
	BREQ _0x2004C
; 0001 0109                 data++;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	STD  Y+2,R30
	STD  Y+2+1,R31
; 0001 010A         else
	RJMP _0x2004D
_0x2004C:
; 0001 010B                 return 0;
	LDI  R30,LOW(0)
	LDD  R17,Y+0
	RJMP _0x20A0004
; 0001 010C     }
_0x2004D:
	SUBI R17,-1
	RJMP _0x2004A
_0x2004B:
; 0001 010D     i2c_stp();
	RCALL _i2c_stp
; 0001 010E     return 1;
	LDI  R30,LOW(1)
	LDD  R17,Y+0
	RJMP _0x20A0004
; 0001 010F }
;
;
;
;/******************************
;open tuner interface
;*******************************/
;void EnableTunerOperation(void)
; 0001 0117 {
_EnableTunerOperation:
; 0001 0118     unsigned char byte[3];
; 0001 0119      byte[0]=0xD0;
	SBIW R28,3
;	byte -> Y+0
	LDI  R30,LOW(208)
	ST   Y,R30
; 0001 011A      byte[1]=0x01;
	LDI  R30,LOW(1)
	STD  Y+1,R30
; 0001 011B      byte[2]=0xD8;
	LDI  R30,LOW(216)
	RJMP _0x20A0007
; 0001 011C      i2c_SendStr(byte,3);
; 0001 011D      //printf("Enable Tuner Operation\n");
; 0001 011E }
;
;/*******************************
;close tuner interface
;*******************************/
;void DisableTunerOperation(void)
; 0001 0124 {
_DisableTunerOperation:
; 0001 0125     unsigned char byte[3];
; 0001 0126     byte[0]=0xD0;
	SBIW R28,3
;	byte -> Y+0
	LDI  R30,LOW(208)
	ST   Y,R30
; 0001 0127     byte[1]=0x01;
	LDI  R30,LOW(1)
	STD  Y+1,R30
; 0001 0128     byte[2]=0x58;
	LDI  R30,LOW(88)
_0x20A0007:
	STD  Y+2,R30
; 0001 0129     i2c_SendStr(byte,3);
	CALL SUBOPT_0xB
	CALL SUBOPT_0xC
; 0001 012A     ////printf("Disable Tuner Operation\n");
; 0001 012B }
	ADIW R28,3
	RET
;
;/******************************************************
;¼ÆËãÆµÂÊ ½«Ö®×ª»»Îªtuner³õÊ¼»¯ÐèÒªµÄ×Ö½ÚÊý¾Ý,²¢Ð´ÈëÐ¾Æ¬
;*******************************************************/
;unsigned char TFC(unsigned long _TunerFrequency) //TunerFrequencyCalculate  KHZ
; 0001 0131 {
_TFC:
; 0001 0132 
; 0001 0133         unsigned long long_tmp, TunerFrequency  ;
; 0001 0134         unsigned int i;
; 0001 0135         unsigned char B[5] = {0x00},temp[5] = {0x00};
; 0001 0136         unsigned int ddata,pd2,pd3,pd4,pd5 ;
; 0001 0137         //printf("TunerFreq %ld.\n",_TunerFrequency);
; 0001 0138 
; 0001 0139         B[0] = 0xc0;
	SBIW R28,24
	LDI  R24,10
	LDI  R26,LOW(6)
	LDI  R27,HIGH(6)
	LDI  R30,LOW(_0x2004E*2)
	LDI  R31,HIGH(_0x2004E*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
;	_TunerFrequency -> Y+30
;	long_tmp -> Y+26
;	TunerFrequency -> Y+22
;	i -> R16,R17
;	B -> Y+17
;	temp -> Y+12
;	ddata -> R18,R19
;	pd2 -> R20,R21
;	pd3 -> Y+10
;	pd4 -> Y+8
;	pd5 -> Y+6
	LDI  R30,LOW(192)
	STD  Y+17,R30
; 0001 013A         if ((_TunerFrequency>=900000)&&(_TunerFrequency<1170000))         //
	CALL SUBOPT_0xD
	__CPD2N 0xDBBA0
	BRLO _0x20050
	CALL SUBOPT_0xD
	__CPD2N 0x11DA50
	BRLO _0x20051
_0x20050:
	RJMP _0x2004F
_0x20051:
; 0001 013B         {
; 0001 013C                 B[4]=0x0e;
	LDI  R30,LOW(14)
	STD  Y+21,R30
; 0001 013D                 for (i=0; i<3; i++)
	__GETWRN 16,17,0
_0x20053:
	__CPWRN 16,17,3
	BRSH _0x20054
; 0001 013E                 {
; 0001 013F                 if (_TunerFrequency < LVCO_FREQS[i][1]) break;
	MOVW R30,R16
	CALL __LSLW3
	SUBI R30,LOW(-_LVCO_FREQS*2)
	SBCI R31,HIGH(-_LVCO_FREQS*2)
	CALL SUBOPT_0xE
	BRLO _0x20054
; 0001 0140                 }
	__ADDWRN 16,17,1
	RJMP _0x20053
_0x20054:
; 0001 0141                 i=i+0x05;
	__ADDWRN 16,17,5
; 0001 0142                 i=i<<5;
	RJMP _0x20076
; 0001 0143                     B[4]= B[4]+i;
; 0001 0144         }
; 0001 0145         else                                                                                                        //
_0x2004F:
; 0001 0146         {
; 0001 0147                 B[4]=0x0c;
	LDI  R30,LOW(12)
	STD  Y+21,R30
; 0001 0148                 for (i=0; i<7; i++)
	__GETWRN 16,17,0
_0x20058:
	__CPWRN 16,17,7
	BRSH _0x20059
; 0001 0149                 {
; 0001 014A                 if (_TunerFrequency < HVCO_FREQS[i][1]) break;
	MOVW R30,R16
	CALL __LSLW3
	SUBI R30,LOW(-_HVCO_FREQS*2)
	SBCI R31,HIGH(-_HVCO_FREQS*2)
	CALL SUBOPT_0xE
	BRLO _0x20059
; 0001 014B                 }
	__ADDWRN 16,17,1
	RJMP _0x20058
_0x20059:
; 0001 014C                 i=i+0x01;
	__ADDWRN 16,17,1
; 0001 014D                 i=i<<5;
_0x20076:
	MOVW R26,R16
	LDI  R30,LOW(5)
	CALL __LSLW12
	MOVW R16,R30
; 0001 014E                 B[4]= B[4]+i;
	MOV  R30,R16
	LDD  R26,Y+21
	ADD  R30,R26
	STD  Y+21,R30
; 0001 014F         }
; 0001 0150         TunerFrequency = _TunerFrequency/500;
	CALL SUBOPT_0xD
	__GETD1N 0x1F4
	CALL __DIVD21U
	__PUTD1S 22
; 0001 0151         long_tmp = TunerFrequency/32;
	__GETD2S 22
	__GETD1N 0x20
	CALL __DIVD21U
	__PUTD1S 26
; 0001 0152         i = TunerFrequency%32;
	__GETD1S 22
	__ANDD1N 0x1F
	MOVW R16,R30
; 0001 0153          B[1] = (int)((long_tmp>>3)&0x000000ff);
	__GETD2S 26
	LDI  R30,LOW(3)
	CALL __LSRD12
	STD  Y+18,R30
; 0001 0154         B[2] = (int)((long_tmp<<5)&0x000000ff);
	LDD  R30,Y+26
	SWAP R30
	ANDI R30,0xF0
	LSL  R30
	STD  Y+19,R30
; 0001 0155         B[2] = (int)(B[2] + i);
	MOV  R30,R16
	LDD  R26,Y+19
	ADD  R30,R26
	STD  Y+19,R30
; 0001 0156         i=0;
	__GETWRN 16,17,0
; 0001 0157         ////printf("TFC byte1~5:0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
; 0001 0158     do
_0x2005C:
; 0001 0159       {
; 0001 015A //             temp_para = 0;
; 0001 015B //             //printf("the cation of i2c acknowlede in function TFC\n");
; 0001 015C             temp[0] = B[0];
	LDD  R30,Y+17
	STD  Y+12,R30
; 0001 015D             temp[1] = B[1];
	LDD  R30,Y+18
	STD  Y+13,R30
; 0001 015E             temp[2] = B[2];
	LDD  R30,Y+19
	STD  Y+14,R30
; 0001 015F             temp[4] = B[4];
	LDD  R30,Y+21
	STD  Y+16,R30
; 0001 0160 
; 0001 0161             temp[3] = 0xe1;
	LDI  R30,LOW(225)
	STD  Y+15,R30
; 0001 0162             temp[4] = B[4] & 0xf3;
	LDD  R30,Y+21
	ANDI R30,LOW(0xF3)
	STD  Y+16,R30
; 0001 0163 //             //printf("B1. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
; 0001 0164              ////printf("temp1. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",temp[0],temp[1],temp[2],temp[3],temp[4]);
; 0001 0165 
; 0001 0166             EnableTunerOperation();
	RCALL _EnableTunerOperation
; 0001 0167             i2c_SendStr(temp,5);                   //write byte1 byte2 byte3 byte4 byte5
	CALL SUBOPT_0xF
	CALL SUBOPT_0x10
; 0001 0168             //DisableTunerOperation();
; 0001 0169 
; 0001 016A             temp[1] = temp[3] | 0x04;
	LDD  R30,Y+15
	ORI  R30,4
	STD  Y+13,R30
; 0001 016B             // //printf("temp2. byte1,4  0x%x,0x%x\n",temp[0],temp[1]);
; 0001 016C             //EnableTunerOperation();
; 0001 016D             i2c_SendStr(temp,2);           //write byte1 byte4
	CALL SUBOPT_0xF
	CALL SUBOPT_0x11
; 0001 016E             //DisableTunerOperation();
; 0001 016F             delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL SUBOPT_0x1
; 0001 0170 
; 0001 0171             B[3] = 0xfd;
	LDI  R30,LOW(253)
	STD  Y+20,R30
; 0001 0172             ddata =  (30000/1000)/2 - 2;
	__GETWRN 18,19,13
; 0001 0173             pd2 = (ddata>>1)&0x04        ;
	MOVW R30,R18
	LSR  R31
	ROR  R30
	ANDI R30,LOW(0x4)
	ANDI R31,HIGH(0x4)
	MOVW R20,R30
; 0001 0174             pd3 = (ddata<<1)&0x08        ;
	MOVW R30,R18
	LSL  R30
	ROL  R31
	ANDI R30,LOW(0x8)
	ANDI R31,HIGH(0x8)
	STD  Y+10,R30
	STD  Y+10+1,R31
; 0001 0175             pd4 = (ddata<<2)&0x08        ;
	MOVW R30,R18
	CALL __LSLW2
	ANDI R30,LOW(0x8)
	ANDI R31,HIGH(0x8)
	STD  Y+8,R30
	STD  Y+8+1,R31
; 0001 0176             pd5 = (ddata<<4)&0x10        ;
	MOVW R30,R18
	CALL __LSLW4
	ANDI R30,LOW(0x10)
	ANDI R31,HIGH(0x10)
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0001 0177             B[3] &= 0xE7        ;
	MOVW R26,R28
	ADIW R26,20
	LD   R30,X
	ANDI R30,LOW(0xE7)
	ST   X,R30
; 0001 0178             B[4] &= 0xF3        ;
	MOVW R26,R28
	ADIW R26,21
	LD   R30,X
	ANDI R30,LOW(0xF3)
	ST   X,R30
; 0001 0179             B[3] |= (pd5|pd4)        ;
	MOVW R30,R28
	ADIW R30,20
	MOVW R22,R30
	LD   R0,Z
	LDD  R30,Y+8
	LDD  R26,Y+6
	OR   R30,R26
	OR   R30,R0
	MOVW R26,R22
	ST   X,R30
; 0001 017A             B[4] |= (pd3|pd2)        ;
	MOVW R30,R28
	ADIW R30,21
	MOVW R22,R30
	LD   R0,Z
	MOV  R30,R20
	LDD  R26,Y+10
	OR   R30,R26
	OR   R30,R0
	MOVW R26,R22
	ST   X,R30
; 0001 017B 
; 0001 017C //             //printf("B2. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
; 0001 017D 
; 0001 017E             temp[1] = B[3] | 0x04;
	LDD  R30,Y+20
	ORI  R30,4
	STD  Y+13,R30
; 0001 017F             temp[2] = B[4];
	LDD  R30,Y+21
	STD  Y+14,R30
; 0001 0180             // //printf("temp3. byte1,4,5  0x%x,0x%x,0x%x\n",temp[0],temp[1],temp[2]);
; 0001 0181             //EnableTunerOperation();
; 0001 0182             i2c_SendStr(temp,3);                   //write byte1 byte4 byte5
	CALL SUBOPT_0xF
	CALL SUBOPT_0xC
; 0001 0183             DisableTunerOperation();
	RCALL _DisableTunerOperation
; 0001 0184 
; 0001 0185             delay_ms(1);
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL SUBOPT_0x1
; 0001 0186             i++;
	__ADDWRN 16,17,1
; 0001 0187             if(pll_lk())
	RCALL _pll_lk
	CPI  R30,0
	BREQ _0x2005E
; 0001 0188             {
; 0001 0189                 //printf("TunerFrequency Calculate & set Success! \n");
; 0001 018A                 return 1;
	LDI  R30,LOW(1)
	RJMP _0x20A0006
; 0001 018B             }
; 0001 018C         }while(i < 4);
_0x2005E:
	__CPWRN 16,17,4
	BRSH _0x2005D
	RJMP _0x2005C
_0x2005D:
; 0001 018D         //printf("TunerFrequency Calculate & set Failed!\n");
; 0001 018E         return 0;
	LDI  R30,LOW(0)
_0x20A0006:
	CALL __LOADLOCR6
	ADIW R28,34
	RET
; 0001 018F }
;
;
;/******************************
;STV0288Ð¾Æ¬³õÊ¼»¯
;***************************/
;void STV0288Init(void)
; 0001 0196 {
_STV0288Init:
; 0001 0197  unsigned char byte[10];  //i = 0;
; 0001 0198  unsigned char *pointer;
; 0001 0199 
; 0001 019A         // temp_para = 0;
; 0001 019B         // //printf("the cation of i2c acknowlede in function STV0288Init\n");
; 0001 019C 
; 0001 019D         byte[0]=0xD0;
	SBIW R28,10
	ST   -Y,R17
	ST   -Y,R16
;	byte -> Y+2
;	*pointer -> R16,R17
	LDI  R30,LOW(208)
	STD  Y+2,R30
; 0001 019E         pointer= &byte[0];
	MOVW R30,R28
	ADIW R30,2
	MOVW R16,R30
; 0001 019F 
; 0001 01A0         /********************************
; 0001 01A1         set clock
; 0001 01A2         PLL_DIV=100
; 0001 01A3         clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M
; 0001 01A4         ********************************/
; 0001 01A5         byte[1]= 0x40;
	LDI  R30,LOW(64)
	STD  Y+3,R30
; 0001 01A6         byte[2]= 0x64;             //PLLCTRL
	LDI  R30,LOW(100)
	STD  Y+4,R30
; 0001 01A7         byte[3]= 0x04;             //SYNTCTRL
	LDI  R30,LOW(4)
	CALL SUBOPT_0x12
; 0001 01A8         i2c_SendStr(pointer,4);
; 0001 01A9 
; 0001 01AA 
; 0001 01AB 
; 0001 01AC         byte[1]=0x02;                 //ACR
	CALL SUBOPT_0x13
; 0001 01AD         byte[2]=0x20;
; 0001 01AE         i2c_SendStr(pointer,3);
; 0001 01AF 
; 0001 01B0 
; 0001 01B1 
; 0001 01B2 
; 0001 01B3         /*********************
; 0001 01B4         set register about AGC
; 0001 01B5         **********************/
; 0001 01B6         byte[1]=0x0F;
	LDI  R30,LOW(15)
	STD  Y+3,R30
; 0001 01B7         byte[2]=0x54;               //AGC1REF
	LDI  R30,LOW(84)
	CALL SUBOPT_0x14
; 0001 01B8         i2c_SendStr(pointer,3);
; 0001 01B9         ////printf("AGC1REF*");
; 0001 01BA         /*******************************
; 0001 01BB         set register about timing loop
; 0001 01BC         ********************************/
; 0001 01BD 
; 0001 01BE         byte[1]=0x11;
	LDI  R30,LOW(17)
	STD  Y+3,R30
; 0001 01BF         byte[2]=0x7a;                 //RTC
	LDI  R30,LOW(122)
	CALL SUBOPT_0x14
; 0001 01C0         i2c_SendStr(pointer,3);
; 0001 01C1         ////printf("RTC*");
; 0001 01C2         byte[1]=0x22;
	LDI  R30,LOW(34)
	STD  Y+3,R30
; 0001 01C3         byte[2]=0x00;               //RTFM
	LDI  R30,LOW(0)
	STD  Y+4,R30
; 0001 01C4         byte[3]=0x00;               //RTFL
	CALL SUBOPT_0x12
; 0001 01C5         i2c_SendStr(pointer,4);
; 0001 01C6         ////printf("RTF*");
; 0001 01C7 
; 0001 01C8         /**********************************************
; 0001 01C9         set register about DAC (¸Ã¼Ä´æÆ÷ÉèÖÃ²»Ó°ÏìËø¶¨)
; 0001 01CA         **********************************************/
; 0001 01CB 
; 0001 01CC         byte[1]=0x1b;
	LDI  R30,LOW(27)
	STD  Y+3,R30
; 0001 01CD         byte[2]=0x8f;                    //DACR1
	LDI  R30,LOW(143)
	STD  Y+4,R30
; 0001 01CE         byte[3]=0xf0;               //DACR2
	LDI  R30,LOW(240)
	CALL SUBOPT_0x12
; 0001 01CF         i2c_SendStr(pointer,4);
; 0001 01D0         ////printf("DACR*");
; 0001 01D1         /*******************************
; 0001 01D2         set register about carrier loop
; 0001 01D3         ********************************/
; 0001 01D4         byte[1]=0x15;
	LDI  R30,LOW(21)
	STD  Y+3,R30
; 0001 01D5         byte[2]=0xf7;                   //CFD
	LDI  R30,LOW(247)
	STD  Y+4,R30
; 0001 01D6         byte[3]=0x88;                 //ACLC
	LDI  R30,LOW(136)
	STD  Y+5,R30
; 0001 01D7         byte[4]=0x58;                 //BCLC
	LDI  R30,LOW(88)
	CALL SUBOPT_0x15
; 0001 01D8         i2c_SendStr(pointer,5);
; 0001 01D9 
; 0001 01DA 
; 0001 01DB         byte[1]=0x19;
	LDI  R30,LOW(25)
	STD  Y+3,R30
; 0001 01DC         byte[2]=0xa6;                   //LDT
	LDI  R30,LOW(166)
	STD  Y+4,R30
; 0001 01DD         byte[3]=0x88;                 //LDT2
	LDI  R30,LOW(136)
	CALL SUBOPT_0x12
; 0001 01DE         i2c_SendStr(pointer,4);
; 0001 01DF 
; 0001 01E0         byte[1]=0x2B;
	LDI  R30,LOW(43)
	STD  Y+3,R30
; 0001 01E1         byte[2]=0xFF;                   //CFRM
	LDI  R30,LOW(255)
	STD  Y+4,R30
; 0001 01E2         byte[3]=0xF7;                 //CFRL
	LDI  R30,LOW(247)
	CALL SUBOPT_0x12
; 0001 01E3         i2c_SendStr(pointer,4);
; 0001 01E4 
; 0001 01E5 
; 0001 01E6         /*******************************
; 0001 01E7         set register about FEC and SYNC
; 0001 01E8         ********************************/
; 0001 01E9         byte[1]=0x37;
	LDI  R30,LOW(55)
	STD  Y+3,R30
; 0001 01EA         byte[2]=0x2f;                   //PR
	LDI  R30,LOW(47)
	STD  Y+4,R30
; 0001 01EB         byte[3]=0x16;                 //VSEARCH
	LDI  R30,LOW(22)
	STD  Y+5,R30
; 0001 01EC         byte[4]=0xbd;                 //RS
	LDI  R30,LOW(189)
	CALL SUBOPT_0x15
; 0001 01ED         i2c_SendStr(pointer,5);
; 0001 01EE 
; 0001 01EF         // byte[1]=0x3B;
; 0001 01F0         // byte[2]=0x13;                   //ERRCTRL
; 0001 01F1         // byte[3]=0x12;                 //VITPROG
; 0001 01F2         // byte[4]=0x30;                 //ERRCTRL2
; 0001 01F3         // i2c_tran(pointer,5);
; 0001 01F4 
; 0001 01F5         byte[1]=0x3c;
	LDI  R30,LOW(60)
	STD  Y+3,R30
; 0001 01F6         byte[2]=0x12;                 //VITPROG
	LDI  R30,LOW(18)
	CALL SUBOPT_0x14
; 0001 01F7         i2c_SendStr(pointer,3);
; 0001 01F8 
; 0001 01F9         byte[1]=0x02;         //ACR
	CALL SUBOPT_0x13
; 0001 01FA         byte[2]=0x20;
; 0001 01FB         i2c_SendStr(pointer,3);
; 0001 01FC 
; 0001 01FD         /********************************
; 0001 01FE         set clock
; 0001 01FF         PLL_DIV=100
; 0001 0200         clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M
; 0001 0201         ********************************/
; 0001 0202         byte[1]= 0x40;
	LDI  R30,LOW(64)
	STD  Y+3,R30
; 0001 0203         byte[2]= 0x63;             //PLLCTRL
	LDI  R30,LOW(99)
	STD  Y+4,R30
; 0001 0204         byte[3]= 0x04;             //SYNTCTRL
	LDI  R30,LOW(4)
	STD  Y+5,R30
; 0001 0205         byte[4]= 0x20;             //TSTTNR1
	LDI  R30,LOW(32)
	CALL SUBOPT_0x15
; 0001 0206         i2c_SendStr(pointer,5);
; 0001 0207 
; 0001 0208 
; 0001 0209         byte[1]=0xB2;
	LDI  R30,LOW(178)
	STD  Y+3,R30
; 0001 020A         byte[2]=0x10;                   //AGCCFG
	LDI  R30,LOW(16)
	STD  Y+4,R30
; 0001 020B         byte[3]=0x82;                 //DIRCLKCFG
	LDI  R30,LOW(130)
	STD  Y+5,R30
; 0001 020C         byte[4]=0x80;                 //AUXCKCFG
	LDI  R30,LOW(128)
	STD  Y+6,R30
; 0001 020D         byte[5]=0x82;                 //STDBYCFG
	LDI  R30,LOW(130)
	STD  Y+7,R30
; 0001 020E         byte[6]=0x82;                 //CS0CFG
	STD  Y+8,R30
; 0001 020F         byte[7]=0x82;                 //CS1CFG
	STD  Y+9,R30
; 0001 0210         i2c_SendStr(pointer,8);
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(8)
	ST   -Y,R30
	RCALL _i2c_SendStr
; 0001 0211         //printf("STV0288 Init Done\n");
; 0001 0212 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,12
	RET
;
;
;/**********************************
;Éè¶¨·ûºÅÂÊ
;**********************************/
;void SetSymbolRate(float sym_rate)
; 0001 0219 {
_SetSymbolRate:
; 0001 021A         char byte[8];
; 0001 021B         char *pointer;
; 0001 021C         long int ksy_rate;
; 0001 021D         pointer = &byte[0];
	SBIW R28,12
	ST   -Y,R17
	ST   -Y,R16
;	sym_rate -> Y+14
;	byte -> Y+6
;	*pointer -> R16,R17
;	ksy_rate -> Y+2
	MOVW R30,R28
	ADIW R30,6
	MOVW R16,R30
; 0001 021E        // temp_para = 0;
; 0001 021F //         //printf("the cation of i2c acknowlede in function SetSymbolRate\n");
; 0001 0220 
; 0001 0221         byte[0]=0xD0;
	LDI  R30,LOW(208)
	STD  Y+6,R30
; 0001 0222 
; 0001 0223         /********************************
; 0001 0224         set clock
; 0001 0225         PLL_DIV=100
; 0001 0226         clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M
; 0001 0227         ********************************/
; 0001 0228         byte[1]= 0x40;
	LDI  R30,LOW(64)
	STD  Y+7,R30
; 0001 0229         byte[2]= 0x64;             //PLLCTRL
	LDI  R30,LOW(100)
	STD  Y+8,R30
; 0001 022A         byte[3]= 0x04;             //SYNTCTRL
	LDI  R30,LOW(4)
	STD  Y+9,R30
; 0001 022B         i2c_SendStr(pointer,4);
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R30
	RCALL _i2c_SendStr
; 0001 022C 
; 0001 022D 
; 0001 022E 
; 0001 022F         byte[1]=0x02;                 //ACR
	LDI  R30,LOW(2)
	STD  Y+7,R30
; 0001 0230         byte[2]=0x20;
	LDI  R30,LOW(32)
	STD  Y+8,R30
; 0001 0231         i2c_SendStr(pointer,3);
	ST   -Y,R17
	ST   -Y,R16
	CALL SUBOPT_0xC
; 0001 0232 
; 0001 0233         /*****************************
; 0001 0234         set symbol rate
; 0001 0235         //SFRH,SFRM,SFRL = 27.5/100*2e20 =0x46666   27.49996
; 0001 0236         *****************************/
; 0001 0237         ksy_rate =(sym_rate*1048576/100000);
	__GETD2S 14
	__GETD1N 0x49800000
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x47C35000
	CALL __DIVF21
	MOVW R26,R28
	ADIW R26,2
	CALL __CFD1
	CALL __PUTDP1
; 0001 0238         byte[1]=0x28;
	LDI  R30,LOW(40)
	STD  Y+7,R30
; 0001 0239 
; 0001 023A         byte[2]=(ksy_rate >> 12)& 0xFF;
	__GETD2S 2
	LDI  R30,LOW(12)
	CALL __ASRD12
	STD  Y+8,R30
; 0001 023B         byte[3]=(ksy_rate >> 4)& 0xFF;
	LDI  R30,LOW(4)
	CALL __ASRD12
	STD  Y+9,R30
; 0001 023C         byte[4]=(ksy_rate << 4)& 0xFF;
	LDD  R30,Y+2
	SWAP R30
	ANDI R30,0xF0
	STD  Y+10,R30
; 0001 023D 
; 0001 023E         //printf("symbol %f, 0x%x 0x%x 0x%x\n",sym_rate,byte[2],byte[3],byte[4] );
; 0001 023F         byte[5]=0;     //CFRM  ÔØ²¨ÆµÂÊ
	LDI  R30,LOW(0)
	STD  Y+11,R30
; 0001 0240         byte[6]=0;     //CFRL
	STD  Y+12,R30
; 0001 0241         i2c_SendStr(pointer,7);
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(7)
	ST   -Y,R30
	RCALL _i2c_SendStr
; 0001 0242         //printf("SetSymbolRate Done\n");
; 0001 0243 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,18
	RET
;
;
;
;/***************************************************************
;7395³õÊ¼»¯
;master clockÉèÖÃÎª100M
;²âÊÔÊ¹ÓÃAsia6  12395MHz frequency  27500K symbol rate
;12395-10750=1645=fvco=32*51+13
;11880-10750=1030
;****************************************************************/
;unsigned char tuner(unsigned long F,float S)
; 0001 024F {
_tuner:
; 0001 0250 
; 0001 0251         char i;
; 0001 0252         TunerRst();
	ST   -Y,R17
;	F -> Y+5
;	S -> Y+1
;	i -> R17
	RCALL _TunerRst
; 0001 0253         delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	CALL SUBOPT_0x1
; 0001 0254 
; 0001 0255 
; 0001 0256         TFC(F);
	__GETD1S 5
	CALL __PUTPARD1
	RCALL _TFC
; 0001 0257         STV0288Init();
	RCALL _STV0288Init
; 0001 0258         SetSymbolRate(S);
	__GETD1S 1
	CALL __PUTPARD1
	RCALL _SetSymbolRate
; 0001 0259         i = 0;
	LDI  R17,LOW(0)
; 0001 025A         while(i<4)
_0x2005F:
	CPI  R17,4
	BRSH _0x20061
; 0001 025B         {
; 0001 025C             i++;
	SUBI R17,-1
; 0001 025D             delay_us(900);
	__DELAY_USW 3600
; 0001 025E             if(locked() == 0xFF)
	RCALL _locked
	CPI  R30,LOW(0xFF)
	BRNE _0x20062
; 0001 025F                return 1;
	LDI  R30,LOW(1)
	RJMP _0x20A0005
; 0001 0260         }
_0x20062:
	RJMP _0x2005F
_0x20061:
; 0001 0261         return 0;
	LDI  R30,LOW(0)
_0x20A0005:
	LDD  R17,Y+0
	ADIW R28,9
	RET
; 0001 0262 
; 0001 0263 }
;
;/*
;get register 1E & 24,TMGlock and CFlock means lock
;return FF means lock,return 0 mean communication failed,return 1 means register not lock
;*/
;char locked(void)
; 0001 026A {
_locked:
; 0001 026B     char reg[2];
; 0001 026C     char addr[2];
; 0001 026D 
; 0001 026E     addr[0] = 0xD0;
	SBIW R28,4
;	reg -> Y+2
;	addr -> Y+0
	LDI  R30,LOW(208)
	ST   Y,R30
; 0001 026F     addr[1] = 0x1E;
	LDI  R30,LOW(30)
	STD  Y+1,R30
; 0001 0270 
; 0001 0271     if (i2c_SendStr(addr,2) == 0)        //send register address 1E
	CALL SUBOPT_0xB
	CALL SUBOPT_0x11
	CPI  R30,0
	BRNE _0x20063
; 0001 0272             return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0004
; 0001 0273     if(i2c_rd(addr[0],reg,1) == 0)   //save reg1E value to reg[0]
_0x20063:
	CALL SUBOPT_0x16
	BRNE _0x20064
; 0001 0274         return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0004
; 0001 0275 
; 0001 0276     reg[1] = reg[0];  //move reg1E value to reg[1]
_0x20064:
	LDD  R30,Y+2
	STD  Y+3,R30
; 0001 0277     addr[1] = 0x24;   //next reg 24
	LDI  R30,LOW(36)
	STD  Y+1,R30
; 0001 0278 
; 0001 0279     if (i2c_SendStr(addr,2) == 0)        //send register address 24
	CALL SUBOPT_0xB
	CALL SUBOPT_0x11
	CPI  R30,0
	BRNE _0x20065
; 0001 027A             return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0004
; 0001 027B     if(i2c_rd(addr[0],reg,1) == 0)   //save reg24 value to reg[0]
_0x20065:
	CALL SUBOPT_0x16
	BRNE _0x20066
; 0001 027C         return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0004
; 0001 027D 
; 0001 027E     if(((reg[0] & 0x80) == 0x80) && ((reg[1] & 0x80) == 0x80))   //1E-timing lock flag, 24-carrier lock flag
_0x20066:
	LDD  R30,Y+2
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BRNE _0x20068
	LDD  R30,Y+3
	ANDI R30,LOW(0x80)
	CPI  R30,LOW(0x80)
	BREQ _0x20069
_0x20068:
	RJMP _0x20067
_0x20069:
; 0001 027F     {
; 0001 0280         //LED_ON;
; 0001 0281         return 0xFF;
	LDI  R30,LOW(255)
	RJMP _0x20A0004
; 0001 0282     }
; 0001 0283     else
_0x20067:
; 0001 0284     {
; 0001 0285        //STV0288Init();
; 0001 0286        //LED_OFF;
; 0001 0287        return 1;
	LDI  R30,LOW(1)
	RJMP _0x20A0004
; 0001 0288     }
; 0001 0289 
; 0001 028A  }
; unsigned int GetAGC(void)
; 0001 028C  {
_GetAGC:
; 0001 028D     union
; 0001 028E             {
; 0001 028F             unsigned int numb;
; 0001 0290                char reg[2];
; 0001 0291         } AGC;
; 0001 0292     char addr[2];
; 0001 0293 
; 0001 0294     addr[0] = 0xD0;
	SBIW R28,4
;	AGC -> Y+2
;	addr -> Y+0
	LDI  R30,LOW(208)
	ST   Y,R30
; 0001 0295     addr[1] = 0x20;
	LDI  R30,LOW(32)
	STD  Y+1,R30
; 0001 0296 
; 0001 0297     if (i2c_SendStr(addr,2) == 0)        //send register address 20
	CALL SUBOPT_0xB
	CALL SUBOPT_0x11
	CPI  R30,0
	BRNE _0x2006B
; 0001 0298             return 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x20A0004
; 0001 0299     if(i2c_rd(addr[0],AGC.reg,2) == 0)   //save reg1E value to reg[0] and reg[1]
_0x2006B:
	LD   R30,Y
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,3
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	RCALL _i2c_rd
	CPI  R30,0
	BRNE _0x2006C
; 0001 029A         return 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x20A0004
; 0001 029B     addr[0] = AGC.reg[0];
_0x2006C:
	LDD  R30,Y+2
	ST   Y,R30
; 0001 029C     AGC.reg[0] = AGC.reg[1];
	LDD  R30,Y+3
	STD  Y+2,R30
; 0001 029D     AGC.reg[1] = addr[0];
	LD   R30,Y
	STD  Y+3,R30
; 0001 029E     uprintf("AGC %d 0x%x%x",AGC.numb,AGC.reg[1],AGC.reg[0]);
	__POINTW1MN _0x2006D,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0x4
	CALL SUBOPT_0x17
	LDD  R30,Y+12
	CALL SUBOPT_0x18
	LDI  R24,12
	RCALL _uprintf
	ADIW R28,14
; 0001 029F     return AGC.numb;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
_0x20A0004:
	ADIW R28,4
	RET
; 0001 02A0  }

	.DSEG
_0x2006D:
	.BYTE 0xE
;
;
;
;char Get0288Register(unsigned char addr)
; 0001 02A5 {

	.CSEG
_Get0288Register:
; 0001 02A6     char data[3];
; 0001 02A7     char *pdata;
; 0001 02A8     //EnableTunerOperation();
; 0001 02A9     pdata = &data[0];
	SBIW R28,3
	ST   -Y,R17
	ST   -Y,R16
;	addr -> Y+5
;	data -> Y+2
;	*pdata -> R16,R17
	MOVW R30,R28
	ADIW R30,2
	MOVW R16,R30
; 0001 02AA     data[0]= 0xD0;
	LDI  R30,LOW(208)
	STD  Y+2,R30
; 0001 02AB     data[1]= addr;
	LDD  R30,Y+5
	STD  Y+3,R30
; 0001 02AC     if (i2c_SendStr(pdata,2))
	ST   -Y,R17
	ST   -Y,R16
	CALL SUBOPT_0x11
	CPI  R30,0
	BREQ _0x2006E
; 0001 02AD       {
; 0001 02AE        if(i2c_rd(data[0],pdata,2))
	LDD  R30,Y+2
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(2)
	ST   -Y,R30
	RCALL _i2c_rd
	CPI  R30,0
	BREQ _0x2006F
; 0001 02AF           {
; 0001 02B0            uprintf("0x%x,0x%x\n",data[0],data[1]);
	__POINTW1MN _0x20070,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	CALL SUBOPT_0x18
	CALL SUBOPT_0x17
	LDI  R24,8
	RCALL _uprintf
	ADIW R28,10
; 0001 02B1            return data[0];
	LDD  R30,Y+2
; 0001 02B2           }
; 0001 02B3       }
_0x2006F:
; 0001 02B4     //DisableTunerOperation();
; 0001 02B5 }
_0x2006E:
_0x20A0003:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET

	.DSEG
_0x20070:
	.BYTE 0xB
;
;unsigned char pll_lk(void)
; 0001 02B8   {

	.CSEG
_pll_lk:
; 0001 02B9       unsigned char byte[1] = {0xc0},i = 0;
; 0001 02BA       EnableTunerOperation();
	SBIW R28,1
	LDI  R30,LOW(192)
	ST   Y,R30
	ST   -Y,R17
;	byte -> Y+1
;	i -> R17
	LDI  R17,0
	RCALL _EnableTunerOperation
; 0001 02BB       do
_0x20072:
; 0001 02BC       {
; 0001 02BD           i2c_rd(byte[0],byte,1);
	LDD  R30,Y+1
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _i2c_rd
; 0001 02BE           uprintf("read tuner:%x\n",byte[0]);
	__POINTW1MN _0x20074,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+3
	CALL SUBOPT_0x18
	CALL SUBOPT_0x5
; 0001 02BF           i++;
	SUBI R17,-1
; 0001 02C0           if((byte[0] & 0x40) != 0)
	LDD  R30,Y+1
	ANDI R30,LOW(0x40)
	BREQ _0x20075
; 0001 02C1           {
; 0001 02C2               DisableTunerOperation();
	RCALL _DisableTunerOperation
; 0001 02C3               return 1;
	LDI  R30,LOW(1)
	RJMP _0x20A0002
; 0001 02C4           }
; 0001 02C5       }while(i < 3);
_0x20075:
	CPI  R17,3
	BRLO _0x20072
; 0001 02C6       DisableTunerOperation();
	RCALL _DisableTunerOperation
; 0001 02C7       return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0002
; 0001 02C8 }

	.DSEG
_0x20074:
	.BYTE 0xF
;
;char tunerTest(char para)
; 0001 02CB {

	.CSEG
_tunerTest:
; 0001 02CC    char byte=para;
; 0001 02CD    //pll_lk();
; 0001 02CE    GetAGC();
	ST   -Y,R17
;	para -> Y+1
;	byte -> R17
	LDD  R17,Y+1
	RCALL _GetAGC
; 0001 02CF    //uprintf("AGC2 %d 0x%x%x\n",GetAGC());
; 0001 02D0    return byte;
	MOV  R30,R17
_0x20A0002:
	LDD  R17,Y+0
	ADIW R28,2
	RET
; 0001 02D1 }
;
;
;
;
;
;
;#include "include.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;#include <stdarg.h>
;
;char uprintf(const char *fmt, ...)
; 0002 0005 {

	.CSEG
_uprintf:
	PUSH R15
	MOV  R15,R24
; 0002 0006     const char *s;
; 0002 0007     int d;
; 0002 0008     char buf[16],i;
; 0002 0009     va_list ap;
; 0002 000A     va_start(ap, fmt);
	SBIW R28,18
	CALL __SAVELOCR6
;	*fmt -> Y+24
;	*s -> R16,R17
;	d -> R18,R19
;	buf -> Y+8
;	i -> R21
;	*ap -> Y+6
	MOVW R26,R28
	ADIW R26,20
	CALL __ADDW2R15
	STD  Y+6,R26
	STD  Y+6+1,R27
; 0002 000B     while (*fmt) {
_0x40003:
	CALL SUBOPT_0x19
	LD   R30,Z
	CPI  R30,0
	BRNE PC+3
	JMP _0x40005
; 0002 000C         if (*fmt != '%') {
	CALL SUBOPT_0x19
	LD   R26,Z
	CPI  R26,LOW(0x25)
	BREQ _0x40006
; 0002 000D             putchar1(*fmt++);
	CALL SUBOPT_0x1A
	SBIW R30,1
	LD   R30,Z
	ST   -Y,R30
	RCALL _putchar1
; 0002 000E             continue;
	RJMP _0x40003
; 0002 000F         }
; 0002 0010         switch (*++fmt) {
_0x40006:
	CALL SUBOPT_0x1A
	LD   R30,Z
	LDI  R31,0
; 0002 0011             case 's':
	CPI  R30,LOW(0x73)
	LDI  R26,HIGH(0x73)
	CPC  R31,R26
	BRNE _0x4000A
; 0002 0012                {
; 0002 0013                 s = va_arg(ap, char *);
	CALL SUBOPT_0x1B
	LD   R16,X+
	LD   R17,X
; 0002 0014                 for ( ; *s; s++)
_0x4000C:
	MOVW R26,R16
	LD   R30,X
	CPI  R30,0
	BREQ _0x4000D
; 0002 0015                     {
; 0002 0016                     putchar1(*s);
	CALL SUBOPT_0x1C
; 0002 0017                     }
	__ADDWRN 16,17,1
	RJMP _0x4000C
_0x4000D:
; 0002 0018                 }
; 0002 0019                 break;
	RJMP _0x40009
; 0002 001A             case 'u':
_0x4000A:
	CPI  R30,LOW(0x75)
	LDI  R26,HIGH(0x75)
	CPC  R31,R26
	BRNE _0x4000E
; 0002 001B                 {
; 0002 001C                     d = va_arg(ap,unsigned int);   //0~4294967295
	CALL SUBOPT_0x1B
	LD   R18,X+
	LD   R19,X
; 0002 001D                     i=0;        //turn d into decimal,low digit first
	LDI  R21,LOW(0)
; 0002 001E                     while(1)
_0x4000F:
; 0002 001F                       {
; 0002 0020                         buf[i] = d%10+'0';  //ASICII character
	CALL SUBOPT_0x7
	CALL SUBOPT_0x1D
; 0002 0021                         d = d/10;
; 0002 0022                         if(d==0)//done
	BREQ _0x40011
; 0002 0023                                 break;
; 0002 0024                         i++;
	SUBI R21,-1
; 0002 0025                       }
	RJMP _0x4000F
_0x40011:
; 0002 0026                     while(i)		//i point to the max digit,output till buf[0]
_0x40013:
	CPI  R21,0
	BREQ _0x40015
; 0002 0027                         {
; 0002 0028                                 putchar1(buf[i]);
	CALL SUBOPT_0x7
	CALL SUBOPT_0x1E
; 0002 0029                                 i--;
	SUBI R21,1
; 0002 002A                         }
	RJMP _0x40013
_0x40015:
; 0002 002B                     putchar1(buf[0]);
	LDD  R30,Y+8
	RJMP _0x4002D
; 0002 002C                 }
; 0002 002D                 break;
; 0002 002E             case 'd':
_0x4000E:
	CPI  R30,LOW(0x64)
	LDI  R26,HIGH(0x64)
	CPC  R31,R26
	BRNE _0x40016
; 0002 002F                 {
; 0002 0030                     d = va_arg(ap,signed long int);  //-2147483648~2147483647
	CALL SUBOPT_0x1B
	LD   R18,X+
	LD   R19,X
; 0002 0031 
; 0002 0032                     if(d<0)	//negative output a minus
	TST  R19
	BRPL _0x40017
; 0002 0033                             putchar1('-');
	LDI  R30,LOW(45)
	ST   -Y,R30
	RCALL _putchar1
; 0002 0034                     d = abs(d);
_0x40017:
	ST   -Y,R19
	ST   -Y,R18
	CALL _abs
	MOVW R18,R30
; 0002 0035                     i=0;
	LDI  R21,LOW(0)
; 0002 0036                     while(1)
_0x40018:
; 0002 0037                            {
; 0002 0038                             buf[i] = d%10+'0';
	CALL SUBOPT_0x7
	CALL SUBOPT_0x1D
; 0002 0039                             d = d/10;
; 0002 003A                             if(d==0)
	BREQ _0x4001A
; 0002 003B                                     break;
; 0002 003C                             i++;
	SUBI R21,-1
; 0002 003D                           }
	RJMP _0x40018
_0x4001A:
; 0002 003E                      while(i)
_0x4001C:
	CPI  R21,0
	BREQ _0x4001E
; 0002 003F 	                {
; 0002 0040                             putchar1(buf[i]);
	CALL SUBOPT_0x7
	CALL SUBOPT_0x1E
; 0002 0041                             i--;
	SUBI R21,1
; 0002 0042                 	}
	RJMP _0x4001C
_0x4001E:
; 0002 0043                      putchar1(buf[0]);
	LDD  R30,Y+8
	RJMP _0x4002D
; 0002 0044                 }
; 0002 0045                 break;
; 0002 0046             case 'x':
_0x40016:
	CPI  R30,LOW(0x78)
	LDI  R26,HIGH(0x78)
	CPC  R31,R26
	BRNE _0x40022
; 0002 0047                 {
; 0002 0048                     d = va_arg(ap,char);  //
	CALL SUBOPT_0x1B
	LD   R18,X
	CLR  R19
; 0002 0049                     buf[1] = d%0x10+'0';
	MOVW R26,R18
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CALL __MODW21
	SUBI R30,-LOW(48)
	STD  Y+9,R30
; 0002 004A                     buf[0] = d/0x10+'0';
	MOVW R26,R18
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CALL __DIVW21
	SUBI R30,-LOW(48)
	STD  Y+8,R30
; 0002 004B                     if(buf[1]>'9')
	LDD  R26,Y+9
	CPI  R26,LOW(0x3A)
	BRLO _0x40020
; 0002 004C                         buf[1] += 7;
	LDD  R30,Y+9
	SUBI R30,-LOW(7)
	STD  Y+9,R30
; 0002 004D                     if(buf[0]>'9')
_0x40020:
	LDD  R26,Y+8
	CPI  R26,LOW(0x3A)
	BRLO _0x40021
; 0002 004E                         buf[0] += 7;
	LDD  R30,Y+8
	SUBI R30,-LOW(7)
	STD  Y+8,R30
; 0002 004F                     putchar1(buf[0]);
_0x40021:
	LDD  R30,Y+8
	ST   -Y,R30
	RCALL _putchar1
; 0002 0050                     putchar1(buf[1]);
	LDD  R30,Y+9
	RJMP _0x4002D
; 0002 0051                 }
; 0002 0052                 break;
; 0002 0053            /* Add other specifiers here... */
; 0002 0054             default:
_0x40022:
; 0002 0055                 putchar1(*fmt);
	CALL SUBOPT_0x19
	LD   R30,Z
_0x4002D:
	ST   -Y,R30
	RCALL _putchar1
; 0002 0056                 break;
; 0002 0057         }
_0x40009:
; 0002 0058         fmt++;
	CALL SUBOPT_0x1A
; 0002 0059     }
	RJMP _0x40003
_0x40005:
; 0002 005A     va_end(ap);
; 0002 005B     return 1;   /* Dummy return value */
	LDI  R30,LOW(1)
	CALL __LOADLOCR6
	ADIW R28,24
	POP  R15
	RET
; 0002 005C }
;
;
;// Read the AD conversion result
;//unsigned int read_adc(unsigned char adc_input)
;//{
;//ADMUX=(adc_input & 0x1f) | (ADC_VREF_TYPE & 0xff);
;//if (adc_input & 0x20) ADCSRB |= 0x08;
;//else ADCSRB &= 0xf7;
;//// Delay needed for the stabilization of the ADC input voltage
;//delay_us(10);
;//// Start the AD conversion
;//ADCSRA|=0x40;
;//// Wait for the AD conversion to complete
;//while ((ADCSRA & 0x10)==0);
;//ADCSRA|=0x10;
;//return ADCW;
;//}
;
;
;
;
;
;
;// Get a character from the USART1 Receiver
;#pragma used+
;char getchar1(void)
; 0002 0077 {
_getchar1:
; 0002 0078 char status,data;
; 0002 0079 while (1)
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
_0x40023:
; 0002 007A       {
; 0002 007B       while (((status=UCSR1A) & RX_COMPLETE)==0);
_0x40026:
	LDS  R30,200
	MOV  R17,R30
	ANDI R30,LOW(0x80)
	BREQ _0x40026
; 0002 007C       data=UDR1;
	LDS  R16,206
; 0002 007D       if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x40029
; 0002 007E          return data;
	MOV  R30,R16
	RJMP _0x20A0001
; 0002 007F       }
_0x40029:
	RJMP _0x40023
; 0002 0080 }
_0x20A0001:
	LD   R16,Y+
	LD   R17,Y+
	RET
;#pragma used-
;
;// Write a character to the USART1 Transmitter
;#pragma used+
;void putchar1(char c)
; 0002 0086 {
_putchar1:
; 0002 0087 while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
;	c -> Y+0
_0x4002A:
	LDS  R30,200
	ANDI R30,LOW(0x20)
	BREQ _0x4002A
; 0002 0088 UDR1=c;
	LD   R30,Y
	STS  206,R30
; 0002 0089 }
	ADIW R28,1
	RET
;#pragma used-
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;

	.CSEG

	.CSEG

	.CSEG
_abs:
    ld   r30,y+
    ld   r31,y+
    sbiw r30,0
    brpl __abs0
    com  r30
    com  r31
    adiw r30,1
__abs0:
    ret
_labs:
    ld    r30,y+
    ld    r31,y+
    ld    r22,y+
    ld    r23,y+
    sbiw  r30,0
    sbci  r22,0
    sbci  r23,0
    brpl  __labs0
    com   r30
    com   r31
    com   r22
    com   r23
    clr   r0
    adiw  r30,1
    adc   r22,r0
    adc   r23,r0
__labs0:
    ret

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG

	.DSEG
__seed_G102:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x0:
	CBI  0xB,7
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
	SBI  0xB,7
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _uprintf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	__GETD1S 20
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	LDI  R24,4
	CALL _uprintf
	ADIW R28,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R21
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7:
	MOV  R30,R21
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x8:
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,8
	CALL _uprintf
	ADIW R28,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R16
	RJMP SUBOPT_0x4

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	SBI  0xE,5
	__DELAY_USB 11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xC:
	LDI  R30,LOW(3)
	ST   -Y,R30
	JMP  _i2c_SendStr

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xD:
	__GETD2S 30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xE:
	ADIW R30,4
	CALL __GETD1PF
	RCALL SUBOPT_0xD
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	MOVW R30,R28
	ADIW R30,12
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10:
	LDI  R30,LOW(5)
	ST   -Y,R30
	JMP  _i2c_SendStr

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x11:
	LDI  R30,LOW(2)
	ST   -Y,R30
	JMP  _i2c_SendStr

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x12:
	STD  Y+5,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(4)
	ST   -Y,R30
	JMP  _i2c_SendStr

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x13:
	LDI  R30,LOW(2)
	STD  Y+3,R30
	LDI  R30,LOW(32)
	STD  Y+4,R30
	ST   -Y,R17
	ST   -Y,R16
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	STD  Y+4,R30
	ST   -Y,R17
	ST   -Y,R16
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x15:
	STD  Y+6,R30
	ST   -Y,R17
	ST   -Y,R16
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x16:
	LD   R30,Y
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,3
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_rd
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	LDD  R30,Y+9
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x18:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x19:
	MOVW R26,R28
	ADIW R26,24
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1A:
	MOVW R26,R28
	ADIW R26,24
	CALL __ADDW2R15
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x1B:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,4
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	LD   R30,X
	ST   -Y,R30
	JMP  _putchar1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x1D:
	MOVW R26,R28
	ADIW R26,8
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	MOVW R26,R18
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	SUBI R30,-LOW(48)
	MOVW R26,R22
	ST   X,R30
	MOVW R26,R18
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	MOVW R18,R30
	MOV  R0,R18
	OR   R0,R19
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	MOVW R26,R28
	ADIW R26,8
	ADD  R26,R30
	ADC  R27,R31
	RJMP SUBOPT_0x1C


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSLW12R
__LSLW12L:
	LSL  R30
	ROL  R31
	DEC  R0
	BRNE __LSLW12L
__LSLW12R:
	RET

__ASRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __ASRD12R
__ASRD12L:
	ASR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __ASRD12L
__ASRD12R:
	RET

__LSRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSRD12R
__LSRD12L:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRD12L
__LSRD12R:
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__GETD1PF:
	LPM  R0,Z+
	LPM  R1,Z+
	LPM  R22,Z+
	LPM  R23,Z
	MOVW R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
