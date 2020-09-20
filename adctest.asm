GAS LISTING /tmp/ccPLkBqf.s 			page 1


   1               		.file	"adcTest.ino.ino.cpp"
   2               	__SP_H__ = 0x3e
   3               	__SP_L__ = 0x3d
   4               	__SREG__ = 0x3f
   5               	__RAMPZ__ = 0x3b
   6               	__tmp_reg__ = 0
   7               	__zero_reg__ = 1
   8               		.text
   9               	.Ltext0:
  10               		.cfi_sections	.debug_frame
  11               		.section	.text.__vector_21,"ax",@progbits
  12               	.global	__vector_21
  13               		.type	__vector_21, @function
  14               	__vector_21:
  15               	.LFB120:
  16               		.file 1 "/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino"
   1:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** typedef enum {REF_AREF=0, REF_AVCC=64, REF_1V=128, REF_256V=192} ADCREF;
   2:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** typedef enum {TRIG_ROUND=0, TRIG_COMPARATOR, TRIG_INT0, TRIG_T0A, TRIG_T0OVF, TRIG_T1B, TRIG_T1OVF,
   3:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** typedef enum {
   4:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_0=0, MUX_1, MUX_2, MUX_3, MUX_4, MUX_5, MUX_6, MUX_7,
   5:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_G10_00, MUX_G10_10, MUX_G200_00, MUX_G200_10,
   6:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_G10_22, MUX_G10_32, MUX_G200_22, MUX_G200_32,
   7:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_D01, MUX_D11, MUX_D21, MUX_D31, MUX_D41, MUX_D51, MUX_D61, MUX_D71,
   8:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_D02, MUX_D12, MUX_D22, MUX_D32, MUX_D42, MUX_D52,
   9:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_1V,  MUX_GND,
  10:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_8, MUX_9, MUX_A, MUX_B, MUX_C, MUX_D, MUX_E, MUX_F,
  11:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_G10_88, MUX_G10_98, MUX_G200_88, MUX_G200_98,
  12:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_G10_AA, MUX_G10_BA, MUX_G200_AA, MUX_G200_BA,
  13:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_D89, MUX_D99, MUX_DA9, MUX_DB9, MUX_DC9, MUX_DD9, MUX_DE9, MUX_DF9,
  14:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   MUX_D8A, MUX_D9A, MUX_DAA, MUX_DBA, MUX_DCA, MUX_DDA
  15:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** } ADCMUX;
  16:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** /*
  17:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define adcStart()   (ADCSRA |= ADSC)
  18:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define adc8bit()    (ADMUX |= ADLAR)
  19:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define adc10bit()   (ADMUX &= ~ADLAR)
  20:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define adcIntOn()   (ADCSRA |= ADIE)
  21:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define adcIntOff()  (ADCSRA &= ~ADIE)
  22:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define adc2comp()   (ADCSRB |= ACME)
  23:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** */
  24:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** // ADMUX:  REFS1(7), REFS0(6), ADLAR(5), MUX4..0
  25:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** // ADCSRA: ADEN(7), ADSC(6), ADATE(5), ADIF(4), ADIE(3), ADPS0..2
  26:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** // ADCSRB: ACME(6), ADMUX5(3),ADTS0..2
  27:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** // DIDR0:  Closed PINx for noise redusing ADC7..0
  28:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** // DIDR2:  Closed PINx for noise reducing ADC15..8
  29:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** // PRR0:   bit0=1 ADC power off!
  30:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  31:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** extern "C" {
  32:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define ADC_GO    0
  33:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define ADC_START 1
  34:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define ADC_DONE  2
  35:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  36:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** int                adcCount;  // how much need to read samples
  37:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** volatile uint8_t * adcBuffer; // pointer to buffer array
  38:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** volatile uint8_t   adcState = ADC_START;
  39:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  40:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** ISR (ADC_vect, ISR_NAKED)
  41:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** {
GAS LISTING /tmp/ccPLkBqf.s 			page 2


  17               		.loc 1 41 0
  18               		.cfi_startproc
  19               	/* prologue: naked */
  20               	/* frame size = 0 */
  21               	/* stack size = 0 */
  22               	.L__stack_usage = 0
  42:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   if( adcState == ADC_START ){
  23               		.loc 1 42 0
  24 0000 8091 0000 		lds r24,adcState
  25 0004 8130      		cpi r24,lo8(1)
  26 0006 01F4      		brne .L1
  43:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     if( adcCount-- ){
  27               		.loc 1 43 0
  28 0008 8091 0000 		lds r24,adcCount
  29 000c 9091 0000 		lds r25,adcCount+1
  30 0010 9C01      		movw r18,r24
  31 0012 2150      		subi r18,1
  32 0014 3109      		sbc r19,__zero_reg__
  33 0016 3093 0000 		sts adcCount+1,r19
  34 001a 2093 0000 		sts adcCount,r18
  35 001e 0097      		sbiw r24,0
  36 0020 01F0      		breq .L3
  44:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****       *adcBuffer++ = ADCH;
  37               		.loc 1 44 0
  38 0022 E091 0000 		lds r30,adcBuffer
  39 0026 F091 0000 		lds r31,adcBuffer+1
  40 002a CF01      		movw r24,r30
  41 002c 0196      		adiw r24,1
  42 002e 9093 0000 		sts adcBuffer+1,r25
  43 0032 8093 0000 		sts adcBuffer,r24
  44 0036 85B1      		in r24,0x5
  45 0038 8083      		st Z,r24
  46 003a 00C0      		rjmp .L1
  47               	.L3:
  45:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     }else{
  46:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****       adcState = ADC_DONE;
  48               		.loc 1 46 0
  49 003c 82E0      		ldi r24,lo8(2)
  50 003e 8093 0000 		sts adcState,r24
  47:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****       ADCSRA &= ~( _BV(ADIE)|_BV(ADFR) );
  51               		.loc 1 47 0
  52 0042 86B1      		in r24,0x6
  53 0044 877D      		andi r24,lo8(-41)
  54 0046 86B9      		out 0x6,r24
  55               	.L1:
  56               	/* epilogue start */
  48:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     }
  49:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   }
  50:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** }
  57               		.loc 1 50 0
  58               		.cfi_endproc
  59               	.LFE120:
  60               		.size	__vector_21, .-__vector_21
  61               		.section	.text.adcReadOne,"ax",@progbits
  62               	.global	adcReadOne
  63               		.type	adcReadOne, @function
  64               	adcReadOne:
GAS LISTING /tmp/ccPLkBqf.s 			page 3


  65               	.LFB121:
  51:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  52:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** }
  53:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  54:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** uint8_t adcReadOne()
  55:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** {
  66               		.loc 1 55 0
  67               		.cfi_startproc
  68               	/* prologue: function */
  69               	/* frame size = 0 */
  70               	/* stack size = 0 */
  71               	.L__stack_usage = 0
  56:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     ADCSRA |= _BV(ADSC);
  72               		.loc 1 56 0
  73 0000 369A      		sbi 0x6,6
  74               	.L5:
  57:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     while( ADCSRA & _BV(ADSC) );
  75               		.loc 1 57 0 discriminator 1
  76 0002 3699      		sbic 0x6,6
  77 0004 00C0      		rjmp .L5
  58:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     return ADCH;
  78               		.loc 1 58 0
  79 0006 85B1      		in r24,0x5
  59:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** }
  80               		.loc 1 59 0
  81 0008 0895      		ret
  82               		.cfi_endproc
  83               	.LFE121:
  84               		.size	adcReadOne, .-adcReadOne
  85               		.section	.text.adcStart,"ax",@progbits
  86               	.global	adcStart
  87               		.type	adcStart, @function
  88               	adcStart:
  89               	.LFB122:
  60:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  61:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** void adcStart(uint8_t * from, int len, uint8_t speed)
  62:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** {
  90               		.loc 1 62 0
  91               		.cfi_startproc
  92               	.LVL0:
  93               	/* prologue: function */
  94               	/* frame size = 0 */
  95               	/* stack size = 0 */
  96               	.L__stack_usage = 0
  63:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   adcBuffer = from;
  97               		.loc 1 63 0
  98 0000 9093 0000 		sts adcBuffer+1,r25
  99 0004 8093 0000 		sts adcBuffer,r24
  64:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   adcCount = len;
 100               		.loc 1 64 0
 101 0008 7093 0000 		sts adcCount+1,r23
 102 000c 6093 0000 		sts adcCount,r22
  65:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   adcState = ADC_START;
 103               		.loc 1 65 0
 104 0010 81E0      		ldi r24,lo8(1)
 105               	.LVL1:
 106 0012 8093 0000 		sts adcState,r24
GAS LISTING /tmp/ccPLkBqf.s 			page 4


  66:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   ADCSRA |= _BV(ADSC) | _BV(ADIE) | _BV(ADFR) | (0x03 & speed);
 107               		.loc 1 66 0
 108 0016 86B1      		in r24,0x6
 109 0018 8866      		ori r24,lo8(104)
 110 001a 4370      		andi r20,lo8(3)
 111               	.LVL2:
 112 001c 482B      		or r20,r24
 113 001e 46B9      		out 0x6,r20
 114               	.LVL3:
 115 0020 0895      		ret
 116               		.cfi_endproc
 117               	.LFE122:
 118               		.size	adcStart, .-adcStart
 119               		.section	.text.test,"ax",@progbits
 120               	.global	test
 121               		.type	test, @function
 122               	test:
 123               	.LFB123:
  67:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** }
  68:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  69:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** #define MAX_BUF 400
  70:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** uint8_t adcs[MAX_BUF];
  71:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  72:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** void test(int start, int len)
  73:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** {
 124               		.loc 1 73 0
 125               		.cfi_startproc
 126               	.LVL4:
 127 0000 EF92      		push r14
 128               	.LCFI0:
 129               		.cfi_def_cfa_offset 3
 130               		.cfi_offset 14, -2
 131 0002 FF92      		push r15
 132               	.LCFI1:
 133               		.cfi_def_cfa_offset 4
 134               		.cfi_offset 15, -3
 135 0004 0F93      		push r16
 136               	.LCFI2:
 137               		.cfi_def_cfa_offset 5
 138               		.cfi_offset 16, -4
 139 0006 1F93      		push r17
 140               	.LCFI3:
 141               		.cfi_def_cfa_offset 6
 142               		.cfi_offset 17, -5
 143 0008 CF93      		push r28
 144               	.LCFI4:
 145               		.cfi_def_cfa_offset 7
 146               		.cfi_offset 28, -6
 147 000a DF93      		push r29
 148               	.LCFI5:
 149               		.cfi_def_cfa_offset 8
 150               		.cfi_offset 29, -7
 151               	/* prologue: function */
 152               	/* frame size = 0 */
 153               	/* stack size = 6 */
 154               	.L__stack_usage = 6
 155 000c 7B01      		movw r14,r22
GAS LISTING /tmp/ccPLkBqf.s 			page 5


 156               	.LVL5:
 157               	.LBB2:
  74:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   uint8_t* ptr = &adcs[start];
 158               		.loc 1 74 0
 159 000e EC01      		movw r28,r24
 160 0010 C050      		subi r28,lo8(-(adcs))
 161 0012 D040      		sbci r29,hi8(-(adcs))
 162 0014 8C01      		movw r16,r24
 163 0016 0C1B      		sub r16,r28
 164 0018 1D0B      		sbc r17,r29
 165               	.LVL6:
 166               	.L10:
 167 001a C801      		movw r24,r16
 168 001c 8C0F      		add r24,r28
 169 001e 9D1F      		adc r25,r29
 170               	.LBB3:
  75:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  76:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   for(int i=start; i<len; i++){
 171               		.loc 1 76 0 discriminator 1
 172 0020 8E15      		cp r24,r14
 173 0022 9F05      		cpc r25,r15
 174 0024 04F4      		brge .L12
 175               	.LVL7:
  77:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     *(ptr++) = adcReadOne();
 176               		.loc 1 77 0 discriminator 3
 177 0026 0E94 0000 		call adcReadOne
 178               	.LVL8:
 179 002a 8993      		st Y+,r24
 180               	.LVL9:
 181 002c 00C0      		rjmp .L10
 182               	.L12:
 183               	/* epilogue start */
 184               	.LBE3:
 185               	.LBE2:
  78:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   }
  79:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** }
 186               		.loc 1 79 0
 187 002e DF91      		pop r29
 188 0030 CF91      		pop r28
 189               	.LVL10:
 190 0032 1F91      		pop r17
 191 0034 0F91      		pop r16
 192 0036 FF90      		pop r15
 193 0038 EF90      		pop r14
 194               	.LVL11:
 195 003a 0895      		ret
 196               		.cfi_endproc
 197               	.LFE123:
 198               		.size	test, .-test
 199               		.section	.text.setup,"ax",@progbits
 200               	.global	setup
 201               		.type	setup, @function
 202               	setup:
 203               	.LFB124:
  80:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  81:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** void setup() {
 204               		.loc 1 81 0
GAS LISTING /tmp/ccPLkBqf.s 			page 6


 205               		.cfi_startproc
 206               	/* prologue: function */
 207               	/* frame size = 0 */
 208               	/* stack size = 0 */
 209               	.L__stack_usage = 0
 210               	.LVL12:
 211               	.LBB6:
 212               	.LBB7:
 213               		.file 2 "/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSer
   1:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** /*
   2:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   HardwareSerial.h - Hardware serial library for Wiring
   3:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   Copyright (c) 2006 Nicholas Zambetti.  All right reserved.
   4:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
   5:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   This library is free software; you can redistribute it and/or
   6:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   modify it under the terms of the GNU Lesser General Public
   7:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   License as published by the Free Software Foundation; either
   8:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   version 2.1 of the License, or (at your option) any later version.
   9:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
  10:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   This library is distributed in the hope that it will be useful,
  11:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   but WITHOUT ANY WARRANTY; without even the implied warranty of
  12:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  13:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   Lesser General Public License for more details.
  14:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
  15:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   You should have received a copy of the GNU Lesser General Public
  16:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   License along with this library; if not, write to the Free Software
  17:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  18:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
  19:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   Modified 28 September 2010 by Mark Sproul
  20:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   Modified 14 August 2012 by Alarus
  21:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   Modified 3 December 2013 by Matthijs Kooijman
  22:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** */
  23:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
  24:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #ifndef HardwareSerial_h
  25:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define HardwareSerial_h
  26:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
  27:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #include <inttypes.h>
  28:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
  29:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #include "Stream.h"
  30:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
  31:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // Define constants and variables for buffering incoming serial data.  We're
  32:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // using a ring buffer (I think), in which head is the index of the location
  33:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // to which to write the next incoming character and tail is the index of the
  34:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // location from which to read.
  35:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // NOTE: a "power of 2" buffer size is reccomended to dramatically
  36:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** //       optimize all the modulo operations for ring buffers.
  37:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // WARNING: When buffer sizes are increased to > 256, the buffer index
  38:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // variables are automatically increased in size, but the extra
  39:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // atomicity guards needed for that are not implemented. This will
  40:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // often work, but occasionally a race condition can occur that makes
  41:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // Serial behave erratically. See https://github.com/arduino/Arduino/issues/2405
  42:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #if !defined(SERIAL_TX_BUFFER_SIZE)
  43:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #if ((RAMEND - RAMSTART) < 1023)
  44:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_TX_BUFFER_SIZE 16
  45:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #else
  46:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_TX_BUFFER_SIZE 64
  47:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #endif
  48:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #endif
GAS LISTING /tmp/ccPLkBqf.s 			page 7


  49:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #if !defined(SERIAL_RX_BUFFER_SIZE)
  50:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #if ((RAMEND - RAMSTART) < 1023)
  51:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_RX_BUFFER_SIZE 16
  52:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #else
  53:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_RX_BUFFER_SIZE 64
  54:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #endif
  55:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #endif
  56:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #if (SERIAL_TX_BUFFER_SIZE>256)
  57:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** typedef uint16_t tx_buffer_index_t;
  58:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #else
  59:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** typedef uint8_t tx_buffer_index_t;
  60:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #endif
  61:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #if  (SERIAL_RX_BUFFER_SIZE>256)
  62:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** typedef uint16_t rx_buffer_index_t;
  63:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #else
  64:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** typedef uint8_t rx_buffer_index_t;
  65:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #endif
  66:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
  67:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** // Define config for Serial.begin(baud, config);
  68:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_5N1 0x00
  69:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_6N1 0x02
  70:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_7N1 0x04
  71:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_8N1 0x06
  72:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_5N2 0x08
  73:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_6N2 0x0A
  74:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_7N2 0x0C
  75:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_8N2 0x0E
  76:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_5E1 0x20
  77:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_6E1 0x22
  78:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_7E1 0x24
  79:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_8E1 0x26
  80:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_5E2 0x28
  81:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_6E2 0x2A
  82:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_7E2 0x2C
  83:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_8E2 0x2E
  84:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_5O1 0x30
  85:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_6O1 0x32
  86:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_7O1 0x34
  87:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_8O1 0x36
  88:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_5O2 0x38
  89:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_6O2 0x3A
  90:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_7O2 0x3C
  91:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** #define SERIAL_8O2 0x3E
  92:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
  93:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** class HardwareSerial : public Stream
  94:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** {
  95:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   protected:
  96:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile uint8_t * const _ubrrh;
  97:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile uint8_t * const _ubrrl;
  98:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile uint8_t * const _ucsra;
  99:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile uint8_t * const _ucsrb;
 100:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile uint8_t * const _ucsrc;
 101:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile uint8_t * const _udr;
 102:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     // Has any byte been written to the UART since begin()
 103:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     bool _written;
 104:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
 105:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile rx_buffer_index_t _rx_buffer_head;
GAS LISTING /tmp/ccPLkBqf.s 			page 8


 106:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile rx_buffer_index_t _rx_buffer_tail;
 107:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile tx_buffer_index_t _tx_buffer_head;
 108:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     volatile tx_buffer_index_t _tx_buffer_tail;
 109:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
 110:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     // Don't put any members after these buffers, since only the first
 111:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     // 32 bytes of this struct can be accessed quickly using the ldd
 112:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     // instruction.
 113:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     unsigned char _rx_buffer[SERIAL_RX_BUFFER_SIZE];
 114:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     unsigned char _tx_buffer[SERIAL_TX_BUFFER_SIZE];
 115:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h **** 
 116:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****   public:
 117:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     inline HardwareSerial(
 118:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****       volatile uint8_t *ubrrh, volatile uint8_t *ubrrl,
 119:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****       volatile uint8_t *ucsra, volatile uint8_t *ucsrb,
 120:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****       volatile uint8_t *ucsrc, volatile uint8_t *udr);
 121:/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/HardwareSerial.h ****     void begin(unsigned long baud) { begin(baud, SERIAL_8N1); }
 214               		.loc 2 121 0
 215 0000 26E0      		ldi r18,lo8(6)
 216 0002 40E0      		ldi r20,0
 217 0004 52EC      		ldi r21,lo8(-62)
 218 0006 61E0      		ldi r22,lo8(1)
 219 0008 70E0      		ldi r23,0
 220 000a 80E0      		ldi r24,lo8(Serial)
 221 000c 90E0      		ldi r25,hi8(Serial)
 222 000e 0E94 0000 		call _ZN14HardwareSerial5beginEmh
 223               	.LVL13:
 224               	.LBE7:
 225               	.LBE6:
  82:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   Serial.begin(115200);
  83:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   TCCR3A = 128+32+8+1; // A,B,C normal + 01 - WGM1,WGM0
 226               		.loc 1 83 0
 227 0012 89EA      		ldi r24,lo8(-87)
 228 0014 8093 8B00 		sts 139,r24
  84:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   TCCR3B = 0+2;        // WGM3,WGM2=01 - "5mode:FastPWM255", Prescaler:1=16Mhz, 2=2Mhz 
 229               		.loc 1 84 0
 230 0018 82E0      		ldi r24,lo8(2)
 231 001a 8093 8A00 		sts 138,r24
  85:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   OCR3A = 192;
 232               		.loc 1 85 0
 233 001e 80EC      		ldi r24,lo8(-64)
 234 0020 90E0      		ldi r25,0
 235 0022 9093 8700 		sts 134+1,r25
 236 0026 8093 8600 		sts 134,r24
  86:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   OCR3B = 128;
 237               		.loc 1 86 0
 238 002a 80E8      		ldi r24,lo8(-128)
 239 002c 90E0      		ldi r25,0
 240 002e 9093 8500 		sts 132+1,r25
 241 0032 8093 8400 		sts 132,r24
  87:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   OCR3C = 64;
 242               		.loc 1 87 0
 243 0036 80E4      		ldi r24,lo8(64)
 244 0038 90E0      		ldi r25,0
 245 003a 9093 8300 		sts 130+1,r25
 246 003e 8093 8200 		sts 130,r24
  88:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   DDRE = _BV(3)|_BV(4)|_BV(5); // T3 A,B,C to uptput!
 247               		.loc 1 88 0
GAS LISTING /tmp/ccPLkBqf.s 			page 9


 248 0042 88E3      		ldi r24,lo8(56)
 249 0044 82B9      		out 0x2,r24
  89:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  90:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   ADMUX = 64|32;
 250               		.loc 1 90 0
 251 0046 80E6      		ldi r24,lo8(96)
 252 0048 87B9      		out 0x7,r24
  91:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** //  DIDR0 = 1;
  92:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** //  ADCSRB = 0;
  93:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** /*
  94:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   ADCSRA = _BV(ADEN) | 2; // 1:2 = 8Mhz
  95:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   delayMicroseconds(10);
  96:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   test(0, MAX_BUF/2);
  97:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
  98:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   ADCSRA = _BV(ADEN) | 4; // 1:4 = 4Mhz
  99:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   delayMicroseconds(10);
 100:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   test(MAX_BUF/2+1, MAX_BUF);
 101:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
 102:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   for(int i=0; i<MAX_BUF; i++){
 103:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     Serial.println(adcs[i], DEC);
 104:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   }
 105:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** */
 106:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   ADCSRA = _BV(ADEN);
 253               		.loc 1 106 0
 254 004a 80E8      		ldi r24,lo8(-128)
 255 004c 86B9      		out 0x6,r24
 107:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   delayMicroseconds(10);
 256               		.loc 1 107 0
 257 004e 8AE0      		ldi r24,lo8(10)
 258 0050 90E0      		ldi r25,0
 259 0052 0E94 0000 		call delayMicroseconds
 260               	.LVL14:
 108:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   adcState = 0;
 261               		.loc 1 108 0
 262 0056 1092 0000 		sts adcState,__zero_reg__
 263 005a 0895      		ret
 264               		.cfi_endproc
 265               	.LFE124:
 266               		.size	setup, .-setup
 267               		.section	.text.loop,"ax",@progbits
 268               	.global	loop
 269               		.type	loop, @function
 270               	loop:
 271               	.LFB125:
 109:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** }
 110:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** 
 111:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** void loop()
 112:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** {
 272               		.loc 1 112 0
 273               		.cfi_startproc
 274 0000 CF93      		push r28
 275               	.LCFI6:
 276               		.cfi_def_cfa_offset 3
 277               		.cfi_offset 28, -2
 278 0002 DF93      		push r29
 279               	.LCFI7:
 280               		.cfi_def_cfa_offset 4
GAS LISTING /tmp/ccPLkBqf.s 			page 10


 281               		.cfi_offset 29, -3
 282               	/* prologue: function */
 283               	/* frame size = 0 */
 284               	/* stack size = 2 */
 285               	.L__stack_usage = 2
 286               	.LBB8:
 113:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   switch(adcState){
 287               		.loc 1 113 0
 288 0004 8091 0000 		lds r24,adcState
 289 0008 8130      		cpi r24,lo8(1)
 290 000a 01F0      		breq .L14
 291 000c 8230      		cpi r24,lo8(2)
 292 000e 01F4      		brne .L15
 293 0010 C0E0      		ldi r28,lo8(adcs)
 294 0012 D0E0      		ldi r29,hi8(adcs)
 295               	.L18:
 296               	.LVL15:
 297               	.LBB9:
 298               	.LBB10:
 114:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     case ADC_START:
 115:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****       break;
 116:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     case ADC_DONE:
 117:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****       for(int i=0; i<MAX_BUF; i++){
 118:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****         Serial.println(adcs[i], DEC);
 299               		.loc 1 118 0 discriminator 3
 300 0014 6991      		ld r22,Y+
 301               	.LVL16:
 302 0016 4AE0      		ldi r20,lo8(10)
 303 0018 50E0      		ldi r21,0
 304 001a 80E0      		ldi r24,lo8(Serial)
 305 001c 90E0      		ldi r25,hi8(Serial)
 306 001e 0E94 0000 		call _ZN5Print7printlnEhi
 307               	.LVL17:
 117:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****         Serial.println(adcs[i], DEC);
 308               		.loc 1 117 0 discriminator 3
 309 0022 80E0      		ldi r24,hi8(adcs+400)
 310 0024 C030      		cpi r28,lo8(adcs+400)
 311 0026 D807      		cpc r29,r24
 312 0028 01F4      		brne .L18
 313               	.LBE10:
 119:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****       }
 120:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****       adcState=0;
 314               		.loc 1 120 0
 315 002a 1092 0000 		sts adcState,__zero_reg__
 121:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****       delay(10000);
 316               		.loc 1 121 0
 317 002e 60E1      		ldi r22,lo8(16)
 318 0030 77E2      		ldi r23,lo8(39)
 319 0032 80E0      		ldi r24,0
 320 0034 90E0      		ldi r25,0
 321 0036 0E94 0000 		call delay
 322               	.LVL18:
 323               	.L15:
 122:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****     default:
 123:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****       adcStart(&adcs[0], MAX_BUF, 3);
 324               		.loc 1 123 0
 325 003a 43E0      		ldi r20,lo8(3)
GAS LISTING /tmp/ccPLkBqf.s 			page 11


 326 003c 60E9      		ldi r22,lo8(-112)
 327 003e 71E0      		ldi r23,lo8(1)
 328 0040 80E0      		ldi r24,lo8(adcs)
 329 0042 90E0      		ldi r25,hi8(adcs)
 330               	/* epilogue start */
 331               	.LBE9:
 332               	.LBE8:
 124:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   }
 125:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino **** }
 333               		.loc 1 125 0
 334 0044 DF91      		pop r29
 335 0046 CF91      		pop r28
 336               	.LBB12:
 337               	.LBB11:
 123:/home/arhat109/Arduino/tests/adcTest.ino/adcTest.ino.ino ****   }
 338               		.loc 1 123 0
 339 0048 0C94 0000 		jmp adcStart
 340               	.LVL19:
 341               	.L14:
 342               	/* epilogue start */
 343               	.LBE11:
 344               	.LBE12:
 345               		.loc 1 125 0
 346 004c DF91      		pop r29
 347 004e CF91      		pop r28
 348 0050 0895      		ret
 349               		.cfi_endproc
 350               	.LFE125:
 351               		.size	loop, .-loop
 352               	.global	adcs
 353               		.section	.bss.adcs,"aw",@nobits
 354               		.type	adcs, @object
 355               		.size	adcs, 400
 356               	adcs:
 357 0000 0000 0000 		.zero	400
 357      0000 0000 
 357      0000 0000 
 357      0000 0000 
 357      0000 0000 
 358               	.global	adcState
 359               		.section	.data.adcState,"aw",@progbits
 360               		.type	adcState, @object
 361               		.size	adcState, 1
 362               	adcState:
 363 0000 01        		.byte	1
 364               	.global	adcBuffer
 365               		.section	.bss.adcBuffer,"aw",@nobits
 366               		.type	adcBuffer, @object
 367               		.size	adcBuffer, 2
 368               	adcBuffer:
 369 0000 0000      		.zero	2
 370               	.global	adcCount
 371               		.section	.bss.adcCount,"aw",@nobits
 372               		.type	adcCount, @object
 373               		.size	adcCount, 2
 374               	adcCount:
 375 0000 0000      		.zero	2
GAS LISTING /tmp/ccPLkBqf.s 			page 12


 376               		.text
 377               	.Letext0:
 378               		.file 3 "/home/arhat109/progs/arduino-1.8.2/hardware/tools/avr/lib/gcc/avr/4.9.2/include/stddef.h"
 379               		.file 4 "/home/arhat109/progs/arduino-1.8.2/hardware/tools/avr/avr/include/stdint.h"
 380               		.file 5 "/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/Print.h"
 381               		.file 6 "/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/Arduino.h"
 382               		.file 7 "/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/variants/standard/pins_ard
 383               		.file 8 "/home/arhat109/.arduino15/packages/MegaCore/hardware/avr/1.0.6/cores/MegaCore/Stream.h"
 384               		.section	.debug_info,"",@progbits
 385               	.Ldebug_info0:
 386 0000 1605 0000 		.long	0x516
 387 0004 0200      		.word	0x2
 388 0006 0000 0000 		.long	.Ldebug_abbrev0
 389 000a 04        		.byte	0x4
 390 000b 01        		.uleb128 0x1
 391 000c 0000 0000 		.long	.LASF43
 392 0010 04        		.byte	0x4
 393 0011 0000 0000 		.long	.LASF44
 394 0015 0000 0000 		.long	.LASF45
 395 0019 0000 0000 		.long	.Ldebug_ranges0+0
 396 001d 0000 0000 		.long	0
 397 0021 0000 0000 		.long	0
 398 0025 0000 0000 		.long	.Ldebug_line0
 399 0029 02        		.uleb128 0x2
 400 002a 0000 0000 		.long	.LASF3
 401 002e 03        		.byte	0x3
 402 002f D4        		.byte	0xd4
 403 0030 3400 0000 		.long	0x34
 404 0034 03        		.uleb128 0x3
 405 0035 02        		.byte	0x2
 406 0036 07        		.byte	0x7
 407 0037 0000 0000 		.long	.LASF0
 408 003b 04        		.uleb128 0x4
 409 003c 02        		.byte	0x2
 410 003d 05        		.byte	0x5
 411 003e 696E 7400 		.string	"int"
 412 0042 03        		.uleb128 0x3
 413 0043 04        		.byte	0x4
 414 0044 05        		.byte	0x5
 415 0045 0000 0000 		.long	.LASF1
 416 0049 03        		.uleb128 0x3
 417 004a 01        		.byte	0x1
 418 004b 06        		.byte	0x6
 419 004c 0000 0000 		.long	.LASF2
 420 0050 02        		.uleb128 0x2
 421 0051 0000 0000 		.long	.LASF4
 422 0055 04        		.byte	0x4
 423 0056 7E        		.byte	0x7e
 424 0057 5B00 0000 		.long	0x5b
 425 005b 03        		.uleb128 0x3
 426 005c 01        		.byte	0x1
 427 005d 08        		.byte	0x8
 428 005e 0000 0000 		.long	.LASF5
 429 0062 03        		.uleb128 0x3
 430 0063 04        		.byte	0x4
 431 0064 07        		.byte	0x7
 432 0065 0000 0000 		.long	.LASF6
GAS LISTING /tmp/ccPLkBqf.s 			page 13


 433 0069 03        		.uleb128 0x3
 434 006a 08        		.byte	0x8
 435 006b 05        		.byte	0x5
 436 006c 0000 0000 		.long	.LASF7
 437 0070 03        		.uleb128 0x3
 438 0071 08        		.byte	0x8
 439 0072 07        		.byte	0x7
 440 0073 0000 0000 		.long	.LASF8
 441 0077 03        		.uleb128 0x3
 442 0078 01        		.byte	0x1
 443 0079 02        		.byte	0x2
 444 007a 0000 0000 		.long	.LASF9
 445 007e 03        		.uleb128 0x3
 446 007f 01        		.byte	0x1
 447 0080 06        		.byte	0x6
 448 0081 0000 0000 		.long	.LASF10
 449 0085 05        		.uleb128 0x5
 450 0086 02        		.byte	0x2
 451 0087 8B00 0000 		.long	0x8b
 452 008b 06        		.uleb128 0x6
 453 008c 7E00 0000 		.long	0x7e
 454 0090 03        		.uleb128 0x3
 455 0091 04        		.byte	0x4
 456 0092 04        		.byte	0x4
 457 0093 0000 0000 		.long	.LASF11
 458 0097 03        		.uleb128 0x3
 459 0098 04        		.byte	0x4
 460 0099 04        		.byte	0x4
 461 009a 0000 0000 		.long	.LASF12
 462 009e 07        		.uleb128 0x7
 463 009f 0000 0000 		.long	.LASF46
 464 00a3 02        		.byte	0x2
 465 00a4 08        		.byte	0x8
 466 00a5 29        		.byte	0x29
 467 00a6 BD00 0000 		.long	0xbd
 468 00aa 08        		.uleb128 0x8
 469 00ab 0000 0000 		.long	.LASF13
 470 00af 00        		.sleb128 0
 471 00b0 08        		.uleb128 0x8
 472 00b1 0000 0000 		.long	.LASF14
 473 00b5 01        		.sleb128 1
 474 00b6 08        		.uleb128 0x8
 475 00b7 0000 0000 		.long	.LASF15
 476 00bb 02        		.sleb128 2
 477 00bc 00        		.byte	0
 478 00bd 09        		.uleb128 0x9
 479 00be 0000 0000 		.long	.LASF16
 480 00c2 01        		.byte	0x1
 481 00c3 1201 0000 		.long	0x112
 482 00c7 0A        		.uleb128 0xa
 483 00c8 02        		.byte	0x2
 484 00c9 5D        		.byte	0x5d
 485 00ca 1C01 0000 		.long	0x11c
 486 00ce 0B        		.uleb128 0xb
 487 00cf 01        		.byte	0x1
 488 00d0 0000 0000 		.long	.LASF18
 489 00d4 02        		.byte	0x2
GAS LISTING /tmp/ccPLkBqf.s 			page 14


 490 00d5 79        		.byte	0x79
 491 00d6 0000 0000 		.long	.LASF20
 492 00da 01        		.byte	0x1
 493 00db E300 0000 		.long	0xe3
 494 00df EF00 0000 		.long	0xef
 495 00e3 0C        		.uleb128 0xc
 496 00e4 7502 0000 		.long	0x275
 497 00e8 01        		.byte	0x1
 498 00e9 0D        		.uleb128 0xd
 499 00ea 6200 0000 		.long	0x62
 500 00ee 00        		.byte	0
 501 00ef 0E        		.uleb128 0xe
 502 00f0 01        		.byte	0x1
 503 00f1 0000 0000 		.long	.LASF18
 504 00f5 02        		.byte	0x2
 505 00f6 7A        		.byte	0x7a
 506 00f7 0000 0000 		.long	.LASF47
 507 00fb 01        		.byte	0x1
 508 00fc 0001 0000 		.long	0x100
 509 0100 0C        		.uleb128 0xc
 510 0101 7502 0000 		.long	0x275
 511 0105 01        		.byte	0x1
 512 0106 0D        		.uleb128 0xd
 513 0107 6200 0000 		.long	0x62
 514 010b 0D        		.uleb128 0xd
 515 010c 5000 0000 		.long	0x50
 516 0110 00        		.byte	0
 517 0111 00        		.byte	0
 518 0112 09        		.uleb128 0x9
 519 0113 0000 0000 		.long	.LASF17
 520 0117 01        		.byte	0x1
 521 0118 6D01 0000 		.long	0x16d
 522 011c 0F        		.uleb128 0xf
 523 011d 01        		.byte	0x1
 524 011e 0000 0000 		.long	.LASF24
 525 0122 05        		.byte	0x5
 526 0123 36        		.byte	0x36
 527 0124 0000 0000 		.long	.LASF48
 528 0128 2900 0000 		.long	0x29
 529 012c 01        		.byte	0x1
 530 012d 3501 0000 		.long	0x135
 531 0131 4601 0000 		.long	0x146
 532 0135 0C        		.uleb128 0xc
 533 0136 6D01 0000 		.long	0x16d
 534 013a 01        		.byte	0x1
 535 013b 0D        		.uleb128 0xd
 536 013c 8500 0000 		.long	0x85
 537 0140 0D        		.uleb128 0xd
 538 0141 2900 0000 		.long	0x29
 539 0145 00        		.byte	0
 540 0146 10        		.uleb128 0x10
 541 0147 01        		.byte	0x1
 542 0148 0000 0000 		.long	.LASF19
 543 014c 05        		.byte	0x5
 544 014d 4A        		.byte	0x4a
 545 014e 0000 0000 		.long	.LASF21
 546 0152 2900 0000 		.long	0x29
GAS LISTING /tmp/ccPLkBqf.s 			page 15


 547 0156 01        		.byte	0x1
 548 0157 5B01 0000 		.long	0x15b
 549 015b 0C        		.uleb128 0xc
 550 015c 6D01 0000 		.long	0x16d
 551 0160 01        		.byte	0x1
 552 0161 0D        		.uleb128 0xd
 553 0162 5B00 0000 		.long	0x5b
 554 0166 0D        		.uleb128 0xd
 555 0167 3B00 0000 		.long	0x3b
 556 016b 00        		.byte	0
 557 016c 00        		.byte	0
 558 016d 05        		.uleb128 0x5
 559 016e 02        		.byte	0x2
 560 016f 1201 0000 		.long	0x112
 561 0173 03        		.uleb128 0x3
 562 0174 04        		.byte	0x4
 563 0175 04        		.byte	0x4
 564 0176 0000 0000 		.long	.LASF22
 565 017a 11        		.uleb128 0x11
 566 017b 0000 0000 		.long	.LASF49
 567 017f 03        		.uleb128 0x3
 568 0180 02        		.byte	0x2
 569 0181 07        		.byte	0x7
 570 0182 0000 0000 		.long	.LASF23
 571 0186 05        		.uleb128 0x5
 572 0187 02        		.byte	0x2
 573 0188 5000 0000 		.long	0x50
 574 018c 12        		.uleb128 0x12
 575 018d 01        		.byte	0x1
 576 018e 0000 0000 		.long	.LASF50
 577 0192 01        		.byte	0x1
 578 0193 28        		.byte	0x28
 579 0194 0000 0000 		.long	.LFB120
 580 0198 0000 0000 		.long	.LFE120
 581 019c 03        		.byte	0x3
 582 019d 92        		.byte	0x92
 583 019e 20        		.uleb128 0x20
 584 019f 02        		.sleb128 2
 585 01a0 01        		.byte	0x1
 586 01a1 13        		.uleb128 0x13
 587 01a2 01        		.byte	0x1
 588 01a3 0000 0000 		.long	.LASF51
 589 01a7 01        		.byte	0x1
 590 01a8 36        		.byte	0x36
 591 01a9 5000 0000 		.long	0x50
 592 01ad 0000 0000 		.long	.LFB121
 593 01b1 0000 0000 		.long	.LFE121
 594 01b5 03        		.byte	0x3
 595 01b6 92        		.byte	0x92
 596 01b7 20        		.uleb128 0x20
 597 01b8 02        		.sleb128 2
 598 01b9 01        		.byte	0x1
 599 01ba 14        		.uleb128 0x14
 600 01bb 01        		.byte	0x1
 601 01bc 0000 0000 		.long	.LASF25
 602 01c0 01        		.byte	0x1
 603 01c1 3D        		.byte	0x3d
GAS LISTING /tmp/ccPLkBqf.s 			page 16


 604 01c2 0000 0000 		.long	.LFB122
 605 01c6 0000 0000 		.long	.LFE122
 606 01ca 03        		.byte	0x3
 607 01cb 92        		.byte	0x92
 608 01cc 20        		.uleb128 0x20
 609 01cd 02        		.sleb128 2
 610 01ce 01        		.byte	0x1
 611 01cf 0402 0000 		.long	0x204
 612 01d3 15        		.uleb128 0x15
 613 01d4 0000 0000 		.long	.LASF26
 614 01d8 01        		.byte	0x1
 615 01d9 3D        		.byte	0x3d
 616 01da 8601 0000 		.long	0x186
 617 01de 0000 0000 		.long	.LLST0
 618 01e2 16        		.uleb128 0x16
 619 01e3 6C65 6E00 		.string	"len"
 620 01e7 01        		.byte	0x1
 621 01e8 3D        		.byte	0x3d
 622 01e9 3B00 0000 		.long	0x3b
 623 01ed 06        		.byte	0x6
 624 01ee 66        		.byte	0x66
 625 01ef 93        		.byte	0x93
 626 01f0 01        		.uleb128 0x1
 627 01f1 67        		.byte	0x67
 628 01f2 93        		.byte	0x93
 629 01f3 01        		.uleb128 0x1
 630 01f4 15        		.uleb128 0x15
 631 01f5 0000 0000 		.long	.LASF27
 632 01f9 01        		.byte	0x1
 633 01fa 3D        		.byte	0x3d
 634 01fb 5000 0000 		.long	0x50
 635 01ff 0000 0000 		.long	.LLST1
 636 0203 00        		.byte	0
 637 0204 17        		.uleb128 0x17
 638 0205 01        		.byte	0x1
 639 0206 0000 0000 		.long	.LASF28
 640 020a 01        		.byte	0x1
 641 020b 48        		.byte	0x48
 642 020c 0000 0000 		.long	.LFB123
 643 0210 0000 0000 		.long	.LFE123
 644 0214 0000 0000 		.long	.LLST2
 645 0218 01        		.byte	0x1
 646 0219 7502 0000 		.long	0x275
 647 021d 15        		.uleb128 0x15
 648 021e 0000 0000 		.long	.LASF29
 649 0222 01        		.byte	0x1
 650 0223 48        		.byte	0x48
 651 0224 3B00 0000 		.long	0x3b
 652 0228 0000 0000 		.long	.LLST3
 653 022c 18        		.uleb128 0x18
 654 022d 6C65 6E00 		.string	"len"
 655 0231 01        		.byte	0x1
 656 0232 48        		.byte	0x48
 657 0233 3B00 0000 		.long	0x3b
 658 0237 0000 0000 		.long	.LLST4
 659 023b 19        		.uleb128 0x19
 660 023c 0000 0000 		.long	.LBB2
GAS LISTING /tmp/ccPLkBqf.s 			page 17


 661 0240 0000 0000 		.long	.LBE2
 662 0244 1A        		.uleb128 0x1a
 663 0245 7074 7200 		.string	"ptr"
 664 0249 01        		.byte	0x1
 665 024a 4A        		.byte	0x4a
 666 024b 8601 0000 		.long	0x186
 667 024f 0000 0000 		.long	.LLST5
 668 0253 19        		.uleb128 0x19
 669 0254 0000 0000 		.long	.LBB3
 670 0258 0000 0000 		.long	.LBE3
 671 025c 1A        		.uleb128 0x1a
 672 025d 6900      		.string	"i"
 673 025f 01        		.byte	0x1
 674 0260 4C        		.byte	0x4c
 675 0261 3B00 0000 		.long	0x3b
 676 0265 0000 0000 		.long	.LLST6
 677 0269 1B        		.uleb128 0x1b
 678 026a 0000 0000 		.long	.LVL8
 679 026e A101 0000 		.long	0x1a1
 680 0272 00        		.byte	0
 681 0273 00        		.byte	0
 682 0274 00        		.byte	0
 683 0275 05        		.uleb128 0x5
 684 0276 02        		.byte	0x2
 685 0277 BD00 0000 		.long	0xbd
 686 027b 1C        		.uleb128 0x1c
 687 027c CE00 0000 		.long	0xce
 688 0280 03        		.byte	0x3
 689 0281 8902 0000 		.long	0x289
 690 0285 9F02 0000 		.long	0x29f
 691 0289 1D        		.uleb128 0x1d
 692 028a 0000 0000 		.long	.LASF52
 693 028e 9F02 0000 		.long	0x29f
 694 0292 01        		.byte	0x1
 695 0293 1E        		.uleb128 0x1e
 696 0294 0000 0000 		.long	.LASF53
 697 0298 02        		.byte	0x2
 698 0299 79        		.byte	0x79
 699 029a 6200 0000 		.long	0x62
 700 029e 00        		.byte	0
 701 029f 06        		.uleb128 0x6
 702 02a0 7502 0000 		.long	0x275
 703 02a4 14        		.uleb128 0x14
 704 02a5 01        		.byte	0x1
 705 02a6 0000 0000 		.long	.LASF30
 706 02aa 01        		.byte	0x1
 707 02ab 51        		.byte	0x51
 708 02ac 0000 0000 		.long	.LFB124
 709 02b0 0000 0000 		.long	.LFE124
 710 02b4 03        		.byte	0x3
 711 02b5 92        		.byte	0x92
 712 02b6 20        		.uleb128 0x20
 713 02b7 02        		.sleb128 2
 714 02b8 01        		.byte	0x1
 715 02b9 1603 0000 		.long	0x316
 716 02bd 1F        		.uleb128 0x1f
 717 02be 7B02 0000 		.long	0x27b
GAS LISTING /tmp/ccPLkBqf.s 			page 18


 718 02c2 0000 0000 		.long	.LBB6
 719 02c6 0000 0000 		.long	.LBE6
 720 02ca 01        		.byte	0x1
 721 02cb 52        		.byte	0x52
 722 02cc 0103 0000 		.long	0x301
 723 02d0 20        		.uleb128 0x20
 724 02d1 9302 0000 		.long	0x293
 725 02d5 00C2 0100 		.long	0x1c200
 726 02d9 21        		.uleb128 0x21
 727 02da 8902 0000 		.long	0x289
 728 02de 22        		.uleb128 0x22
 729 02df 0000 0000 		.long	.LVL13
 730 02e3 EF00 0000 		.long	0xef
 731 02e7 23        		.uleb128 0x23
 732 02e8 0C        		.byte	0xc
 733 02e9 64        		.byte	0x64
 734 02ea 93        		.byte	0x93
 735 02eb 01        		.uleb128 0x1
 736 02ec 65        		.byte	0x65
 737 02ed 93        		.byte	0x93
 738 02ee 01        		.uleb128 0x1
 739 02ef 66        		.byte	0x66
 740 02f0 93        		.byte	0x93
 741 02f1 01        		.uleb128 0x1
 742 02f2 67        		.byte	0x67
 743 02f3 93        		.byte	0x93
 744 02f4 01        		.uleb128 0x1
 745 02f5 04        		.byte	0x4
 746 02f6 08        		.byte	0x8
 747 02f7 E1        		.byte	0xe1
 748 02f8 39        		.byte	0x39
 749 02f9 24        		.byte	0x24
 750 02fa 23        		.uleb128 0x23
 751 02fb 01        		.byte	0x1
 752 02fc 62        		.byte	0x62
 753 02fd 01        		.byte	0x1
 754 02fe 36        		.byte	0x36
 755 02ff 00        		.byte	0
 756 0300 00        		.byte	0
 757 0301 22        		.uleb128 0x22
 758 0302 0000 0000 		.long	.LVL14
 759 0306 F704 0000 		.long	0x4f7
 760 030a 23        		.uleb128 0x23
 761 030b 06        		.byte	0x6
 762 030c 68        		.byte	0x68
 763 030d 93        		.byte	0x93
 764 030e 01        		.uleb128 0x1
 765 030f 69        		.byte	0x69
 766 0310 93        		.byte	0x93
 767 0311 01        		.uleb128 0x1
 768 0312 01        		.byte	0x1
 769 0313 3A        		.byte	0x3a
 770 0314 00        		.byte	0
 771 0315 00        		.byte	0
 772 0316 17        		.uleb128 0x17
 773 0317 01        		.byte	0x1
 774 0318 0000 0000 		.long	.LASF31
GAS LISTING /tmp/ccPLkBqf.s 			page 19


 775 031c 01        		.byte	0x1
 776 031d 6F        		.byte	0x6f
 777 031e 0000 0000 		.long	.LFB125
 778 0322 0000 0000 		.long	.LFE125
 779 0326 0000 0000 		.long	.LLST7
 780 032a 01        		.byte	0x1
 781 032b A903 0000 		.long	0x3a9
 782 032f 24        		.uleb128 0x24
 783 0330 0000 0000 		.long	.LBB10
 784 0334 0000 0000 		.long	.LBE10
 785 0338 5E03 0000 		.long	0x35e
 786 033c 1A        		.uleb128 0x1a
 787 033d 6900      		.string	"i"
 788 033f 01        		.byte	0x1
 789 0340 75        		.byte	0x75
 790 0341 3B00 0000 		.long	0x3b
 791 0345 0000 0000 		.long	.LLST8
 792 0349 22        		.uleb128 0x22
 793 034a 0000 0000 		.long	.LVL17
 794 034e 4601 0000 		.long	0x146
 795 0352 23        		.uleb128 0x23
 796 0353 06        		.byte	0x6
 797 0354 64        		.byte	0x64
 798 0355 93        		.byte	0x93
 799 0356 01        		.uleb128 0x1
 800 0357 65        		.byte	0x65
 801 0358 93        		.byte	0x93
 802 0359 01        		.uleb128 0x1
 803 035a 01        		.byte	0x1
 804 035b 3A        		.byte	0x3a
 805 035c 00        		.byte	0
 806 035d 00        		.byte	0
 807 035e 25        		.uleb128 0x25
 808 035f 0000 0000 		.long	.LVL18
 809 0363 0A05 0000 		.long	0x50a
 810 0367 7E03 0000 		.long	0x37e
 811 036b 23        		.uleb128 0x23
 812 036c 0C        		.byte	0xc
 813 036d 66        		.byte	0x66
 814 036e 93        		.byte	0x93
 815 036f 01        		.uleb128 0x1
 816 0370 67        		.byte	0x67
 817 0371 93        		.byte	0x93
 818 0372 01        		.uleb128 0x1
 819 0373 68        		.byte	0x68
 820 0374 93        		.byte	0x93
 821 0375 01        		.uleb128 0x1
 822 0376 69        		.byte	0x69
 823 0377 93        		.byte	0x93
 824 0378 01        		.uleb128 0x1
 825 0379 03        		.byte	0x3
 826 037a 0A        		.byte	0xa
 827 037b 1027      		.word	0x2710
 828 037d 00        		.byte	0
 829 037e 26        		.uleb128 0x26
 830 037f 0000 0000 		.long	.LVL19
 831 0383 01        		.byte	0x1
GAS LISTING /tmp/ccPLkBqf.s 			page 20


 832 0384 BA01 0000 		.long	0x1ba
 833 0388 23        		.uleb128 0x23
 834 0389 06        		.byte	0x6
 835 038a 68        		.byte	0x68
 836 038b 93        		.byte	0x93
 837 038c 01        		.uleb128 0x1
 838 038d 69        		.byte	0x69
 839 038e 93        		.byte	0x93
 840 038f 01        		.uleb128 0x1
 841 0390 05        		.byte	0x5
 842 0391 03        		.byte	0x3
 843 0392 0000 0000 		.long	adcs
 844 0396 23        		.uleb128 0x23
 845 0397 06        		.byte	0x6
 846 0398 66        		.byte	0x66
 847 0399 93        		.byte	0x93
 848 039a 01        		.uleb128 0x1
 849 039b 67        		.byte	0x67
 850 039c 93        		.byte	0x93
 851 039d 01        		.uleb128 0x1
 852 039e 03        		.byte	0x3
 853 039f 0A        		.byte	0xa
 854 03a0 9001      		.word	0x190
 855 03a2 23        		.uleb128 0x23
 856 03a3 01        		.byte	0x1
 857 03a4 64        		.byte	0x64
 858 03a5 01        		.byte	0x1
 859 03a6 33        		.byte	0x33
 860 03a7 00        		.byte	0
 861 03a8 00        		.byte	0
 862 03a9 27        		.uleb128 0x27
 863 03aa 3400 0000 		.long	0x34
 864 03ae B403 0000 		.long	0x3b4
 865 03b2 28        		.uleb128 0x28
 866 03b3 00        		.byte	0
 867 03b4 29        		.uleb128 0x29
 868 03b5 0000 0000 		.long	.LASF32
 869 03b9 06        		.byte	0x6
 870 03ba 9A        		.byte	0x9a
 871 03bb A903 0000 		.long	0x3a9
 872 03bf 01        		.byte	0x1
 873 03c0 01        		.byte	0x1
 874 03c1 29        		.uleb128 0x29
 875 03c2 0000 0000 		.long	.LASF33
 876 03c6 06        		.byte	0x6
 877 03c7 9B        		.byte	0x9b
 878 03c8 A903 0000 		.long	0x3a9
 879 03cc 01        		.byte	0x1
 880 03cd 01        		.byte	0x1
 881 03ce 29        		.uleb128 0x29
 882 03cf 0000 0000 		.long	.LASF34
 883 03d3 06        		.byte	0x6
 884 03d4 9C        		.byte	0x9c
 885 03d5 A903 0000 		.long	0x3a9
 886 03d9 01        		.byte	0x1
 887 03da 01        		.byte	0x1
 888 03db 29        		.uleb128 0x29
GAS LISTING /tmp/ccPLkBqf.s 			page 21


 889 03dc 0000 0000 		.long	.LASF35
 890 03e0 02        		.byte	0x2
 891 03e1 8F        		.byte	0x8f
 892 03e2 BD00 0000 		.long	0xbd
 893 03e6 01        		.byte	0x1
 894 03e7 01        		.byte	0x1
 895 03e8 2A        		.uleb128 0x2a
 896 03e9 5353 00   		.string	"SS"
 897 03ec 07        		.byte	0x7
 898 03ed 46        		.byte	0x46
 899 03ee F303 0000 		.long	0x3f3
 900 03f2 08        		.byte	0x8
 901 03f3 06        		.uleb128 0x6
 902 03f4 5000 0000 		.long	0x50
 903 03f8 2A        		.uleb128 0x2a
 904 03f9 5343 4B00 		.string	"SCK"
 905 03fd 07        		.byte	0x7
 906 03fe 47        		.byte	0x47
 907 03ff F303 0000 		.long	0x3f3
 908 0403 09        		.byte	0x9
 909 0404 2B        		.uleb128 0x2b
 910 0405 0000 0000 		.long	.LASF36
 911 0409 07        		.byte	0x7
 912 040a 48        		.byte	0x48
 913 040b F303 0000 		.long	0x3f3
 914 040f 0A        		.byte	0xa
 915 0410 2B        		.uleb128 0x2b
 916 0411 0000 0000 		.long	.LASF37
 917 0415 07        		.byte	0x7
 918 0416 49        		.byte	0x49
 919 0417 F303 0000 		.long	0x3f3
 920 041b 0B        		.byte	0xb
 921 041c 2A        		.uleb128 0x2a
 922 041d 5344 4100 		.string	"SDA"
 923 0421 07        		.byte	0x7
 924 0422 4D        		.byte	0x4d
 925 0423 F303 0000 		.long	0x3f3
 926 0427 12        		.byte	0x12
 927 0428 2A        		.uleb128 0x2a
 928 0429 5343 4C00 		.string	"SCL"
 929 042d 07        		.byte	0x7
 930 042e 4E        		.byte	0x4e
 931 042f F303 0000 		.long	0x3f3
 932 0433 13        		.byte	0x13
 933 0434 2A        		.uleb128 0x2a
 934 0435 4130 00   		.string	"A0"
 935 0438 07        		.byte	0x7
 936 0439 50        		.byte	0x50
 937 043a F303 0000 		.long	0x3f3
 938 043e 2D        		.byte	0x2d
 939 043f 2A        		.uleb128 0x2a
 940 0440 4131 00   		.string	"A1"
 941 0443 07        		.byte	0x7
 942 0444 51        		.byte	0x51
 943 0445 F303 0000 		.long	0x3f3
 944 0449 2E        		.byte	0x2e
 945 044a 2A        		.uleb128 0x2a
GAS LISTING /tmp/ccPLkBqf.s 			page 22


 946 044b 4132 00   		.string	"A2"
 947 044e 07        		.byte	0x7
 948 044f 52        		.byte	0x52
 949 0450 F303 0000 		.long	0x3f3
 950 0454 2F        		.byte	0x2f
 951 0455 2A        		.uleb128 0x2a
 952 0456 4133 00   		.string	"A3"
 953 0459 07        		.byte	0x7
 954 045a 53        		.byte	0x53
 955 045b F303 0000 		.long	0x3f3
 956 045f 30        		.byte	0x30
 957 0460 2A        		.uleb128 0x2a
 958 0461 4134 00   		.string	"A4"
 959 0464 07        		.byte	0x7
 960 0465 54        		.byte	0x54
 961 0466 F303 0000 		.long	0x3f3
 962 046a 31        		.byte	0x31
 963 046b 2A        		.uleb128 0x2a
 964 046c 4135 00   		.string	"A5"
 965 046f 07        		.byte	0x7
 966 0470 55        		.byte	0x55
 967 0471 F303 0000 		.long	0x3f3
 968 0475 32        		.byte	0x32
 969 0476 2A        		.uleb128 0x2a
 970 0477 4136 00   		.string	"A6"
 971 047a 07        		.byte	0x7
 972 047b 56        		.byte	0x56
 973 047c F303 0000 		.long	0x3f3
 974 0480 33        		.byte	0x33
 975 0481 2A        		.uleb128 0x2a
 976 0482 4137 00   		.string	"A7"
 977 0485 07        		.byte	0x7
 978 0486 57        		.byte	0x57
 979 0487 F303 0000 		.long	0x3f3
 980 048b 34        		.byte	0x34
 981 048c 2C        		.uleb128 0x2c
 982 048d 0000 0000 		.long	.LASF38
 983 0491 01        		.byte	0x1
 984 0492 24        		.byte	0x24
 985 0493 3B00 0000 		.long	0x3b
 986 0497 01        		.byte	0x1
 987 0498 05        		.byte	0x5
 988 0499 03        		.byte	0x3
 989 049a 0000 0000 		.long	adcCount
 990 049e 2C        		.uleb128 0x2c
 991 049f 0000 0000 		.long	.LASF39
 992 04a3 01        		.byte	0x1
 993 04a4 25        		.byte	0x25
 994 04a5 B004 0000 		.long	0x4b0
 995 04a9 01        		.byte	0x1
 996 04aa 05        		.byte	0x5
 997 04ab 03        		.byte	0x3
 998 04ac 0000 0000 		.long	adcBuffer
 999 04b0 05        		.uleb128 0x5
 1000 04b1 02        		.byte	0x2
 1001 04b2 B604 0000 		.long	0x4b6
 1002 04b6 2D        		.uleb128 0x2d
GAS LISTING /tmp/ccPLkBqf.s 			page 23


 1003 04b7 5000 0000 		.long	0x50
 1004 04bb 2C        		.uleb128 0x2c
 1005 04bc 0000 0000 		.long	.LASF40
 1006 04c0 01        		.byte	0x1
 1007 04c1 26        		.byte	0x26
 1008 04c2 B604 0000 		.long	0x4b6
 1009 04c6 01        		.byte	0x1
 1010 04c7 05        		.byte	0x5
 1011 04c8 03        		.byte	0x3
 1012 04c9 0000 0000 		.long	adcState
 1013 04cd 27        		.uleb128 0x27
 1014 04ce 5B00 0000 		.long	0x5b
 1015 04d2 DE04 0000 		.long	0x4de
 1016 04d6 2E        		.uleb128 0x2e
 1017 04d7 DE04 0000 		.long	0x4de
 1018 04db 8F01      		.word	0x18f
 1019 04dd 00        		.byte	0
 1020 04de 03        		.uleb128 0x3
 1021 04df 02        		.byte	0x2
 1022 04e0 07        		.byte	0x7
 1023 04e1 0000 0000 		.long	.LASF41
 1024 04e5 2C        		.uleb128 0x2c
 1025 04e6 0000 0000 		.long	.LASF42
 1026 04ea 01        		.byte	0x1
 1027 04eb 46        		.byte	0x46
 1028 04ec CD04 0000 		.long	0x4cd
 1029 04f0 01        		.byte	0x1
 1030 04f1 05        		.byte	0x5
 1031 04f2 03        		.byte	0x3
 1032 04f3 0000 0000 		.long	adcs
 1033 04f7 2F        		.uleb128 0x2f
 1034 04f8 01        		.byte	0x1
 1035 04f9 0000 0000 		.long	.LASF54
 1036 04fd 06        		.byte	0x6
 1037 04fe 86        		.byte	0x86
 1038 04ff 01        		.byte	0x1
 1039 0500 0A05 0000 		.long	0x50a
 1040 0504 0D        		.uleb128 0xd
 1041 0505 3400 0000 		.long	0x34
 1042 0509 00        		.byte	0
 1043 050a 30        		.uleb128 0x30
 1044 050b 01        		.byte	0x1
 1045 050c 0000 0000 		.long	.LASF55
 1046 0510 06        		.byte	0x6
 1047 0511 85        		.byte	0x85
 1048 0512 01        		.byte	0x1
 1049 0513 0D        		.uleb128 0xd
 1050 0514 6200 0000 		.long	0x62
 1051 0518 00        		.byte	0
 1052 0519 00        		.byte	0
 1053               		.section	.debug_abbrev,"",@progbits
 1054               	.Ldebug_abbrev0:
 1055 0000 01        		.uleb128 0x1
 1056 0001 11        		.uleb128 0x11
 1057 0002 01        		.byte	0x1
 1058 0003 25        		.uleb128 0x25
 1059 0004 0E        		.uleb128 0xe
GAS LISTING /tmp/ccPLkBqf.s 			page 24


 1060 0005 13        		.uleb128 0x13
 1061 0006 0B        		.uleb128 0xb
 1062 0007 03        		.uleb128 0x3
 1063 0008 0E        		.uleb128 0xe
 1064 0009 1B        		.uleb128 0x1b
 1065 000a 0E        		.uleb128 0xe
 1066 000b 55        		.uleb128 0x55
 1067 000c 06        		.uleb128 0x6
 1068 000d 11        		.uleb128 0x11
 1069 000e 01        		.uleb128 0x1
 1070 000f 52        		.uleb128 0x52
 1071 0010 01        		.uleb128 0x1
 1072 0011 10        		.uleb128 0x10
 1073 0012 06        		.uleb128 0x6
 1074 0013 00        		.byte	0
 1075 0014 00        		.byte	0
 1076 0015 02        		.uleb128 0x2
 1077 0016 16        		.uleb128 0x16
 1078 0017 00        		.byte	0
 1079 0018 03        		.uleb128 0x3
 1080 0019 0E        		.uleb128 0xe
 1081 001a 3A        		.uleb128 0x3a
 1082 001b 0B        		.uleb128 0xb
 1083 001c 3B        		.uleb128 0x3b
 1084 001d 0B        		.uleb128 0xb
 1085 001e 49        		.uleb128 0x49
 1086 001f 13        		.uleb128 0x13
 1087 0020 00        		.byte	0
 1088 0021 00        		.byte	0
 1089 0022 03        		.uleb128 0x3
 1090 0023 24        		.uleb128 0x24
 1091 0024 00        		.byte	0
 1092 0025 0B        		.uleb128 0xb
 1093 0026 0B        		.uleb128 0xb
 1094 0027 3E        		.uleb128 0x3e
 1095 0028 0B        		.uleb128 0xb
 1096 0029 03        		.uleb128 0x3
 1097 002a 0E        		.uleb128 0xe
 1098 002b 00        		.byte	0
 1099 002c 00        		.byte	0
 1100 002d 04        		.uleb128 0x4
 1101 002e 24        		.uleb128 0x24
 1102 002f 00        		.byte	0
 1103 0030 0B        		.uleb128 0xb
 1104 0031 0B        		.uleb128 0xb
 1105 0032 3E        		.uleb128 0x3e
 1106 0033 0B        		.uleb128 0xb
 1107 0034 03        		.uleb128 0x3
 1108 0035 08        		.uleb128 0x8
 1109 0036 00        		.byte	0
 1110 0037 00        		.byte	0
 1111 0038 05        		.uleb128 0x5
 1112 0039 0F        		.uleb128 0xf
 1113 003a 00        		.byte	0
 1114 003b 0B        		.uleb128 0xb
 1115 003c 0B        		.uleb128 0xb
 1116 003d 49        		.uleb128 0x49
GAS LISTING /tmp/ccPLkBqf.s 			page 25


 1117 003e 13        		.uleb128 0x13
 1118 003f 00        		.byte	0
 1119 0040 00        		.byte	0
 1120 0041 06        		.uleb128 0x6
 1121 0042 26        		.uleb128 0x26
 1122 0043 00        		.byte	0
 1123 0044 49        		.uleb128 0x49
 1124 0045 13        		.uleb128 0x13
 1125 0046 00        		.byte	0
 1126 0047 00        		.byte	0
 1127 0048 07        		.uleb128 0x7
 1128 0049 04        		.uleb128 0x4
 1129 004a 01        		.byte	0x1
 1130 004b 03        		.uleb128 0x3
 1131 004c 0E        		.uleb128 0xe
 1132 004d 0B        		.uleb128 0xb
 1133 004e 0B        		.uleb128 0xb
 1134 004f 3A        		.uleb128 0x3a
 1135 0050 0B        		.uleb128 0xb
 1136 0051 3B        		.uleb128 0x3b
 1137 0052 0B        		.uleb128 0xb
 1138 0053 01        		.uleb128 0x1
 1139 0054 13        		.uleb128 0x13
 1140 0055 00        		.byte	0
 1141 0056 00        		.byte	0
 1142 0057 08        		.uleb128 0x8
 1143 0058 28        		.uleb128 0x28
 1144 0059 00        		.byte	0
 1145 005a 03        		.uleb128 0x3
 1146 005b 0E        		.uleb128 0xe
 1147 005c 1C        		.uleb128 0x1c
 1148 005d 0D        		.uleb128 0xd
 1149 005e 00        		.byte	0
 1150 005f 00        		.byte	0
 1151 0060 09        		.uleb128 0x9
 1152 0061 02        		.uleb128 0x2
 1153 0062 01        		.byte	0x1
 1154 0063 03        		.uleb128 0x3
 1155 0064 0E        		.uleb128 0xe
 1156 0065 3C        		.uleb128 0x3c
 1157 0066 0C        		.uleb128 0xc
 1158 0067 01        		.uleb128 0x1
 1159 0068 13        		.uleb128 0x13
 1160 0069 00        		.byte	0
 1161 006a 00        		.byte	0
 1162 006b 0A        		.uleb128 0xa
 1163 006c 08        		.uleb128 0x8
 1164 006d 00        		.byte	0
 1165 006e 3A        		.uleb128 0x3a
 1166 006f 0B        		.uleb128 0xb
 1167 0070 3B        		.uleb128 0x3b
 1168 0071 0B        		.uleb128 0xb
 1169 0072 18        		.uleb128 0x18
 1170 0073 13        		.uleb128 0x13
 1171 0074 00        		.byte	0
 1172 0075 00        		.byte	0
 1173 0076 0B        		.uleb128 0xb
GAS LISTING /tmp/ccPLkBqf.s 			page 26


 1174 0077 2E        		.uleb128 0x2e
 1175 0078 01        		.byte	0x1
 1176 0079 3F        		.uleb128 0x3f
 1177 007a 0C        		.uleb128 0xc
 1178 007b 03        		.uleb128 0x3
 1179 007c 0E        		.uleb128 0xe
 1180 007d 3A        		.uleb128 0x3a
 1181 007e 0B        		.uleb128 0xb
 1182 007f 3B        		.uleb128 0x3b
 1183 0080 0B        		.uleb128 0xb
 1184 0081 8740      		.uleb128 0x2007
 1185 0083 0E        		.uleb128 0xe
 1186 0084 3C        		.uleb128 0x3c
 1187 0085 0C        		.uleb128 0xc
 1188 0086 64        		.uleb128 0x64
 1189 0087 13        		.uleb128 0x13
 1190 0088 01        		.uleb128 0x1
 1191 0089 13        		.uleb128 0x13
 1192 008a 00        		.byte	0
 1193 008b 00        		.byte	0
 1194 008c 0C        		.uleb128 0xc
 1195 008d 05        		.uleb128 0x5
 1196 008e 00        		.byte	0
 1197 008f 49        		.uleb128 0x49
 1198 0090 13        		.uleb128 0x13
 1199 0091 34        		.uleb128 0x34
 1200 0092 0C        		.uleb128 0xc
 1201 0093 00        		.byte	0
 1202 0094 00        		.byte	0
 1203 0095 0D        		.uleb128 0xd
 1204 0096 05        		.uleb128 0x5
 1205 0097 00        		.byte	0
 1206 0098 49        		.uleb128 0x49
 1207 0099 13        		.uleb128 0x13
 1208 009a 00        		.byte	0
 1209 009b 00        		.byte	0
 1210 009c 0E        		.uleb128 0xe
 1211 009d 2E        		.uleb128 0x2e
 1212 009e 01        		.byte	0x1
 1213 009f 3F        		.uleb128 0x3f
 1214 00a0 0C        		.uleb128 0xc
 1215 00a1 03        		.uleb128 0x3
 1216 00a2 0E        		.uleb128 0xe
 1217 00a3 3A        		.uleb128 0x3a
 1218 00a4 0B        		.uleb128 0xb
 1219 00a5 3B        		.uleb128 0x3b
 1220 00a6 0B        		.uleb128 0xb
 1221 00a7 8740      		.uleb128 0x2007
 1222 00a9 0E        		.uleb128 0xe
 1223 00aa 3C        		.uleb128 0x3c
 1224 00ab 0C        		.uleb128 0xc
 1225 00ac 64        		.uleb128 0x64
 1226 00ad 13        		.uleb128 0x13
 1227 00ae 00        		.byte	0
 1228 00af 00        		.byte	0
 1229 00b0 0F        		.uleb128 0xf
 1230 00b1 2E        		.uleb128 0x2e
GAS LISTING /tmp/ccPLkBqf.s 			page 27


 1231 00b2 01        		.byte	0x1
 1232 00b3 3F        		.uleb128 0x3f
 1233 00b4 0C        		.uleb128 0xc
 1234 00b5 03        		.uleb128 0x3
 1235 00b6 0E        		.uleb128 0xe
 1236 00b7 3A        		.uleb128 0x3a
 1237 00b8 0B        		.uleb128 0xb
 1238 00b9 3B        		.uleb128 0x3b
 1239 00ba 0B        		.uleb128 0xb
 1240 00bb 8740      		.uleb128 0x2007
 1241 00bd 0E        		.uleb128 0xe
 1242 00be 49        		.uleb128 0x49
 1243 00bf 13        		.uleb128 0x13
 1244 00c0 3C        		.uleb128 0x3c
 1245 00c1 0C        		.uleb128 0xc
 1246 00c2 64        		.uleb128 0x64
 1247 00c3 13        		.uleb128 0x13
 1248 00c4 01        		.uleb128 0x1
 1249 00c5 13        		.uleb128 0x13
 1250 00c6 00        		.byte	0
 1251 00c7 00        		.byte	0
 1252 00c8 10        		.uleb128 0x10
 1253 00c9 2E        		.uleb128 0x2e
 1254 00ca 01        		.byte	0x1
 1255 00cb 3F        		.uleb128 0x3f
 1256 00cc 0C        		.uleb128 0xc
 1257 00cd 03        		.uleb128 0x3
 1258 00ce 0E        		.uleb128 0xe
 1259 00cf 3A        		.uleb128 0x3a
 1260 00d0 0B        		.uleb128 0xb
 1261 00d1 3B        		.uleb128 0x3b
 1262 00d2 0B        		.uleb128 0xb
 1263 00d3 8740      		.uleb128 0x2007
 1264 00d5 0E        		.uleb128 0xe
 1265 00d6 49        		.uleb128 0x49
 1266 00d7 13        		.uleb128 0x13
 1267 00d8 3C        		.uleb128 0x3c
 1268 00d9 0C        		.uleb128 0xc
 1269 00da 64        		.uleb128 0x64
 1270 00db 13        		.uleb128 0x13
 1271 00dc 00        		.byte	0
 1272 00dd 00        		.byte	0
 1273 00de 11        		.uleb128 0x11
 1274 00df 3B        		.uleb128 0x3b
 1275 00e0 00        		.byte	0
 1276 00e1 03        		.uleb128 0x3
 1277 00e2 0E        		.uleb128 0xe
 1278 00e3 00        		.byte	0
 1279 00e4 00        		.byte	0
 1280 00e5 12        		.uleb128 0x12
 1281 00e6 2E        		.uleb128 0x2e
 1282 00e7 00        		.byte	0
 1283 00e8 3F        		.uleb128 0x3f
 1284 00e9 0C        		.uleb128 0xc
 1285 00ea 03        		.uleb128 0x3
 1286 00eb 0E        		.uleb128 0xe
 1287 00ec 3A        		.uleb128 0x3a
GAS LISTING /tmp/ccPLkBqf.s 			page 28


 1288 00ed 0B        		.uleb128 0xb
 1289 00ee 3B        		.uleb128 0x3b
 1290 00ef 0B        		.uleb128 0xb
 1291 00f0 11        		.uleb128 0x11
 1292 00f1 01        		.uleb128 0x1
 1293 00f2 12        		.uleb128 0x12
 1294 00f3 01        		.uleb128 0x1
 1295 00f4 40        		.uleb128 0x40
 1296 00f5 0A        		.uleb128 0xa
 1297 00f6 9742      		.uleb128 0x2117
 1298 00f8 0C        		.uleb128 0xc
 1299 00f9 00        		.byte	0
 1300 00fa 00        		.byte	0
 1301 00fb 13        		.uleb128 0x13
 1302 00fc 2E        		.uleb128 0x2e
 1303 00fd 00        		.byte	0
 1304 00fe 3F        		.uleb128 0x3f
 1305 00ff 0C        		.uleb128 0xc
 1306 0100 03        		.uleb128 0x3
 1307 0101 0E        		.uleb128 0xe
 1308 0102 3A        		.uleb128 0x3a
 1309 0103 0B        		.uleb128 0xb
 1310 0104 3B        		.uleb128 0x3b
 1311 0105 0B        		.uleb128 0xb
 1312 0106 49        		.uleb128 0x49
 1313 0107 13        		.uleb128 0x13
 1314 0108 11        		.uleb128 0x11
 1315 0109 01        		.uleb128 0x1
 1316 010a 12        		.uleb128 0x12
 1317 010b 01        		.uleb128 0x1
 1318 010c 40        		.uleb128 0x40
 1319 010d 0A        		.uleb128 0xa
 1320 010e 9742      		.uleb128 0x2117
 1321 0110 0C        		.uleb128 0xc
 1322 0111 00        		.byte	0
 1323 0112 00        		.byte	0
 1324 0113 14        		.uleb128 0x14
 1325 0114 2E        		.uleb128 0x2e
 1326 0115 01        		.byte	0x1
 1327 0116 3F        		.uleb128 0x3f
 1328 0117 0C        		.uleb128 0xc
 1329 0118 03        		.uleb128 0x3
 1330 0119 0E        		.uleb128 0xe
 1331 011a 3A        		.uleb128 0x3a
 1332 011b 0B        		.uleb128 0xb
 1333 011c 3B        		.uleb128 0x3b
 1334 011d 0B        		.uleb128 0xb
 1335 011e 11        		.uleb128 0x11
 1336 011f 01        		.uleb128 0x1
 1337 0120 12        		.uleb128 0x12
 1338 0121 01        		.uleb128 0x1
 1339 0122 40        		.uleb128 0x40
 1340 0123 0A        		.uleb128 0xa
 1341 0124 9742      		.uleb128 0x2117
 1342 0126 0C        		.uleb128 0xc
 1343 0127 01        		.uleb128 0x1
 1344 0128 13        		.uleb128 0x13
GAS LISTING /tmp/ccPLkBqf.s 			page 29


 1345 0129 00        		.byte	0
 1346 012a 00        		.byte	0
 1347 012b 15        		.uleb128 0x15
 1348 012c 05        		.uleb128 0x5
 1349 012d 00        		.byte	0
 1350 012e 03        		.uleb128 0x3
 1351 012f 0E        		.uleb128 0xe
 1352 0130 3A        		.uleb128 0x3a
 1353 0131 0B        		.uleb128 0xb
 1354 0132 3B        		.uleb128 0x3b
 1355 0133 0B        		.uleb128 0xb
 1356 0134 49        		.uleb128 0x49
 1357 0135 13        		.uleb128 0x13
 1358 0136 02        		.uleb128 0x2
 1359 0137 06        		.uleb128 0x6
 1360 0138 00        		.byte	0
 1361 0139 00        		.byte	0
 1362 013a 16        		.uleb128 0x16
 1363 013b 05        		.uleb128 0x5
 1364 013c 00        		.byte	0
 1365 013d 03        		.uleb128 0x3
 1366 013e 08        		.uleb128 0x8
 1367 013f 3A        		.uleb128 0x3a
 1368 0140 0B        		.uleb128 0xb
 1369 0141 3B        		.uleb128 0x3b
 1370 0142 0B        		.uleb128 0xb
 1371 0143 49        		.uleb128 0x49
 1372 0144 13        		.uleb128 0x13
 1373 0145 02        		.uleb128 0x2
 1374 0146 0A        		.uleb128 0xa
 1375 0147 00        		.byte	0
 1376 0148 00        		.byte	0
 1377 0149 17        		.uleb128 0x17
 1378 014a 2E        		.uleb128 0x2e
 1379 014b 01        		.byte	0x1
 1380 014c 3F        		.uleb128 0x3f
 1381 014d 0C        		.uleb128 0xc
 1382 014e 03        		.uleb128 0x3
 1383 014f 0E        		.uleb128 0xe
 1384 0150 3A        		.uleb128 0x3a
 1385 0151 0B        		.uleb128 0xb
 1386 0152 3B        		.uleb128 0x3b
 1387 0153 0B        		.uleb128 0xb
 1388 0154 11        		.uleb128 0x11
 1389 0155 01        		.uleb128 0x1
 1390 0156 12        		.uleb128 0x12
 1391 0157 01        		.uleb128 0x1
 1392 0158 40        		.uleb128 0x40
 1393 0159 06        		.uleb128 0x6
 1394 015a 9742      		.uleb128 0x2117
 1395 015c 0C        		.uleb128 0xc
 1396 015d 01        		.uleb128 0x1
 1397 015e 13        		.uleb128 0x13
 1398 015f 00        		.byte	0
 1399 0160 00        		.byte	0
 1400 0161 18        		.uleb128 0x18
 1401 0162 05        		.uleb128 0x5
GAS LISTING /tmp/ccPLkBqf.s 			page 30


 1402 0163 00        		.byte	0
 1403 0164 03        		.uleb128 0x3
 1404 0165 08        		.uleb128 0x8
 1405 0166 3A        		.uleb128 0x3a
 1406 0167 0B        		.uleb128 0xb
 1407 0168 3B        		.uleb128 0x3b
 1408 0169 0B        		.uleb128 0xb
 1409 016a 49        		.uleb128 0x49
 1410 016b 13        		.uleb128 0x13
 1411 016c 02        		.uleb128 0x2
 1412 016d 06        		.uleb128 0x6
 1413 016e 00        		.byte	0
 1414 016f 00        		.byte	0
 1415 0170 19        		.uleb128 0x19
 1416 0171 0B        		.uleb128 0xb
 1417 0172 01        		.byte	0x1
 1418 0173 11        		.uleb128 0x11
 1419 0174 01        		.uleb128 0x1
 1420 0175 12        		.uleb128 0x12
 1421 0176 01        		.uleb128 0x1
 1422 0177 00        		.byte	0
 1423 0178 00        		.byte	0
 1424 0179 1A        		.uleb128 0x1a
 1425 017a 34        		.uleb128 0x34
 1426 017b 00        		.byte	0
 1427 017c 03        		.uleb128 0x3
 1428 017d 08        		.uleb128 0x8
 1429 017e 3A        		.uleb128 0x3a
 1430 017f 0B        		.uleb128 0xb
 1431 0180 3B        		.uleb128 0x3b
 1432 0181 0B        		.uleb128 0xb
 1433 0182 49        		.uleb128 0x49
 1434 0183 13        		.uleb128 0x13
 1435 0184 02        		.uleb128 0x2
 1436 0185 06        		.uleb128 0x6
 1437 0186 00        		.byte	0
 1438 0187 00        		.byte	0
 1439 0188 1B        		.uleb128 0x1b
 1440 0189 8982 01   		.uleb128 0x4109
 1441 018c 00        		.byte	0
 1442 018d 11        		.uleb128 0x11
 1443 018e 01        		.uleb128 0x1
 1444 018f 31        		.uleb128 0x31
 1445 0190 13        		.uleb128 0x13
 1446 0191 00        		.byte	0
 1447 0192 00        		.byte	0
 1448 0193 1C        		.uleb128 0x1c
 1449 0194 2E        		.uleb128 0x2e
 1450 0195 01        		.byte	0x1
 1451 0196 47        		.uleb128 0x47
 1452 0197 13        		.uleb128 0x13
 1453 0198 20        		.uleb128 0x20
 1454 0199 0B        		.uleb128 0xb
 1455 019a 64        		.uleb128 0x64
 1456 019b 13        		.uleb128 0x13
 1457 019c 01        		.uleb128 0x1
 1458 019d 13        		.uleb128 0x13
GAS LISTING /tmp/ccPLkBqf.s 			page 31


 1459 019e 00        		.byte	0
 1460 019f 00        		.byte	0
 1461 01a0 1D        		.uleb128 0x1d
 1462 01a1 05        		.uleb128 0x5
 1463 01a2 00        		.byte	0
 1464 01a3 03        		.uleb128 0x3
 1465 01a4 0E        		.uleb128 0xe
 1466 01a5 49        		.uleb128 0x49
 1467 01a6 13        		.uleb128 0x13
 1468 01a7 34        		.uleb128 0x34
 1469 01a8 0C        		.uleb128 0xc
 1470 01a9 00        		.byte	0
 1471 01aa 00        		.byte	0
 1472 01ab 1E        		.uleb128 0x1e
 1473 01ac 05        		.uleb128 0x5
 1474 01ad 00        		.byte	0
 1475 01ae 03        		.uleb128 0x3
 1476 01af 0E        		.uleb128 0xe
 1477 01b0 3A        		.uleb128 0x3a
 1478 01b1 0B        		.uleb128 0xb
 1479 01b2 3B        		.uleb128 0x3b
 1480 01b3 0B        		.uleb128 0xb
 1481 01b4 49        		.uleb128 0x49
 1482 01b5 13        		.uleb128 0x13
 1483 01b6 00        		.byte	0
 1484 01b7 00        		.byte	0
 1485 01b8 1F        		.uleb128 0x1f
 1486 01b9 1D        		.uleb128 0x1d
 1487 01ba 01        		.byte	0x1
 1488 01bb 31        		.uleb128 0x31
 1489 01bc 13        		.uleb128 0x13
 1490 01bd 11        		.uleb128 0x11
 1491 01be 01        		.uleb128 0x1
 1492 01bf 12        		.uleb128 0x12
 1493 01c0 01        		.uleb128 0x1
 1494 01c1 58        		.uleb128 0x58
 1495 01c2 0B        		.uleb128 0xb
 1496 01c3 59        		.uleb128 0x59
 1497 01c4 0B        		.uleb128 0xb
 1498 01c5 01        		.uleb128 0x1
 1499 01c6 13        		.uleb128 0x13
 1500 01c7 00        		.byte	0
 1501 01c8 00        		.byte	0
 1502 01c9 20        		.uleb128 0x20
 1503 01ca 05        		.uleb128 0x5
 1504 01cb 00        		.byte	0
 1505 01cc 31        		.uleb128 0x31
 1506 01cd 13        		.uleb128 0x13
 1507 01ce 1C        		.uleb128 0x1c
 1508 01cf 06        		.uleb128 0x6
 1509 01d0 00        		.byte	0
 1510 01d1 00        		.byte	0
 1511 01d2 21        		.uleb128 0x21
 1512 01d3 05        		.uleb128 0x5
 1513 01d4 00        		.byte	0
 1514 01d5 31        		.uleb128 0x31
 1515 01d6 13        		.uleb128 0x13
GAS LISTING /tmp/ccPLkBqf.s 			page 32


 1516 01d7 00        		.byte	0
 1517 01d8 00        		.byte	0
 1518 01d9 22        		.uleb128 0x22
 1519 01da 8982 01   		.uleb128 0x4109
 1520 01dd 01        		.byte	0x1
 1521 01de 11        		.uleb128 0x11
 1522 01df 01        		.uleb128 0x1
 1523 01e0 31        		.uleb128 0x31
 1524 01e1 13        		.uleb128 0x13
 1525 01e2 00        		.byte	0
 1526 01e3 00        		.byte	0
 1527 01e4 23        		.uleb128 0x23
 1528 01e5 8A82 01   		.uleb128 0x410a
 1529 01e8 00        		.byte	0
 1530 01e9 02        		.uleb128 0x2
 1531 01ea 0A        		.uleb128 0xa
 1532 01eb 9142      		.uleb128 0x2111
 1533 01ed 0A        		.uleb128 0xa
 1534 01ee 00        		.byte	0
 1535 01ef 00        		.byte	0
 1536 01f0 24        		.uleb128 0x24
 1537 01f1 0B        		.uleb128 0xb
 1538 01f2 01        		.byte	0x1
 1539 01f3 11        		.uleb128 0x11
 1540 01f4 01        		.uleb128 0x1
 1541 01f5 12        		.uleb128 0x12
 1542 01f6 01        		.uleb128 0x1
 1543 01f7 01        		.uleb128 0x1
 1544 01f8 13        		.uleb128 0x13
 1545 01f9 00        		.byte	0
 1546 01fa 00        		.byte	0
 1547 01fb 25        		.uleb128 0x25
 1548 01fc 8982 01   		.uleb128 0x4109
 1549 01ff 01        		.byte	0x1
 1550 0200 11        		.uleb128 0x11
 1551 0201 01        		.uleb128 0x1
 1552 0202 31        		.uleb128 0x31
 1553 0203 13        		.uleb128 0x13
 1554 0204 01        		.uleb128 0x1
 1555 0205 13        		.uleb128 0x13
 1556 0206 00        		.byte	0
 1557 0207 00        		.byte	0
 1558 0208 26        		.uleb128 0x26
 1559 0209 8982 01   		.uleb128 0x4109
 1560 020c 01        		.byte	0x1
 1561 020d 11        		.uleb128 0x11
 1562 020e 01        		.uleb128 0x1
 1563 020f 9542      		.uleb128 0x2115
 1564 0211 0C        		.uleb128 0xc
 1565 0212 31        		.uleb128 0x31
 1566 0213 13        		.uleb128 0x13
 1567 0214 00        		.byte	0
 1568 0215 00        		.byte	0
 1569 0216 27        		.uleb128 0x27
 1570 0217 01        		.uleb128 0x1
 1571 0218 01        		.byte	0x1
 1572 0219 49        		.uleb128 0x49
GAS LISTING /tmp/ccPLkBqf.s 			page 33


 1573 021a 13        		.uleb128 0x13
 1574 021b 01        		.uleb128 0x1
 1575 021c 13        		.uleb128 0x13
 1576 021d 00        		.byte	0
 1577 021e 00        		.byte	0
 1578 021f 28        		.uleb128 0x28
 1579 0220 21        		.uleb128 0x21
 1580 0221 00        		.byte	0
 1581 0222 00        		.byte	0
 1582 0223 00        		.byte	0
 1583 0224 29        		.uleb128 0x29
 1584 0225 34        		.uleb128 0x34
 1585 0226 00        		.byte	0
 1586 0227 03        		.uleb128 0x3
 1587 0228 0E        		.uleb128 0xe
 1588 0229 3A        		.uleb128 0x3a
 1589 022a 0B        		.uleb128 0xb
 1590 022b 3B        		.uleb128 0x3b
 1591 022c 0B        		.uleb128 0xb
 1592 022d 49        		.uleb128 0x49
 1593 022e 13        		.uleb128 0x13
 1594 022f 3F        		.uleb128 0x3f
 1595 0230 0C        		.uleb128 0xc
 1596 0231 3C        		.uleb128 0x3c
 1597 0232 0C        		.uleb128 0xc
 1598 0233 00        		.byte	0
 1599 0234 00        		.byte	0
 1600 0235 2A        		.uleb128 0x2a
 1601 0236 34        		.uleb128 0x34
 1602 0237 00        		.byte	0
 1603 0238 03        		.uleb128 0x3
 1604 0239 08        		.uleb128 0x8
 1605 023a 3A        		.uleb128 0x3a
 1606 023b 0B        		.uleb128 0xb
 1607 023c 3B        		.uleb128 0x3b
 1608 023d 0B        		.uleb128 0xb
 1609 023e 49        		.uleb128 0x49
 1610 023f 13        		.uleb128 0x13
 1611 0240 1C        		.uleb128 0x1c
 1612 0241 0B        		.uleb128 0xb
 1613 0242 00        		.byte	0
 1614 0243 00        		.byte	0
 1615 0244 2B        		.uleb128 0x2b
 1616 0245 34        		.uleb128 0x34
 1617 0246 00        		.byte	0
 1618 0247 03        		.uleb128 0x3
 1619 0248 0E        		.uleb128 0xe
 1620 0249 3A        		.uleb128 0x3a
 1621 024a 0B        		.uleb128 0xb
 1622 024b 3B        		.uleb128 0x3b
 1623 024c 0B        		.uleb128 0xb
 1624 024d 49        		.uleb128 0x49
 1625 024e 13        		.uleb128 0x13
 1626 024f 1C        		.uleb128 0x1c
 1627 0250 0B        		.uleb128 0xb
 1628 0251 00        		.byte	0
 1629 0252 00        		.byte	0
GAS LISTING /tmp/ccPLkBqf.s 			page 34


 1630 0253 2C        		.uleb128 0x2c
 1631 0254 34        		.uleb128 0x34
 1632 0255 00        		.byte	0
 1633 0256 03        		.uleb128 0x3
 1634 0257 0E        		.uleb128 0xe
 1635 0258 3A        		.uleb128 0x3a
 1636 0259 0B        		.uleb128 0xb
 1637 025a 3B        		.uleb128 0x3b
 1638 025b 0B        		.uleb128 0xb
 1639 025c 49        		.uleb128 0x49
 1640 025d 13        		.uleb128 0x13
 1641 025e 3F        		.uleb128 0x3f
 1642 025f 0C        		.uleb128 0xc
 1643 0260 02        		.uleb128 0x2
 1644 0261 0A        		.uleb128 0xa
 1645 0262 00        		.byte	0
 1646 0263 00        		.byte	0
 1647 0264 2D        		.uleb128 0x2d
 1648 0265 35        		.uleb128 0x35
 1649 0266 00        		.byte	0
 1650 0267 49        		.uleb128 0x49
 1651 0268 13        		.uleb128 0x13
 1652 0269 00        		.byte	0
 1653 026a 00        		.byte	0
 1654 026b 2E        		.uleb128 0x2e
 1655 026c 21        		.uleb128 0x21
 1656 026d 00        		.byte	0
 1657 026e 49        		.uleb128 0x49
 1658 026f 13        		.uleb128 0x13
 1659 0270 2F        		.uleb128 0x2f
 1660 0271 05        		.uleb128 0x5
 1661 0272 00        		.byte	0
 1662 0273 00        		.byte	0
 1663 0274 2F        		.uleb128 0x2f
 1664 0275 2E        		.uleb128 0x2e
 1665 0276 01        		.byte	0x1
 1666 0277 3F        		.uleb128 0x3f
 1667 0278 0C        		.uleb128 0xc
 1668 0279 03        		.uleb128 0x3
 1669 027a 0E        		.uleb128 0xe
 1670 027b 3A        		.uleb128 0x3a
 1671 027c 0B        		.uleb128 0xb
 1672 027d 3B        		.uleb128 0x3b
 1673 027e 0B        		.uleb128 0xb
 1674 027f 3C        		.uleb128 0x3c
 1675 0280 0C        		.uleb128 0xc
 1676 0281 01        		.uleb128 0x1
 1677 0282 13        		.uleb128 0x13
 1678 0283 00        		.byte	0
 1679 0284 00        		.byte	0
 1680 0285 30        		.uleb128 0x30
 1681 0286 2E        		.uleb128 0x2e
 1682 0287 01        		.byte	0x1
 1683 0288 3F        		.uleb128 0x3f
 1684 0289 0C        		.uleb128 0xc
 1685 028a 03        		.uleb128 0x3
 1686 028b 0E        		.uleb128 0xe
GAS LISTING /tmp/ccPLkBqf.s 			page 35


 1687 028c 3A        		.uleb128 0x3a
 1688 028d 0B        		.uleb128 0xb
 1689 028e 3B        		.uleb128 0x3b
 1690 028f 0B        		.uleb128 0xb
 1691 0290 3C        		.uleb128 0x3c
 1692 0291 0C        		.uleb128 0xc
 1693 0292 00        		.byte	0
 1694 0293 00        		.byte	0
 1695 0294 00        		.byte	0
 1696               		.section	.debug_loc,"",@progbits
 1697               	.Ldebug_loc0:
 1698               	.LLST0:
 1699 0000 0000 0000 		.long	.LVL0
 1700 0004 0000 0000 		.long	.LVL1
 1701 0008 0600      		.word	0x6
 1702 000a 68        		.byte	0x68
 1703 000b 93        		.byte	0x93
 1704 000c 01        		.uleb128 0x1
 1705 000d 69        		.byte	0x69
 1706 000e 93        		.byte	0x93
 1707 000f 01        		.uleb128 0x1
 1708 0010 0000 0000 		.long	.LVL1
 1709 0014 0000 0000 		.long	.LVL3
 1710 0018 0500      		.word	0x5
 1711 001a 03        		.byte	0x3
 1712 001b 0000 0000 		.long	adcBuffer
 1713 001f 0000 0000 		.long	.LVL3
 1714 0023 0000 0000 		.long	.LFE122
 1715 0027 0400      		.word	0x4
 1716 0029 F3        		.byte	0xf3
 1717 002a 01        		.uleb128 0x1
 1718 002b 68        		.byte	0x68
 1719 002c 9F        		.byte	0x9f
 1720 002d 0000 0000 		.long	0
 1721 0031 0000 0000 		.long	0
 1722               	.LLST1:
 1723 0035 0000 0000 		.long	.LVL0
 1724 0039 0000 0000 		.long	.LVL2
 1725 003d 0100      		.word	0x1
 1726 003f 64        		.byte	0x64
 1727 0040 0000 0000 		.long	.LVL2
 1728 0044 0000 0000 		.long	.LFE122
 1729 0048 0400      		.word	0x4
 1730 004a F3        		.byte	0xf3
 1731 004b 01        		.uleb128 0x1
 1732 004c 64        		.byte	0x64
 1733 004d 9F        		.byte	0x9f
 1734 004e 0000 0000 		.long	0
 1735 0052 0000 0000 		.long	0
 1736               	.LLST2:
 1737 0056 0000 0000 		.long	.LFB123
 1738 005a 0000 0000 		.long	.LCFI0
 1739 005e 0300      		.word	0x3
 1740 0060 92        		.byte	0x92
 1741 0061 20        		.uleb128 0x20
 1742 0062 02        		.sleb128 2
 1743 0063 0000 0000 		.long	.LCFI0
GAS LISTING /tmp/ccPLkBqf.s 			page 36


 1744 0067 0000 0000 		.long	.LCFI1
 1745 006b 0300      		.word	0x3
 1746 006d 92        		.byte	0x92
 1747 006e 20        		.uleb128 0x20
 1748 006f 03        		.sleb128 3
 1749 0070 0000 0000 		.long	.LCFI1
 1750 0074 0000 0000 		.long	.LCFI2
 1751 0078 0300      		.word	0x3
 1752 007a 92        		.byte	0x92
 1753 007b 20        		.uleb128 0x20
 1754 007c 04        		.sleb128 4
 1755 007d 0000 0000 		.long	.LCFI2
 1756 0081 0000 0000 		.long	.LCFI3
 1757 0085 0300      		.word	0x3
 1758 0087 92        		.byte	0x92
 1759 0088 20        		.uleb128 0x20
 1760 0089 05        		.sleb128 5
 1761 008a 0000 0000 		.long	.LCFI3
 1762 008e 0000 0000 		.long	.LCFI4
 1763 0092 0300      		.word	0x3
 1764 0094 92        		.byte	0x92
 1765 0095 20        		.uleb128 0x20
 1766 0096 06        		.sleb128 6
 1767 0097 0000 0000 		.long	.LCFI4
 1768 009b 0000 0000 		.long	.LCFI5
 1769 009f 0300      		.word	0x3
 1770 00a1 92        		.byte	0x92
 1771 00a2 20        		.uleb128 0x20
 1772 00a3 07        		.sleb128 7
 1773 00a4 0000 0000 		.long	.LCFI5
 1774 00a8 0000 0000 		.long	.LFE123
 1775 00ac 0300      		.word	0x3
 1776 00ae 92        		.byte	0x92
 1777 00af 20        		.uleb128 0x20
 1778 00b0 08        		.sleb128 8
 1779 00b1 0000 0000 		.long	0
 1780 00b5 0000 0000 		.long	0
 1781               	.LLST3:
 1782 00b9 0000 0000 		.long	.LVL4
 1783 00bd 0000 0000 		.long	.LVL6
 1784 00c1 0600      		.word	0x6
 1785 00c3 68        		.byte	0x68
 1786 00c4 93        		.byte	0x93
 1787 00c5 01        		.uleb128 0x1
 1788 00c6 69        		.byte	0x69
 1789 00c7 93        		.byte	0x93
 1790 00c8 01        		.uleb128 0x1
 1791 00c9 0000 0000 		.long	.LVL6
 1792 00cd 0000 0000 		.long	.LFE123
 1793 00d1 0400      		.word	0x4
 1794 00d3 F3        		.byte	0xf3
 1795 00d4 01        		.uleb128 0x1
 1796 00d5 68        		.byte	0x68
 1797 00d6 9F        		.byte	0x9f
 1798 00d7 0000 0000 		.long	0
 1799 00db 0000 0000 		.long	0
 1800               	.LLST4:
GAS LISTING /tmp/ccPLkBqf.s 			page 37


 1801 00df 0000 0000 		.long	.LVL4
 1802 00e3 0000 0000 		.long	.LVL6
 1803 00e7 0600      		.word	0x6
 1804 00e9 66        		.byte	0x66
 1805 00ea 93        		.byte	0x93
 1806 00eb 01        		.uleb128 0x1
 1807 00ec 67        		.byte	0x67
 1808 00ed 93        		.byte	0x93
 1809 00ee 01        		.uleb128 0x1
 1810 00ef 0000 0000 		.long	.LVL6
 1811 00f3 0000 0000 		.long	.LVL11
 1812 00f7 0600      		.word	0x6
 1813 00f9 5E        		.byte	0x5e
 1814 00fa 93        		.byte	0x93
 1815 00fb 01        		.uleb128 0x1
 1816 00fc 5F        		.byte	0x5f
 1817 00fd 93        		.byte	0x93
 1818 00fe 01        		.uleb128 0x1
 1819 00ff 0000 0000 		.long	.LVL11
 1820 0103 0000 0000 		.long	.LFE123
 1821 0107 0400      		.word	0x4
 1822 0109 F3        		.byte	0xf3
 1823 010a 01        		.uleb128 0x1
 1824 010b 66        		.byte	0x66
 1825 010c 9F        		.byte	0x9f
 1826 010d 0000 0000 		.long	0
 1827 0111 0000 0000 		.long	0
 1828               	.LLST5:
 1829 0115 0000 0000 		.long	.LVL5
 1830 0119 0000 0000 		.long	.LVL6
 1831 011d 0900      		.word	0x9
 1832 011f 88        		.byte	0x88
 1833 0120 00        		.sleb128 0
 1834 0121 03        		.byte	0x3
 1835 0122 0000 0000 		.long	adcs
 1836 0126 22        		.byte	0x22
 1837 0127 9F        		.byte	0x9f
 1838 0128 0000 0000 		.long	.LVL6
 1839 012c 0000 0000 		.long	.LVL7
 1840 0130 0600      		.word	0x6
 1841 0132 6C        		.byte	0x6c
 1842 0133 93        		.byte	0x93
 1843 0134 01        		.uleb128 0x1
 1844 0135 6D        		.byte	0x6d
 1845 0136 93        		.byte	0x93
 1846 0137 01        		.uleb128 0x1
 1847 0138 0000 0000 		.long	.LVL7
 1848 013c 0000 0000 		.long	.LVL9
 1849 0140 0300      		.word	0x3
 1850 0142 8C        		.byte	0x8c
 1851 0143 01        		.sleb128 1
 1852 0144 9F        		.byte	0x9f
 1853 0145 0000 0000 		.long	.LVL9
 1854 0149 0000 0000 		.long	.LVL10
 1855 014d 0600      		.word	0x6
 1856 014f 6C        		.byte	0x6c
 1857 0150 93        		.byte	0x93
GAS LISTING /tmp/ccPLkBqf.s 			page 38


 1858 0151 01        		.uleb128 0x1
 1859 0152 6D        		.byte	0x6d
 1860 0153 93        		.byte	0x93
 1861 0154 01        		.uleb128 0x1
 1862 0155 0000 0000 		.long	0
 1863 0159 0000 0000 		.long	0
 1864               	.LLST6:
 1865 015d 0000 0000 		.long	.LVL5
 1866 0161 0000 0000 		.long	.LVL6
 1867 0165 0600      		.word	0x6
 1868 0167 68        		.byte	0x68
 1869 0168 93        		.byte	0x93
 1870 0169 01        		.uleb128 0x1
 1871 016a 69        		.byte	0x69
 1872 016b 93        		.byte	0x93
 1873 016c 01        		.uleb128 0x1
 1874 016d 0000 0000 		.long	.LVL6
 1875 0171 0000 0000 		.long	.LVL10
 1876 0175 0900      		.word	0x9
 1877 0177 8C        		.byte	0x8c
 1878 0178 00        		.sleb128 0
 1879 0179 03        		.byte	0x3
 1880 017a 0000 0000 		.long	adcs
 1881 017e 1C        		.byte	0x1c
 1882 017f 9F        		.byte	0x9f
 1883 0180 0000 0000 		.long	0
 1884 0184 0000 0000 		.long	0
 1885               	.LLST7:
 1886 0188 0000 0000 		.long	.LFB125
 1887 018c 0000 0000 		.long	.LCFI6
 1888 0190 0300      		.word	0x3
 1889 0192 92        		.byte	0x92
 1890 0193 20        		.uleb128 0x20
 1891 0194 02        		.sleb128 2
 1892 0195 0000 0000 		.long	.LCFI6
 1893 0199 0000 0000 		.long	.LCFI7
 1894 019d 0300      		.word	0x3
 1895 019f 92        		.byte	0x92
 1896 01a0 20        		.uleb128 0x20
 1897 01a1 03        		.sleb128 3
 1898 01a2 0000 0000 		.long	.LCFI7
 1899 01a6 0000 0000 		.long	.LFE125
 1900 01aa 0300      		.word	0x3
 1901 01ac 92        		.byte	0x92
 1902 01ad 20        		.uleb128 0x20
 1903 01ae 04        		.sleb128 4
 1904 01af 0000 0000 		.long	0
 1905 01b3 0000 0000 		.long	0
 1906               	.LLST8:
 1907 01b7 0000 0000 		.long	.LVL15
 1908 01bb 0000 0000 		.long	.LVL16
 1909 01bf 0900      		.word	0x9
 1910 01c1 8C        		.byte	0x8c
 1911 01c2 00        		.sleb128 0
 1912 01c3 03        		.byte	0x3
 1913 01c4 0000 0000 		.long	adcs
 1914 01c8 1C        		.byte	0x1c
GAS LISTING /tmp/ccPLkBqf.s 			page 39


 1915 01c9 9F        		.byte	0x9f
 1916 01ca 0000 0000 		.long	.LVL16
 1917 01ce 0000 0000 		.long	.LVL17
 1918 01d2 0A00      		.word	0xa
 1919 01d4 03        		.byte	0x3
 1920 01d5 0000 0000 		.long	adcs
 1921 01d9 20        		.byte	0x20
 1922 01da 8C        		.byte	0x8c
 1923 01db 00        		.sleb128 0
 1924 01dc 22        		.byte	0x22
 1925 01dd 9F        		.byte	0x9f
 1926 01de 0000 0000 		.long	.LVL17
 1927 01e2 0000 0000 		.long	.LVL18
 1928 01e6 0900      		.word	0x9
 1929 01e8 8C        		.byte	0x8c
 1930 01e9 00        		.sleb128 0
 1931 01ea 03        		.byte	0x3
 1932 01eb 0000 0000 		.long	adcs
 1933 01ef 1C        		.byte	0x1c
 1934 01f0 9F        		.byte	0x9f
 1935 01f1 0000 0000 		.long	0
 1936 01f5 0000 0000 		.long	0
 1937               		.section	.debug_aranges,"",@progbits
 1938 0000 4400 0000 		.long	0x44
 1939 0004 0200      		.word	0x2
 1940 0006 0000 0000 		.long	.Ldebug_info0
 1941 000a 04        		.byte	0x4
 1942 000b 00        		.byte	0
 1943 000c 0000      		.word	0
 1944 000e 0000      		.word	0
 1945 0010 0000 0000 		.long	.LFB120
 1946 0014 4800 0000 		.long	.LFE120-.LFB120
 1947 0018 0000 0000 		.long	.LFB121
 1948 001c 0A00 0000 		.long	.LFE121-.LFB121
 1949 0020 0000 0000 		.long	.LFB122
 1950 0024 2200 0000 		.long	.LFE122-.LFB122
 1951 0028 0000 0000 		.long	.LFB123
 1952 002c 3C00 0000 		.long	.LFE123-.LFB123
 1953 0030 0000 0000 		.long	.LFB124
 1954 0034 5C00 0000 		.long	.LFE124-.LFB124
 1955 0038 0000 0000 		.long	.LFB125
 1956 003c 5200 0000 		.long	.LFE125-.LFB125
 1957 0040 0000 0000 		.long	0
 1958 0044 0000 0000 		.long	0
 1959               		.section	.debug_ranges,"",@progbits
 1960               	.Ldebug_ranges0:
 1961 0000 0000 0000 		.long	.LFB120
 1962 0004 0000 0000 		.long	.LFE120
 1963 0008 0000 0000 		.long	.LFB121
 1964 000c 0000 0000 		.long	.LFE121
 1965 0010 0000 0000 		.long	.LFB122
 1966 0014 0000 0000 		.long	.LFE122
 1967 0018 0000 0000 		.long	.LFB123
 1968 001c 0000 0000 		.long	.LFE123
 1969 0020 0000 0000 		.long	.LFB124
 1970 0024 0000 0000 		.long	.LFE124
 1971 0028 0000 0000 		.long	.LFB125
GAS LISTING /tmp/ccPLkBqf.s 			page 40


 1972 002c 0000 0000 		.long	.LFE125
 1973 0030 0000 0000 		.long	0
 1974 0034 0000 0000 		.long	0
 1975               		.section	.debug_line,"",@progbits
 1976               	.Ldebug_line0:
 1977 0000 4403 0000 		.section	.debug_str,"MS",@progbits,1
 1977      0200 DF01 
 1977      0000 0201 
 1977      FB0E 0A00 
 1977      0101 0101 
 1978               	.LASF50:
 1979 0000 5F5F 7665 		.string	"__vector_21"
 1979      6374 6F72 
 1979      5F32 3100 
 1980               	.LASF48:
 1981 000c 5F5A 4E35 		.string	"_ZN5Print5writeEPKcj"
 1981      5072 696E 
 1981      7435 7772 
 1981      6974 6545 
 1981      504B 636A 
 1982               	.LASF49:
 1983 0021 6465 636C 		.string	"decltype(nullptr)"
 1983      7479 7065 
 1983      286E 756C 
 1983      6C70 7472 
 1983      2900 
 1984               	.LASF47:
 1985 0033 5F5A 4E31 		.string	"_ZN14HardwareSerial5beginEmh"
 1985      3448 6172 
 1985      6477 6172 
 1985      6553 6572 
 1985      6961 6C35 
 1986               	.LASF45:
 1987 0050 2F74 6D70 		.string	"/tmp/arduino_build_637439"
 1987      2F61 7264 
 1987      7569 6E6F 
 1987      5F62 7569 
 1987      6C64 5F36 
 1988               	.LASF16:
 1989 006a 4861 7264 		.string	"HardwareSerial"
 1989      7761 7265 
 1989      5365 7269 
 1989      616C 00
 1990               	.LASF3:
 1991 0079 7369 7A65 		.string	"size_t"
 1991      5F74 00
 1992               	.LASF41:
 1993 0080 7369 7A65 		.string	"sizetype"
 1993      7479 7065 
 1993      00
 1994               	.LASF42:
 1995 0089 6164 6373 		.string	"adcs"
 1995      00
 1996               	.LASF13:
 1997 008e 534B 4950 		.string	"SKIP_ALL"
 1997      5F41 4C4C 
 1997      00
GAS LISTING /tmp/ccPLkBqf.s 			page 41


 1998               	.LASF51:
 1999 0097 6164 6352 		.string	"adcReadOne"
 1999      6561 644F 
 1999      6E65 00
 2000               	.LASF55:
 2001 00a2 6465 6C61 		.string	"delay"
 2001      7900 
 2002               	.LASF38:
 2003 00a8 6164 6343 		.string	"adcCount"
 2003      6F75 6E74 
 2003      00
 2004               	.LASF54:
 2005 00b1 6465 6C61 		.string	"delayMicroseconds"
 2005      794D 6963 
 2005      726F 7365 
 2005      636F 6E64 
 2005      7300 
 2006               	.LASF46:
 2007 00c3 4C6F 6F6B 		.string	"LookaheadMode"
 2007      6168 6561 
 2007      644D 6F64 
 2007      6500 
 2008               	.LASF4:
 2009 00d1 7569 6E74 		.string	"uint8_t"
 2009      385F 7400 
 2010               	.LASF30:
 2011 00d9 7365 7475 		.string	"setup"
 2011      7000 
 2012               	.LASF20:
 2013 00df 5F5A 4E31 		.string	"_ZN14HardwareSerial5beginEm"
 2013      3448 6172 
 2013      6477 6172 
 2013      6553 6572 
 2013      6961 6C35 
 2014               	.LASF43:
 2015 00fb 474E 5520 		.string	"GNU C++ 4.9.2 -mn-flash=2 -mmcu=avr51 -g -Os -std=gnu++11 -ffunction-sections -fdata-sect
 2015      432B 2B20 
 2015      342E 392E 
 2015      3220 2D6D 
 2015      6E2D 666C 
 2016               	.LASF9:
 2017 01bb 626F 6F6C 		.string	"bool"
 2017      00
 2018               	.LASF11:
 2019 01c0 666C 6F61 		.string	"float"
 2019      7400 
 2020               	.LASF17:
 2021 01c6 5072 696E 		.string	"Print"
 2021      7400 
 2022               	.LASF7:
 2023 01cc 6C6F 6E67 		.string	"long long int"
 2023      206C 6F6E 
 2023      6720 696E 
 2023      7400 
 2024               	.LASF8:
 2025 01da 6C6F 6E67 		.string	"long long unsigned int"
 2025      206C 6F6E 
GAS LISTING /tmp/ccPLkBqf.s 			page 42


 2025      6720 756E 
 2025      7369 676E 
 2025      6564 2069 
 2026               	.LASF1:
 2027 01f1 6C6F 6E67 		.string	"long int"
 2027      2069 6E74 
 2027      00
 2028               	.LASF40:
 2029 01fa 6164 6353 		.string	"adcState"
 2029      7461 7465 
 2029      00
 2030               	.LASF32:
 2031 0203 706F 7274 		.string	"port_to_mode_PGM"
 2031      5F74 6F5F 
 2031      6D6F 6465 
 2031      5F50 474D 
 2031      00
 2032               	.LASF22:
 2033 0214 6C6F 6E67 		.string	"long double"
 2033      2064 6F75 
 2033      626C 6500 
 2034               	.LASF53:
 2035 0220 6261 7564 		.string	"baud"
 2035      00
 2036               	.LASF5:
 2037 0225 756E 7369 		.string	"unsigned char"
 2037      676E 6564 
 2037      2063 6861 
 2037      7200 
 2038               	.LASF2:
 2039 0233 7369 676E 		.string	"signed char"
 2039      6564 2063 
 2039      6861 7200 
 2040               	.LASF0:
 2041 023f 756E 7369 		.string	"unsigned int"
 2041      676E 6564 
 2041      2069 6E74 
 2041      00
 2042               	.LASF34:
 2043 024c 706F 7274 		.string	"port_to_output_PGM"
 2043      5F74 6F5F 
 2043      6F75 7470 
 2043      7574 5F50 
 2043      474D 00
 2044               	.LASF6:
 2045 025f 6C6F 6E67 		.string	"long unsigned int"
 2045      2075 6E73 
 2045      6967 6E65 
 2045      6420 696E 
 2045      7400 
 2046               	.LASF27:
 2047 0271 7370 6565 		.string	"speed"
 2047      6400 
 2048               	.LASF29:
 2049 0277 7374 6172 		.string	"start"
 2049      7400 
 2050               	.LASF23:
GAS LISTING /tmp/ccPLkBqf.s 			page 43


 2051 027d 7368 6F72 		.string	"short unsigned int"
 2051      7420 756E 
 2051      7369 676E 
 2051      6564 2069 
 2051      6E74 00
 2052               	.LASF44:
 2053 0290 2F74 6D70 		.string	"/tmp/arduino_build_637439/sketch/adcTest.ino.ino.cpp"
 2053      2F61 7264 
 2053      7569 6E6F 
 2053      5F62 7569 
 2053      6C64 5F36 
 2054               	.LASF10:
 2055 02c5 6368 6172 		.string	"char"
 2055      00
 2056               	.LASF37:
 2057 02ca 4D49 534F 		.string	"MISO"
 2057      00
 2058               	.LASF19:
 2059 02cf 7072 696E 		.string	"println"
 2059      746C 6E00 
 2060               	.LASF21:
 2061 02d7 5F5A 4E35 		.string	"_ZN5Print7printlnEhi"
 2061      5072 696E 
 2061      7437 7072 
 2061      696E 746C 
 2061      6E45 6869 
 2062               	.LASF52:
 2063 02ec 7468 6973 		.string	"this"
 2063      00
 2064               	.LASF28:
 2065 02f1 7465 7374 		.string	"test"
 2065      00
 2066               	.LASF12:
 2067 02f6 646F 7562 		.string	"double"
 2067      6C65 00
 2068               	.LASF15:
 2069 02fd 534B 4950 		.string	"SKIP_WHITESPACE"
 2069      5F57 4849 
 2069      5445 5350 
 2069      4143 4500 
 2070               	.LASF18:
 2071 030d 6265 6769 		.string	"begin"
 2071      6E00 
 2072               	.LASF39:
 2073 0313 6164 6342 		.string	"adcBuffer"
 2073      7566 6665 
 2073      7200 
 2074               	.LASF33:
 2075 031d 706F 7274 		.string	"port_to_input_PGM"
 2075      5F74 6F5F 
 2075      696E 7075 
 2075      745F 5047 
 2075      4D00 
 2076               	.LASF24:
 2077 032f 7772 6974 		.string	"write"
 2077      6500 
 2078               	.LASF35:
GAS LISTING /tmp/ccPLkBqf.s 			page 44


 2079 0335 5365 7269 		.string	"Serial"
 2079      616C 00
 2080               	.LASF31:
 2081 033c 6C6F 6F70 		.string	"loop"
 2081      00
 2082               	.LASF14:
 2083 0341 534B 4950 		.string	"SKIP_NONE"
 2083      5F4E 4F4E 
 2083      4500 
 2084               	.LASF25:
 2085 034b 6164 6353 		.string	"adcStart"
 2085      7461 7274 
 2085      00
 2086               	.LASF36:
 2087 0354 4D4F 5349 		.string	"MOSI"
 2087      00
 2088               	.LASF26:
 2089 0359 6672 6F6D 		.string	"from"
 2089      00
 2090               		.ident	"GCC: (GNU) 4.9.2"
 2091               	.global __do_copy_data
 2092               	.global __do_clear_bss
GAS LISTING /tmp/ccPLkBqf.s 			page 45


DEFINED SYMBOLS
                            *ABS*:0000000000000000 adcTest.ino.ino.cpp
     /tmp/ccPLkBqf.s:2      *ABS*:000000000000003e __SP_H__
     /tmp/ccPLkBqf.s:3      *ABS*:000000000000003d __SP_L__
     /tmp/ccPLkBqf.s:4      *ABS*:000000000000003f __SREG__
     /tmp/ccPLkBqf.s:5      *ABS*:000000000000003b __RAMPZ__
     /tmp/ccPLkBqf.s:6      *ABS*:0000000000000000 __tmp_reg__
     /tmp/ccPLkBqf.s:7      *ABS*:0000000000000001 __zero_reg__
     /tmp/ccPLkBqf.s:14     .text.__vector_21:0000000000000000 __vector_21
     /tmp/ccPLkBqf.s:362    .data.adcState:0000000000000000 adcState
     /tmp/ccPLkBqf.s:374    .bss.adcCount:0000000000000000 adcCount
     /tmp/ccPLkBqf.s:368    .bss.adcBuffer:0000000000000000 adcBuffer
     /tmp/ccPLkBqf.s:64     .text.adcReadOne:0000000000000000 adcReadOne
     /tmp/ccPLkBqf.s:88     .text.adcStart:0000000000000000 adcStart
     /tmp/ccPLkBqf.s:122    .text.test:0000000000000000 test
     /tmp/ccPLkBqf.s:356    .bss.adcs:0000000000000000 adcs
     /tmp/ccPLkBqf.s:202    .text.setup:0000000000000000 setup
     /tmp/ccPLkBqf.s:270    .text.loop:0000000000000000 loop

UNDEFINED SYMBOLS
Serial
_ZN14HardwareSerial5beginEmh
delayMicroseconds
_ZN5Print7printlnEhi
delay
__do_copy_data
__do_clear_bss
