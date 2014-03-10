
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

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _lockinfo=R4

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

_0x17:
	.DB  0x0
_0x20045:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_0x2040060:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x04
	.DW  _0x17*2

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
;� Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 2014-1-23
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
;unsigned char lockinfo=0;
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
; 0000 0047     DDRE=0xB8;
	LDI  R30,LOW(184)
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
; 0000 0167 
; 0000 0168 
; 0000 0169     LNB_frequence =10750;//11300;
	SBIW R28,16
;	LNB_frequence -> Y+12
;	sate_frequence -> Y+8
;	TunerFreq -> Y+4
;	symbol_rate -> Y+0
	__GETD1N 0x29FE
	__PUTD1S 12
; 0000 016A     sate_frequence =11880; //92.2
	__GETD1N 0x2E68
	__PUTD1S 8
; 0000 016B     symbol_rate  =28800;   //
	__GETD1N 0x46E10000
	CALL __PUTD1S0
; 0000 016C     TunerFreq = (labs(LNB_frequence-sate_frequence))*1000;
	__GETD2S 8
	__GETD1S 12
	CALL __SUBD12
	CALL __PUTPARD1
	CALL _labs
	__GETD2N 0x3E8
	CALL __MULD12U
	__PUTD1S 4
; 0000 016D     init();
	RCALL _init
; 0000 016E 
; 0000 016F     LED_ON;
	CALL SUBOPT_0x0
; 0000 0170     delay_ms(200);
; 0000 0171     LED_OFF;
; 0000 0172     delay_ms(200);
; 0000 0173     LED_ON;
	CALL SUBOPT_0x0
; 0000 0174     delay_ms(200);
; 0000 0175     LED_OFF;
; 0000 0176     delay_ms(200);
; 0000 0177     LED_ON;
	CBI  0xB,7
; 0000 0178     delay_ms(200);
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CALL SUBOPT_0x1
; 0000 0179     LED_OFF;
	SBI  0xB,7
; 0000 017A     delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	CALL SUBOPT_0x1
; 0000 017B     putchar1('A');
	LDI  R30,LOW(65)
	ST   -Y,R30
	CALL _putchar1
; 0000 017C     putchar1('B');
	LDI  R30,LOW(66)
	ST   -Y,R30
	CALL _putchar1
; 0000 017D 
; 0000 017E     /*LED_ON;
; 0000 017F     delay_ms(500);
; 0000 0180     LED_OFF;
; 0000 0181     delay_ms(500); */
; 0000 0182 
; 0000 0183     //tuner(TunerFreq,symbol_rate);
; 0000 0184     putchar1('C');
	LDI  R30,LOW(67)
	ST   -Y,R30
	CALL _putchar1
; 0000 0185     while (getchar1())
_0xF:
	CALL _getchar1
	CPI  R30,0
	BREQ _0x11
; 0000 0186           {
; 0000 0187            // Place your code here
; 0000 0188             putchar1('D');
	LDI  R30,LOW(68)
	ST   -Y,R30
	CALL _putchar1
; 0000 0189 
; 0000 018A             LED_ON;
	CBI  0xB,7
; 0000 018B             delay_ms(1000);
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CALL SUBOPT_0x1
; 0000 018C             LED_OFF;
	SBI  0xB,7
; 0000 018D             delay_ms(1000);
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CALL SUBOPT_0x1
; 0000 018E 
; 0000 018F //            if(lockinfo>0)      //1st one
; 0000 0190 //                LED_ON;
; 0000 0191 //            delay_ms(200);
; 0000 0192 //            LED_OFF;
; 0000 0193 //            delay_ms(200);
; 0000 0194 //
; 0000 0195 //            if(lockinfo>1)      //2nd two
; 0000 0196 //                LED_ON;
; 0000 0197 //            delay_ms(200);
; 0000 0198 //            LED_OFF;
; 0000 0199 //            delay_ms(200);
; 0000 019A //
; 0000 019B //            if(lockinfo>3)       //third four
; 0000 019C //                LED_ON;
; 0000 019D //            delay_ms(200);
; 0000 019E //            LED_OFF;
; 0000 019F //            delay_ms(200);
; 0000 01A0 //
; 0000 01A1 //            if(lockinfo>5)        //4th 8
; 0000 01A2 //                LED_ON;
; 0000 01A3 //            delay_ms(200);
; 0000 01A4 //            LED_OFF;
; 0000 01A5 //            delay_ms(200);
; 0000 01A6 //
; 0000 01A7 //            LED_ON;
; 0000 01A8 //            delay_ms(1000);
; 0000 01A9 //            LED_OFF;
; 0000 01AA //            delay_ms(1000);
; 0000 01AB 
; 0000 01AC             putchar1('A');
	LDI  R30,LOW(65)
	ST   -Y,R30
	CALL _putchar1
; 0000 01AD           }
	RJMP _0xF
_0x11:
; 0000 01AE }
	ADIW R28,16
_0x16:
	RJMP _0x16
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
;#define SCLH PORTE.5=1
;#define SCLL PORTE.5=0
;#define SDAH PORTE.4=1
;#define SDAL PORTE.4=0
;
;
;extern unsigned char lockinfo;
;
;flash	unsigned	long	LVCO_FREQS[3][2] =
;{
;	{950000,970000},
;	{970000,1065000},
;	{1065000,1170000}
;};
;flash	unsigned	long	HVCO_FREQS[7][2] =
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
;
;void TunerRst(void)
; 0001 001F {

	.CSEG
; 0001 0020 	PORTE.2=0;
; 0001 0021 	delay_ms(50);
; 0001 0022 	PORTE.2=1;
; 0001 0023 }
;
;
;
;/***********************************
;I2C��ʼλ  SDA SCL��Ϊ���
;SDA��SCLΪ��ʱ�Ӹ߱�Ϊ��
;***********************************/
;void i2c_sta(void)
; 0001 002C {
; 0001 002D 	DDRE |= 0x30;      //PE5 PE4(SCL SDA) as output
; 0001 002E 	SDAH;
; 0001 002F 	SCLH;
; 0001 0030 	delay_us(4);
; 0001 0031 	SDAL;
; 0001 0032 	delay_us(2);
; 0001 0033 }
;
;/***********************************
;I2C����λ  SDA SCL��Ϊ���
;SDA��SCLΪ��ʱ��Ϊ��
;***********************************/
;void i2c_stp(void)
; 0001 003A {
; 0001 003B 	SCLH;
; 0001 003C 	delay_us(2);
; 0001 003D 	SDAL;
; 0001 003E }
;
;
;/*****************************
;��ȡACK  ��SCL��ߺ�2us��ȡSDA
;�ӻ���SDA����ΪACK��Ӧ
;��ACK����1  ��ACK����0
;******************************/
;char SDA_in(void)
; 0001 0047 {
; 0001 0048 
; 0001 0049 DDRE &=0xEF;       //SDA  input
; 0001 004A PORTE |= 0x10;       //SDA pull-up
; 0001 004B delay_us(6);
; 0001 004C SCLH;
; 0001 004D delay_us(2);
; 0001 004E if(PINE.4==0)
; 0001 004F   {
; 0001 0050 //         temp_para++;
; 0001 0051 //         //printf("xiang ying: temp_para = %d\n",temp_para);
; 0001 0052   delay_us(2);
; 0001 0053   SCLL;
; 0001 0054   DDRE |=0x10;          //SDA output
; 0001 0055   PORTE.4=1;            //SDA high
; 0001 0056    putchar1('&');
; 0001 0057   return 1;
; 0001 0058   }
; 0001 0059 else
; 0001 005A 	{
; 0001 005B 	 //temp_para++;
; 0001 005C 	 //Tx0('X');
; 0001 005D 	 DDRE |=0x10;             //SDA output
; 0001 005E 	 return 0;
; 0001 005F 	}
; 0001 0060 }
;
;
;/**************************************
;����һ���ֽڵ����ݣ���������յ�ACK����1  ���򷵻�0
;***************************************/
;char i2c_send(unsigned char data)
; 0001 0067 {
; 0001 0068 	char i;
; 0001 0069 
; 0001 006A 	for(i=0;i<8;i++)
;	data -> Y+1
;	i -> R17
; 0001 006B 	{
; 0001 006C         	SCLL;
; 0001 006D         	delay_us(4);
; 0001 006E         	if(data & 0x80)
; 0001 006F         		SDAH;
; 0001 0070         	else
; 0001 0071         		SDAL;
; 0001 0072         	data=(data<<1);
; 0001 0073 
; 0001 0074 
; 0001 0075         	delay_us(2);
; 0001 0076         	SCLH;
; 0001 0077         	delay_us(4);
; 0001 0078 	}
; 0001 0079 	SCLL;
; 0001 007A 
; 0001 007B 	if(SDA_in()==1)
; 0001 007C 		{
; 0001 007D 		delay_us(2);
; 0001 007E 		//Tx0('P');
; 0001 007F                 lockinfo = 1;
; 0001 0080 		return 1;
; 0001 0081 		}
; 0001 0082 	else
; 0001 0083 		{
; 0001 0084 		delay_us(2);
; 0001 0085 		lockinfo = 0;
; 0001 0086 		return 0;
; 0001 0087 		}
; 0001 0088 
; 0001 0089 }
;/****************************************
;��ȡһ���ֽڵ����ݲ����ظ��ֽ�
;****************************************/
;unsigned char i2c_byte_read(void)
; 0001 008E {
; 0001 008F         unsigned char i,data;
; 0001 0090         data=0;
;	i -> R17
;	data -> R16
; 0001 0091         DDRE &=0xEF;       //SDA  input
; 0001 0092         PORTE |= 0x10;       //SDA pull-up
; 0001 0093         SCLL;
; 0001 0094         delay_us(3);
; 0001 0095         for(i=0;i<8;i++)
; 0001 0096         {
; 0001 0097                 SCLH;
; 0001 0098                 delay_us(2);
; 0001 0099                 data=data<<1;
; 0001 009A                 data=(data |(PINE & 0x10));
; 0001 009B                 delay_us(2);
; 0001 009C 
; 0001 009D                 SCLL;
; 0001 009E                 delay_us(4);
; 0001 009F         }
; 0001 00A0         //data=(data |((PINE & 0x10)?1:0));
; 0001 00A1         DDRE.4=1;
; 0001 00A2         SDAL;
; 0001 00A3         SCLH;
; 0001 00A4         delay_us(4);
; 0001 00A5         SCLL;
; 0001 00A6         delay_us(4);
; 0001 00A7         return data;
; 0001 00A8 
; 0001 00A9 }
;
;
;
;/******************************************************
;������ȡI2C  �����ֱ�Ϊ �ӻ���ַ�����ص��ֽڴ�ŵ�����ָ�룬���ص��ֽ���
;slave address,pointer to be written,number to be read
;�ӻ���Ӧ�˵�ַ����1 ���򷵻�0
;*******************************************************/
;char i2c_rd(unsigned char addr,unsigned char *ddata,unsigned char counter)
; 0001 00B3 {
; 0001 00B4  unsigned char i;
; 0001 00B5  unsigned char *pdata;
; 0001 00B6  i=counter;
;	addr -> Y+7
;	*ddata -> Y+5
;	counter -> Y+4
;	i -> R17
;	*pdata -> R18,R19
; 0001 00B7  pdata=ddata;
; 0001 00B8  i2c_sta();
; 0001 00B9  if(i2c_send(addr|0x01)==1)
; 0001 00BA    {
; 0001 00BB          while(i)
; 0001 00BC         	{
; 0001 00BD         		*pdata=i2c_byte_read();
; 0001 00BE         		pdata++;
; 0001 00BF         		i--;
; 0001 00C0         	}
; 0001 00C1          i2c_stp();
; 0001 00C2          return 1;
; 0001 00C3     }
; 0001 00C4  else
; 0001 00C5         return 0;
; 0001 00C6 
; 0001 00C7 }
;/**********************************************
;����һ���ֽڵ��ӻ�
;pointer to the first byte,number to be written
;������ɷ���1  ���򷵻�0
;**********************************************/
;char i2c_tran(char *data,char num)
; 0001 00CE {
; 0001 00CF 	char i;
; 0001 00D0 	i2c_sta();
;	*data -> Y+2
;	num -> Y+1
;	i -> R17
; 0001 00D1 	for(i=0;i<num;i++)
; 0001 00D2 	{
; 0001 00D3         	if(i2c_send(*data))
; 0001 00D4         		data++;
; 0001 00D5         	else
; 0001 00D6         		return 0;
; 0001 00D7 	}
; 0001 00D8 	i2c_stp();
; 0001 00D9 	return 1;
; 0001 00DA 
; 0001 00DB }
;
;
;
;/******************************
;open tuner interface
;*******************************/
;void EnableTunerOperation(void)
; 0001 00E3 {
; 0001 00E4     unsigned char byte[3];
; 0001 00E5      byte[0]=0xD0;
;	byte -> Y+0
; 0001 00E6      byte[1]=0x01;
; 0001 00E7      byte[2]=0xC0;
; 0001 00E8      i2c_tran(byte,3);
; 0001 00E9      ////printf("Enable Tuner Operation\n");
; 0001 00EA }
;
;/*******************************
;close tuner interface
;*******************************/
;void DisableTunerOperation(void)
; 0001 00F0 {
; 0001 00F1     unsigned char byte[3];
; 0001 00F2     byte[0]=0xD0;
;	byte -> Y+0
; 0001 00F3     byte[1]=0x01;
; 0001 00F4     byte[2]=0x40;
; 0001 00F5     i2c_tran(byte,3);
; 0001 00F6     ////printf("Disable Tuner Operation\n");
; 0001 00F7 }
;
;/******************************************************
;����Ƶ�� ��֮ת��Ϊtuner��ʼ����Ҫ���ֽ�����,��д��оƬ
;*******************************************************/
;unsigned char TFC(unsigned long _TunerFrequency) //TunerFrequencyCalculate  KHZ
; 0001 00FD {
; 0001 00FE 
; 0001 00FF 	unsigned long long_tmp, TunerFrequency  ;
; 0001 0100 	unsigned int i;
; 0001 0101 	unsigned char B[5] = {0x00},temp[5] = {0x00};
; 0001 0102 	unsigned int ddata,pd2,pd3,pd4,pd5 ;
; 0001 0103         //printf("TunerFreq %ld.\n",_TunerFrequency);
; 0001 0104 
; 0001 0105 	B[0] = 0xc0;
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
; 0001 0106 	if ((_TunerFrequency>=900000)&&(_TunerFrequency<1170000)) 	//
; 0001 0107 	{
; 0001 0108 		B[4]=0x0e;
; 0001 0109 		for (i=0; i<3; i++)
; 0001 010A 		{
; 0001 010B 	        if (_TunerFrequency < LVCO_FREQS[i][1]) break;
; 0001 010C 		}
; 0001 010D 		i=i+0x05;
; 0001 010E 		i=i<<5;
; 0001 010F     		B[4]= B[4]+i;
; 0001 0110 	}
; 0001 0111 	else													//
; 0001 0112 	{
; 0001 0113 		B[4]=0x0c;
; 0001 0114 		for (i=0; i<7; i++)
; 0001 0115 		{
; 0001 0116 	        if (_TunerFrequency < HVCO_FREQS[i][1]) break;
; 0001 0117 		}
; 0001 0118 		i=i+0x01;
; 0001 0119 		i=i<<5;
; 0001 011A 		B[4]= B[4]+i;
; 0001 011B 	}
; 0001 011C 	TunerFrequency = _TunerFrequency/500;
; 0001 011D 	long_tmp = TunerFrequency/32;
; 0001 011E 	i = TunerFrequency%32;
; 0001 011F  	B[1] = (int)((long_tmp>>3)&0x000000ff);
; 0001 0120 	B[2] = (int)((long_tmp<<5)&0x000000ff);
; 0001 0121 	B[2] = (int)(B[2] + i);
; 0001 0122 	i=0;
; 0001 0123 	////printf("TFC byte1~5:0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
; 0001 0124     do
; 0001 0125       {
; 0001 0126 //             temp_para = 0;
; 0001 0127 // 	    //printf("the cation of i2c acknowlede in function TFC\n");
; 0001 0128 	    temp[0] = B[0];
; 0001 0129 	    temp[1] = B[1];
; 0001 012A 	    temp[2] = B[2];
; 0001 012B 	    temp[4] = B[4];
; 0001 012C 
; 0001 012D             temp[3] = 0xe1;
; 0001 012E             temp[4] = B[4] & 0xf3;
; 0001 012F //             //printf("B1. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
; 0001 0130              ////printf("temp1. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",temp[0],temp[1],temp[2],temp[3],temp[4]);
; 0001 0131 
; 0001 0132             EnableTunerOperation();
; 0001 0133             i2c_tran(temp,5);                   //write byte1 byte2 byte3 byte4 byte5
; 0001 0134             //DisableTunerOperation();
; 0001 0135 
; 0001 0136             temp[1] = temp[3] | 0x04;
; 0001 0137             // //printf("temp2. byte1,4  0x%x,0x%x\n",temp[0],temp[1]);
; 0001 0138             //EnableTunerOperation();
; 0001 0139             i2c_tran(temp,2);           //write byte1 byte4
; 0001 013A             //DisableTunerOperation();
; 0001 013B             delay_ms(10);
; 0001 013C 
; 0001 013D             B[3] = 0xfd;
; 0001 013E             ddata =  (30000/1000)/2 - 2;
; 0001 013F             pd2 = (ddata>>1)&0x04	;
; 0001 0140             pd3 = (ddata<<1)&0x08	;
; 0001 0141             pd4 = (ddata<<2)&0x08	;
; 0001 0142             pd5 = (ddata<<4)&0x10	;
; 0001 0143             B[3] &= 0xE7	;
; 0001 0144             B[4] &= 0xF3	;
; 0001 0145             B[3] |= (pd5|pd4)	;
; 0001 0146             B[4] |= (pd3|pd2)	;
; 0001 0147 
; 0001 0148 //             //printf("B2. byte1~5  0x%x,0x%x,0x%x,0x%x,0x%x\n",B[0],B[1],B[2],B[3],B[4]);
; 0001 0149 
; 0001 014A             temp[1] = B[3] | 0x04;
; 0001 014B             temp[2] = B[4];
; 0001 014C             // //printf("temp3. byte1,4,5  0x%x,0x%x,0x%x\n",temp[0],temp[1],temp[2]);
; 0001 014D             //EnableTunerOperation();
; 0001 014E             i2c_tran(temp,3);                   //write byte1 byte4 byte5
; 0001 014F             DisableTunerOperation();
; 0001 0150 
; 0001 0151             delay_ms(1);
; 0001 0152             i++;
; 0001 0153             if(pll_lk())
; 0001 0154             {
; 0001 0155                 //printf("TunerFrequency Calculate & set Success! \n");
; 0001 0156                 return 1;
; 0001 0157             }
; 0001 0158         }while(i < 4);
; 0001 0159         //printf("TunerFrequency Calculate & set Failed!\n");
; 0001 015A         return 0;
; 0001 015B }
;
;
;/******************************
;STV0288оƬ��ʼ��
;***************************/
;void STV0288Init(void)
; 0001 0162 {
; 0001 0163  unsigned char byte[10];  //i = 0;
; 0001 0164  unsigned char *pointer;
; 0001 0165 
; 0001 0166         // temp_para = 0;
; 0001 0167         // //printf("the cation of i2c acknowlede in function STV0288Init\n");
; 0001 0168 
; 0001 0169         byte[0]=0xD0;
;	byte -> Y+2
;	*pointer -> R16,R17
; 0001 016A         pointer= &byte[0];
; 0001 016B 
; 0001 016C         /********************************
; 0001 016D         set clock
; 0001 016E         PLL_DIV=100
; 0001 016F         clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M
; 0001 0170         ********************************/
; 0001 0171         byte[1]= 0x40;
; 0001 0172         byte[2]= 0x64;             //PLLCTRL
; 0001 0173         byte[3]= 0x04;             //SYNTCTRL
; 0001 0174         i2c_tran(pointer,4);
; 0001 0175 
; 0001 0176 
; 0001 0177 
; 0001 0178         byte[1]=0x02;                 //ACR
; 0001 0179         byte[2]=0x20;
; 0001 017A         i2c_tran(pointer,3);
; 0001 017B 
; 0001 017C 
; 0001 017D 
; 0001 017E 
; 0001 017F         /*********************
; 0001 0180         set register about AGC
; 0001 0181         **********************/
; 0001 0182         byte[1]=0x0F;
; 0001 0183         byte[2]=0x54;               //AGC1REF
; 0001 0184         i2c_tran(pointer,3);
; 0001 0185         ////printf("AGC1REF*");
; 0001 0186         /*******************************
; 0001 0187         set register about timing loop
; 0001 0188         ********************************/
; 0001 0189 
; 0001 018A         byte[1]=0x11;
; 0001 018B         byte[2]=0x7a;                 //RTC
; 0001 018C         i2c_tran(pointer,3);
; 0001 018D         ////printf("RTC*");
; 0001 018E         byte[1]=0x22;
; 0001 018F         byte[2]=0x00;               //RTFM
; 0001 0190         byte[3]=0x00;               //RTFL
; 0001 0191         i2c_tran(pointer,4);
; 0001 0192         ////printf("RTF*");
; 0001 0193 
; 0001 0194         /**********************************************
; 0001 0195         set register about DAC (�üĴ������ò�Ӱ������)
; 0001 0196         **********************************************/
; 0001 0197 
; 0001 0198         byte[1]=0x1b;
; 0001 0199         byte[2]=0x8f;                    //DACR1
; 0001 019A         byte[3]=0xf0;               //DACR2
; 0001 019B         i2c_tran(pointer,4);
; 0001 019C         ////printf("DACR*");
; 0001 019D         /*******************************
; 0001 019E         set register about carrier loop
; 0001 019F         ********************************/
; 0001 01A0         byte[1]=0x15;
; 0001 01A1         byte[2]=0xf7;                   //CFD
; 0001 01A2         byte[3]=0x88;                 //ACLC
; 0001 01A3         byte[4]=0x58;                 //BCLC
; 0001 01A4         i2c_tran(pointer,5);
; 0001 01A5 
; 0001 01A6 
; 0001 01A7         byte[1]=0x19;
; 0001 01A8         byte[2]=0xa6;                   //LDT
; 0001 01A9         byte[3]=0x88;                 //LDT2
; 0001 01AA         i2c_tran(pointer,4);
; 0001 01AB 
; 0001 01AC         byte[1]=0x2B;
; 0001 01AD         byte[2]=0xFF;                   //CFRM
; 0001 01AE         byte[3]=0xF7;                 //CFRL
; 0001 01AF         i2c_tran(pointer,4);
; 0001 01B0 
; 0001 01B1 
; 0001 01B2         /*******************************
; 0001 01B3         set register about FEC and SYNC
; 0001 01B4         ********************************/
; 0001 01B5         byte[1]=0x37;
; 0001 01B6         byte[2]=0x2f;                   //PR
; 0001 01B7         byte[3]=0x16;                 //VSEARCH
; 0001 01B8         byte[4]=0xbd;                 //RS
; 0001 01B9         i2c_tran(pointer,5);
; 0001 01BA 
; 0001 01BB         // byte[1]=0x3B;
; 0001 01BC         // byte[2]=0x13;                   //ERRCTRL
; 0001 01BD         // byte[3]=0x12;                 //VITPROG
; 0001 01BE         // byte[4]=0x30;                 //ERRCTRL2
; 0001 01BF         // i2c_tran(pointer,5);
; 0001 01C0 
; 0001 01C1         byte[1]=0x3c;
; 0001 01C2         byte[2]=0x12;                 //VITPROG
; 0001 01C3         i2c_tran(pointer,3);
; 0001 01C4 
; 0001 01C5         byte[1]=0x02;         //ACR
; 0001 01C6         byte[2]=0x20;
; 0001 01C7         i2c_tran(pointer,3);
; 0001 01C8 
; 0001 01C9         /********************************
; 0001 01CA         set clock
; 0001 01CB         PLL_DIV=100
; 0001 01CC         clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M
; 0001 01CD         ********************************/
; 0001 01CE         byte[1]= 0x40;
; 0001 01CF         byte[2]= 0x63;             //PLLCTRL
; 0001 01D0         byte[3]= 0x04;             //SYNTCTRL
; 0001 01D1         byte[4]= 0x20;             //TSTTNR1
; 0001 01D2         i2c_tran(pointer,5);
; 0001 01D3 
; 0001 01D4 
; 0001 01D5         byte[1]=0xB2;
; 0001 01D6         byte[2]=0x10;                   //AGCCFG
; 0001 01D7         byte[3]=0x82;                 //DIRCLKCFG
; 0001 01D8         byte[4]=0x80;                 //AUXCKCFG
; 0001 01D9         byte[5]=0x82;                 //STDBYCFG
; 0001 01DA         byte[6]=0x82;                 //CS0CFG
; 0001 01DB         byte[7]=0x82;                 //CS1CFG
; 0001 01DC         i2c_tran(pointer,8);
; 0001 01DD         //printf("STV0288 Init Done\n");
; 0001 01DE }
;
;
;/**********************************
;�趨������
;**********************************/
;void SetSymbolRate(float sym_rate)
; 0001 01E5 {
; 0001 01E6         char byte[8];
; 0001 01E7         char *pointer;
; 0001 01E8         long int ksy_rate;
; 0001 01E9         pointer = &byte[0];
;	sym_rate -> Y+14
;	byte -> Y+6
;	*pointer -> R16,R17
;	ksy_rate -> Y+2
; 0001 01EA        // temp_para = 0;
; 0001 01EB //         //printf("the cation of i2c acknowlede in function SetSymbolRate\n");
; 0001 01EC 
; 0001 01ED         byte[0]=0xD0;
; 0001 01EE 
; 0001 01EF         /********************************
; 0001 01F0         set clock
; 0001 01F1         PLL_DIV=100
; 0001 01F2         clock inputfrom CLKI,Fmclk=4M*PLL_DIV/4=100M
; 0001 01F3         ********************************/
; 0001 01F4         byte[1]= 0x40;
; 0001 01F5         byte[2]= 0x64;             //PLLCTRL
; 0001 01F6         byte[3]= 0x04;             //SYNTCTRL
; 0001 01F7         i2c_tran(pointer,4);
; 0001 01F8 
; 0001 01F9 
; 0001 01FA 
; 0001 01FB         byte[1]=0x02;                 //ACR
; 0001 01FC         byte[2]=0x20;
; 0001 01FD         i2c_tran(pointer,3);
; 0001 01FE 
; 0001 01FF         /*****************************
; 0001 0200         set symbol rate
; 0001 0201         //SFRH,SFRM,SFRL = 27.5/100*2e20 =0x46666   27.49996
; 0001 0202         *****************************/
; 0001 0203         ksy_rate =(sym_rate*1048576/100000);
; 0001 0204         byte[1]=0x28;
; 0001 0205 
; 0001 0206         byte[2]=(ksy_rate >> 12)& 0xFF;
; 0001 0207         byte[3]=(ksy_rate >> 4)& 0xFF;
; 0001 0208         byte[4]=(ksy_rate << 4)& 0xFF;
; 0001 0209 
; 0001 020A         //printf("symbol %f, 0x%x 0x%x 0x%x\n",sym_rate,byte[2],byte[3],byte[4] );
; 0001 020B         byte[5]=0;     //CFRM  �ز�Ƶ��
; 0001 020C         byte[6]=0;     //CFRL
; 0001 020D         i2c_tran(pointer,7);
; 0001 020E         //printf("SetSymbolRate Done\n");
; 0001 020F }
;
;
;
;/***************************************************************
;7395��ʼ��
;master clock����Ϊ100M
;����ʹ��Asia6  12395MHz frequency  27500K symbol rate
;12395-10750=1645=fvco=32*51+13
;11880-10750=1030
;****************************************************************/
;unsigned char tuner(unsigned long F,float S)
; 0001 021B {
; 0001 021C 
; 0001 021D         char i;
; 0001 021E         TunerRst();
;	F -> Y+5
;	S -> Y+1
;	i -> R17
; 0001 021F         delay_ms(50);
; 0001 0220 
; 0001 0221 
; 0001 0222         putchar1('1');
; 0001 0223         TFC(F);
; 0001 0224         putchar1('2');
; 0001 0225         STV0288Init();
; 0001 0226         putchar1('3');
; 0001 0227         SetSymbolRate(S);
; 0001 0228         putchar1('4');
; 0001 0229         i = 0;
; 0001 022A         while(i<4)
; 0001 022B         {
; 0001 022C             i++;
; 0001 022D             delay_us(900);
; 0001 022E             if(locked())
; 0001 022F             {
; 0001 0230                //printf("locked\n");
; 0001 0231                lockinfo = 8;
; 0001 0232                return 1;
; 0001 0233             }
; 0001 0234         }
; 0001 0235         //printf("not locked\n");
; 0001 0236         return 0;
; 0001 0237 
; 0001 0238 }
;
;/*
;read lock register
;and save to pointer p
;*/
;void getstus(char *p)
; 0001 023F   {
; 0001 0240         char data[3];
; 0001 0241         char *pdata;
; 0001 0242         char i,j;
; 0001 0243         i = 1;
;	*p -> Y+7
;	data -> Y+4
;	*pdata -> R16,R17
;	i -> R19
;	j -> R18
; 0001 0244         j = 0;
; 0001 0245         putchar1('5');
; 0001 0246         do
; 0001 0247           {
; 0001 0248                  pdata = &data[0];
; 0001 0249                  data[0]= 0xD0;
; 0001 024A                  data[1]= 0x24;
; 0001 024B                  if (i2c_tran(pdata,2))
; 0001 024C                    {
; 0001 024D                      putchar1('b');
; 0001 024E                       if(i2c_rd(data[0],pdata,2))
; 0001 024F                       {
; 0001 0250                                p[j] = data[0];
; 0001 0251                                //////printf("R 24-0x%x    ",data[0]);
; 0001 0252                                j = 1;
; 0001 0253 
; 0001 0254                                 i=0;
; 0001 0255 
; 0001 0256                       }
; 0001 0257                    }
; 0001 0258             }
; 0001 0259        while(i) ;
; 0001 025A        putchar1('6');
; 0001 025B        i=1;
; 0001 025C        do
; 0001 025D           {
; 0001 025E                  pdata = &data[0];
; 0001 025F                  data[0]= 0xD0;
; 0001 0260                  data[1]= 0x1E;
; 0001 0261                  if (i2c_tran(pdata,2))
; 0001 0262                    {
; 0001 0263                          if(i2c_rd(data[0],pdata,2))
; 0001 0264                          {
; 0001 0265                               p[j] = data[0];
; 0001 0266                               //////printf("R 1E-0x%x\n",data[0]);
; 0001 0267                               i=0;
; 0001 0268                          }
; 0001 0269                    }
; 0001 026A           }
; 0001 026B        while(i) ;
; 0001 026C       putchar1('7');
; 0001 026D   }
;
;
;char locked(void)
; 0001 0271 {
; 0001 0272     char t[2];
; 0001 0273     getstus(t);
;	t -> Y+0
; 0001 0274 
; 0001 0275 
; 0001 0276     if(((t[0] & 0x80) == 0x80) && ((t[1] & 0x80) == 0x80))
; 0001 0277     {
; 0001 0278         //LED_ON;
; 0001 0279         return 1;
; 0001 027A     }
; 0001 027B     else
; 0001 027C     {
; 0001 027D        STV0288Init();
; 0001 027E        //LED_OFF;
; 0001 027F        return 0;
; 0001 0280     }
; 0001 0281 
; 0001 0282  }
;
;
;char Get0288Register(unsigned char addr)
; 0001 0286 {
; 0001 0287     char data[3];
; 0001 0288     char *pdata;
; 0001 0289     pdata = &data[0];
;	addr -> Y+5
;	data -> Y+2
;	*pdata -> R16,R17
; 0001 028A     data[0]= 0xD0;
; 0001 028B     data[1]= addr;
; 0001 028C     if (i2c_tran(pdata,2))
; 0001 028D       {
; 0001 028E        if(i2c_rd(data[0],pdata,1))
; 0001 028F           {
; 0001 0290            return data[0];
; 0001 0291           }
; 0001 0292       }
; 0001 0293 }
;
;unsigned char pll_lk(void)
; 0001 0296   {
; 0001 0297       unsigned char byte[1] = {0xc0},i = 0;
; 0001 0298       EnableTunerOperation();
;	byte -> Y+1
;	i -> R17
; 0001 0299       do
; 0001 029A       {
; 0001 029B           i2c_rd(byte[0],byte,1);
; 0001 029C           i++;
; 0001 029D           if((byte[0] & 0x40) != 0)
; 0001 029E           {
; 0001 029F               ////printf("pll locked:0x%x\n",byte[0]);
; 0001 02A0               lockinfo = 4;
; 0001 02A1               DisableTunerOperation();
; 0001 02A2               return 1;
; 0001 02A3           }
; 0001 02A4           else
; 0001 02A5           {
; 0001 02A6              if(byte[0]>0)
; 0001 02A7                    lockinfo = 2;
; 0001 02A8              ////printf("pll no locked:0x%x\n",byte[0]);
; 0001 02A9           }
; 0001 02AA       }while(i < 3);
; 0001 02AB       DisableTunerOperation();
; 0001 02AC       return 0;
; 0001 02AD }
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
;
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0002 0007 {

	.CSEG
; 0002 0008 ADMUX=(adc_input & 0x1f) | (ADC_VREF_TYPE & 0xff);
;	adc_input -> Y+0
; 0002 0009 if (adc_input & 0x20) ADCSRB |= 0x08;
; 0002 000A else ADCSRB &= 0xf7;
; 0002 000B // Delay needed for the stabilization of the ADC input voltage
; 0002 000C delay_us(10);
; 0002 000D // Start the AD conversion
; 0002 000E ADCSRA|=0x40;
; 0002 000F // Wait for the AD conversion to complete
; 0002 0010 while ((ADCSRA & 0x10)==0);
; 0002 0011 ADCSRA|=0x10;
; 0002 0012 return ADCW;
; 0002 0013 }
;
;
;#pragma used+
;/**********************
;���͵����ַ�
;***********************/
;void Tx0(unsigned char c)
; 0002 001B {
; 0002 001C         UDR0 = c;
;	c -> Y+0
; 0002 001D         while(!(UCSR0A & 0x40))
; 0002 001E                 ;
; 0002 001F         UCSR0A |= 0x40;
; 0002 0020 
; 0002 0021 }
;#pragma used-
;
;#pragma used+
;/**********************
;���յ����ַ�
;***********************/
;unsigned char Rx0(void)
; 0002 0029 {
; 0002 002A         if(UCSR0A & 0x80)
; 0002 002B            return UDR0;
; 0002 002C         else
; 0002 002D            return 0;
; 0002 002E }
;#pragma used-
;
;
;
;// Get a character from the USART1 Receiver
;#pragma used+
;char getchar1(void)
; 0002 0036 {
_getchar1:
; 0002 0037 char status,data;
; 0002 0038 while (1)
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
_0x4000D:
; 0002 0039       {
; 0002 003A       while (((status=UCSR1A) & RX_COMPLETE)==0);
_0x40010:
	LDS  R30,200
	MOV  R17,R30
	ANDI R30,LOW(0x80)
	BREQ _0x40010
; 0002 003B       data=UDR1;
	LDS  R16,206
; 0002 003C       if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x40013
; 0002 003D          return data;
	MOV  R30,R16
	RJMP _0x20A0001
; 0002 003E       }
_0x40013:
	RJMP _0x4000D
; 0002 003F }
_0x20A0001:
	LD   R16,Y+
	LD   R17,Y+
	RET
;#pragma used-
;
;// Write a character to the USART1 Transmitter
;#pragma used+
;void putchar1(char c)
; 0002 0045 {
_putchar1:
; 0002 0046 while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
;	c -> Y+0
_0x40014:
	LDS  R30,200
	ANDI R30,LOW(0x20)
	BREQ _0x40014
; 0002 0047 UDR1=c;
	LD   R30,Y
	STS  206,R30
; 0002 0048 }
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms


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

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
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

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

;END OF CODE MARKER
__END_OF_CODE:
