GAS LISTING /tmp/ccNcTpZI.s 			page 1


   1               		.file	"Osciloscope.ino.cpp"
   2               	__SP_H__ = 0x3e
   3               	__SP_L__ = 0x3d
   4               	__SREG__ = 0x3f
   5               	__RAMPZ__ = 0x3b
   6               	__tmp_reg__ = 0
   7               	__zero_reg__ = 1
   8               		.text
   9               	.Ltext0:
  10               		.cfi_sections	.debug_frame
  11               		.section	.text.adcMeasure,"ax",@progbits
  12               	.global	adcMeasure
  13               		.type	adcMeasure, @function
  14               	adcMeasure:
  15               	.LFB110:
  16               		.file 1 "/home/arhat109/Arduino/Osciloscope/Osciloscope.ino"
   1:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
   2:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** extern "C" {
   3:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
   4:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** typedef enum {REF_AREF=0, REF_AVCC=64, REF_1V=128, REF_256V=192} ADCREF;
   5:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** typedef enum {TRIG_ROUND=0, TRIG_COMPARATOR, TRIG_INT0, TRIG_T0A, TRIG_T0OVF, TRIG_T1B, TRIG_T1OVF,
   6:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** typedef enum {
   7:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_0=0, MUX_1, MUX_2, MUX_3, MUX_4, MUX_5, MUX_6, MUX_7,
   8:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_G10_00, MUX_G10_10, MUX_G200_00, MUX_G200_10,
   9:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_G10_22, MUX_G10_32, MUX_G200_22, MUX_G200_32,
  10:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_D01, MUX_D11, MUX_D21, MUX_D31, MUX_D41, MUX_D51, MUX_D61, MUX_D71,
  11:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_D02, MUX_D12, MUX_D22, MUX_D32, MUX_D42, MUX_D52,
  12:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_1V,  MUX_GND,
  13:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_8, MUX_9, MUX_A, MUX_B, MUX_C, MUX_D, MUX_E, MUX_F,
  14:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_G10_88, MUX_G10_98, MUX_G200_88, MUX_G200_98,
  15:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_G10_AA, MUX_G10_BA, MUX_G200_AA, MUX_G200_BA,
  16:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_D89, MUX_D99, MUX_DA9, MUX_DB9, MUX_DC9, MUX_DD9, MUX_DE9, MUX_DF9,
  17:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   MUX_D8A, MUX_D9A, MUX_DAA, MUX_DBA, MUX_DCA, MUX_DDA
  18:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** } ADCMUX;
  19:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** /*
  20:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define adcStart()   (ADCSRA |= (1<<ADSC))
  21:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define adc8bit()    (ADMUX |= (1<<ADLAR))
  22:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define adc10bit()   (ADMUX &= ~(1<<ADLAR))
  23:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define adcIntOn()   (ADCSRA |= (1<<ADIE))
  24:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define adcIntOff()  (ADCSRA &= ~(1<<ADIE))
  25:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define adc2comp()   (ADCSRB |= (1<<ACME))
  26:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** */
  27:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // ADMUX:  REFS1(7), REFS0(6), ADLAR(5), MUX4..0
  28:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // ADCSRA: ADEN(7), ADSC(6), ADATE(5), ADIF(4), ADIE(3), ADPS0..2
  29:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // ADCSRB: ACME(6), ADMUX5(3),ADTS0..2
  30:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // DIDR0:  Closed PINx for noise redusing ADC7..0
  31:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // DIDR2:  Closed PINx for noise reducing ADC15..8
  32:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // PRR0:   bit0=1 ADC power off!
  33:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
  34:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** typedef struct{
  35:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t    mux;    // prepared before the ADMUX for channel
  36:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t    pinPos; // to future..
  37:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t    pinNeg; // to future..
  38:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** } AdcChannel;
  39:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
  40:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define ADC_SAMPLE_LENGTH   256
  41:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define ADC_MAX_CHANNELS      1
GAS LISTING /tmp/ccNcTpZI.s 			page 2


  42:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define ADC_MAX_SAMPLES       4
  43:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define ADC_MAX_BUFFER     ADC_SAMPLE_LENGTH * ADC_MAX_CHANNELS * ADC_MAX_SAMPLES
  44:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
  45:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** volatile uint8_t      adcBuffer[ADC_MAX_BUFFER];        /** ADC results buffer for all samples and 
  46:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** volatile uint8_t      adcMaxSamples  =ADC_MAX_SAMPLES;  /** Current repeated samples for each chann
  47:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** volatile uint16_t     adcSampleLength=ADC_SAMPLE_LENGTH;/** Current one channel sample length <= AD
  48:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
  49:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** volatile AdcChannel   adcChannels[ADC_MAX_CHANNELS];    /** All channels data */
  50:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** volatile uint8_t      adcMaxChannels = ADC_MAX_CHANNELS;/** Current channels in work [0..ADC_MAX_CH
  51:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
  52:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** volatile uint8_t      adcLevel=32;                      /** Current sinhrolevel for start in ADC ui
  53:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** volatile uint8_t      adcSign=0;                        /** Current edge sinhro level to pos[0] or 
  54:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** volatile uint8_t      adcShift=0;                       /** Current max strobe shift for last sampl
  55:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
  56:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define adcWaitInt() {while((ADCSRA&(1<<ADIF))==0); ADCSRA &= ~(1<<ADIF);}
  57:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define adcRead1(p) { adcWaitInt(); (p)=ADCH; }
  58:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define delayMicro16(__count) \
  59:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   __asm__ __volatile__ (      \
  60:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "1: sbiw %0,1 \n\t"       \
  61:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****        "brne 1b\n\t"          \
  62:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****        :: "w" (__count)       \
  63:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** )
  64:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
  65:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** /**
  66:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  * Fill measures buffer for all channels with presetted channel data, sinhro-level, etc.
  67:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  * Before: ADC must be set into free running mode!
  68:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  * USAGE:
  69:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  *  r16,17,30,31 -- ptr for adcChannels
  70:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  *  r28,29       -- ptr for adcBuffer
  71:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  *  r26          -- adcMaxSamples
  72:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  *  r24,25       -- adcSampleLength
  73:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  *  r23          -- adcMaxChannels
  74:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  *  r22          -- adcShift
  75:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  *  r21          -- adcLevel
  76:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  *  r20          -- adcSign
  77:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  *  r19,r18 -- local temporary usage
  78:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  * All registers and SREG are push/pop into procedure!!!
  79:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****  */
  80:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** void adcMeasure()
  81:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** {
  17               		.loc 1 81 0
  18               		.cfi_startproc
  19               	/* prologue: function */
  20               	/* frame size = 0 */
  21               	/* stack size = 0 */
  22               	.L__stack_usage = 0
  82:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   asm volatile(
  83:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r16 \n\t"
  84:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r17 \n\t"
  85:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r18 \n\t"
  86:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r19 \n\t"
  87:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r20 \n\t"
  88:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r21 \n\t"
  89:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r22 \n\t"
  90:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r23 \n\t"
  91:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r24 \n\t"
  92:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r25 \n\t"
GAS LISTING /tmp/ccNcTpZI.s 			page 3


  93:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r26 \n\t"
  94:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r27 \n\t"
  95:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r28 \n\t"
  96:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r29 \n\t"
  97:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r30 \n\t"
  98:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r31 \n\t"
  99:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    in   r31,__SREG__ \n\t"
 100:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    push r31          \n\t"
 101:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r16,adcChannels       ; ptrCh=adcChannels;           \n\t"
 102:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r17,adcChannels+1     ;                              \n\t"
 103:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    mov  r30,r16               ; current doublicate!          \n\t"
 104:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    mov  r31,r17               ;                              \n\t"
 105:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r28,adcBuffer         ; buf=adcBuffer;               \n\t"
 106:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r29,adcBuffer+1       ;                              \n\t"
 107:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r26,adcMaxSamples     ; samples=adcMaxSamples;       \n\t"
 108:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r23,adcMaxChannels    ; numCh = adcMaxChannels;      \n\t"
 109:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r22,adcShift          ; shift=adcShift;              \n\t"
 110:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r21,adcLevel          ; level=adcLevel;              \n\t"
 111:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r20,adcSign           ; sign=adcSign;                \n\t"
 112:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "SAMPLES:                       ; do{                          \n\t"
 113:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r24,adcSampleLength   ; 19.measure=adcSampleLength;  \n\t"
 114:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r25,adcSampleLength   ; .                            \n\t"
 115:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // 0. Prepare ADMUX for channel[0]:
 116:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    ld   r18,Z                 ; .ADMUX = ptrCh->mux;         \n\t"
 117:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sts  0x007c,r18            ; .                            \n\t"
 118:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // 1. search sinhrolevel:
 119:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    clr  r19                   ; .isOk = false                \n\t"
 120:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // 1.1. wait ADIF and read ADC data:
 121:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "WAIT_L:                        ; ..while(ADCSRA&(1<<ADIF)==0); \n\t"
 122:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r18,122               ; 0...                           \n\t"
 123:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sbrs r18,4                 ; 2...                           \n\t"
 124:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    rjmp WAIT_L                ; ...                           \n\t"
 125:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    andi r18,lo8(-17)          ; 4..ADCSRA &= ~(1<<ADIF);       \n\t"
 126:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sts  122,r18               ; 5..                            \n\t"
 127:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r18,121               ; 7.._t = ADCH;                  \n\t"
 128:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // 1.2. control sinhro-level:
 129:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    cp   r18,r21               ; 9..SREG = ADCH ? level;        \n\t"
 130:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sbrs r20,0                 ; 10..if( sign == 1)skip POS;    \n\t"
 131:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    rjmp POS                   ; 11                             \n\t"
 132:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    brlo ISOK                  ; 12..go if (NEG & LT)           \n\t"
 133:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "FOUNDED:                       ;                               \n\t"
 134:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    ldi  r19,1                 ; ..NEG,POS are founded!        \n\t"
 135:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    rjmp WAIT_L                ; ..continue;                   \n\t"
 136:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "POS:                           ;                               \n\t"
 137:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    brsh ISOK                  ; ..go if (POS & GE)            \n\t"
 138:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    rjmp FOUNDED               ;                               \n\t"
 139:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "ISOK:                          ;                               \n\t"
 140:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sbrs r19,0                 ; 14(15)..level is ok - start!  \n\t"
 141:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    rjmp WAIT_L                ; ..not founded - continue      \n\t"
 142:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // 2. Make shift for next sample if need:
 143:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r18,0x007a            ; 16(17)...stop ADC!            \n\t"
 144:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    andi r18,lo8(223)          ; 18...ADCSRA &= ~(1<<ADATE)    \n\t"
 145:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sts  0x007a,r18            ; 19...                         \n\t"
 146:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    cpi  r22,0                 ; 21.if( _shift == 0 )          \n\t"
 147:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    breq START_ADC             ; 22.skip shift delay           \n\t"
 148:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    mov  r18,r22               ; 23._t=shift;                  \n\t"
 149:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "SHIFT:                         ;                               \n\t"
GAS LISTING /tmp/ccNcTpZI.s 			page 4


 150:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    dec  r18                   ; 24/27.._t--                   \n\t"
 151:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    brne SHIFT                 ; 25/28.delay _t*250us          \n\t"
 152:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    dec  r22                   ; 26/29.shift--;                \n\t"
 153:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "START_ADC:                     ;                               \n\t"
 154:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r18,0x007a            ; 24/27/30...start ADC!         \n\t"
 155:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    ori  r18,lo8(32)           ; 26/...ADCSRA |= (1<<ADATE)    \n\t"
 156:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sts  0x007a,r18            ; 27/...                        \n\t"
 157:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // 3. start all measures for 1 sample:
 158:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "MEASURE:                       ; .do{//measures    \n\t"
 159:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    mov  r19,r23               ; 29(+3)..numCh = adcMaxChannels;  \n\t"
 160:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "CHANNEL:                       ; ..do{//channels                  \n\t"
 161:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // 3.1 prepare next admux before read!
 162:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    dec  r19                   ; 31...if( --_numChannel > 0 )    \n\t"
 163:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    breq LAST_CH               ; 32...goto else                  \n\t"
 164:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    adiw r30,3                 ; 33....ptrCh++; (sizeof()=3!)    \n\t"
 165:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    rjmp SET_NEXT              ; 34....                          \n\t"
 166:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "LAST_CH:                       ; ...else                         \n\t"
 167:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    mov  r30,r16               ; 34....ptrCh=adcChannels;        \n\t"
 168:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    mov  r31,r17               ; 35....                          \n\t"
 169:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "SET_NEXT:                      ;                                 \n\t"
 170:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    ld   r18,Z                 ; 36...ADMUX= ptrCh->mux;         \n\t"
 171:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sts  0x007c,r18            ; 37...                           \n\t"
 172:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** // 2.2 wait and get ADC result:
 173:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "WAIT_D:                        ; ...while(ADCSRA&(1<<ADIF)==0); \n\t"
 174:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r18,122               ; 0...                           \n\t"
 175:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sbrs r18,4                 ; 2...                           \n\t"
 176:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    rjmp WAIT_D                ; ...                           \n\t"
 177:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    andi r18,lo8(-17)          ; 4..ADCSRA &= ~(1<<ADIF);       \n\t"
 178:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sts  122,r18               ; 5..                            \n\t"
 179:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    lds  r18,121               ; 7.._t = ADCH;                  \n\t"
 180:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    st   Y+,r18                ; 9...                           \n\t"
 181:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    tst  r19                   ; 11..}while( numCh > 0 );       \n\t"
 182:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    brne CHANNEL               ; 12..                           \n\t"
 183:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    sbiw r24,1                 ; 13.}while(--_measures > 0 );   \n\t"
 184:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    brne MEASURE               ; 15.                            \n\t"
 185:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    dec  r26                   ; 16}while( --_samples>0 );      \n\t"
 186:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    brne SAMPLES               ; 17                             \n\t"
 187:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r31          \n\t"
 188:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    out  __SREG__,r31 \n\t"
 189:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r31 \n\t"
 190:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r30 \n\t"
 191:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r29 \n\t"
 192:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r28 \n\t"
 193:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r27 \n\t"
 194:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r26 \n\t"
 195:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r25 \n\t"
 196:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r24 \n\t"
 197:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r23 \n\t"
 198:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r22 \n\t"
 199:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r21 \n\t"
 200:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r20 \n\t"
 201:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r19 \n\t"
 202:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r18 \n\t"
 203:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r17 \n\t"
 204:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     "    pop  r16 \n\t"
 205:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   ::);
  23               		.loc 1 205 0
GAS LISTING /tmp/ccNcTpZI.s 			page 5


  24               	/* #APP */
  25               	 ;  205 "/home/arhat109/Arduino/Osciloscope/Osciloscope.ino" 1
  26 0000 0F93      		    push r16 
  27 0002 1F93      		    push r17 
  28 0004 2F93      		    push r18 
  29 0006 3F93      		    push r19 
  30 0008 4F93      		    push r20 
  31 000a 5F93      		    push r21 
  32 000c 6F93      		    push r22 
  33 000e 7F93      		    push r23 
  34 0010 8F93      		    push r24 
  35 0012 9F93      		    push r25 
  36 0014 AF93      		    push r26 
  37 0016 BF93      		    push r27 
  38 0018 CF93      		    push r28 
  39 001a DF93      		    push r29 
  40 001c EF93      		    push r30 
  41 001e FF93      		    push r31 
  42 0020 FFB7      		    in   r31,__SREG__ 
  43 0022 FF93      		    push r31          
  44 0024 0091 0000 		    lds  r16,adcChannels       ; ptrCh=adcChannels;           
  45 0028 1091 0000 		    lds  r17,adcChannels+1     ;                              
  46 002c E02F      		    mov  r30,r16               ; current doublicate!          
  47 002e F12F      		    mov  r31,r17               ;                              
  48 0030 C091 0000 		    lds  r28,adcBuffer         ; buf=adcBuffer;               
  49 0034 D091 0000 		    lds  r29,adcBuffer+1       ;                              
  50 0038 A091 0000 		    lds  r26,adcMaxSamples     ; samples=adcMaxSamples;       
  51 003c 7091 0000 		    lds  r23,adcMaxChannels    ; numCh = adcMaxChannels;      
  52 0040 6091 0000 		    lds  r22,adcShift          ; shift=adcShift;              
  53 0044 5091 0000 		    lds  r21,adcLevel          ; level=adcLevel;              
  54 0048 4091 0000 		    lds  r20,adcSign           ; sign=adcSign;                
  55               		SAMPLES:                       ; do{                          
  56 004c 8091 0000 		    lds  r24,adcSampleLength   ; 19.measure=adcSampleLength;  
  57 0050 9091 0000 		    lds  r25,adcSampleLength   ; .                            
  58 0054 2081      		    ld   r18,Z                 ; .ADMUX = ptrCh->mux;         
  59 0056 2093 7C00 		    sts  0x007c,r18            ; .                            
  60 005a 3327      		    clr  r19                   ; .isOk = false                
  61               		WAIT_L:                        ; ..while(ADCSRA&(1<<ADIF)==0); 
  62 005c 2091 7A00 		    lds  r18,122               ; 0...                           
  63 0060 24FF      		    sbrs r18,4                 ; 2...                           
  64 0062 00C0      		    rjmp WAIT_L                ; ...                           
  65 0064 2F7E      		    andi r18,lo8(-17)          ; 4..ADCSRA &= ~(1<<ADIF);       
  66 0066 2093 7A00 		    sts  122,r18               ; 5..                            
  67 006a 2091 7900 		    lds  r18,121               ; 7.._t = ADCH;                  
  68 006e 2517      		    cp   r18,r21               ; 9..SREG = ADCH ? level;        
  69 0070 40FF      		    sbrs r20,0                 ; 10..if( sign == 1)skip POS;    
  70 0072 00C0      		    rjmp POS                   ; 11                             
  71 0074 00F0      		    brlo ISOK                  ; 12..go if (NEG & LT)           
  72               		FOUNDED:                       ;                               
  73 0076 31E0      		    ldi  r19,1                 ; ..NEG,POS are founded!        
  74 0078 00C0      		    rjmp WAIT_L                ; ..continue;                   
  75               		POS:                           ;                               
  76 007a 00F4      		    brsh ISOK                  ; ..go if (POS & GE)            
  77 007c 00C0      		    rjmp FOUNDED               ;                               
  78               		ISOK:                          ;                               
  79 007e 30FF      		    sbrs r19,0                 ; 14(15)..level is ok - start!  
  80 0080 00C0      		    rjmp WAIT_L                ; ..not founded - continue      
GAS LISTING /tmp/ccNcTpZI.s 			page 6


  81 0082 2091 7A00 		    lds  r18,0x007a            ; 16(17)...stop ADC!            
  82 0086 2F7D      		    andi r18,lo8(223)          ; 18...ADCSRA &= ~(1<<ADATE)    
  83 0088 2093 7A00 		    sts  0x007a,r18            ; 19...                         
  84 008c 6030      		    cpi  r22,0                 ; 21.if( _shift == 0 )          
  85 008e 01F0      		    breq START_ADC             ; 22.skip shift delay           
  86 0090 262F      		    mov  r18,r22               ; 23._t=shift;                  
  87               		SHIFT:                         ;                               
  88 0092 2A95      		    dec  r18                   ; 24/27.._t--                   
  89 0094 01F4      		    brne SHIFT                 ; 25/28.delay _t*250us          
  90 0096 6A95      		    dec  r22                   ; 26/29.shift--;                
  91               		START_ADC:                     ;                               
  92 0098 2091 7A00 		    lds  r18,0x007a            ; 24/27/30...start ADC!         
  93 009c 2062      		    ori  r18,lo8(32)           ; 26/...ADCSRA |= (1<<ADATE)    
  94 009e 2093 7A00 		    sts  0x007a,r18            ; 27/...                        
  95               		MEASURE:                       ; .do{//measures    
  96 00a2 372F      		    mov  r19,r23               ; 29(+3)..numCh = adcMaxChannels;  
  97               		CHANNEL:                       ; ..do{//channels                  
  98 00a4 3A95      		    dec  r19                   ; 31...if( --_numChannel > 0 )    
  99 00a6 01F0      		    breq LAST_CH               ; 32...goto else                  
 100 00a8 3396      		    adiw r30,3                 ; 33....ptrCh++; (sizeof()=3!)    
 101 00aa 00C0      		    rjmp SET_NEXT              ; 34....                          
 102               		LAST_CH:                       ; ...else                         
 103 00ac E02F      		    mov  r30,r16               ; 34....ptrCh=adcChannels;        
 104 00ae F12F      		    mov  r31,r17               ; 35....                          
 105               		SET_NEXT:                      ;                                 
 106 00b0 2081      		    ld   r18,Z                 ; 36...ADMUX= ptrCh->mux;         
 107 00b2 2093 7C00 		    sts  0x007c,r18            ; 37...                           
 108               		WAIT_D:                        ; ...while(ADCSRA&(1<<ADIF)==0); 
 109 00b6 2091 7A00 		    lds  r18,122               ; 0...                           
 110 00ba 24FF      		    sbrs r18,4                 ; 2...                           
 111 00bc 00C0      		    rjmp WAIT_D                ; ...                           
 112 00be 2F7E      		    andi r18,lo8(-17)          ; 4..ADCSRA &= ~(1<<ADIF);       
 113 00c0 2093 7A00 		    sts  122,r18               ; 5..                            
 114 00c4 2091 7900 		    lds  r18,121               ; 7.._t = ADCH;                  
 115 00c8 2993      		    st   Y+,r18                ; 9...                           
 116 00ca 3323      		    tst  r19                   ; 11..}while( numCh > 0 );       
 117 00cc 01F4      		    brne CHANNEL               ; 12..                           
 118 00ce 0197      		    sbiw r24,1                 ; 13.}while(--_measures > 0 );   
 119 00d0 01F4      		    brne MEASURE               ; 15.                            
 120 00d2 AA95      		    dec  r26                   ; 16}while( --_samples>0 );      
 121 00d4 01F4      		    brne SAMPLES               ; 17                             
 122 00d6 FF91      		    pop  r31          
 123 00d8 FFBF      		    out  __SREG__,r31 
 124 00da FF91      		    pop  r31 
 125 00dc EF91      		    pop  r30 
 126 00de DF91      		    pop  r29 
 127 00e0 CF91      		    pop  r28 
 128 00e2 BF91      		    pop  r27 
 129 00e4 AF91      		    pop  r26 
 130 00e6 9F91      		    pop  r25 
 131 00e8 8F91      		    pop  r24 
 132 00ea 7F91      		    pop  r23 
 133 00ec 6F91      		    pop  r22 
 134 00ee 5F91      		    pop  r21 
 135 00f0 4F91      		    pop  r20 
 136 00f2 3F91      		    pop  r19 
 137 00f4 2F91      		    pop  r18 
GAS LISTING /tmp/ccNcTpZI.s 			page 7


 138 00f6 1F91      		    pop  r17 
 139 00f8 0F91      		    pop  r16 
 140               		
 141               	 ;  0 "" 2
 142               	/* #NOAPP */
 143 00fa 0895      		ret
 144               		.cfi_endproc
 145               	.LFE110:
 146               		.size	adcMeasure, .-adcMeasure
 147               		.section	.text.setup,"ax",@progbits
 148               	.global	setup
 149               		.type	setup, @function
 150               	setup:
 151               	.LFB111:
 206:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** /*
 207:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   AdcChannel * _ptrChannel = (AdcChannel *)adcChannels;
 208:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t    * _buf        = (uint8_t *)adcBuffer;
 209:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint16_t     _measures   = adcSampleLength;
 210:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t      _samples    = adcMaxSamples;
 211:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t      _level      = adcLevel;
 212:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t      _sign       = adcSign;
 213:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t      _shift      = adcShift;
 214:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   
 215:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t      _adc, _isSign, _numChannel;
 216:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 217:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   do{
 218:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     uint8_t      _measures   = adcSampleLength;
 219:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 220:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     // 0. Prepare ADMUX for channel[0]:
 221:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     ADMUX = _ptrChannel->mux;
 222:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 223:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     // 1. search sinhrolevel:
 224:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     _isSign = 0;
 225:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     do{
 226:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** _LEVEL:
 227:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       adcRead1(_adc);
 228:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       switch(_sign){
 229:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       case 0: //to positive //
 230:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****           if( _adc < _level ){ _isSign = 1; goto _LEVEL; }
 231:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         break;
 232:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       case 1: // to negative //
 233:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****           if( _adc > _level ){ _isSign = 1; goto _LEVEL; }
 234:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         break;
 235:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       }
 236:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     }while(_isSign == 0);
 237:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 238:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     // 2. Make shift for next sample if need:
 239:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     if( _shift > 0 ){ delayMicro16( (int)_shift); }
 240:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 241:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     // 3. start measure for 1 sample:
 242:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     do{
 243:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       _numChannel = adcMaxChannels;
 244:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       do{
 245:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         // 2.1 prepare next measure before read!
 246:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         if( --_numChannel > 0 ){ _ptrChannel++;             }
 247:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         else                   { _ptrChannel = (AdcChannel *)adcChannels; }
 248:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         ADMUX = _ptrChannel->mux;
GAS LISTING /tmp/ccNcTpZI.s 			page 8


 249:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         // 2.2 wait and get ADC result:
 250:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         adcRead1(_adc);
 251:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         *_buf++ = _adc;
 252:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       }while( _numChannel > 0 );
 253:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     }while(--_measures > 0 );
 254:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   }while( --_samples>0 );
 255:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** */
 256:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** }
 257:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 258:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** #define MAX_RESULT (ADC_SAMPLE_LENGTH * ADC_MAX_CHANNELS)
 259:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** uint8_t    resBuffer[MAX_RESULT];
 260:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 261:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** }
 262:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 263:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** void setup() {
 152               		.loc 1 263 0
 153               		.cfi_startproc
 154               	/* prologue: function */
 155               	/* frame size = 0 */
 156               	/* stack size = 0 */
 157               	.L__stack_usage = 0
 158               	.LBB8:
 264:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t _adc;
 265:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   unsigned long time;
 266:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 267:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   asm volatile ("nop \n\t"::);
 159               		.loc 1 267 0
 160               	/* #APP */
 161               	 ;  267 "/home/arhat109/Arduino/Osciloscope/Osciloscope.ino" 1
 162 0000 0000      		nop 
 163               		
 164               	 ;  0 "" 2
 165               	.LVL0:
 166               	/* #NOAPP */
 167               	.LBB9:
 168               	.LBB10:
 169               		.file 2 "/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h"
   1:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** /*
   2:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   HardwareSerial.h - Hardware serial library for Wiring
   3:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   Copyright (c) 2006 Nicholas Zambetti.  All right reserved.
   4:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
   5:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   This library is free software; you can redistribute it and/or
   6:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   modify it under the terms of the GNU Lesser General Public
   7:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   License as published by the Free Software Foundation; either
   8:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   version 2.1 of the License, or (at your option) any later version.
   9:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
  10:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   This library is distributed in the hope that it will be useful,
  11:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   but WITHOUT ANY WARRANTY; without even the implied warranty of
  12:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  13:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   Lesser General Public License for more details.
  14:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
  15:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   You should have received a copy of the GNU Lesser General Public
  16:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   License along with this library; if not, write to the Free Software
  17:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  18:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
  19:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   Modified 28 September 2010 by Mark Sproul
  20:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   Modified 14 August 2012 by Alarus
GAS LISTING /tmp/ccNcTpZI.s 			page 9


  21:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   Modified 3 December 2013 by Matthijs Kooijman
  22:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** */
  23:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
  24:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #ifndef HardwareSerial_h
  25:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define HardwareSerial_h
  26:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
  27:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #include <inttypes.h>
  28:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
  29:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #include "Stream.h"
  30:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
  31:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // Define constants and variables for buffering incoming serial data.  We're
  32:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // using a ring buffer (I think), in which head is the index of the location
  33:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // to which to write the next incoming character and tail is the index of the
  34:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // location from which to read.
  35:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // NOTE: a "power of 2" buffer size is reccomended to dramatically
  36:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** //       optimize all the modulo operations for ring buffers.
  37:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // WARNING: When buffer sizes are increased to > 256, the buffer index
  38:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // variables are automatically increased in size, but the extra
  39:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // atomicity guards needed for that are not implemented. This will
  40:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // often work, but occasionally a race condition can occur that makes
  41:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // Serial behave erratically. See https://github.com/arduino/Arduino/issues/2405
  42:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #if !defined(SERIAL_TX_BUFFER_SIZE)
  43:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #if ((RAMEND - RAMSTART) < 1023)
  44:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_TX_BUFFER_SIZE 16
  45:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #else
  46:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_TX_BUFFER_SIZE 64
  47:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #endif
  48:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #endif
  49:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #if !defined(SERIAL_RX_BUFFER_SIZE)
  50:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #if ((RAMEND - RAMSTART) < 1023)
  51:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_RX_BUFFER_SIZE 16
  52:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #else
  53:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_RX_BUFFER_SIZE 64
  54:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #endif
  55:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #endif
  56:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #if (SERIAL_TX_BUFFER_SIZE>256)
  57:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** typedef uint16_t tx_buffer_index_t;
  58:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #else
  59:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** typedef uint8_t tx_buffer_index_t;
  60:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #endif
  61:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #if  (SERIAL_RX_BUFFER_SIZE>256)
  62:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** typedef uint16_t rx_buffer_index_t;
  63:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #else
  64:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** typedef uint8_t rx_buffer_index_t;
  65:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #endif
  66:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
  67:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** // Define config for Serial.begin(baud, config);
  68:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_5N1 0x00
  69:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_6N1 0x02
  70:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_7N1 0x04
  71:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_8N1 0x06
  72:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_5N2 0x08
  73:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_6N2 0x0A
  74:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_7N2 0x0C
  75:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_8N2 0x0E
  76:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_5E1 0x20
  77:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_6E1 0x22
GAS LISTING /tmp/ccNcTpZI.s 			page 10


  78:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_7E1 0x24
  79:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_8E1 0x26
  80:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_5E2 0x28
  81:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_6E2 0x2A
  82:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_7E2 0x2C
  83:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_8E2 0x2E
  84:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_5O1 0x30
  85:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_6O1 0x32
  86:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_7O1 0x34
  87:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_8O1 0x36
  88:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_5O2 0x38
  89:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_6O2 0x3A
  90:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_7O2 0x3C
  91:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** #define SERIAL_8O2 0x3E
  92:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
  93:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** class HardwareSerial : public Stream
  94:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** {
  95:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   protected:
  96:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile uint8_t * const _ubrrh;
  97:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile uint8_t * const _ubrrl;
  98:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile uint8_t * const _ucsra;
  99:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile uint8_t * const _ucsrb;
 100:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile uint8_t * const _ucsrc;
 101:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile uint8_t * const _udr;
 102:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     // Has any byte been written to the UART since begin()
 103:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     bool _written;
 104:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
 105:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile rx_buffer_index_t _rx_buffer_head;
 106:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile rx_buffer_index_t _rx_buffer_tail;
 107:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile tx_buffer_index_t _tx_buffer_head;
 108:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     volatile tx_buffer_index_t _tx_buffer_tail;
 109:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
 110:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     // Don't put any members after these buffers, since only the first
 111:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     // 32 bytes of this struct can be accessed quickly using the ldd
 112:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     // instruction.
 113:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     unsigned char _rx_buffer[SERIAL_RX_BUFFER_SIZE];
 114:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     unsigned char _tx_buffer[SERIAL_TX_BUFFER_SIZE];
 115:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h **** 
 116:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****   public:
 117:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     inline HardwareSerial(
 118:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****       volatile uint8_t *ubrrh, volatile uint8_t *ubrrl,
 119:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****       volatile uint8_t *ucsra, volatile uint8_t *ucsrb,
 120:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****       volatile uint8_t *ucsrc, volatile uint8_t *udr);
 121:/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/HardwareSerial.h ****     void begin(unsigned long baud) { begin(baud, SERIAL_8N1); }
 170               		.loc 2 121 0
 171 0002 26E0      		ldi r18,lo8(6)
 172 0004 40E0      		ldi r20,0
 173 0006 52EC      		ldi r21,lo8(-62)
 174 0008 61E0      		ldi r22,lo8(1)
 175 000a 70E0      		ldi r23,0
 176 000c 80E0      		ldi r24,lo8(Serial)
 177 000e 90E0      		ldi r25,hi8(Serial)
 178 0010 0E94 0000 		call _ZN14HardwareSerial5beginEmh
 179               	.LVL1:
 180               	.LBE10:
 181               	.LBE9:
 268:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   Serial.begin(115200);
GAS LISTING /tmp/ccNcTpZI.s 			page 11


 269:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   while (!Serial);
 270:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 271:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   TCCR1A = 128+32+8+1; // A,B,C normal + 01 - WGM1,WGM0 "1mode:PhaseCorrectPWM255"
 182               		.loc 1 271 0
 183 0014 89EA      		ldi r24,lo8(-87)
 184 0016 8093 8000 		sts 128,r24
 272:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   TCCR1B = 0+2;        // WGM3,WGM2=01-"5mode:FastPWM255", Prescaler:1=16Mhz, 2=2Mhz 
 185               		.loc 1 272 0
 186 001a 82E0      		ldi r24,lo8(2)
 187 001c 8093 8100 		sts 129,r24
 273:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   OCR1A = 192;
 188               		.loc 1 273 0
 189 0020 80EC      		ldi r24,lo8(-64)
 190 0022 90E0      		ldi r25,0
 191 0024 9093 8900 		sts 136+1,r25
 192 0028 8093 8800 		sts 136,r24
 274:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   OCR1B = 128;
 193               		.loc 1 274 0
 194 002c 80E8      		ldi r24,lo8(-128)
 195 002e 90E0      		ldi r25,0
 196 0030 9093 8B00 		sts 138+1,r25
 197 0034 8093 8A00 		sts 138,r24
 275:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   OCR1C = 64;
 198               		.loc 1 275 0
 199 0038 80E4      		ldi r24,lo8(64)
 200 003a 90E0      		ldi r25,0
 201 003c 9093 8D00 		sts 140+1,r25
 202 0040 8093 8C00 		sts 140,r24
 276:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   DDRB = _BV(5)|_BV(6)|_BV(7);   // T1 A,B,C for ATmega128a,ATmega2560
 203               		.loc 1 276 0
 204 0044 80EE      		ldi r24,lo8(-32)
 205 0046 84B9      		out 0x4,r24
 277:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 278:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** //  Serial.print("ADIF="); Serial.println(ADCSRA&(1<<ADIF), DEC);
 279:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   ADMUX = 64|32; // src=+5v + ADLAR<-left
 206               		.loc 1 279 0
 207 0048 80E6      		ldi r24,lo8(96)
 208 004a 8093 7C00 		sts 124,r24
 280:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   DIDR0 = 1;
 209               		.loc 1 280 0
 210 004e 81E0      		ldi r24,lo8(1)
 211 0050 8093 7E00 		sts 126,r24
 281:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   ADCSRB = TRIG_ROUND;
 212               		.loc 1 281 0
 213 0054 1092 7B00 		sts 123,__zero_reg__
 282:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   ADCSRA = (1<<ADEN) | (1<<ADSC) | (1<<ADATE) | 1; // 1:2 = 8Mhz
 214               		.loc 1 282 0
 215 0058 81EE      		ldi r24,lo8(-31)
 216 005a 8093 7A00 		sts 122,r24
 217               	.L3:
 283:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** //  ADCSRA = (1<<ADEN) | (1<<ADSC) | (1<<ADFR) | 1; // 1:2 = 8Mhz
 284:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 285:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcRead1(adcBuffer[0]);
 218               		.loc 1 285 0 discriminator 1
 219 005e 8091 7A00 		lds r24,122
 220 0062 84FF      		sbrs r24,4
 221 0064 00C0      		rjmp .L3
GAS LISTING /tmp/ccNcTpZI.s 			page 12


 222               		.loc 1 285 0 is_stmt 0 discriminator 2
 223 0066 8091 7A00 		lds r24,122
 224 006a 8F7E      		andi r24,lo8(-17)
 225 006c 8093 7A00 		sts 122,r24
 226 0070 8091 7900 		lds r24,121
 227 0074 8093 0000 		sts adcBuffer,r24
 286:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** /*  adcRead1(adcBuffer[1]);
 287:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcRead1(adcBuffer[2]);
 288:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcRead1(adcBuffer[3]);
 289:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcRead1(adcBuffer[4]);
 290:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcRead1(adcBuffer[5]);
 291:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcRead1(adcBuffer[6]);
 292:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcRead1(adcBuffer[7]);
 293:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcRead1(adcBuffer[8]);
 294:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcRead1(adcBuffer[9]);
 295:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 296:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   time = micros()-time;
 297:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   Serial.print("time="); Serial.println(time, DEC);
 298:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   Serial.print("ADIF="); Serial.println(ADCSRA&(1<<ADIF), DEC);
 299:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   for(uint8_t i=0; i<10; i++){ Serial.println(adcBuffer[i], DEC);}
 300:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** */
 301:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcMaxChannels = 2;
 228               		.loc 1 301 0 is_stmt 1 discriminator 2
 229 0078 82E0      		ldi r24,lo8(2)
 230 007a 8093 0000 		sts adcMaxChannels,r24
 302:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcMaxSamples = 1;
 231               		.loc 1 302 0 discriminator 2
 232 007e 81E0      		ldi r24,lo8(1)
 233 0080 8093 0000 		sts adcMaxSamples,r24
 303:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcLevel = 64;
 234               		.loc 1 303 0 discriminator 2
 235 0084 80E4      		ldi r24,lo8(64)
 236 0086 8093 0000 		sts adcLevel,r24
 304:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcChannels[0].mux = 64|32|0; // +5v, ADCH, pin A0
 237               		.loc 1 304 0 discriminator 2
 238 008a 80E6      		ldi r24,lo8(96)
 239 008c 8093 0000 		sts adcChannels,r24
 305:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcChannels[0].mux = 64|32|2; // +5v, ADCH, pin A0
 240               		.loc 1 305 0 discriminator 2
 241 0090 82E6      		ldi r24,lo8(98)
 242 0092 8093 0000 		sts adcChannels,r24
 243 0096 0895      		ret
 244               	.LBE8:
 245               		.cfi_endproc
 246               	.LFE111:
 247               		.size	setup, .-setup
 248               		.section	.rodata.str1.1,"aMS",@progbits,1
 249               	.LC0:
 250 0000 7469 6D65 		.string	"time="
 250      3D00 
 251               		.section	.text.loop,"ax",@progbits
 252               	.global	loop
 253               		.type	loop, @function
 254               	loop:
 255               	.LFB112:
 306:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 307:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** //  Serial.println("ASCII Table ~ Character Map");
GAS LISTING /tmp/ccNcTpZI.s 			page 13


 308:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** }
 309:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 310:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** void loop() {
 256               		.loc 1 310 0
 257               		.cfi_startproc
 258 0000 8F92      		push r8
 259               	.LCFI0:
 260               		.cfi_def_cfa_offset 4
 261               		.cfi_offset 8, -3
 262 0002 9F92      		push r9
 263               	.LCFI1:
 264               		.cfi_def_cfa_offset 5
 265               		.cfi_offset 9, -4
 266 0004 AF92      		push r10
 267               	.LCFI2:
 268               		.cfi_def_cfa_offset 6
 269               		.cfi_offset 10, -5
 270 0006 BF92      		push r11
 271               	.LCFI3:
 272               		.cfi_def_cfa_offset 7
 273               		.cfi_offset 11, -6
 274 0008 CF92      		push r12
 275               	.LCFI4:
 276               		.cfi_def_cfa_offset 8
 277               		.cfi_offset 12, -7
 278 000a DF92      		push r13
 279               	.LCFI5:
 280               		.cfi_def_cfa_offset 9
 281               		.cfi_offset 13, -8
 282 000c EF92      		push r14
 283               	.LCFI6:
 284               		.cfi_def_cfa_offset 10
 285               		.cfi_offset 14, -9
 286 000e FF92      		push r15
 287               	.LCFI7:
 288               		.cfi_def_cfa_offset 11
 289               		.cfi_offset 15, -10
 290 0010 0F93      		push r16
 291               	.LCFI8:
 292               		.cfi_def_cfa_offset 12
 293               		.cfi_offset 16, -11
 294 0012 1F93      		push r17
 295               	.LCFI9:
 296               		.cfi_def_cfa_offset 13
 297               		.cfi_offset 17, -12
 298 0014 CF93      		push r28
 299               	.LCFI10:
 300               		.cfi_def_cfa_offset 14
 301               		.cfi_offset 28, -13
 302 0016 DF93      		push r29
 303               	.LCFI11:
 304               		.cfi_def_cfa_offset 15
 305               		.cfi_offset 29, -14
 306               	/* prologue: function */
 307               	/* frame size = 0 */
 308               	/* stack size = 12 */
 309               	.L__stack_usage = 12
GAS LISTING /tmp/ccNcTpZI.s 			page 14


 310               	.LBB11:
 311:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   int i,j;
 312:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   unsigned long time;
 313:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** //  uint8_t * ptrRes;
 314:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   uint8_t * ptrBuf;
 315:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 316:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   time = micros();
 311               		.loc 1 316 0
 312 0018 0E94 0000 		call micros
 313               	.LVL2:
 314 001c 4B01      		movw r8,r22
 315 001e 5C01      		movw r10,r24
 316               	.LVL3:
 317:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   adcMeasure();
 317               		.loc 1 317 0
 318 0020 0E94 0000 		call adcMeasure
 319               	.LVL4:
 318:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   time = micros()-time;
 320               		.loc 1 318 0
 321 0024 0E94 0000 		call micros
 322               	.LVL5:
 323 0028 6B01      		movw r12,r22
 324 002a 7C01      		movw r14,r24
 325 002c C818      		sub r12,r8
 326 002e D908      		sbc r13,r9
 327 0030 EA08      		sbc r14,r10
 328 0032 FB08      		sbc r15,r11
 329               	.LVL6:
 319:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   Serial.print("time="); Serial.println(time, DEC);
 330               		.loc 1 319 0
 331 0034 60E0      		ldi r22,lo8(.LC0)
 332 0036 70E0      		ldi r23,hi8(.LC0)
 333 0038 80E0      		ldi r24,lo8(Serial)
 334 003a 90E0      		ldi r25,hi8(Serial)
 335 003c 0E94 0000 		call _ZN5Print5printEPKc
 336               	.LVL7:
 337 0040 2AE0      		ldi r18,lo8(10)
 338 0042 30E0      		ldi r19,0
 339 0044 B701      		movw r22,r14
 340 0046 A601      		movw r20,r12
 341 0048 80E0      		ldi r24,lo8(Serial)
 342 004a 90E0      		ldi r25,hi8(Serial)
 343 004c 0E94 0000 		call _ZN5Print7printlnEmi
 344               	.LVL8:
 345               	.LBB12:
 320:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** /*
 321:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   ptrRes = resBuffer;
 322:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   ptrBuf = adcBuffer;
 323:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   for(i=0; i<adcSampleLength; i++){
 324:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     for(j=0; j<adcMaxChannels; j++){
 325:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       *ptrRes++ = *ptrBuf++;
 326:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     }
 327:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   }
 328:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** */
 329:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** //  Serial.print("Hello!");
 330:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   ptrBuf = (uint8_t *)adcBuffer;
 331:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   for(int j=0; j<adcMaxSamples; j++){
GAS LISTING /tmp/ccNcTpZI.s 			page 15


 346               		.loc 1 331 0
 347 0050 00E0      		ldi r16,0
 348 0052 10E0      		ldi r17,0
 349               	.LVL9:
 350               	.L8:
 351               		.loc 1 331 0 is_stmt 0 discriminator 1
 352 0054 8091 0000 		lds r24,adcMaxSamples
 353 0058 90E0      		ldi r25,0
 354 005a 0817      		cp r16,r24
 355 005c 1907      		cpc r17,r25
 356 005e 04F0      		brlt .+2
 357 0060 00C0      		rjmp .L14
 358               	.LBB13:
 332:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     Serial.println(adcLevel, DEC);
 359               		.loc 1 332 0 is_stmt 1
 360 0062 6091 0000 		lds r22,adcLevel
 361 0066 4AE0      		ldi r20,lo8(10)
 362 0068 50E0      		ldi r21,0
 363 006a 80E0      		ldi r24,lo8(Serial)
 364 006c 90E0      		ldi r25,hi8(Serial)
 365 006e 0E94 0000 		call _ZN5Print7printlnEhi
 366               	.LVL10:
 333:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     Serial.println(adcLevel, DEC);
 367               		.loc 1 333 0
 368 0072 6091 0000 		lds r22,adcLevel
 369 0076 4AE0      		ldi r20,lo8(10)
 370 0078 50E0      		ldi r21,0
 371 007a 80E0      		ldi r24,lo8(Serial)
 372 007c 90E0      		ldi r25,hi8(Serial)
 373 007e 0E94 0000 		call _ZN5Print7printlnEhi
 374               	.LVL11:
 334:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     Serial.println(adcLevel, DEC);
 375               		.loc 1 334 0
 376 0082 6091 0000 		lds r22,adcLevel
 377 0086 4AE0      		ldi r20,lo8(10)
 378 0088 50E0      		ldi r21,0
 379 008a 80E0      		ldi r24,lo8(Serial)
 380 008c 90E0      		ldi r25,hi8(Serial)
 381 008e 0E94 0000 		call _ZN5Print7printlnEhi
 382               	.LVL12:
 383               	.LBB14:
 335:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     for(int k=0; k<adcMaxChannels; k++){
 384               		.loc 1 335 0
 385 0092 E12C      		mov r14,__zero_reg__
 386 0094 F12C      		mov r15,__zero_reg__
 387               	.LVL13:
 388               	.L9:
 389               		.loc 1 335 0 is_stmt 0 discriminator 1
 390 0096 8091 0000 		lds r24,adcMaxChannels
 391 009a 90E0      		ldi r25,0
 392               	.LBB15:
 336:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       Serial.println(adcLevel, DEC);
 393               		.loc 1 336 0 is_stmt 1 discriminator 1
 394 009c 6091 0000 		lds r22,adcLevel
 395 00a0 4AE0      		ldi r20,lo8(10)
 396 00a2 50E0      		ldi r21,0
 397               	.LBE15:
GAS LISTING /tmp/ccNcTpZI.s 			page 16


 335:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     for(int k=0; k<adcMaxChannels; k++){
 398               		.loc 1 335 0 discriminator 1
 399 00a4 E816      		cp r14,r24
 400 00a6 F906      		cpc r15,r25
 401 00a8 04F0      		brlt .+2
 402 00aa 00C0      		rjmp .L15
 403               	.LBB17:
 404               		.loc 1 336 0
 405 00ac 80E0      		ldi r24,lo8(Serial)
 406 00ae 90E0      		ldi r25,hi8(Serial)
 407 00b0 0E94 0000 		call _ZN5Print7printlnEhi
 408               	.LVL14:
 337:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       Serial.println(adcLevel, DEC);
 409               		.loc 1 337 0
 410 00b4 6091 0000 		lds r22,adcLevel
 411 00b8 4AE0      		ldi r20,lo8(10)
 412 00ba 50E0      		ldi r21,0
 413 00bc 80E0      		ldi r24,lo8(Serial)
 414 00be 90E0      		ldi r25,hi8(Serial)
 415 00c0 0E94 0000 		call _ZN5Print7printlnEhi
 416               	.LVL15:
 338:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       Serial.println(adcLevel, DEC);
 417               		.loc 1 338 0
 418 00c4 6091 0000 		lds r22,adcLevel
 419 00c8 4AE0      		ldi r20,lo8(10)
 420 00ca 50E0      		ldi r21,0
 421 00cc 80E0      		ldi r24,lo8(Serial)
 422 00ce 90E0      		ldi r25,hi8(Serial)
 423 00d0 0E94 0000 		call _ZN5Print7printlnEhi
 424               	.LVL16:
 339:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       ptrBuf = (uint8_t *)adcBuffer + k + j*adcSampleLength;
 425               		.loc 1 339 0
 426 00d4 8091 0000 		lds r24,adcSampleLength
 427 00d8 9091 0000 		lds r25,adcSampleLength+1
 428 00dc 089F      		mul r16,r24
 429 00de E001      		movw r28,r0
 430 00e0 099F      		mul r16,r25
 431 00e2 D00D      		add r29,r0
 432 00e4 189F      		mul r17,r24
 433 00e6 D00D      		add r29,r0
 434 00e8 1124      		clr r1
 435 00ea CE0D      		add r28,r14
 436 00ec DF1D      		adc r29,r15
 437 00ee C050      		subi r28,lo8(-(adcBuffer))
 438 00f0 D040      		sbci r29,hi8(-(adcBuffer))
 439               	.LVL17:
 440               	.LBB16:
 340:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       for(int i=0; i<adcSampleLength; i++){
 441               		.loc 1 340 0
 442 00f2 C12C      		mov r12,__zero_reg__
 443 00f4 D12C      		mov r13,__zero_reg__
 444               	.LVL18:
 445               	.L10:
 446               		.loc 1 340 0 is_stmt 0 discriminator 1
 447 00f6 8091 0000 		lds r24,adcSampleLength
 448 00fa 9091 0000 		lds r25,adcSampleLength+1
 449 00fe C816      		cp r12,r24
GAS LISTING /tmp/ccNcTpZI.s 			page 17


 450 0100 D906      		cpc r13,r25
 451 0102 00F4      		brsh .L16
 341:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         Serial.println( *ptrBuf, DEC);
 452               		.loc 1 341 0 is_stmt 1 discriminator 3
 453 0104 4AE0      		ldi r20,lo8(10)
 454 0106 50E0      		ldi r21,0
 455 0108 6881      		ld r22,Y
 456 010a 80E0      		ldi r24,lo8(Serial)
 457 010c 90E0      		ldi r25,hi8(Serial)
 458 010e 0E94 0000 		call _ZN5Print7printlnEhi
 459               	.LVL19:
 342:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****         ptrBuf += adcMaxChannels;
 460               		.loc 1 342 0 discriminator 3
 461 0112 8091 0000 		lds r24,adcMaxChannels
 462 0116 C80F      		add r28,r24
 463 0118 D11D      		adc r29,__zero_reg__
 464               	.LVL20:
 340:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       for(int i=0; i<adcSampleLength; i++){
 465               		.loc 1 340 0 discriminator 3
 466 011a 8FEF      		ldi r24,-1
 467 011c C81A      		sub r12,r24
 468 011e D80A      		sbc r13,r24
 469               	.LVL21:
 470 0120 00C0      		rjmp .L10
 471               	.L16:
 472               	.LBE16:
 343:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       }
 344:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       Serial.println(adcLevel, DEC);
 473               		.loc 1 344 0 discriminator 2
 474 0122 6091 0000 		lds r22,adcLevel
 475 0126 4AE0      		ldi r20,lo8(10)
 476 0128 50E0      		ldi r21,0
 477 012a 80E0      		ldi r24,lo8(Serial)
 478 012c 90E0      		ldi r25,hi8(Serial)
 479 012e 0E94 0000 		call _ZN5Print7printlnEhi
 480               	.LVL22:
 345:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       Serial.println(adcLevel, DEC);
 481               		.loc 1 345 0 discriminator 2
 482 0132 6091 0000 		lds r22,adcLevel
 483 0136 4AE0      		ldi r20,lo8(10)
 484 0138 50E0      		ldi r21,0
 485 013a 80E0      		ldi r24,lo8(Serial)
 486 013c 90E0      		ldi r25,hi8(Serial)
 487 013e 0E94 0000 		call _ZN5Print7printlnEhi
 488               	.LVL23:
 346:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       Serial.println(adcLevel, DEC);
 489               		.loc 1 346 0 discriminator 2
 490 0142 6091 0000 		lds r22,adcLevel
 491 0146 4AE0      		ldi r20,lo8(10)
 492 0148 50E0      		ldi r21,0
 493 014a 80E0      		ldi r24,lo8(Serial)
 494 014c 90E0      		ldi r25,hi8(Serial)
 495 014e 0E94 0000 		call _ZN5Print7printlnEhi
 496               	.LVL24:
 497               	.LBE17:
 335:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****       Serial.println(adcLevel, DEC);
 498               		.loc 1 335 0 discriminator 2
GAS LISTING /tmp/ccNcTpZI.s 			page 18


 499 0152 8FEF      		ldi r24,-1
 500 0154 E81A      		sub r14,r24
 501 0156 F80A      		sbc r15,r24
 502               	.LVL25:
 503 0158 00C0      		rjmp .L9
 504               	.LVL26:
 505               	.L15:
 506               	.LBE14:
 347:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     }
 348:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     Serial.println(adcLevel, DEC);
 507               		.loc 1 348 0 discriminator 2
 508 015a 80E0      		ldi r24,lo8(Serial)
 509 015c 90E0      		ldi r25,hi8(Serial)
 510 015e 0E94 0000 		call _ZN5Print7printlnEhi
 511               	.LVL27:
 349:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     Serial.println(adcLevel, DEC);
 512               		.loc 1 349 0 discriminator 2
 513 0162 6091 0000 		lds r22,adcLevel
 514 0166 4AE0      		ldi r20,lo8(10)
 515 0168 50E0      		ldi r21,0
 516 016a 80E0      		ldi r24,lo8(Serial)
 517 016c 90E0      		ldi r25,hi8(Serial)
 518 016e 0E94 0000 		call _ZN5Print7printlnEhi
 519               	.LVL28:
 350:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     Serial.println(adcLevel, DEC);
 520               		.loc 1 350 0 discriminator 2
 521 0172 6091 0000 		lds r22,adcLevel
 522 0176 4AE0      		ldi r20,lo8(10)
 523 0178 50E0      		ldi r21,0
 524 017a 80E0      		ldi r24,lo8(Serial)
 525 017c 90E0      		ldi r25,hi8(Serial)
 526 017e 0E94 0000 		call _ZN5Print7printlnEhi
 527               	.LVL29:
 528               	.LBE13:
 331:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****     Serial.println(adcLevel, DEC);
 529               		.loc 1 331 0 discriminator 2
 530 0182 0F5F      		subi r16,-1
 531 0184 1F4F      		sbci r17,-1
 532               	.LVL30:
 533 0186 00C0      		rjmp .L8
 534               	.LVL31:
 535               	.L14:
 536               	.LBE12:
 351:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   }
 352:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino ****   delay(1000);
 537               		.loc 1 352 0
 538 0188 68EE      		ldi r22,lo8(-24)
 539 018a 73E0      		ldi r23,lo8(3)
 540 018c 80E0      		ldi r24,0
 541 018e 90E0      		ldi r25,0
 542               	/* epilogue start */
 543               	.LBE11:
 353:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 354:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** }
 544               		.loc 1 354 0
 545 0190 DF91      		pop r29
 546 0192 CF91      		pop r28
GAS LISTING /tmp/ccNcTpZI.s 			page 19


 547 0194 1F91      		pop r17
 548 0196 0F91      		pop r16
 549               	.LVL32:
 550 0198 FF90      		pop r15
 551 019a EF90      		pop r14
 552 019c DF90      		pop r13
 553 019e CF90      		pop r12
 554 01a0 BF90      		pop r11
 555 01a2 AF90      		pop r10
 556 01a4 9F90      		pop r9
 557 01a6 8F90      		pop r8
 558               	.LBB18:
 352:/home/arhat109/Arduino/Osciloscope/Osciloscope.ino **** 
 559               		.loc 1 352 0
 560 01a8 0C94 0000 		jmp delay
 561               	.LVL33:
 562               	.LBE18:
 563               		.cfi_endproc
 564               	.LFE112:
 565               		.size	loop, .-loop
 566               	.global	resBuffer
 567               		.section	.bss.resBuffer,"aw",@nobits
 568               		.type	resBuffer, @object
 569               		.size	resBuffer, 256
 570               	resBuffer:
 571 0000 0000 0000 		.zero	256
 571      0000 0000 
 571      0000 0000 
 571      0000 0000 
 571      0000 0000 
 572               	.global	adcShift
 573               		.section	.bss.adcShift,"aw",@nobits
 574               		.type	adcShift, @object
 575               		.size	adcShift, 1
 576               	adcShift:
 577 0000 00        		.zero	1
 578               	.global	adcSign
 579               		.section	.bss.adcSign,"aw",@nobits
 580               		.type	adcSign, @object
 581               		.size	adcSign, 1
 582               	adcSign:
 583 0000 00        		.zero	1
 584               	.global	adcLevel
 585               		.section	.data.adcLevel,"aw",@progbits
 586               		.type	adcLevel, @object
 587               		.size	adcLevel, 1
 588               	adcLevel:
 589 0000 20        		.byte	32
 590               	.global	adcMaxChannels
 591               		.section	.data.adcMaxChannels,"aw",@progbits
 592               		.type	adcMaxChannels, @object
 593               		.size	adcMaxChannels, 1
 594               	adcMaxChannels:
 595 0000 01        		.byte	1
 596               	.global	adcChannels
 597               		.section	.bss.adcChannels,"aw",@nobits
 598               		.type	adcChannels, @object
GAS LISTING /tmp/ccNcTpZI.s 			page 20


 599               		.size	adcChannels, 3
 600               	adcChannels:
 601 0000 0000 00   		.zero	3
 602               	.global	adcSampleLength
 603               		.section	.data.adcSampleLength,"aw",@progbits
 604               		.type	adcSampleLength, @object
 605               		.size	adcSampleLength, 2
 606               	adcSampleLength:
 607 0000 0001      		.word	256
 608               	.global	adcMaxSamples
 609               		.section	.data.adcMaxSamples,"aw",@progbits
 610               		.type	adcMaxSamples, @object
 611               		.size	adcMaxSamples, 1
 612               	adcMaxSamples:
 613 0000 04        		.byte	4
 614               	.global	adcBuffer
 615               		.section	.bss.adcBuffer,"aw",@nobits
 616               		.type	adcBuffer, @object
 617               		.size	adcBuffer, 1024
 618               	adcBuffer:
 619 0000 0000 0000 		.zero	1024
 619      0000 0000 
 619      0000 0000 
 619      0000 0000 
 619      0000 0000 
 620               		.text
 621               	.Letext0:
 622               		.file 3 "/home/arhat109/progs/arduino-1.8.2/hardware/tools/avr/lib/gcc/avr/4.9.2/include/stddef.h"
 623               		.file 4 "/home/arhat109/progs/arduino-1.8.2/hardware/tools/avr/avr/include/stdint.h"
 624               		.file 5 "/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/Print.h"
 625               		.file 6 "/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/variants/mega/pins_arduino.h"
 626               		.file 7 "/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/Stream.h"
 627               		.file 8 "/home/arhat109/progs/arduino-1.8.2/hardware/arduino/avr/cores/arduino/Arduino.h"
 628               		.section	.debug_info,"",@progbits
 629               	.Ldebug_info0:
 630 0000 CB07 0000 		.long	0x7cb
 631 0004 0200      		.word	0x2
 632 0006 0000 0000 		.long	.Ldebug_abbrev0
 633 000a 04        		.byte	0x4
 634 000b 01        		.uleb128 0x1
 635 000c 0000 0000 		.long	.LASF64
 636 0010 04        		.byte	0x4
 637 0011 0000 0000 		.long	.LASF65
 638 0015 0000 0000 		.long	.LASF66
 639 0019 0000 0000 		.long	.Ldebug_ranges0+0x18
 640 001d 0000 0000 		.long	0
 641 0021 0000 0000 		.long	0
 642 0025 0000 0000 		.long	.Ldebug_line0
 643 0029 02        		.uleb128 0x2
 644 002a 0000 0000 		.long	.LASF3
 645 002e 03        		.byte	0x3
 646 002f D4        		.byte	0xd4
 647 0030 3400 0000 		.long	0x34
 648 0034 03        		.uleb128 0x3
 649 0035 02        		.byte	0x2
 650 0036 07        		.byte	0x7
 651 0037 0000 0000 		.long	.LASF0
GAS LISTING /tmp/ccNcTpZI.s 			page 21


 652 003b 04        		.uleb128 0x4
 653 003c 02        		.byte	0x2
 654 003d 05        		.byte	0x5
 655 003e 696E 7400 		.string	"int"
 656 0042 03        		.uleb128 0x3
 657 0043 04        		.byte	0x4
 658 0044 05        		.byte	0x5
 659 0045 0000 0000 		.long	.LASF1
 660 0049 03        		.uleb128 0x3
 661 004a 01        		.byte	0x1
 662 004b 06        		.byte	0x6
 663 004c 0000 0000 		.long	.LASF2
 664 0050 02        		.uleb128 0x2
 665 0051 0000 0000 		.long	.LASF4
 666 0055 04        		.byte	0x4
 667 0056 7E        		.byte	0x7e
 668 0057 5B00 0000 		.long	0x5b
 669 005b 03        		.uleb128 0x3
 670 005c 01        		.byte	0x1
 671 005d 08        		.byte	0x8
 672 005e 0000 0000 		.long	.LASF5
 673 0062 02        		.uleb128 0x2
 674 0063 0000 0000 		.long	.LASF6
 675 0067 04        		.byte	0x4
 676 0068 80        		.byte	0x80
 677 0069 3400 0000 		.long	0x34
 678 006d 03        		.uleb128 0x3
 679 006e 04        		.byte	0x4
 680 006f 07        		.byte	0x7
 681 0070 0000 0000 		.long	.LASF7
 682 0074 03        		.uleb128 0x3
 683 0075 08        		.byte	0x8
 684 0076 05        		.byte	0x5
 685 0077 0000 0000 		.long	.LASF8
 686 007b 03        		.uleb128 0x3
 687 007c 08        		.byte	0x8
 688 007d 07        		.byte	0x7
 689 007e 0000 0000 		.long	.LASF9
 690 0082 03        		.uleb128 0x3
 691 0083 01        		.byte	0x1
 692 0084 02        		.byte	0x2
 693 0085 0000 0000 		.long	.LASF10
 694 0089 03        		.uleb128 0x3
 695 008a 01        		.byte	0x1
 696 008b 06        		.byte	0x6
 697 008c 0000 0000 		.long	.LASF11
 698 0090 05        		.uleb128 0x5
 699 0091 02        		.byte	0x2
 700 0092 9600 0000 		.long	0x96
 701 0096 06        		.uleb128 0x6
 702 0097 8900 0000 		.long	0x89
 703 009b 03        		.uleb128 0x3
 704 009c 04        		.byte	0x4
 705 009d 04        		.byte	0x4
 706 009e 0000 0000 		.long	.LASF12
 707 00a2 03        		.uleb128 0x3
 708 00a3 04        		.byte	0x4
GAS LISTING /tmp/ccNcTpZI.s 			page 22


 709 00a4 04        		.byte	0x4
 710 00a5 0000 0000 		.long	.LASF13
 711 00a9 07        		.uleb128 0x7
 712 00aa 0000 0000 		.long	.LASF67
 713 00ae 02        		.byte	0x2
 714 00af 07        		.byte	0x7
 715 00b0 29        		.byte	0x29
 716 00b1 C800 0000 		.long	0xc8
 717 00b5 08        		.uleb128 0x8
 718 00b6 0000 0000 		.long	.LASF14
 719 00ba 00        		.sleb128 0
 720 00bb 08        		.uleb128 0x8
 721 00bc 0000 0000 		.long	.LASF15
 722 00c0 01        		.sleb128 1
 723 00c1 08        		.uleb128 0x8
 724 00c2 0000 0000 		.long	.LASF16
 725 00c6 02        		.sleb128 2
 726 00c7 00        		.byte	0
 727 00c8 09        		.uleb128 0x9
 728 00c9 0000 0000 		.long	.LASF17
 729 00cd 01        		.byte	0x1
 730 00ce 3D01 0000 		.long	0x13d
 731 00d2 0A        		.uleb128 0xa
 732 00d3 02        		.byte	0x2
 733 00d4 5D        		.byte	0x5d
 734 00d5 4701 0000 		.long	0x147
 735 00d9 0B        		.uleb128 0xb
 736 00da 01        		.byte	0x1
 737 00db 0000 0000 		.long	.LASF19
 738 00df 02        		.byte	0x2
 739 00e0 87        		.byte	0x87
 740 00e1 0000 0000 		.long	.LASF21
 741 00e5 8200 0000 		.long	0x82
 742 00e9 01        		.byte	0x1
 743 00ea F200 0000 		.long	0xf2
 744 00ee F900 0000 		.long	0xf9
 745 00f2 0C        		.uleb128 0xc
 746 00f3 9602 0000 		.long	0x296
 747 00f7 01        		.byte	0x1
 748 00f8 00        		.byte	0
 749 00f9 0D        		.uleb128 0xd
 750 00fa 01        		.byte	0x1
 751 00fb 0000 0000 		.long	.LASF27
 752 00ff 02        		.byte	0x2
 753 0100 79        		.byte	0x79
 754 0101 0000 0000 		.long	.LASF28
 755 0105 01        		.byte	0x1
 756 0106 0E01 0000 		.long	0x10e
 757 010a 1A01 0000 		.long	0x11a
 758 010e 0C        		.uleb128 0xc
 759 010f 9602 0000 		.long	0x296
 760 0113 01        		.byte	0x1
 761 0114 0E        		.uleb128 0xe
 762 0115 6D00 0000 		.long	0x6d
 763 0119 00        		.byte	0
 764 011a 0F        		.uleb128 0xf
 765 011b 01        		.byte	0x1
GAS LISTING /tmp/ccNcTpZI.s 			page 23


 766 011c 0000 0000 		.long	.LASF27
 767 0120 02        		.byte	0x2
 768 0121 7A        		.byte	0x7a
 769 0122 0000 0000 		.long	.LASF68
 770 0126 01        		.byte	0x1
 771 0127 2B01 0000 		.long	0x12b
 772 012b 0C        		.uleb128 0xc
 773 012c 9602 0000 		.long	0x296
 774 0130 01        		.byte	0x1
 775 0131 0E        		.uleb128 0xe
 776 0132 6D00 0000 		.long	0x6d
 777 0136 0E        		.uleb128 0xe
 778 0137 5000 0000 		.long	0x50
 779 013b 00        		.byte	0
 780 013c 00        		.byte	0
 781 013d 09        		.uleb128 0x9
 782 013e 0000 0000 		.long	.LASF18
 783 0142 01        		.byte	0x1
 784 0143 E701 0000 		.long	0x1e7
 785 0147 0B        		.uleb128 0xb
 786 0148 01        		.byte	0x1
 787 0149 0000 0000 		.long	.LASF20
 788 014d 05        		.byte	0x5
 789 014e 39        		.byte	0x39
 790 014f 0000 0000 		.long	.LASF22
 791 0153 2900 0000 		.long	0x29
 792 0157 01        		.byte	0x1
 793 0158 6001 0000 		.long	0x160
 794 015c 7101 0000 		.long	0x171
 795 0160 0C        		.uleb128 0xc
 796 0161 E701 0000 		.long	0x1e7
 797 0165 01        		.byte	0x1
 798 0166 0E        		.uleb128 0xe
 799 0167 9000 0000 		.long	0x90
 800 016b 0E        		.uleb128 0xe
 801 016c 2900 0000 		.long	0x29
 802 0170 00        		.byte	0
 803 0171 0B        		.uleb128 0xb
 804 0172 01        		.byte	0x1
 805 0173 0000 0000 		.long	.LASF23
 806 0177 05        		.byte	0x5
 807 0178 4D        		.byte	0x4d
 808 0179 0000 0000 		.long	.LASF24
 809 017d 2900 0000 		.long	0x29
 810 0181 01        		.byte	0x1
 811 0182 8A01 0000 		.long	0x18a
 812 0186 9B01 0000 		.long	0x19b
 813 018a 0C        		.uleb128 0xc
 814 018b E701 0000 		.long	0x1e7
 815 018f 01        		.byte	0x1
 816 0190 0E        		.uleb128 0xe
 817 0191 5B00 0000 		.long	0x5b
 818 0195 0E        		.uleb128 0xe
 819 0196 3B00 0000 		.long	0x3b
 820 019a 00        		.byte	0
 821 019b 0B        		.uleb128 0xb
 822 019c 01        		.byte	0x1
GAS LISTING /tmp/ccNcTpZI.s 			page 24


 823 019d 0000 0000 		.long	.LASF25
 824 01a1 05        		.byte	0x5
 825 01a2 3F        		.byte	0x3f
 826 01a3 0000 0000 		.long	.LASF26
 827 01a7 2900 0000 		.long	0x29
 828 01ab 01        		.byte	0x1
 829 01ac B401 0000 		.long	0x1b4
 830 01b0 C001 0000 		.long	0x1c0
 831 01b4 0C        		.uleb128 0xc
 832 01b5 E701 0000 		.long	0x1e7
 833 01b9 01        		.byte	0x1
 834 01ba 0E        		.uleb128 0xe
 835 01bb 9000 0000 		.long	0x90
 836 01bf 00        		.byte	0
 837 01c0 10        		.uleb128 0x10
 838 01c1 01        		.byte	0x1
 839 01c2 0000 0000 		.long	.LASF23
 840 01c6 05        		.byte	0x5
 841 01c7 51        		.byte	0x51
 842 01c8 0000 0000 		.long	.LASF29
 843 01cc 2900 0000 		.long	0x29
 844 01d0 01        		.byte	0x1
 845 01d1 D501 0000 		.long	0x1d5
 846 01d5 0C        		.uleb128 0xc
 847 01d6 E701 0000 		.long	0x1e7
 848 01da 01        		.byte	0x1
 849 01db 0E        		.uleb128 0xe
 850 01dc 6D00 0000 		.long	0x6d
 851 01e0 0E        		.uleb128 0xe
 852 01e1 3B00 0000 		.long	0x3b
 853 01e5 00        		.byte	0
 854 01e6 00        		.byte	0
 855 01e7 05        		.uleb128 0x5
 856 01e8 02        		.byte	0x2
 857 01e9 3D01 0000 		.long	0x13d
 858 01ed 03        		.uleb128 0x3
 859 01ee 04        		.byte	0x4
 860 01ef 04        		.byte	0x4
 861 01f0 0000 0000 		.long	.LASF30
 862 01f4 11        		.uleb128 0x11
 863 01f5 0000 0000 		.long	.LASF69
 864 01f9 03        		.uleb128 0x3
 865 01fa 02        		.byte	0x2
 866 01fb 07        		.byte	0x7
 867 01fc 0000 0000 		.long	.LASF31
 868 0200 12        		.uleb128 0x12
 869 0201 02        		.byte	0x2
 870 0202 01        		.byte	0x1
 871 0203 05        		.byte	0x5
 872 0204 0000 0000 		.long	.LASF70
 873 0208 4302 0000 		.long	0x243
 874 020c 08        		.uleb128 0x8
 875 020d 0000 0000 		.long	.LASF32
 876 0211 00        		.sleb128 0
 877 0212 08        		.uleb128 0x8
 878 0213 0000 0000 		.long	.LASF33
 879 0217 01        		.sleb128 1
GAS LISTING /tmp/ccNcTpZI.s 			page 25


 880 0218 08        		.uleb128 0x8
 881 0219 0000 0000 		.long	.LASF34
 882 021d 02        		.sleb128 2
 883 021e 08        		.uleb128 0x8
 884 021f 0000 0000 		.long	.LASF35
 885 0223 03        		.sleb128 3
 886 0224 08        		.uleb128 0x8
 887 0225 0000 0000 		.long	.LASF36
 888 0229 04        		.sleb128 4
 889 022a 08        		.uleb128 0x8
 890 022b 0000 0000 		.long	.LASF37
 891 022f 05        		.sleb128 5
 892 0230 08        		.uleb128 0x8
 893 0231 0000 0000 		.long	.LASF38
 894 0235 06        		.sleb128 6
 895 0236 08        		.uleb128 0x8
 896 0237 0000 0000 		.long	.LASF39
 897 023b 07        		.sleb128 7
 898 023c 08        		.uleb128 0x8
 899 023d 0000 0000 		.long	.LASF40
 900 0241 08        		.sleb128 8
 901 0242 00        		.byte	0
 902 0243 02        		.uleb128 0x2
 903 0244 0000 0000 		.long	.LASF41
 904 0248 01        		.byte	0x1
 905 0249 05        		.byte	0x5
 906 024a 0002 0000 		.long	0x200
 907 024e 13        		.uleb128 0x13
 908 024f 03        		.byte	0x3
 909 0250 01        		.byte	0x1
 910 0251 22        		.byte	0x22
 911 0252 0000 0000 		.long	.LASF71
 912 0256 8502 0000 		.long	0x285
 913 025a 14        		.uleb128 0x14
 914 025b 6D75 7800 		.string	"mux"
 915 025f 01        		.byte	0x1
 916 0260 23        		.byte	0x23
 917 0261 5000 0000 		.long	0x50
 918 0265 02        		.byte	0x2
 919 0266 23        		.byte	0x23
 920 0267 00        		.uleb128 0
 921 0268 15        		.uleb128 0x15
 922 0269 0000 0000 		.long	.LASF42
 923 026d 01        		.byte	0x1
 924 026e 24        		.byte	0x24
 925 026f 5000 0000 		.long	0x50
 926 0273 02        		.byte	0x2
 927 0274 23        		.byte	0x23
 928 0275 01        		.uleb128 0x1
 929 0276 15        		.uleb128 0x15
 930 0277 0000 0000 		.long	.LASF43
 931 027b 01        		.byte	0x1
 932 027c 25        		.byte	0x25
 933 027d 5000 0000 		.long	0x50
 934 0281 02        		.byte	0x2
 935 0282 23        		.byte	0x23
 936 0283 02        		.uleb128 0x2
GAS LISTING /tmp/ccNcTpZI.s 			page 26


 937 0284 00        		.byte	0
 938 0285 02        		.uleb128 0x2
 939 0286 0000 0000 		.long	.LASF44
 940 028a 01        		.byte	0x1
 941 028b 26        		.byte	0x26
 942 028c 4E02 0000 		.long	0x24e
 943 0290 05        		.uleb128 0x5
 944 0291 02        		.byte	0x2
 945 0292 5000 0000 		.long	0x50
 946 0296 05        		.uleb128 0x5
 947 0297 02        		.byte	0x2
 948 0298 C800 0000 		.long	0xc8
 949 029c 16        		.uleb128 0x16
 950 029d D900 0000 		.long	0xd9
 951 02a1 03        		.byte	0x3
 952 02a2 AA02 0000 		.long	0x2aa
 953 02a6 B502 0000 		.long	0x2b5
 954 02aa 17        		.uleb128 0x17
 955 02ab 0000 0000 		.long	.LASF45
 956 02af B502 0000 		.long	0x2b5
 957 02b3 01        		.byte	0x1
 958 02b4 00        		.byte	0
 959 02b5 06        		.uleb128 0x6
 960 02b6 9602 0000 		.long	0x296
 961 02ba 18        		.uleb128 0x18
 962 02bb 01        		.byte	0x1
 963 02bc 0000 0000 		.long	.LASF72
 964 02c0 01        		.byte	0x1
 965 02c1 50        		.byte	0x50
 966 02c2 0000 0000 		.long	.LFB110
 967 02c6 0000 0000 		.long	.LFE110
 968 02ca 03        		.byte	0x3
 969 02cb 92        		.byte	0x92
 970 02cc 20        		.uleb128 0x20
 971 02cd 03        		.sleb128 3
 972 02ce 01        		.byte	0x1
 973 02cf 16        		.uleb128 0x16
 974 02d0 F900 0000 		.long	0xf9
 975 02d4 03        		.byte	0x3
 976 02d5 DD02 0000 		.long	0x2dd
 977 02d9 F302 0000 		.long	0x2f3
 978 02dd 17        		.uleb128 0x17
 979 02de 0000 0000 		.long	.LASF45
 980 02e2 B502 0000 		.long	0x2b5
 981 02e6 01        		.byte	0x1
 982 02e7 19        		.uleb128 0x19
 983 02e8 0000 0000 		.long	.LASF73
 984 02ec 02        		.byte	0x2
 985 02ed 79        		.byte	0x79
 986 02ee 6D00 0000 		.long	0x6d
 987 02f2 00        		.byte	0
 988 02f3 1A        		.uleb128 0x1a
 989 02f4 01        		.byte	0x1
 990 02f5 0000 0000 		.long	.LASF46
 991 02f9 01        		.byte	0x1
 992 02fa 0701      		.word	0x107
 993 02fc 0000 0000 		.long	.LFB111
GAS LISTING /tmp/ccNcTpZI.s 			page 27


 994 0300 0000 0000 		.long	.LFE111
 995 0304 03        		.byte	0x3
 996 0305 92        		.byte	0x92
 997 0306 20        		.uleb128 0x20
 998 0307 03        		.sleb128 3
 999 0308 01        		.byte	0x1
 1000 0309 7103 0000 		.long	0x371
 1001 030d 1B        		.uleb128 0x1b
 1002 030e 0000 0000 		.long	.LBB8
 1003 0312 0000 0000 		.long	.LBE8
 1004 0316 1C        		.uleb128 0x1c
 1005 0317 0000 0000 		.long	.LASF47
 1006 031b 01        		.byte	0x1
 1007 031c 0801      		.word	0x108
 1008 031e 5000 0000 		.long	0x50
 1009 0322 1C        		.uleb128 0x1c
 1010 0323 0000 0000 		.long	.LASF48
 1011 0327 01        		.byte	0x1
 1012 0328 0901      		.word	0x109
 1013 032a 6D00 0000 		.long	0x6d
 1014 032e 1D        		.uleb128 0x1d
 1015 032f CF02 0000 		.long	0x2cf
 1016 0333 0000 0000 		.long	.LBB9
 1017 0337 0000 0000 		.long	.LBE9
 1018 033b 01        		.byte	0x1
 1019 033c 0C01      		.word	0x10c
 1020 033e 1E        		.uleb128 0x1e
 1021 033f E702 0000 		.long	0x2e7
 1022 0343 00C2 0100 		.long	0x1c200
 1023 0347 1F        		.uleb128 0x1f
 1024 0348 DD02 0000 		.long	0x2dd
 1025 034c 20        		.uleb128 0x20
 1026 034d 0000 0000 		.long	.LVL1
 1027 0351 1A01 0000 		.long	0x11a
 1028 0355 21        		.uleb128 0x21
 1029 0356 0C        		.byte	0xc
 1030 0357 64        		.byte	0x64
 1031 0358 93        		.byte	0x93
 1032 0359 01        		.uleb128 0x1
 1033 035a 65        		.byte	0x65
 1034 035b 93        		.byte	0x93
 1035 035c 01        		.uleb128 0x1
 1036 035d 66        		.byte	0x66
 1037 035e 93        		.byte	0x93
 1038 035f 01        		.uleb128 0x1
 1039 0360 67        		.byte	0x67
 1040 0361 93        		.byte	0x93
 1041 0362 01        		.uleb128 0x1
 1042 0363 04        		.byte	0x4
 1043 0364 08        		.byte	0x8
 1044 0365 E1        		.byte	0xe1
 1045 0366 39        		.byte	0x39
 1046 0367 24        		.byte	0x24
 1047 0368 21        		.uleb128 0x21
 1048 0369 01        		.byte	0x1
 1049 036a 62        		.byte	0x62
 1050 036b 01        		.byte	0x1
GAS LISTING /tmp/ccNcTpZI.s 			page 28


 1051 036c 36        		.byte	0x36
 1052 036d 00        		.byte	0
 1053 036e 00        		.byte	0
 1054 036f 00        		.byte	0
 1055 0370 00        		.byte	0
 1056 0371 22        		.uleb128 0x22
 1057 0372 01        		.byte	0x1
 1058 0373 0000 0000 		.long	.LASF49
 1059 0377 01        		.byte	0x1
 1060 0378 3601      		.word	0x136
 1061 037a 0000 0000 		.long	.LFB112
 1062 037e 0000 0000 		.long	.LFE112
 1063 0382 0000 0000 		.long	.LLST0
 1064 0386 01        		.byte	0x1
 1065 0387 B405 0000 		.long	0x5b4
 1066 038b 23        		.uleb128 0x23
 1067 038c 0000 0000 		.long	.Ldebug_ranges0+0
 1068 0390 24        		.uleb128 0x24
 1069 0391 6900      		.string	"i"
 1070 0393 01        		.byte	0x1
 1071 0394 3701      		.word	0x137
 1072 0396 3B00 0000 		.long	0x3b
 1073 039a 24        		.uleb128 0x24
 1074 039b 6A00      		.string	"j"
 1075 039d 01        		.byte	0x1
 1076 039e 3701      		.word	0x137
 1077 03a0 3B00 0000 		.long	0x3b
 1078 03a4 25        		.uleb128 0x25
 1079 03a5 0000 0000 		.long	.LASF48
 1080 03a9 01        		.byte	0x1
 1081 03aa 3801      		.word	0x138
 1082 03ac 6D00 0000 		.long	0x6d
 1083 03b0 0000 0000 		.long	.LLST1
 1084 03b4 25        		.uleb128 0x25
 1085 03b5 0000 0000 		.long	.LASF50
 1086 03b9 01        		.byte	0x1
 1087 03ba 3A01      		.word	0x13a
 1088 03bc 9002 0000 		.long	0x290
 1089 03c0 0000 0000 		.long	.LLST2
 1090 03c4 26        		.uleb128 0x26
 1091 03c5 0000 0000 		.long	.LBB12
 1092 03c9 0000 0000 		.long	.LBE12
 1093 03cd 3505 0000 		.long	0x535
 1094 03d1 27        		.uleb128 0x27
 1095 03d2 6A00      		.string	"j"
 1096 03d4 01        		.byte	0x1
 1097 03d5 4B01      		.word	0x14b
 1098 03d7 3B00 0000 		.long	0x3b
 1099 03db 0000 0000 		.long	.LLST3
 1100 03df 26        		.uleb128 0x26
 1101 03e0 0000 0000 		.long	.LBB14
 1102 03e4 0000 0000 		.long	.LBE14
 1103 03e8 B704 0000 		.long	0x4b7
 1104 03ec 27        		.uleb128 0x27
 1105 03ed 6B00      		.string	"k"
 1106 03ef 01        		.byte	0x1
 1107 03f0 4F01      		.word	0x14f
GAS LISTING /tmp/ccNcTpZI.s 			page 29


 1108 03f2 3B00 0000 		.long	0x3b
 1109 03f6 0000 0000 		.long	.LLST4
 1110 03fa 26        		.uleb128 0x26
 1111 03fb 0000 0000 		.long	.LBB16
 1112 03ff 0000 0000 		.long	.LBE16
 1113 0403 2A04 0000 		.long	0x42a
 1114 0407 27        		.uleb128 0x27
 1115 0408 6900      		.string	"i"
 1116 040a 01        		.byte	0x1
 1117 040b 5401      		.word	0x154
 1118 040d 3B00 0000 		.long	0x3b
 1119 0411 0000 0000 		.long	.LLST5
 1120 0415 20        		.uleb128 0x20
 1121 0416 0000 0000 		.long	.LVL19
 1122 041a 7101 0000 		.long	0x171
 1123 041e 21        		.uleb128 0x21
 1124 041f 06        		.byte	0x6
 1125 0420 64        		.byte	0x64
 1126 0421 93        		.byte	0x93
 1127 0422 01        		.uleb128 0x1
 1128 0423 65        		.byte	0x65
 1129 0424 93        		.byte	0x93
 1130 0425 01        		.uleb128 0x1
 1131 0426 01        		.byte	0x1
 1132 0427 3A        		.byte	0x3a
 1133 0428 00        		.byte	0
 1134 0429 00        		.byte	0
 1135 042a 28        		.uleb128 0x28
 1136 042b 0000 0000 		.long	.LVL14
 1137 042f 7101 0000 		.long	0x171
 1138 0433 4204 0000 		.long	0x442
 1139 0437 21        		.uleb128 0x21
 1140 0438 06        		.byte	0x6
 1141 0439 64        		.byte	0x64
 1142 043a 93        		.byte	0x93
 1143 043b 01        		.uleb128 0x1
 1144 043c 65        		.byte	0x65
 1145 043d 93        		.byte	0x93
 1146 043e 01        		.uleb128 0x1
 1147 043f 01        		.byte	0x1
 1148 0440 3A        		.byte	0x3a
 1149 0441 00        		.byte	0
 1150 0442 28        		.uleb128 0x28
 1151 0443 0000 0000 		.long	.LVL15
 1152 0447 7101 0000 		.long	0x171
 1153 044b 5A04 0000 		.long	0x45a
 1154 044f 21        		.uleb128 0x21
 1155 0450 06        		.byte	0x6
 1156 0451 64        		.byte	0x64
 1157 0452 93        		.byte	0x93
 1158 0453 01        		.uleb128 0x1
 1159 0454 65        		.byte	0x65
 1160 0455 93        		.byte	0x93
 1161 0456 01        		.uleb128 0x1
 1162 0457 01        		.byte	0x1
 1163 0458 3A        		.byte	0x3a
 1164 0459 00        		.byte	0
GAS LISTING /tmp/ccNcTpZI.s 			page 30


 1165 045a 28        		.uleb128 0x28
 1166 045b 0000 0000 		.long	.LVL16
 1167 045f 7101 0000 		.long	0x171
 1168 0463 7204 0000 		.long	0x472
 1169 0467 21        		.uleb128 0x21
 1170 0468 06        		.byte	0x6
 1171 0469 64        		.byte	0x64
 1172 046a 93        		.byte	0x93
 1173 046b 01        		.uleb128 0x1
 1174 046c 65        		.byte	0x65
 1175 046d 93        		.byte	0x93
 1176 046e 01        		.uleb128 0x1
 1177 046f 01        		.byte	0x1
 1178 0470 3A        		.byte	0x3a
 1179 0471 00        		.byte	0
 1180 0472 28        		.uleb128 0x28
 1181 0473 0000 0000 		.long	.LVL22
 1182 0477 7101 0000 		.long	0x171
 1183 047b 8A04 0000 		.long	0x48a
 1184 047f 21        		.uleb128 0x21
 1185 0480 06        		.byte	0x6
 1186 0481 64        		.byte	0x64
 1187 0482 93        		.byte	0x93
 1188 0483 01        		.uleb128 0x1
 1189 0484 65        		.byte	0x65
 1190 0485 93        		.byte	0x93
 1191 0486 01        		.uleb128 0x1
 1192 0487 01        		.byte	0x1
 1193 0488 3A        		.byte	0x3a
 1194 0489 00        		.byte	0
 1195 048a 28        		.uleb128 0x28
 1196 048b 0000 0000 		.long	.LVL23
 1197 048f 7101 0000 		.long	0x171
 1198 0493 A204 0000 		.long	0x4a2
 1199 0497 21        		.uleb128 0x21
 1200 0498 06        		.byte	0x6
 1201 0499 64        		.byte	0x64
 1202 049a 93        		.byte	0x93
 1203 049b 01        		.uleb128 0x1
 1204 049c 65        		.byte	0x65
 1205 049d 93        		.byte	0x93
 1206 049e 01        		.uleb128 0x1
 1207 049f 01        		.byte	0x1
 1208 04a0 3A        		.byte	0x3a
 1209 04a1 00        		.byte	0
 1210 04a2 20        		.uleb128 0x20
 1211 04a3 0000 0000 		.long	.LVL24
 1212 04a7 7101 0000 		.long	0x171
 1213 04ab 21        		.uleb128 0x21
 1214 04ac 06        		.byte	0x6
 1215 04ad 64        		.byte	0x64
 1216 04ae 93        		.byte	0x93
 1217 04af 01        		.uleb128 0x1
 1218 04b0 65        		.byte	0x65
 1219 04b1 93        		.byte	0x93
 1220 04b2 01        		.uleb128 0x1
 1221 04b3 01        		.byte	0x1
GAS LISTING /tmp/ccNcTpZI.s 			page 31


 1222 04b4 3A        		.byte	0x3a
 1223 04b5 00        		.byte	0
 1224 04b6 00        		.byte	0
 1225 04b7 28        		.uleb128 0x28
 1226 04b8 0000 0000 		.long	.LVL10
 1227 04bc 7101 0000 		.long	0x171
 1228 04c0 CF04 0000 		.long	0x4cf
 1229 04c4 21        		.uleb128 0x21
 1230 04c5 06        		.byte	0x6
 1231 04c6 64        		.byte	0x64
 1232 04c7 93        		.byte	0x93
 1233 04c8 01        		.uleb128 0x1
 1234 04c9 65        		.byte	0x65
 1235 04ca 93        		.byte	0x93
 1236 04cb 01        		.uleb128 0x1
 1237 04cc 01        		.byte	0x1
 1238 04cd 3A        		.byte	0x3a
 1239 04ce 00        		.byte	0
 1240 04cf 28        		.uleb128 0x28
 1241 04d0 0000 0000 		.long	.LVL11
 1242 04d4 7101 0000 		.long	0x171
 1243 04d8 E704 0000 		.long	0x4e7
 1244 04dc 21        		.uleb128 0x21
 1245 04dd 06        		.byte	0x6
 1246 04de 64        		.byte	0x64
 1247 04df 93        		.byte	0x93
 1248 04e0 01        		.uleb128 0x1
 1249 04e1 65        		.byte	0x65
 1250 04e2 93        		.byte	0x93
 1251 04e3 01        		.uleb128 0x1
 1252 04e4 01        		.byte	0x1
 1253 04e5 3A        		.byte	0x3a
 1254 04e6 00        		.byte	0
 1255 04e7 28        		.uleb128 0x28
 1256 04e8 0000 0000 		.long	.LVL12
 1257 04ec 7101 0000 		.long	0x171
 1258 04f0 FF04 0000 		.long	0x4ff
 1259 04f4 21        		.uleb128 0x21
 1260 04f5 06        		.byte	0x6
 1261 04f6 64        		.byte	0x64
 1262 04f7 93        		.byte	0x93
 1263 04f8 01        		.uleb128 0x1
 1264 04f9 65        		.byte	0x65
 1265 04fa 93        		.byte	0x93
 1266 04fb 01        		.uleb128 0x1
 1267 04fc 01        		.byte	0x1
 1268 04fd 3A        		.byte	0x3a
 1269 04fe 00        		.byte	0
 1270 04ff 29        		.uleb128 0x29
 1271 0500 0000 0000 		.long	.LVL27
 1272 0504 7101 0000 		.long	0x171
 1273 0508 28        		.uleb128 0x28
 1274 0509 0000 0000 		.long	.LVL28
 1275 050d 7101 0000 		.long	0x171
 1276 0511 2005 0000 		.long	0x520
 1277 0515 21        		.uleb128 0x21
 1278 0516 06        		.byte	0x6
GAS LISTING /tmp/ccNcTpZI.s 			page 32


 1279 0517 64        		.byte	0x64
 1280 0518 93        		.byte	0x93
 1281 0519 01        		.uleb128 0x1
 1282 051a 65        		.byte	0x65
 1283 051b 93        		.byte	0x93
 1284 051c 01        		.uleb128 0x1
 1285 051d 01        		.byte	0x1
 1286 051e 3A        		.byte	0x3a
 1287 051f 00        		.byte	0
 1288 0520 20        		.uleb128 0x20
 1289 0521 0000 0000 		.long	.LVL29
 1290 0525 7101 0000 		.long	0x171
 1291 0529 21        		.uleb128 0x21
 1292 052a 06        		.byte	0x6
 1293 052b 64        		.byte	0x64
 1294 052c 93        		.byte	0x93
 1295 052d 01        		.uleb128 0x1
 1296 052e 65        		.byte	0x65
 1297 052f 93        		.byte	0x93
 1298 0530 01        		.uleb128 0x1
 1299 0531 01        		.byte	0x1
 1300 0532 3A        		.byte	0x3a
 1301 0533 00        		.byte	0
 1302 0534 00        		.byte	0
 1303 0535 29        		.uleb128 0x29
 1304 0536 0000 0000 		.long	.LVL2
 1305 053a B207 0000 		.long	0x7b2
 1306 053e 29        		.uleb128 0x29
 1307 053f 0000 0000 		.long	.LVL4
 1308 0543 BA02 0000 		.long	0x2ba
 1309 0547 29        		.uleb128 0x29
 1310 0548 0000 0000 		.long	.LVL5
 1311 054c B207 0000 		.long	0x7b2
 1312 0550 28        		.uleb128 0x28
 1313 0551 0000 0000 		.long	.LVL7
 1314 0555 9B01 0000 		.long	0x19b
 1315 0559 6C05 0000 		.long	0x56c
 1316 055d 21        		.uleb128 0x21
 1317 055e 06        		.byte	0x6
 1318 055f 66        		.byte	0x66
 1319 0560 93        		.byte	0x93
 1320 0561 01        		.uleb128 0x1
 1321 0562 67        		.byte	0x67
 1322 0563 93        		.byte	0x93
 1323 0564 01        		.uleb128 0x1
 1324 0565 05        		.byte	0x5
 1325 0566 03        		.byte	0x3
 1326 0567 0000 0000 		.long	.LC0
 1327 056b 00        		.byte	0
 1328 056c 28        		.uleb128 0x28
 1329 056d 0000 0000 		.long	.LVL8
 1330 0571 C001 0000 		.long	0x1c0
 1331 0575 9505 0000 		.long	0x595
 1332 0579 21        		.uleb128 0x21
 1333 057a 0C        		.byte	0xc
 1334 057b 64        		.byte	0x64
 1335 057c 93        		.byte	0x93
GAS LISTING /tmp/ccNcTpZI.s 			page 33


 1336 057d 01        		.uleb128 0x1
 1337 057e 65        		.byte	0x65
 1338 057f 93        		.byte	0x93
 1339 0580 01        		.uleb128 0x1
 1340 0581 66        		.byte	0x66
 1341 0582 93        		.byte	0x93
 1342 0583 01        		.uleb128 0x1
 1343 0584 67        		.byte	0x67
 1344 0585 93        		.byte	0x93
 1345 0586 01        		.uleb128 0x1
 1346 0587 02        		.byte	0x2
 1347 0588 7C        		.byte	0x7c
 1348 0589 00        		.sleb128 0
 1349 058a 21        		.uleb128 0x21
 1350 058b 06        		.byte	0x6
 1351 058c 62        		.byte	0x62
 1352 058d 93        		.byte	0x93
 1353 058e 01        		.uleb128 0x1
 1354 058f 63        		.byte	0x63
 1355 0590 93        		.byte	0x93
 1356 0591 01        		.uleb128 0x1
 1357 0592 01        		.byte	0x1
 1358 0593 3A        		.byte	0x3a
 1359 0594 00        		.byte	0
 1360 0595 2A        		.uleb128 0x2a
 1361 0596 0000 0000 		.long	.LVL33
 1362 059a 01        		.byte	0x1
 1363 059b BF07 0000 		.long	0x7bf
 1364 059f 21        		.uleb128 0x21
 1365 05a0 0C        		.byte	0xc
 1366 05a1 66        		.byte	0x66
 1367 05a2 93        		.byte	0x93
 1368 05a3 01        		.uleb128 0x1
 1369 05a4 67        		.byte	0x67
 1370 05a5 93        		.byte	0x93
 1371 05a6 01        		.uleb128 0x1
 1372 05a7 68        		.byte	0x68
 1373 05a8 93        		.byte	0x93
 1374 05a9 01        		.uleb128 0x1
 1375 05aa 69        		.byte	0x69
 1376 05ab 93        		.byte	0x93
 1377 05ac 01        		.uleb128 0x1
 1378 05ad 03        		.byte	0x3
 1379 05ae 0A        		.byte	0xa
 1380 05af E803      		.word	0x3e8
 1381 05b1 00        		.byte	0
 1382 05b2 00        		.byte	0
 1383 05b3 00        		.byte	0
 1384 05b4 2B        		.uleb128 0x2b
 1385 05b5 0000 0000 		.long	.LASF54
 1386 05b9 02        		.byte	0x2
 1387 05ba 8F        		.byte	0x8f
 1388 05bb C800 0000 		.long	0xc8
 1389 05bf 01        		.byte	0x1
 1390 05c0 01        		.byte	0x1
 1391 05c1 2C        		.uleb128 0x2c
 1392 05c2 5353 00   		.string	"SS"
GAS LISTING /tmp/ccNcTpZI.s 			page 34


 1393 05c5 06        		.byte	0x6
 1394 05c6 26        		.byte	0x26
 1395 05c7 CC05 0000 		.long	0x5cc
 1396 05cb 35        		.byte	0x35
 1397 05cc 06        		.uleb128 0x6
 1398 05cd 5000 0000 		.long	0x50
 1399 05d1 2D        		.uleb128 0x2d
 1400 05d2 0000 0000 		.long	.LASF51
 1401 05d6 06        		.byte	0x6
 1402 05d7 27        		.byte	0x27
 1403 05d8 CC05 0000 		.long	0x5cc
 1404 05dc 33        		.byte	0x33
 1405 05dd 2D        		.uleb128 0x2d
 1406 05de 0000 0000 		.long	.LASF52
 1407 05e2 06        		.byte	0x6
 1408 05e3 28        		.byte	0x28
 1409 05e4 CC05 0000 		.long	0x5cc
 1410 05e8 32        		.byte	0x32
 1411 05e9 2C        		.uleb128 0x2c
 1412 05ea 5343 4B00 		.string	"SCK"
 1413 05ee 06        		.byte	0x6
 1414 05ef 29        		.byte	0x29
 1415 05f0 CC05 0000 		.long	0x5cc
 1416 05f4 34        		.byte	0x34
 1417 05f5 2C        		.uleb128 0x2c
 1418 05f6 5344 4100 		.string	"SDA"
 1419 05fa 06        		.byte	0x6
 1420 05fb 2E        		.byte	0x2e
 1421 05fc CC05 0000 		.long	0x5cc
 1422 0600 14        		.byte	0x14
 1423 0601 2C        		.uleb128 0x2c
 1424 0602 5343 4C00 		.string	"SCL"
 1425 0606 06        		.byte	0x6
 1426 0607 2F        		.byte	0x2f
 1427 0608 CC05 0000 		.long	0x5cc
 1428 060c 15        		.byte	0x15
 1429 060d 2C        		.uleb128 0x2c
 1430 060e 4130 00   		.string	"A0"
 1431 0611 06        		.byte	0x6
 1432 0612 44        		.byte	0x44
 1433 0613 CC05 0000 		.long	0x5cc
 1434 0617 36        		.byte	0x36
 1435 0618 2C        		.uleb128 0x2c
 1436 0619 4131 00   		.string	"A1"
 1437 061c 06        		.byte	0x6
 1438 061d 45        		.byte	0x45
 1439 061e CC05 0000 		.long	0x5cc
 1440 0622 37        		.byte	0x37
 1441 0623 2C        		.uleb128 0x2c
 1442 0624 4132 00   		.string	"A2"
 1443 0627 06        		.byte	0x6
 1444 0628 46        		.byte	0x46
 1445 0629 CC05 0000 		.long	0x5cc
 1446 062d 38        		.byte	0x38
 1447 062e 2C        		.uleb128 0x2c
 1448 062f 4133 00   		.string	"A3"
 1449 0632 06        		.byte	0x6
GAS LISTING /tmp/ccNcTpZI.s 			page 35


 1450 0633 47        		.byte	0x47
 1451 0634 CC05 0000 		.long	0x5cc
 1452 0638 39        		.byte	0x39
 1453 0639 2C        		.uleb128 0x2c
 1454 063a 4134 00   		.string	"A4"
 1455 063d 06        		.byte	0x6
 1456 063e 48        		.byte	0x48
 1457 063f CC05 0000 		.long	0x5cc
 1458 0643 3A        		.byte	0x3a
 1459 0644 2C        		.uleb128 0x2c
 1460 0645 4135 00   		.string	"A5"
 1461 0648 06        		.byte	0x6
 1462 0649 49        		.byte	0x49
 1463 064a CC05 0000 		.long	0x5cc
 1464 064e 3B        		.byte	0x3b
 1465 064f 2C        		.uleb128 0x2c
 1466 0650 4136 00   		.string	"A6"
 1467 0653 06        		.byte	0x6
 1468 0654 4A        		.byte	0x4a
 1469 0655 CC05 0000 		.long	0x5cc
 1470 0659 3C        		.byte	0x3c
 1471 065a 2C        		.uleb128 0x2c
 1472 065b 4137 00   		.string	"A7"
 1473 065e 06        		.byte	0x6
 1474 065f 4B        		.byte	0x4b
 1475 0660 CC05 0000 		.long	0x5cc
 1476 0664 3D        		.byte	0x3d
 1477 0665 2C        		.uleb128 0x2c
 1478 0666 4138 00   		.string	"A8"
 1479 0669 06        		.byte	0x6
 1480 066a 4C        		.byte	0x4c
 1481 066b CC05 0000 		.long	0x5cc
 1482 066f 3E        		.byte	0x3e
 1483 0670 2C        		.uleb128 0x2c
 1484 0671 4139 00   		.string	"A9"
 1485 0674 06        		.byte	0x6
 1486 0675 4D        		.byte	0x4d
 1487 0676 CC05 0000 		.long	0x5cc
 1488 067a 3F        		.byte	0x3f
 1489 067b 2C        		.uleb128 0x2c
 1490 067c 4131 3000 		.string	"A10"
 1491 0680 06        		.byte	0x6
 1492 0681 4E        		.byte	0x4e
 1493 0682 CC05 0000 		.long	0x5cc
 1494 0686 40        		.byte	0x40
 1495 0687 2C        		.uleb128 0x2c
 1496 0688 4131 3100 		.string	"A11"
 1497 068c 06        		.byte	0x6
 1498 068d 4F        		.byte	0x4f
 1499 068e CC05 0000 		.long	0x5cc
 1500 0692 41        		.byte	0x41
 1501 0693 2C        		.uleb128 0x2c
 1502 0694 4131 3200 		.string	"A12"
 1503 0698 06        		.byte	0x6
 1504 0699 50        		.byte	0x50
 1505 069a CC05 0000 		.long	0x5cc
 1506 069e 42        		.byte	0x42
GAS LISTING /tmp/ccNcTpZI.s 			page 36


 1507 069f 2C        		.uleb128 0x2c
 1508 06a0 4131 3300 		.string	"A13"
 1509 06a4 06        		.byte	0x6
 1510 06a5 51        		.byte	0x51
 1511 06a6 CC05 0000 		.long	0x5cc
 1512 06aa 43        		.byte	0x43
 1513 06ab 2C        		.uleb128 0x2c
 1514 06ac 4131 3400 		.string	"A14"
 1515 06b0 06        		.byte	0x6
 1516 06b1 52        		.byte	0x52
 1517 06b2 CC05 0000 		.long	0x5cc
 1518 06b6 44        		.byte	0x44
 1519 06b7 2C        		.uleb128 0x2c
 1520 06b8 4131 3500 		.string	"A15"
 1521 06bc 06        		.byte	0x6
 1522 06bd 53        		.byte	0x53
 1523 06be CC05 0000 		.long	0x5cc
 1524 06c2 45        		.byte	0x45
 1525 06c3 2E        		.uleb128 0x2e
 1526 06c4 5B00 0000 		.long	0x5b
 1527 06c8 D406 0000 		.long	0x6d4
 1528 06cc 2F        		.uleb128 0x2f
 1529 06cd D406 0000 		.long	0x6d4
 1530 06d1 FF03      		.word	0x3ff
 1531 06d3 00        		.byte	0
 1532 06d4 03        		.uleb128 0x3
 1533 06d5 02        		.byte	0x2
 1534 06d6 07        		.byte	0x7
 1535 06d7 0000 0000 		.long	.LASF53
 1536 06db 30        		.uleb128 0x30
 1537 06dc 0000 0000 		.long	.LASF55
 1538 06e0 01        		.byte	0x1
 1539 06e1 2D        		.byte	0x2d
 1540 06e2 ED06 0000 		.long	0x6ed
 1541 06e6 01        		.byte	0x1
 1542 06e7 05        		.byte	0x5
 1543 06e8 03        		.byte	0x3
 1544 06e9 0000 0000 		.long	adcBuffer
 1545 06ed 31        		.uleb128 0x31
 1546 06ee C306 0000 		.long	0x6c3
 1547 06f2 30        		.uleb128 0x30
 1548 06f3 0000 0000 		.long	.LASF56
 1549 06f7 01        		.byte	0x1
 1550 06f8 2E        		.byte	0x2e
 1551 06f9 0407 0000 		.long	0x704
 1552 06fd 01        		.byte	0x1
 1553 06fe 05        		.byte	0x5
 1554 06ff 03        		.byte	0x3
 1555 0700 0000 0000 		.long	adcMaxSamples
 1556 0704 31        		.uleb128 0x31
 1557 0705 5000 0000 		.long	0x50
 1558 0709 30        		.uleb128 0x30
 1559 070a 0000 0000 		.long	.LASF57
 1560 070e 01        		.byte	0x1
 1561 070f 2F        		.byte	0x2f
 1562 0710 1B07 0000 		.long	0x71b
 1563 0714 01        		.byte	0x1
GAS LISTING /tmp/ccNcTpZI.s 			page 37


 1564 0715 05        		.byte	0x5
 1565 0716 03        		.byte	0x3
 1566 0717 0000 0000 		.long	adcSampleLength
 1567 071b 31        		.uleb128 0x31
 1568 071c 6200 0000 		.long	0x62
 1569 0720 2E        		.uleb128 0x2e
 1570 0721 8502 0000 		.long	0x285
 1571 0725 3007 0000 		.long	0x730
 1572 0729 32        		.uleb128 0x32
 1573 072a D406 0000 		.long	0x6d4
 1574 072e 00        		.byte	0
 1575 072f 00        		.byte	0
 1576 0730 30        		.uleb128 0x30
 1577 0731 0000 0000 		.long	.LASF58
 1578 0735 01        		.byte	0x1
 1579 0736 31        		.byte	0x31
 1580 0737 4207 0000 		.long	0x742
 1581 073b 01        		.byte	0x1
 1582 073c 05        		.byte	0x5
 1583 073d 03        		.byte	0x3
 1584 073e 0000 0000 		.long	adcChannels
 1585 0742 31        		.uleb128 0x31
 1586 0743 2007 0000 		.long	0x720
 1587 0747 30        		.uleb128 0x30
 1588 0748 0000 0000 		.long	.LASF59
 1589 074c 01        		.byte	0x1
 1590 074d 32        		.byte	0x32
 1591 074e 0407 0000 		.long	0x704
 1592 0752 01        		.byte	0x1
 1593 0753 05        		.byte	0x5
 1594 0754 03        		.byte	0x3
 1595 0755 0000 0000 		.long	adcMaxChannels
 1596 0759 30        		.uleb128 0x30
 1597 075a 0000 0000 		.long	.LASF60
 1598 075e 01        		.byte	0x1
 1599 075f 34        		.byte	0x34
 1600 0760 0407 0000 		.long	0x704
 1601 0764 01        		.byte	0x1
 1602 0765 05        		.byte	0x5
 1603 0766 03        		.byte	0x3
 1604 0767 0000 0000 		.long	adcLevel
 1605 076b 30        		.uleb128 0x30
 1606 076c 0000 0000 		.long	.LASF61
 1607 0770 01        		.byte	0x1
 1608 0771 35        		.byte	0x35
 1609 0772 0407 0000 		.long	0x704
 1610 0776 01        		.byte	0x1
 1611 0777 05        		.byte	0x5
 1612 0778 03        		.byte	0x3
 1613 0779 0000 0000 		.long	adcSign
 1614 077d 30        		.uleb128 0x30
 1615 077e 0000 0000 		.long	.LASF62
 1616 0782 01        		.byte	0x1
 1617 0783 36        		.byte	0x36
 1618 0784 0407 0000 		.long	0x704
 1619 0788 01        		.byte	0x1
 1620 0789 05        		.byte	0x5
GAS LISTING /tmp/ccNcTpZI.s 			page 38


 1621 078a 03        		.byte	0x3
 1622 078b 0000 0000 		.long	adcShift
 1623 078f 2E        		.uleb128 0x2e
 1624 0790 5B00 0000 		.long	0x5b
 1625 0794 9F07 0000 		.long	0x79f
 1626 0798 32        		.uleb128 0x32
 1627 0799 D406 0000 		.long	0x6d4
 1628 079d FF        		.byte	0xff
 1629 079e 00        		.byte	0
 1630 079f 33        		.uleb128 0x33
 1631 07a0 0000 0000 		.long	.LASF63
 1632 07a4 01        		.byte	0x1
 1633 07a5 0301      		.word	0x103
 1634 07a7 8F07 0000 		.long	0x78f
 1635 07ab 01        		.byte	0x1
 1636 07ac 05        		.byte	0x5
 1637 07ad 03        		.byte	0x3
 1638 07ae 0000 0000 		.long	resBuffer
 1639 07b2 34        		.uleb128 0x34
 1640 07b3 01        		.byte	0x1
 1641 07b4 0000 0000 		.long	.LASF74
 1642 07b8 08        		.byte	0x8
 1643 07b9 8D        		.byte	0x8d
 1644 07ba 6D00 0000 		.long	0x6d
 1645 07be 01        		.byte	0x1
 1646 07bf 35        		.uleb128 0x35
 1647 07c0 01        		.byte	0x1
 1648 07c1 0000 0000 		.long	.LASF75
 1649 07c5 08        		.byte	0x8
 1650 07c6 8E        		.byte	0x8e
 1651 07c7 01        		.byte	0x1
 1652 07c8 0E        		.uleb128 0xe
 1653 07c9 6D00 0000 		.long	0x6d
 1654 07cd 00        		.byte	0
 1655 07ce 00        		.byte	0
 1656               		.section	.debug_abbrev,"",@progbits
 1657               	.Ldebug_abbrev0:
 1658 0000 01        		.uleb128 0x1
 1659 0001 11        		.uleb128 0x11
 1660 0002 01        		.byte	0x1
 1661 0003 25        		.uleb128 0x25
 1662 0004 0E        		.uleb128 0xe
 1663 0005 13        		.uleb128 0x13
 1664 0006 0B        		.uleb128 0xb
 1665 0007 03        		.uleb128 0x3
 1666 0008 0E        		.uleb128 0xe
 1667 0009 1B        		.uleb128 0x1b
 1668 000a 0E        		.uleb128 0xe
 1669 000b 55        		.uleb128 0x55
 1670 000c 06        		.uleb128 0x6
 1671 000d 11        		.uleb128 0x11
 1672 000e 01        		.uleb128 0x1
 1673 000f 52        		.uleb128 0x52
 1674 0010 01        		.uleb128 0x1
 1675 0011 10        		.uleb128 0x10
 1676 0012 06        		.uleb128 0x6
 1677 0013 00        		.byte	0
GAS LISTING /tmp/ccNcTpZI.s 			page 39


 1678 0014 00        		.byte	0
 1679 0015 02        		.uleb128 0x2
 1680 0016 16        		.uleb128 0x16
 1681 0017 00        		.byte	0
 1682 0018 03        		.uleb128 0x3
 1683 0019 0E        		.uleb128 0xe
 1684 001a 3A        		.uleb128 0x3a
 1685 001b 0B        		.uleb128 0xb
 1686 001c 3B        		.uleb128 0x3b
 1687 001d 0B        		.uleb128 0xb
 1688 001e 49        		.uleb128 0x49
 1689 001f 13        		.uleb128 0x13
 1690 0020 00        		.byte	0
 1691 0021 00        		.byte	0
 1692 0022 03        		.uleb128 0x3
 1693 0023 24        		.uleb128 0x24
 1694 0024 00        		.byte	0
 1695 0025 0B        		.uleb128 0xb
 1696 0026 0B        		.uleb128 0xb
 1697 0027 3E        		.uleb128 0x3e
 1698 0028 0B        		.uleb128 0xb
 1699 0029 03        		.uleb128 0x3
 1700 002a 0E        		.uleb128 0xe
 1701 002b 00        		.byte	0
 1702 002c 00        		.byte	0
 1703 002d 04        		.uleb128 0x4
 1704 002e 24        		.uleb128 0x24
 1705 002f 00        		.byte	0
 1706 0030 0B        		.uleb128 0xb
 1707 0031 0B        		.uleb128 0xb
 1708 0032 3E        		.uleb128 0x3e
 1709 0033 0B        		.uleb128 0xb
 1710 0034 03        		.uleb128 0x3
 1711 0035 08        		.uleb128 0x8
 1712 0036 00        		.byte	0
 1713 0037 00        		.byte	0
 1714 0038 05        		.uleb128 0x5
 1715 0039 0F        		.uleb128 0xf
 1716 003a 00        		.byte	0
 1717 003b 0B        		.uleb128 0xb
 1718 003c 0B        		.uleb128 0xb
 1719 003d 49        		.uleb128 0x49
 1720 003e 13        		.uleb128 0x13
 1721 003f 00        		.byte	0
 1722 0040 00        		.byte	0
 1723 0041 06        		.uleb128 0x6
 1724 0042 26        		.uleb128 0x26
 1725 0043 00        		.byte	0
 1726 0044 49        		.uleb128 0x49
 1727 0045 13        		.uleb128 0x13
 1728 0046 00        		.byte	0
 1729 0047 00        		.byte	0
 1730 0048 07        		.uleb128 0x7
 1731 0049 04        		.uleb128 0x4
 1732 004a 01        		.byte	0x1
 1733 004b 03        		.uleb128 0x3
 1734 004c 0E        		.uleb128 0xe
GAS LISTING /tmp/ccNcTpZI.s 			page 40


 1735 004d 0B        		.uleb128 0xb
 1736 004e 0B        		.uleb128 0xb
 1737 004f 3A        		.uleb128 0x3a
 1738 0050 0B        		.uleb128 0xb
 1739 0051 3B        		.uleb128 0x3b
 1740 0052 0B        		.uleb128 0xb
 1741 0053 01        		.uleb128 0x1
 1742 0054 13        		.uleb128 0x13
 1743 0055 00        		.byte	0
 1744 0056 00        		.byte	0
 1745 0057 08        		.uleb128 0x8
 1746 0058 28        		.uleb128 0x28
 1747 0059 00        		.byte	0
 1748 005a 03        		.uleb128 0x3
 1749 005b 0E        		.uleb128 0xe
 1750 005c 1C        		.uleb128 0x1c
 1751 005d 0D        		.uleb128 0xd
 1752 005e 00        		.byte	0
 1753 005f 00        		.byte	0
 1754 0060 09        		.uleb128 0x9
 1755 0061 02        		.uleb128 0x2
 1756 0062 01        		.byte	0x1
 1757 0063 03        		.uleb128 0x3
 1758 0064 0E        		.uleb128 0xe
 1759 0065 3C        		.uleb128 0x3c
 1760 0066 0C        		.uleb128 0xc
 1761 0067 01        		.uleb128 0x1
 1762 0068 13        		.uleb128 0x13
 1763 0069 00        		.byte	0
 1764 006a 00        		.byte	0
 1765 006b 0A        		.uleb128 0xa
 1766 006c 08        		.uleb128 0x8
 1767 006d 00        		.byte	0
 1768 006e 3A        		.uleb128 0x3a
 1769 006f 0B        		.uleb128 0xb
 1770 0070 3B        		.uleb128 0x3b
 1771 0071 0B        		.uleb128 0xb
 1772 0072 18        		.uleb128 0x18
 1773 0073 13        		.uleb128 0x13
 1774 0074 00        		.byte	0
 1775 0075 00        		.byte	0
 1776 0076 0B        		.uleb128 0xb
 1777 0077 2E        		.uleb128 0x2e
 1778 0078 01        		.byte	0x1
 1779 0079 3F        		.uleb128 0x3f
 1780 007a 0C        		.uleb128 0xc
 1781 007b 03        		.uleb128 0x3
 1782 007c 0E        		.uleb128 0xe
 1783 007d 3A        		.uleb128 0x3a
 1784 007e 0B        		.uleb128 0xb
 1785 007f 3B        		.uleb128 0x3b
 1786 0080 0B        		.uleb128 0xb
 1787 0081 8740      		.uleb128 0x2007
 1788 0083 0E        		.uleb128 0xe
 1789 0084 49        		.uleb128 0x49
 1790 0085 13        		.uleb128 0x13
 1791 0086 3C        		.uleb128 0x3c
GAS LISTING /tmp/ccNcTpZI.s 			page 41


 1792 0087 0C        		.uleb128 0xc
 1793 0088 64        		.uleb128 0x64
 1794 0089 13        		.uleb128 0x13
 1795 008a 01        		.uleb128 0x1
 1796 008b 13        		.uleb128 0x13
 1797 008c 00        		.byte	0
 1798 008d 00        		.byte	0
 1799 008e 0C        		.uleb128 0xc
 1800 008f 05        		.uleb128 0x5
 1801 0090 00        		.byte	0
 1802 0091 49        		.uleb128 0x49
 1803 0092 13        		.uleb128 0x13
 1804 0093 34        		.uleb128 0x34
 1805 0094 0C        		.uleb128 0xc
 1806 0095 00        		.byte	0
 1807 0096 00        		.byte	0
 1808 0097 0D        		.uleb128 0xd
 1809 0098 2E        		.uleb128 0x2e
 1810 0099 01        		.byte	0x1
 1811 009a 3F        		.uleb128 0x3f
 1812 009b 0C        		.uleb128 0xc
 1813 009c 03        		.uleb128 0x3
 1814 009d 0E        		.uleb128 0xe
 1815 009e 3A        		.uleb128 0x3a
 1816 009f 0B        		.uleb128 0xb
 1817 00a0 3B        		.uleb128 0x3b
 1818 00a1 0B        		.uleb128 0xb
 1819 00a2 8740      		.uleb128 0x2007
 1820 00a4 0E        		.uleb128 0xe
 1821 00a5 3C        		.uleb128 0x3c
 1822 00a6 0C        		.uleb128 0xc
 1823 00a7 64        		.uleb128 0x64
 1824 00a8 13        		.uleb128 0x13
 1825 00a9 01        		.uleb128 0x1
 1826 00aa 13        		.uleb128 0x13
 1827 00ab 00        		.byte	0
 1828 00ac 00        		.byte	0
 1829 00ad 0E        		.uleb128 0xe
 1830 00ae 05        		.uleb128 0x5
 1831 00af 00        		.byte	0
 1832 00b0 49        		.uleb128 0x49
 1833 00b1 13        		.uleb128 0x13
 1834 00b2 00        		.byte	0
 1835 00b3 00        		.byte	0
 1836 00b4 0F        		.uleb128 0xf
 1837 00b5 2E        		.uleb128 0x2e
 1838 00b6 01        		.byte	0x1
 1839 00b7 3F        		.uleb128 0x3f
 1840 00b8 0C        		.uleb128 0xc
 1841 00b9 03        		.uleb128 0x3
 1842 00ba 0E        		.uleb128 0xe
 1843 00bb 3A        		.uleb128 0x3a
 1844 00bc 0B        		.uleb128 0xb
 1845 00bd 3B        		.uleb128 0x3b
 1846 00be 0B        		.uleb128 0xb
 1847 00bf 8740      		.uleb128 0x2007
 1848 00c1 0E        		.uleb128 0xe
GAS LISTING /tmp/ccNcTpZI.s 			page 42


 1849 00c2 3C        		.uleb128 0x3c
 1850 00c3 0C        		.uleb128 0xc
 1851 00c4 64        		.uleb128 0x64
 1852 00c5 13        		.uleb128 0x13
 1853 00c6 00        		.byte	0
 1854 00c7 00        		.byte	0
 1855 00c8 10        		.uleb128 0x10
 1856 00c9 2E        		.uleb128 0x2e
 1857 00ca 01        		.byte	0x1
 1858 00cb 3F        		.uleb128 0x3f
 1859 00cc 0C        		.uleb128 0xc
 1860 00cd 03        		.uleb128 0x3
 1861 00ce 0E        		.uleb128 0xe
 1862 00cf 3A        		.uleb128 0x3a
 1863 00d0 0B        		.uleb128 0xb
 1864 00d1 3B        		.uleb128 0x3b
 1865 00d2 0B        		.uleb128 0xb
 1866 00d3 8740      		.uleb128 0x2007
 1867 00d5 0E        		.uleb128 0xe
 1868 00d6 49        		.uleb128 0x49
 1869 00d7 13        		.uleb128 0x13
 1870 00d8 3C        		.uleb128 0x3c
 1871 00d9 0C        		.uleb128 0xc
 1872 00da 64        		.uleb128 0x64
 1873 00db 13        		.uleb128 0x13
 1874 00dc 00        		.byte	0
 1875 00dd 00        		.byte	0
 1876 00de 11        		.uleb128 0x11
 1877 00df 3B        		.uleb128 0x3b
 1878 00e0 00        		.byte	0
 1879 00e1 03        		.uleb128 0x3
 1880 00e2 0E        		.uleb128 0xe
 1881 00e3 00        		.byte	0
 1882 00e4 00        		.byte	0
 1883 00e5 12        		.uleb128 0x12
 1884 00e6 04        		.uleb128 0x4
 1885 00e7 01        		.byte	0x1
 1886 00e8 0B        		.uleb128 0xb
 1887 00e9 0B        		.uleb128 0xb
 1888 00ea 3A        		.uleb128 0x3a
 1889 00eb 0B        		.uleb128 0xb
 1890 00ec 3B        		.uleb128 0x3b
 1891 00ed 0B        		.uleb128 0xb
 1892 00ee 8740      		.uleb128 0x2007
 1893 00f0 0E        		.uleb128 0xe
 1894 00f1 01        		.uleb128 0x1
 1895 00f2 13        		.uleb128 0x13
 1896 00f3 00        		.byte	0
 1897 00f4 00        		.byte	0
 1898 00f5 13        		.uleb128 0x13
 1899 00f6 13        		.uleb128 0x13
 1900 00f7 01        		.byte	0x1
 1901 00f8 0B        		.uleb128 0xb
 1902 00f9 0B        		.uleb128 0xb
 1903 00fa 3A        		.uleb128 0x3a
 1904 00fb 0B        		.uleb128 0xb
 1905 00fc 3B        		.uleb128 0x3b
GAS LISTING /tmp/ccNcTpZI.s 			page 43


 1906 00fd 0B        		.uleb128 0xb
 1907 00fe 8740      		.uleb128 0x2007
 1908 0100 0E        		.uleb128 0xe
 1909 0101 01        		.uleb128 0x1
 1910 0102 13        		.uleb128 0x13
 1911 0103 00        		.byte	0
 1912 0104 00        		.byte	0
 1913 0105 14        		.uleb128 0x14
 1914 0106 0D        		.uleb128 0xd
 1915 0107 00        		.byte	0
 1916 0108 03        		.uleb128 0x3
 1917 0109 08        		.uleb128 0x8
 1918 010a 3A        		.uleb128 0x3a
 1919 010b 0B        		.uleb128 0xb
 1920 010c 3B        		.uleb128 0x3b
 1921 010d 0B        		.uleb128 0xb
 1922 010e 49        		.uleb128 0x49
 1923 010f 13        		.uleb128 0x13
 1924 0110 38        		.uleb128 0x38
 1925 0111 0A        		.uleb128 0xa
 1926 0112 00        		.byte	0
 1927 0113 00        		.byte	0
 1928 0114 15        		.uleb128 0x15
 1929 0115 0D        		.uleb128 0xd
 1930 0116 00        		.byte	0
 1931 0117 03        		.uleb128 0x3
 1932 0118 0E        		.uleb128 0xe
 1933 0119 3A        		.uleb128 0x3a
 1934 011a 0B        		.uleb128 0xb
 1935 011b 3B        		.uleb128 0x3b
 1936 011c 0B        		.uleb128 0xb
 1937 011d 49        		.uleb128 0x49
 1938 011e 13        		.uleb128 0x13
 1939 011f 38        		.uleb128 0x38
 1940 0120 0A        		.uleb128 0xa
 1941 0121 00        		.byte	0
 1942 0122 00        		.byte	0
 1943 0123 16        		.uleb128 0x16
 1944 0124 2E        		.uleb128 0x2e
 1945 0125 01        		.byte	0x1
 1946 0126 47        		.uleb128 0x47
 1947 0127 13        		.uleb128 0x13
 1948 0128 20        		.uleb128 0x20
 1949 0129 0B        		.uleb128 0xb
 1950 012a 64        		.uleb128 0x64
 1951 012b 13        		.uleb128 0x13
 1952 012c 01        		.uleb128 0x1
 1953 012d 13        		.uleb128 0x13
 1954 012e 00        		.byte	0
 1955 012f 00        		.byte	0
 1956 0130 17        		.uleb128 0x17
 1957 0131 05        		.uleb128 0x5
 1958 0132 00        		.byte	0
 1959 0133 03        		.uleb128 0x3
 1960 0134 0E        		.uleb128 0xe
 1961 0135 49        		.uleb128 0x49
 1962 0136 13        		.uleb128 0x13
GAS LISTING /tmp/ccNcTpZI.s 			page 44


 1963 0137 34        		.uleb128 0x34
 1964 0138 0C        		.uleb128 0xc
 1965 0139 00        		.byte	0
 1966 013a 00        		.byte	0
 1967 013b 18        		.uleb128 0x18
 1968 013c 2E        		.uleb128 0x2e
 1969 013d 00        		.byte	0
 1970 013e 3F        		.uleb128 0x3f
 1971 013f 0C        		.uleb128 0xc
 1972 0140 03        		.uleb128 0x3
 1973 0141 0E        		.uleb128 0xe
 1974 0142 3A        		.uleb128 0x3a
 1975 0143 0B        		.uleb128 0xb
 1976 0144 3B        		.uleb128 0x3b
 1977 0145 0B        		.uleb128 0xb
 1978 0146 11        		.uleb128 0x11
 1979 0147 01        		.uleb128 0x1
 1980 0148 12        		.uleb128 0x12
 1981 0149 01        		.uleb128 0x1
 1982 014a 40        		.uleb128 0x40
 1983 014b 0A        		.uleb128 0xa
 1984 014c 9742      		.uleb128 0x2117
 1985 014e 0C        		.uleb128 0xc
 1986 014f 00        		.byte	0
 1987 0150 00        		.byte	0
 1988 0151 19        		.uleb128 0x19
 1989 0152 05        		.uleb128 0x5
 1990 0153 00        		.byte	0
 1991 0154 03        		.uleb128 0x3
 1992 0155 0E        		.uleb128 0xe
 1993 0156 3A        		.uleb128 0x3a
 1994 0157 0B        		.uleb128 0xb
 1995 0158 3B        		.uleb128 0x3b
 1996 0159 0B        		.uleb128 0xb
 1997 015a 49        		.uleb128 0x49
 1998 015b 13        		.uleb128 0x13
 1999 015c 00        		.byte	0
 2000 015d 00        		.byte	0
 2001 015e 1A        		.uleb128 0x1a
 2002 015f 2E        		.uleb128 0x2e
 2003 0160 01        		.byte	0x1
 2004 0161 3F        		.uleb128 0x3f
 2005 0162 0C        		.uleb128 0xc
 2006 0163 03        		.uleb128 0x3
 2007 0164 0E        		.uleb128 0xe
 2008 0165 3A        		.uleb128 0x3a
 2009 0166 0B        		.uleb128 0xb
 2010 0167 3B        		.uleb128 0x3b
 2011 0168 05        		.uleb128 0x5
 2012 0169 11        		.uleb128 0x11
 2013 016a 01        		.uleb128 0x1
 2014 016b 12        		.uleb128 0x12
 2015 016c 01        		.uleb128 0x1
 2016 016d 40        		.uleb128 0x40
 2017 016e 0A        		.uleb128 0xa
 2018 016f 9742      		.uleb128 0x2117
 2019 0171 0C        		.uleb128 0xc
GAS LISTING /tmp/ccNcTpZI.s 			page 45


 2020 0172 01        		.uleb128 0x1
 2021 0173 13        		.uleb128 0x13
 2022 0174 00        		.byte	0
 2023 0175 00        		.byte	0
 2024 0176 1B        		.uleb128 0x1b
 2025 0177 0B        		.uleb128 0xb
 2026 0178 01        		.byte	0x1
 2027 0179 11        		.uleb128 0x11
 2028 017a 01        		.uleb128 0x1
 2029 017b 12        		.uleb128 0x12
 2030 017c 01        		.uleb128 0x1
 2031 017d 00        		.byte	0
 2032 017e 00        		.byte	0
 2033 017f 1C        		.uleb128 0x1c
 2034 0180 34        		.uleb128 0x34
 2035 0181 00        		.byte	0
 2036 0182 03        		.uleb128 0x3
 2037 0183 0E        		.uleb128 0xe
 2038 0184 3A        		.uleb128 0x3a
 2039 0185 0B        		.uleb128 0xb
 2040 0186 3B        		.uleb128 0x3b
 2041 0187 05        		.uleb128 0x5
 2042 0188 49        		.uleb128 0x49
 2043 0189 13        		.uleb128 0x13
 2044 018a 00        		.byte	0
 2045 018b 00        		.byte	0
 2046 018c 1D        		.uleb128 0x1d
 2047 018d 1D        		.uleb128 0x1d
 2048 018e 01        		.byte	0x1
 2049 018f 31        		.uleb128 0x31
 2050 0190 13        		.uleb128 0x13
 2051 0191 11        		.uleb128 0x11
 2052 0192 01        		.uleb128 0x1
 2053 0193 12        		.uleb128 0x12
 2054 0194 01        		.uleb128 0x1
 2055 0195 58        		.uleb128 0x58
 2056 0196 0B        		.uleb128 0xb
 2057 0197 59        		.uleb128 0x59
 2058 0198 05        		.uleb128 0x5
 2059 0199 00        		.byte	0
 2060 019a 00        		.byte	0
 2061 019b 1E        		.uleb128 0x1e
 2062 019c 05        		.uleb128 0x5
 2063 019d 00        		.byte	0
 2064 019e 31        		.uleb128 0x31
 2065 019f 13        		.uleb128 0x13
 2066 01a0 1C        		.uleb128 0x1c
 2067 01a1 06        		.uleb128 0x6
 2068 01a2 00        		.byte	0
 2069 01a3 00        		.byte	0
 2070 01a4 1F        		.uleb128 0x1f
 2071 01a5 05        		.uleb128 0x5
 2072 01a6 00        		.byte	0
 2073 01a7 31        		.uleb128 0x31
 2074 01a8 13        		.uleb128 0x13
 2075 01a9 00        		.byte	0
 2076 01aa 00        		.byte	0
GAS LISTING /tmp/ccNcTpZI.s 			page 46


 2077 01ab 20        		.uleb128 0x20
 2078 01ac 8982 01   		.uleb128 0x4109
 2079 01af 01        		.byte	0x1
 2080 01b0 11        		.uleb128 0x11
 2081 01b1 01        		.uleb128 0x1
 2082 01b2 31        		.uleb128 0x31
 2083 01b3 13        		.uleb128 0x13
 2084 01b4 00        		.byte	0
 2085 01b5 00        		.byte	0
 2086 01b6 21        		.uleb128 0x21
 2087 01b7 8A82 01   		.uleb128 0x410a
 2088 01ba 00        		.byte	0
 2089 01bb 02        		.uleb128 0x2
 2090 01bc 0A        		.uleb128 0xa
 2091 01bd 9142      		.uleb128 0x2111
 2092 01bf 0A        		.uleb128 0xa
 2093 01c0 00        		.byte	0
 2094 01c1 00        		.byte	0
 2095 01c2 22        		.uleb128 0x22
 2096 01c3 2E        		.uleb128 0x2e
 2097 01c4 01        		.byte	0x1
 2098 01c5 3F        		.uleb128 0x3f
 2099 01c6 0C        		.uleb128 0xc
 2100 01c7 03        		.uleb128 0x3
 2101 01c8 0E        		.uleb128 0xe
 2102 01c9 3A        		.uleb128 0x3a
 2103 01ca 0B        		.uleb128 0xb
 2104 01cb 3B        		.uleb128 0x3b
 2105 01cc 05        		.uleb128 0x5
 2106 01cd 11        		.uleb128 0x11
 2107 01ce 01        		.uleb128 0x1
 2108 01cf 12        		.uleb128 0x12
 2109 01d0 01        		.uleb128 0x1
 2110 01d1 40        		.uleb128 0x40
 2111 01d2 06        		.uleb128 0x6
 2112 01d3 9742      		.uleb128 0x2117
 2113 01d5 0C        		.uleb128 0xc
 2114 01d6 01        		.uleb128 0x1
 2115 01d7 13        		.uleb128 0x13
 2116 01d8 00        		.byte	0
 2117 01d9 00        		.byte	0
 2118 01da 23        		.uleb128 0x23
 2119 01db 0B        		.uleb128 0xb
 2120 01dc 01        		.byte	0x1
 2121 01dd 55        		.uleb128 0x55
 2122 01de 06        		.uleb128 0x6
 2123 01df 00        		.byte	0
 2124 01e0 00        		.byte	0
 2125 01e1 24        		.uleb128 0x24
 2126 01e2 34        		.uleb128 0x34
 2127 01e3 00        		.byte	0
 2128 01e4 03        		.uleb128 0x3
 2129 01e5 08        		.uleb128 0x8
 2130 01e6 3A        		.uleb128 0x3a
 2131 01e7 0B        		.uleb128 0xb
 2132 01e8 3B        		.uleb128 0x3b
 2133 01e9 05        		.uleb128 0x5
GAS LISTING /tmp/ccNcTpZI.s 			page 47


 2134 01ea 49        		.uleb128 0x49
 2135 01eb 13        		.uleb128 0x13
 2136 01ec 00        		.byte	0
 2137 01ed 00        		.byte	0
 2138 01ee 25        		.uleb128 0x25
 2139 01ef 34        		.uleb128 0x34
 2140 01f0 00        		.byte	0
 2141 01f1 03        		.uleb128 0x3
 2142 01f2 0E        		.uleb128 0xe
 2143 01f3 3A        		.uleb128 0x3a
 2144 01f4 0B        		.uleb128 0xb
 2145 01f5 3B        		.uleb128 0x3b
 2146 01f6 05        		.uleb128 0x5
 2147 01f7 49        		.uleb128 0x49
 2148 01f8 13        		.uleb128 0x13
 2149 01f9 02        		.uleb128 0x2
 2150 01fa 06        		.uleb128 0x6
 2151 01fb 00        		.byte	0
 2152 01fc 00        		.byte	0
 2153 01fd 26        		.uleb128 0x26
 2154 01fe 0B        		.uleb128 0xb
 2155 01ff 01        		.byte	0x1
 2156 0200 11        		.uleb128 0x11
 2157 0201 01        		.uleb128 0x1
 2158 0202 12        		.uleb128 0x12
 2159 0203 01        		.uleb128 0x1
 2160 0204 01        		.uleb128 0x1
 2161 0205 13        		.uleb128 0x13
 2162 0206 00        		.byte	0
 2163 0207 00        		.byte	0
 2164 0208 27        		.uleb128 0x27
 2165 0209 34        		.uleb128 0x34
 2166 020a 00        		.byte	0
 2167 020b 03        		.uleb128 0x3
 2168 020c 08        		.uleb128 0x8
 2169 020d 3A        		.uleb128 0x3a
 2170 020e 0B        		.uleb128 0xb
 2171 020f 3B        		.uleb128 0x3b
 2172 0210 05        		.uleb128 0x5
 2173 0211 49        		.uleb128 0x49
 2174 0212 13        		.uleb128 0x13
 2175 0213 02        		.uleb128 0x2
 2176 0214 06        		.uleb128 0x6
 2177 0215 00        		.byte	0
 2178 0216 00        		.byte	0
 2179 0217 28        		.uleb128 0x28
 2180 0218 8982 01   		.uleb128 0x4109
 2181 021b 01        		.byte	0x1
 2182 021c 11        		.uleb128 0x11
 2183 021d 01        		.uleb128 0x1
 2184 021e 31        		.uleb128 0x31
 2185 021f 13        		.uleb128 0x13
 2186 0220 01        		.uleb128 0x1
 2187 0221 13        		.uleb128 0x13
 2188 0222 00        		.byte	0
 2189 0223 00        		.byte	0
 2190 0224 29        		.uleb128 0x29
GAS LISTING /tmp/ccNcTpZI.s 			page 48


 2191 0225 8982 01   		.uleb128 0x4109
 2192 0228 00        		.byte	0
 2193 0229 11        		.uleb128 0x11
 2194 022a 01        		.uleb128 0x1
 2195 022b 31        		.uleb128 0x31
 2196 022c 13        		.uleb128 0x13
 2197 022d 00        		.byte	0
 2198 022e 00        		.byte	0
 2199 022f 2A        		.uleb128 0x2a
 2200 0230 8982 01   		.uleb128 0x4109
 2201 0233 01        		.byte	0x1
 2202 0234 11        		.uleb128 0x11
 2203 0235 01        		.uleb128 0x1
 2204 0236 9542      		.uleb128 0x2115
 2205 0238 0C        		.uleb128 0xc
 2206 0239 31        		.uleb128 0x31
 2207 023a 13        		.uleb128 0x13
 2208 023b 00        		.byte	0
 2209 023c 00        		.byte	0
 2210 023d 2B        		.uleb128 0x2b
 2211 023e 34        		.uleb128 0x34
 2212 023f 00        		.byte	0
 2213 0240 03        		.uleb128 0x3
 2214 0241 0E        		.uleb128 0xe
 2215 0242 3A        		.uleb128 0x3a
 2216 0243 0B        		.uleb128 0xb
 2217 0244 3B        		.uleb128 0x3b
 2218 0245 0B        		.uleb128 0xb
 2219 0246 49        		.uleb128 0x49
 2220 0247 13        		.uleb128 0x13
 2221 0248 3F        		.uleb128 0x3f
 2222 0249 0C        		.uleb128 0xc
 2223 024a 3C        		.uleb128 0x3c
 2224 024b 0C        		.uleb128 0xc
 2225 024c 00        		.byte	0
 2226 024d 00        		.byte	0
 2227 024e 2C        		.uleb128 0x2c
 2228 024f 34        		.uleb128 0x34
 2229 0250 00        		.byte	0
 2230 0251 03        		.uleb128 0x3
 2231 0252 08        		.uleb128 0x8
 2232 0253 3A        		.uleb128 0x3a
 2233 0254 0B        		.uleb128 0xb
 2234 0255 3B        		.uleb128 0x3b
 2235 0256 0B        		.uleb128 0xb
 2236 0257 49        		.uleb128 0x49
 2237 0258 13        		.uleb128 0x13
 2238 0259 1C        		.uleb128 0x1c
 2239 025a 0B        		.uleb128 0xb
 2240 025b 00        		.byte	0
 2241 025c 00        		.byte	0
 2242 025d 2D        		.uleb128 0x2d
 2243 025e 34        		.uleb128 0x34
 2244 025f 00        		.byte	0
 2245 0260 03        		.uleb128 0x3
 2246 0261 0E        		.uleb128 0xe
 2247 0262 3A        		.uleb128 0x3a
GAS LISTING /tmp/ccNcTpZI.s 			page 49


 2248 0263 0B        		.uleb128 0xb
 2249 0264 3B        		.uleb128 0x3b
 2250 0265 0B        		.uleb128 0xb
 2251 0266 49        		.uleb128 0x49
 2252 0267 13        		.uleb128 0x13
 2253 0268 1C        		.uleb128 0x1c
 2254 0269 0B        		.uleb128 0xb
 2255 026a 00        		.byte	0
 2256 026b 00        		.byte	0
 2257 026c 2E        		.uleb128 0x2e
 2258 026d 01        		.uleb128 0x1
 2259 026e 01        		.byte	0x1
 2260 026f 49        		.uleb128 0x49
 2261 0270 13        		.uleb128 0x13
 2262 0271 01        		.uleb128 0x1
 2263 0272 13        		.uleb128 0x13
 2264 0273 00        		.byte	0
 2265 0274 00        		.byte	0
 2266 0275 2F        		.uleb128 0x2f
 2267 0276 21        		.uleb128 0x21
 2268 0277 00        		.byte	0
 2269 0278 49        		.uleb128 0x49
 2270 0279 13        		.uleb128 0x13
 2271 027a 2F        		.uleb128 0x2f
 2272 027b 05        		.uleb128 0x5
 2273 027c 00        		.byte	0
 2274 027d 00        		.byte	0
 2275 027e 30        		.uleb128 0x30
 2276 027f 34        		.uleb128 0x34
 2277 0280 00        		.byte	0
 2278 0281 03        		.uleb128 0x3
 2279 0282 0E        		.uleb128 0xe
 2280 0283 3A        		.uleb128 0x3a
 2281 0284 0B        		.uleb128 0xb
 2282 0285 3B        		.uleb128 0x3b
 2283 0286 0B        		.uleb128 0xb
 2284 0287 49        		.uleb128 0x49
 2285 0288 13        		.uleb128 0x13
 2286 0289 3F        		.uleb128 0x3f
 2287 028a 0C        		.uleb128 0xc
 2288 028b 02        		.uleb128 0x2
 2289 028c 0A        		.uleb128 0xa
 2290 028d 00        		.byte	0
 2291 028e 00        		.byte	0
 2292 028f 31        		.uleb128 0x31
 2293 0290 35        		.uleb128 0x35
 2294 0291 00        		.byte	0
 2295 0292 49        		.uleb128 0x49
 2296 0293 13        		.uleb128 0x13
 2297 0294 00        		.byte	0
 2298 0295 00        		.byte	0
 2299 0296 32        		.uleb128 0x32
 2300 0297 21        		.uleb128 0x21
 2301 0298 00        		.byte	0
 2302 0299 49        		.uleb128 0x49
 2303 029a 13        		.uleb128 0x13
 2304 029b 2F        		.uleb128 0x2f
GAS LISTING /tmp/ccNcTpZI.s 			page 50


 2305 029c 0B        		.uleb128 0xb
 2306 029d 00        		.byte	0
 2307 029e 00        		.byte	0
 2308 029f 33        		.uleb128 0x33
 2309 02a0 34        		.uleb128 0x34
 2310 02a1 00        		.byte	0
 2311 02a2 03        		.uleb128 0x3
 2312 02a3 0E        		.uleb128 0xe
 2313 02a4 3A        		.uleb128 0x3a
 2314 02a5 0B        		.uleb128 0xb
 2315 02a6 3B        		.uleb128 0x3b
 2316 02a7 05        		.uleb128 0x5
 2317 02a8 49        		.uleb128 0x49
 2318 02a9 13        		.uleb128 0x13
 2319 02aa 3F        		.uleb128 0x3f
 2320 02ab 0C        		.uleb128 0xc
 2321 02ac 02        		.uleb128 0x2
 2322 02ad 0A        		.uleb128 0xa
 2323 02ae 00        		.byte	0
 2324 02af 00        		.byte	0
 2325 02b0 34        		.uleb128 0x34
 2326 02b1 2E        		.uleb128 0x2e
 2327 02b2 00        		.byte	0
 2328 02b3 3F        		.uleb128 0x3f
 2329 02b4 0C        		.uleb128 0xc
 2330 02b5 03        		.uleb128 0x3
 2331 02b6 0E        		.uleb128 0xe
 2332 02b7 3A        		.uleb128 0x3a
 2333 02b8 0B        		.uleb128 0xb
 2334 02b9 3B        		.uleb128 0x3b
 2335 02ba 0B        		.uleb128 0xb
 2336 02bb 49        		.uleb128 0x49
 2337 02bc 13        		.uleb128 0x13
 2338 02bd 3C        		.uleb128 0x3c
 2339 02be 0C        		.uleb128 0xc
 2340 02bf 00        		.byte	0
 2341 02c0 00        		.byte	0
 2342 02c1 35        		.uleb128 0x35
 2343 02c2 2E        		.uleb128 0x2e
 2344 02c3 01        		.byte	0x1
 2345 02c4 3F        		.uleb128 0x3f
 2346 02c5 0C        		.uleb128 0xc
 2347 02c6 03        		.uleb128 0x3
 2348 02c7 0E        		.uleb128 0xe
 2349 02c8 3A        		.uleb128 0x3a
 2350 02c9 0B        		.uleb128 0xb
 2351 02ca 3B        		.uleb128 0x3b
 2352 02cb 0B        		.uleb128 0xb
 2353 02cc 3C        		.uleb128 0x3c
 2354 02cd 0C        		.uleb128 0xc
 2355 02ce 00        		.byte	0
 2356 02cf 00        		.byte	0
 2357 02d0 00        		.byte	0
 2358               		.section	.debug_loc,"",@progbits
 2359               	.Ldebug_loc0:
 2360               	.LLST0:
 2361 0000 0000 0000 		.long	.LFB112
GAS LISTING /tmp/ccNcTpZI.s 			page 51


 2362 0004 0000 0000 		.long	.LCFI0
 2363 0008 0300      		.word	0x3
 2364 000a 92        		.byte	0x92
 2365 000b 20        		.uleb128 0x20
 2366 000c 03        		.sleb128 3
 2367 000d 0000 0000 		.long	.LCFI0
 2368 0011 0000 0000 		.long	.LCFI1
 2369 0015 0300      		.word	0x3
 2370 0017 92        		.byte	0x92
 2371 0018 20        		.uleb128 0x20
 2372 0019 04        		.sleb128 4
 2373 001a 0000 0000 		.long	.LCFI1
 2374 001e 0000 0000 		.long	.LCFI2
 2375 0022 0300      		.word	0x3
 2376 0024 92        		.byte	0x92
 2377 0025 20        		.uleb128 0x20
 2378 0026 05        		.sleb128 5
 2379 0027 0000 0000 		.long	.LCFI2
 2380 002b 0000 0000 		.long	.LCFI3
 2381 002f 0300      		.word	0x3
 2382 0031 92        		.byte	0x92
 2383 0032 20        		.uleb128 0x20
 2384 0033 06        		.sleb128 6
 2385 0034 0000 0000 		.long	.LCFI3
 2386 0038 0000 0000 		.long	.LCFI4
 2387 003c 0300      		.word	0x3
 2388 003e 92        		.byte	0x92
 2389 003f 20        		.uleb128 0x20
 2390 0040 07        		.sleb128 7
 2391 0041 0000 0000 		.long	.LCFI4
 2392 0045 0000 0000 		.long	.LCFI5
 2393 0049 0300      		.word	0x3
 2394 004b 92        		.byte	0x92
 2395 004c 20        		.uleb128 0x20
 2396 004d 08        		.sleb128 8
 2397 004e 0000 0000 		.long	.LCFI5
 2398 0052 0000 0000 		.long	.LCFI6
 2399 0056 0300      		.word	0x3
 2400 0058 92        		.byte	0x92
 2401 0059 20        		.uleb128 0x20
 2402 005a 09        		.sleb128 9
 2403 005b 0000 0000 		.long	.LCFI6
 2404 005f 0000 0000 		.long	.LCFI7
 2405 0063 0300      		.word	0x3
 2406 0065 92        		.byte	0x92
 2407 0066 20        		.uleb128 0x20
 2408 0067 0A        		.sleb128 10
 2409 0068 0000 0000 		.long	.LCFI7
 2410 006c 0000 0000 		.long	.LCFI8
 2411 0070 0300      		.word	0x3
 2412 0072 92        		.byte	0x92
 2413 0073 20        		.uleb128 0x20
 2414 0074 0B        		.sleb128 11
 2415 0075 0000 0000 		.long	.LCFI8
 2416 0079 0000 0000 		.long	.LCFI9
 2417 007d 0300      		.word	0x3
 2418 007f 92        		.byte	0x92
GAS LISTING /tmp/ccNcTpZI.s 			page 52


 2419 0080 20        		.uleb128 0x20
 2420 0081 0C        		.sleb128 12
 2421 0082 0000 0000 		.long	.LCFI9
 2422 0086 0000 0000 		.long	.LCFI10
 2423 008a 0300      		.word	0x3
 2424 008c 92        		.byte	0x92
 2425 008d 20        		.uleb128 0x20
 2426 008e 0D        		.sleb128 13
 2427 008f 0000 0000 		.long	.LCFI10
 2428 0093 0000 0000 		.long	.LCFI11
 2429 0097 0300      		.word	0x3
 2430 0099 92        		.byte	0x92
 2431 009a 20        		.uleb128 0x20
 2432 009b 0E        		.sleb128 14
 2433 009c 0000 0000 		.long	.LCFI11
 2434 00a0 0000 0000 		.long	.LFE112
 2435 00a4 0300      		.word	0x3
 2436 00a6 92        		.byte	0x92
 2437 00a7 20        		.uleb128 0x20
 2438 00a8 0F        		.sleb128 15
 2439 00a9 0000 0000 		.long	0
 2440 00ad 0000 0000 		.long	0
 2441               	.LLST1:
 2442 00b1 0000 0000 		.long	.LVL3
 2443 00b5 0000 0000 		.long	.LVL6
 2444 00b9 0C00      		.word	0xc
 2445 00bb 58        		.byte	0x58
 2446 00bc 93        		.byte	0x93
 2447 00bd 01        		.uleb128 0x1
 2448 00be 59        		.byte	0x59
 2449 00bf 93        		.byte	0x93
 2450 00c0 01        		.uleb128 0x1
 2451 00c1 5A        		.byte	0x5a
 2452 00c2 93        		.byte	0x93
 2453 00c3 01        		.uleb128 0x1
 2454 00c4 5B        		.byte	0x5b
 2455 00c5 93        		.byte	0x93
 2456 00c6 01        		.uleb128 0x1
 2457 00c7 0000 0000 		.long	.LVL6
 2458 00cb 0000 0000 		.long	.LVL9
 2459 00cf 0C00      		.word	0xc
 2460 00d1 5C        		.byte	0x5c
 2461 00d2 93        		.byte	0x93
 2462 00d3 01        		.uleb128 0x1
 2463 00d4 5D        		.byte	0x5d
 2464 00d5 93        		.byte	0x93
 2465 00d6 01        		.uleb128 0x1
 2466 00d7 5E        		.byte	0x5e
 2467 00d8 93        		.byte	0x93
 2468 00d9 01        		.uleb128 0x1
 2469 00da 5F        		.byte	0x5f
 2470 00db 93        		.byte	0x93
 2471 00dc 01        		.uleb128 0x1
 2472 00dd 0000 0000 		.long	0
 2473 00e1 0000 0000 		.long	0
 2474               	.LLST2:
 2475 00e5 0000 0000 		.long	.LVL17
GAS LISTING /tmp/ccNcTpZI.s 			page 53


 2476 00e9 0000 0000 		.long	.LVL26
 2477 00ed 0600      		.word	0x6
 2478 00ef 6C        		.byte	0x6c
 2479 00f0 93        		.byte	0x93
 2480 00f1 01        		.uleb128 0x1
 2481 00f2 6D        		.byte	0x6d
 2482 00f3 93        		.byte	0x93
 2483 00f4 01        		.uleb128 0x1
 2484 00f5 0000 0000 		.long	0
 2485 00f9 0000 0000 		.long	0
 2486               	.LLST3:
 2487 00fd 0000 0000 		.long	.LVL8
 2488 0101 0000 0000 		.long	.LVL9
 2489 0105 0200      		.word	0x2
 2490 0107 30        		.byte	0x30
 2491 0108 9F        		.byte	0x9f
 2492 0109 0000 0000 		.long	.LVL9
 2493 010d 0000 0000 		.long	.LVL32
 2494 0111 0600      		.word	0x6
 2495 0113 60        		.byte	0x60
 2496 0114 93        		.byte	0x93
 2497 0115 01        		.uleb128 0x1
 2498 0116 61        		.byte	0x61
 2499 0117 93        		.byte	0x93
 2500 0118 01        		.uleb128 0x1
 2501 0119 0000 0000 		.long	0
 2502 011d 0000 0000 		.long	0
 2503               	.LLST4:
 2504 0121 0000 0000 		.long	.LVL12
 2505 0125 0000 0000 		.long	.LVL13
 2506 0129 0200      		.word	0x2
 2507 012b 30        		.byte	0x30
 2508 012c 9F        		.byte	0x9f
 2509 012d 0000 0000 		.long	.LVL13
 2510 0131 0000 0000 		.long	.LVL31
 2511 0135 0600      		.word	0x6
 2512 0137 5E        		.byte	0x5e
 2513 0138 93        		.byte	0x93
 2514 0139 01        		.uleb128 0x1
 2515 013a 5F        		.byte	0x5f
 2516 013b 93        		.byte	0x93
 2517 013c 01        		.uleb128 0x1
 2518 013d 0000 0000 		.long	0
 2519 0141 0000 0000 		.long	0
 2520               	.LLST5:
 2521 0145 0000 0000 		.long	.LVL17
 2522 0149 0000 0000 		.long	.LVL18
 2523 014d 0200      		.word	0x2
 2524 014f 30        		.byte	0x30
 2525 0150 9F        		.byte	0x9f
 2526 0151 0000 0000 		.long	.LVL18
 2527 0155 0000 0000 		.long	.LVL26
 2528 0159 0600      		.word	0x6
 2529 015b 5C        		.byte	0x5c
 2530 015c 93        		.byte	0x93
 2531 015d 01        		.uleb128 0x1
 2532 015e 5D        		.byte	0x5d
GAS LISTING /tmp/ccNcTpZI.s 			page 54


 2533 015f 93        		.byte	0x93
 2534 0160 01        		.uleb128 0x1
 2535 0161 0000 0000 		.long	0
 2536 0165 0000 0000 		.long	0
 2537               		.section	.debug_aranges,"",@progbits
 2538 0000 2C00 0000 		.long	0x2c
 2539 0004 0200      		.word	0x2
 2540 0006 0000 0000 		.long	.Ldebug_info0
 2541 000a 04        		.byte	0x4
 2542 000b 00        		.byte	0
 2543 000c 0000      		.word	0
 2544 000e 0000      		.word	0
 2545 0010 0000 0000 		.long	.LFB110
 2546 0014 FC00 0000 		.long	.LFE110-.LFB110
 2547 0018 0000 0000 		.long	.LFB111
 2548 001c 9800 0000 		.long	.LFE111-.LFB111
 2549 0020 0000 0000 		.long	.LFB112
 2550 0024 AC01 0000 		.long	.LFE112-.LFB112
 2551 0028 0000 0000 		.long	0
 2552 002c 0000 0000 		.long	0
 2553               		.section	.debug_ranges,"",@progbits
 2554               	.Ldebug_ranges0:
 2555 0000 0000 0000 		.long	.LBB11
 2556 0004 0000 0000 		.long	.LBE11
 2557 0008 0000 0000 		.long	.LBB18
 2558 000c 0000 0000 		.long	.LBE18
 2559 0010 0000 0000 		.long	0
 2560 0014 0000 0000 		.long	0
 2561 0018 0000 0000 		.long	.LFB110
 2562 001c 0000 0000 		.long	.LFE110
 2563 0020 0000 0000 		.long	.LFB111
 2564 0024 0000 0000 		.long	.LFE111
 2565 0028 0000 0000 		.long	.LFB112
 2566 002c 0000 0000 		.long	.LFE112
 2567 0030 0000 0000 		.long	0
 2568 0034 0000 0000 		.long	0
 2569               		.section	.debug_line,"",@progbits
 2570               	.Ldebug_line0:
 2571 0000 A803 0000 		.section	.debug_str,"MS",@progbits,1
 2571      0200 C601 
 2571      0000 0201 
 2571      FB0E 0A00 
 2571      0101 0101 
 2572               	.LASF72:
 2573 0000 6164 634D 		.string	"adcMeasure"
 2573      6561 7375 
 2573      7265 00
 2574               	.LASF22:
 2575 000b 5F5A 4E35 		.string	"_ZN5Print5writeEPKcj"
 2575      5072 696E 
 2575      7435 7772 
 2575      6974 6545 
 2575      504B 636A 
 2576               	.LASF69:
 2577 0020 6465 636C 		.string	"decltype(nullptr)"
 2577      7479 7065 
 2577      286E 756C 
GAS LISTING /tmp/ccNcTpZI.s 			page 55


 2577      6C70 7472 
 2577      2900 
 2578               	.LASF68:
 2579 0032 5F5A 4E31 		.string	"_ZN14HardwareSerial5beginEmh"
 2579      3448 6172 
 2579      6477 6172 
 2579      6553 6572 
 2579      6961 6C35 
 2580               	.LASF17:
 2581 004f 4861 7264 		.string	"HardwareSerial"
 2581      7761 7265 
 2581      5365 7269 
 2581      616C 00
 2582               	.LASF56:
 2583 005e 6164 634D 		.string	"adcMaxSamples"
 2583      6178 5361 
 2583      6D70 6C65 
 2583      7300 
 2584               	.LASF3:
 2585 006c 7369 7A65 		.string	"size_t"
 2585      5F74 00
 2586               	.LASF53:
 2587 0073 7369 7A65 		.string	"sizetype"
 2587      7479 7065 
 2587      00
 2588               	.LASF14:
 2589 007c 534B 4950 		.string	"SKIP_ALL"
 2589      5F41 4C4C 
 2589      00
 2590               	.LASF38:
 2591 0085 5452 4947 		.string	"TRIG_T1OVF"
 2591      5F54 314F 
 2591      5646 00
 2592               	.LASF47:
 2593 0090 5F61 6463 		.string	"_adc"
 2593      00
 2594               	.LASF30:
 2595 0095 6C6F 6E67 		.string	"long double"
 2595      2064 6F75 
 2595      626C 6500 
 2596               	.LASF75:
 2597 00a1 6465 6C61 		.string	"delay"
 2597      7900 
 2598               	.LASF66:
 2599 00a7 2F68 6F6D 		.string	"/home/arhat109/Arduino"
 2599      652F 6172 
 2599      6861 7431 
 2599      3039 2F41 
 2599      7264 7569 
 2600               	.LASF43:
 2601 00be 7069 6E4E 		.string	"pinNeg"
 2601      6567 00
 2602               	.LASF4:
 2603 00c5 7569 6E74 		.string	"uint8_t"
 2603      385F 7400 
 2604               	.LASF46:
 2605 00cd 7365 7475 		.string	"setup"
GAS LISTING /tmp/ccNcTpZI.s 			page 56


 2605      7000 
 2606               	.LASF34:
 2607 00d3 5452 4947 		.string	"TRIG_INT0"
 2607      5F49 4E54 
 2607      3000 
 2608               	.LASF28:
 2609 00dd 5F5A 4E31 		.string	"_ZN14HardwareSerial5beginEm"
 2609      3448 6172 
 2609      6477 6172 
 2609      6553 6572 
 2609      6961 6C35 
 2610               	.LASF10:
 2611 00f9 626F 6F6C 		.string	"bool"
 2611      00
 2612               	.LASF26:
 2613 00fe 5F5A 4E35 		.string	"_ZN5Print5printEPKc"
 2613      5072 696E 
 2613      7435 7072 
 2613      696E 7445 
 2613      504B 6300 
 2614               	.LASF12:
 2615 0112 666C 6F61 		.string	"float"
 2615      7400 
 2616               	.LASF18:
 2617 0118 5072 696E 		.string	"Print"
 2617      7400 
 2618               	.LASF59:
 2619 011e 6164 634D 		.string	"adcMaxChannels"
 2619      6178 4368 
 2619      616E 6E65 
 2619      6C73 00
 2620               	.LASF8:
 2621 012d 6C6F 6E67 		.string	"long long int"
 2621      206C 6F6E 
 2621      6720 696E 
 2621      7400 
 2622               	.LASF9:
 2623 013b 6C6F 6E67 		.string	"long long unsigned int"
 2623      206C 6F6E 
 2623      6720 756E 
 2623      7369 676E 
 2623      6564 2069 
 2624               	.LASF40:
 2625 0152 5452 4947 		.string	"TRIG_MANUAL"
 2625      5F4D 414E 
 2625      5541 4C00 
 2626               	.LASF32:
 2627 015e 5452 4947 		.string	"TRIG_ROUND"
 2627      5F52 4F55 
 2627      4E44 00
 2628               	.LASF19:
 2629 0169 6F70 6572 		.string	"operator bool"
 2629      6174 6F72 
 2629      2062 6F6F 
 2629      6C00 
 2630               	.LASF71:
 2631 0177 3130 4164 		.string	"10AdcChannel"
GAS LISTING /tmp/ccNcTpZI.s 			page 57


 2631      6343 6861 
 2631      6E6E 656C 
 2631      00
 2632               	.LASF35:
 2633 0184 5452 4947 		.string	"TRIG_T0A"
 2633      5F54 3041 
 2633      00
 2634               	.LASF70:
 2635 018d 3741 4443 		.string	"7ADCTRIG"
 2635      5452 4947 
 2635      00
 2636               	.LASF61:
 2637 0196 6164 6353 		.string	"adcSign"
 2637      6967 6E00 
 2638               	.LASF73:
 2639 019e 6261 7564 		.string	"baud"
 2639      00
 2640               	.LASF33:
 2641 01a3 5452 4947 		.string	"TRIG_COMPARATOR"
 2641      5F43 4F4D 
 2641      5041 5241 
 2641      544F 5200 
 2642               	.LASF5:
 2643 01b3 756E 7369 		.string	"unsigned char"
 2643      676E 6564 
 2643      2063 6861 
 2643      7200 
 2644               	.LASF2:
 2645 01c1 7369 676E 		.string	"signed char"
 2645      6564 2063 
 2645      6861 7200 
 2646               	.LASF25:
 2647 01cd 7072 696E 		.string	"print"
 2647      7400 
 2648               	.LASF0:
 2649 01d3 756E 7369 		.string	"unsigned int"
 2649      676E 6564 
 2649      2069 6E74 
 2649      00
 2650               	.LASF6:
 2651 01e0 7569 6E74 		.string	"uint16_t"
 2651      3136 5F74 
 2651      00
 2652               	.LASF7:
 2653 01e9 6C6F 6E67 		.string	"long unsigned int"
 2653      2075 6E73 
 2653      6967 6E65 
 2653      6420 696E 
 2653      7400 
 2654               	.LASF48:
 2655 01fb 7469 6D65 		.string	"time"
 2655      00
 2656               	.LASF31:
 2657 0200 7368 6F72 		.string	"short unsigned int"
 2657      7420 756E 
 2657      7369 676E 
 2657      6564 2069 
GAS LISTING /tmp/ccNcTpZI.s 			page 58


 2657      6E74 00
 2658               	.LASF67:
 2659 0213 4C6F 6F6B 		.string	"LookaheadMode"
 2659      6168 6561 
 2659      644D 6F64 
 2659      6500 
 2660               	.LASF11:
 2661 0221 6368 6172 		.string	"char"
 2661      00
 2662               	.LASF52:
 2663 0226 4D49 534F 		.string	"MISO"
 2663      00
 2664               	.LASF65:
 2665 022b 2F74 6D70 		.string	"/tmp/arduino_build_753841/sketch/Osciloscope.ino.cpp"
 2665      2F61 7264 
 2665      7569 6E6F 
 2665      5F62 7569 
 2665      6C64 5F37 
 2666               	.LASF37:
 2667 0260 5452 4947 		.string	"TRIG_T1B"
 2667      5F54 3142 
 2667      00
 2668               	.LASF23:
 2669 0269 7072 696E 		.string	"println"
 2669      746C 6E00 
 2670               	.LASF24:
 2671 0271 5F5A 4E35 		.string	"_ZN5Print7printlnEhi"
 2671      5072 696E 
 2671      7437 7072 
 2671      696E 746C 
 2671      6E45 6869 
 2672               	.LASF62:
 2673 0286 6164 6353 		.string	"adcShift"
 2673      6869 6674 
 2673      00
 2674               	.LASF45:
 2675 028f 7468 6973 		.string	"this"
 2675      00
 2676               	.LASF42:
 2677 0294 7069 6E50 		.string	"pinPos"
 2677      6F73 00
 2678               	.LASF60:
 2679 029b 6164 634C 		.string	"adcLevel"
 2679      6576 656C 
 2679      00
 2680               	.LASF21:
 2681 02a4 5F5A 4E31 		.string	"_ZN14HardwareSerialcvbEv"
 2681      3448 6172 
 2681      6477 6172 
 2681      6553 6572 
 2681      6961 6C63 
 2682               	.LASF50:
 2683 02bd 7074 7242 		.string	"ptrBuf"
 2683      7566 00
 2684               	.LASF16:
 2685 02c4 534B 4950 		.string	"SKIP_WHITESPACE"
 2685      5F57 4849 
GAS LISTING /tmp/ccNcTpZI.s 			page 59


 2685      5445 5350 
 2685      4143 4500 
 2686               	.LASF27:
 2687 02d4 6265 6769 		.string	"begin"
 2687      6E00 
 2688               	.LASF44:
 2689 02da 4164 6343 		.string	"AdcChannel"
 2689      6861 6E6E 
 2689      656C 00
 2690               	.LASF39:
 2691 02e5 5452 4947 		.string	"TRIG_T1ICP"
 2691      5F54 3149 
 2691      4350 00
 2692               	.LASF55:
 2693 02f0 6164 6342 		.string	"adcBuffer"
 2693      7566 6665 
 2693      7200 
 2694               	.LASF64:
 2695 02fa 474E 5520 		.string	"GNU C++ 4.9.2 -mn-flash=4 -mmcu=avr6 -g -Os -std=gnu++11 -fpermissive -ffunction-sections
 2695      432B 2B20 
 2695      342E 392E 
 2695      3220 2D6D 
 2695      6E2D 666C 
 2696               	.LASF20:
 2697 03c6 7772 6974 		.string	"write"
 2697      6500 
 2698               	.LASF41:
 2699 03cc 4144 4354 		.string	"ADCTRIG"
 2699      5249 4700 
 2700               	.LASF36:
 2701 03d4 5452 4947 		.string	"TRIG_T0OVF"
 2701      5F54 304F 
 2701      5646 00
 2702               	.LASF54:
 2703 03df 5365 7269 		.string	"Serial"
 2703      616C 00
 2704               	.LASF49:
 2705 03e6 6C6F 6F70 		.string	"loop"
 2705      00
 2706               	.LASF13:
 2707 03eb 646F 7562 		.string	"double"
 2707      6C65 00
 2708               	.LASF15:
 2709 03f2 534B 4950 		.string	"SKIP_NONE"
 2709      5F4E 4F4E 
 2709      4500 
 2710               	.LASF57:
 2711 03fc 6164 6353 		.string	"adcSampleLength"
 2711      616D 706C 
 2711      654C 656E 
 2711      6774 6800 
 2712               	.LASF1:
 2713 040c 6C6F 6E67 		.string	"long int"
 2713      2069 6E74 
 2713      00
 2714               	.LASF51:
 2715 0415 4D4F 5349 		.string	"MOSI"
GAS LISTING /tmp/ccNcTpZI.s 			page 60


 2715      00
 2716               	.LASF63:
 2717 041a 7265 7342 		.string	"resBuffer"
 2717      7566 6665 
 2717      7200 
 2718               	.LASF74:
 2719 0424 6D69 6372 		.string	"micros"
 2719      6F73 00
 2720               	.LASF29:
 2721 042b 5F5A 4E35 		.string	"_ZN5Print7printlnEmi"
 2721      5072 696E 
 2721      7437 7072 
 2721      696E 746C 
 2721      6E45 6D69 
 2722               	.LASF58:
 2723 0440 6164 6343 		.string	"adcChannels"
 2723      6861 6E6E 
 2723      656C 7300 
 2724               		.ident	"GCC: (GNU) 4.9.2"
 2725               	.global __do_copy_data
 2726               	.global __do_clear_bss
GAS LISTING /tmp/ccNcTpZI.s 			page 61


DEFINED SYMBOLS
                            *ABS*:0000000000000000 Osciloscope.ino.cpp
     /tmp/ccNcTpZI.s:2      *ABS*:000000000000003e __SP_H__
     /tmp/ccNcTpZI.s:3      *ABS*:000000000000003d __SP_L__
     /tmp/ccNcTpZI.s:4      *ABS*:000000000000003f __SREG__
     /tmp/ccNcTpZI.s:5      *ABS*:000000000000003b __RAMPZ__
     /tmp/ccNcTpZI.s:6      *ABS*:0000000000000000 __tmp_reg__
     /tmp/ccNcTpZI.s:7      *ABS*:0000000000000001 __zero_reg__
     /tmp/ccNcTpZI.s:14     .text.adcMeasure:0000000000000000 adcMeasure
     /tmp/ccNcTpZI.s:600    .bss.adcChannels:0000000000000000 adcChannels
     /tmp/ccNcTpZI.s:618    .bss.adcBuffer:0000000000000000 adcBuffer
     /tmp/ccNcTpZI.s:612    .data.adcMaxSamples:0000000000000000 adcMaxSamples
     /tmp/ccNcTpZI.s:594    .data.adcMaxChannels:0000000000000000 adcMaxChannels
     /tmp/ccNcTpZI.s:576    .bss.adcShift:0000000000000000 adcShift
     /tmp/ccNcTpZI.s:588    .data.adcLevel:0000000000000000 adcLevel
     /tmp/ccNcTpZI.s:582    .bss.adcSign:0000000000000000 adcSign
     /tmp/ccNcTpZI.s:55     .text.adcMeasure:000000000000004c SAMPLES
     /tmp/ccNcTpZI.s:606    .data.adcSampleLength:0000000000000000 adcSampleLength
     /tmp/ccNcTpZI.s:61     .text.adcMeasure:000000000000005c WAIT_L
     /tmp/ccNcTpZI.s:75     .text.adcMeasure:000000000000007a POS
     /tmp/ccNcTpZI.s:78     .text.adcMeasure:000000000000007e ISOK
     /tmp/ccNcTpZI.s:72     .text.adcMeasure:0000000000000076 FOUNDED
     /tmp/ccNcTpZI.s:91     .text.adcMeasure:0000000000000098 START_ADC
     /tmp/ccNcTpZI.s:87     .text.adcMeasure:0000000000000092 SHIFT
     /tmp/ccNcTpZI.s:95     .text.adcMeasure:00000000000000a2 MEASURE
     /tmp/ccNcTpZI.s:97     .text.adcMeasure:00000000000000a4 CHANNEL
     /tmp/ccNcTpZI.s:102    .text.adcMeasure:00000000000000ac LAST_CH
     /tmp/ccNcTpZI.s:105    .text.adcMeasure:00000000000000b0 SET_NEXT
     /tmp/ccNcTpZI.s:108    .text.adcMeasure:00000000000000b6 WAIT_D
     /tmp/ccNcTpZI.s:150    .text.setup:0000000000000000 setup
     /tmp/ccNcTpZI.s:254    .text.loop:0000000000000000 loop
     /tmp/ccNcTpZI.s:570    .bss.resBuffer:0000000000000000 resBuffer

UNDEFINED SYMBOLS
Serial
_ZN14HardwareSerial5beginEmh
micros
_ZN5Print5printEPKc
_ZN5Print7printlnEmi
_ZN5Print7printlnEhi
delay
__do_copy_data
__do_clear_bss
