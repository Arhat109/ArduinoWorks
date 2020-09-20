
extern "C" {

typedef enum {REF_AREF=0, REF_AVCC=64, REF_1V=128, REF_256V=192} ADCREF;
typedef enum {TRIG_ROUND=0, TRIG_COMPARATOR, TRIG_INT0, TRIG_T0A, TRIG_T0OVF, TRIG_T1B, TRIG_T1OVF, TRIG_T1ICP, TRIG_MANUAL} ADCTRIG;
typedef enum {
  MUX_0=0, MUX_1, MUX_2, MUX_3, MUX_4, MUX_5, MUX_6, MUX_7,
  MUX_G10_00, MUX_G10_10, MUX_G200_00, MUX_G200_10,
  MUX_G10_22, MUX_G10_32, MUX_G200_22, MUX_G200_32,
  MUX_D01, MUX_D11, MUX_D21, MUX_D31, MUX_D41, MUX_D51, MUX_D61, MUX_D71,
  MUX_D02, MUX_D12, MUX_D22, MUX_D32, MUX_D42, MUX_D52,
  MUX_1V,  MUX_GND,
  MUX_8, MUX_9, MUX_A, MUX_B, MUX_C, MUX_D, MUX_E, MUX_F,
  MUX_G10_88, MUX_G10_98, MUX_G200_88, MUX_G200_98,
  MUX_G10_AA, MUX_G10_BA, MUX_G200_AA, MUX_G200_BA,
  MUX_D89, MUX_D99, MUX_DA9, MUX_DB9, MUX_DC9, MUX_DD9, MUX_DE9, MUX_DF9,
  MUX_D8A, MUX_D9A, MUX_DAA, MUX_DBA, MUX_DCA, MUX_DDA
} ADCMUX;
/*
#define adcStart()   (ADCSRA |= (1<<ADSC))
#define adc8bit()    (ADMUX |= (1<<ADLAR))
#define adc10bit()   (ADMUX &= ~(1<<ADLAR))
#define adcIntOn()   (ADCSRA |= (1<<ADIE))
#define adcIntOff()  (ADCSRA &= ~(1<<ADIE))
#define adc2comp()   (ADCSRB |= (1<<ACME))
*/
// ADMUX:  REFS1(7), REFS0(6), ADLAR(5), MUX4..0
// ADCSRA: ADEN(7), ADSC(6), ADATE(5), ADIF(4), ADIE(3), ADPS0..2
// ADCSRB: ACME(6), ADMUX5(3),ADTS0..2
// DIDR0:  Closed PINx for noise redusing ADC7..0
// DIDR2:  Closed PINx for noise reducing ADC15..8
// PRR0:   bit0=1 ADC power off!

typedef struct{
  uint8_t    mux;    // prepared before the ADMUX for channel
  uint8_t    pinPos; // to future..
  uint8_t    pinNeg; // to future..
} AdcChannel;

#define ADC_SAMPLE_LENGTH   500
#define ADC_MAX_CHANNELS      1
#define ADC_MAX_SAMPLES       1
#define ADC_MAX_BUFFER     ADC_SAMPLE_LENGTH * ADC_MAX_CHANNELS * ADC_MAX_SAMPLES

volatile uint8_t      adcBuffer[ADC_MAX_BUFFER];        /** ADC results buffer for all samples and measures */
volatile uint8_t      adcMaxSamples  =ADC_MAX_SAMPLES;  /** Current repeated samples for each channels */
volatile uint16_t     adcSampleLength=ADC_SAMPLE_LENGTH;/** Current one channel sample length <= ADC_MAX_BUFFER / adcMaxChannels / adcMaxSamples! */

volatile AdcChannel   adcChannels[ADC_MAX_CHANNELS];    /** All channels data */
volatile uint8_t      adcMaxChannels = ADC_MAX_CHANNELS;/** Current channels in work [0..ADC_MAX_CHANNELS-1] */

volatile uint8_t      adcLevel=32;                      /** Current sinhrolevel for start in ADC uints [0..255] */
volatile uint8_t      adcSign=0;                        /** Current edge sinhro level to pos[0] or to neg[!0]   */
volatile uint8_t      adcShift=0;                       /** Current max strobe shift for last sample [decremented by 250us!]            */

#define adcWaitInt() {while(!(ADCSRA&(1<<ADSC)));}
#define adcRead1(p) { adcWaitInt(); (p)=ADCH; ADCSRA |= (1<<ADSC);}
#define delayMicro16(__count) \
  __asm__ __volatile__ (      \
    "1: sbiw %0,1 \n\t"       \
       "brne 1b\n\t"          \
       :: "w" (__count)       \
)

/**
 * Fill measures buffer for all channels with presetted channel data, sinhro-level, etc.
 * Before: ADC must be set into free running mode!
 * USAGE:
 *  r16,17,30,31 -- ptr for adcChannels
 *  r28,29       -- ptr for adcBuffer
 *  r26          -- adcMaxSamples
 *  r24,25       -- adcSampleLength
 *  r23          -- adcMaxChannels
 *  r22          -- adcShift
 *  r21          -- adcLevel
 *  r20          -- adcSign
 *  r19,r18 -- local temporary usage
 * All registers and SREG are push/pop into procedure!!!
 */
void adcMeasure()
{
/*
  asm volatile(
    "    push r16 \n\t"
    "    push r17 \n\t"
    "    push r18 \n\t"
    "    push r19 \n\t"
    "    push r20 \n\t"
    "    push r21 \n\t"
    "    push r22 \n\t"
    "    push r23 \n\t"
    "    push r24 \n\t"
    "    push r25 \n\t"
    "    push r26 \n\t"
    "    push r27 \n\t"
    "    push r28 \n\t"
    "    push r29 \n\t"
    "    push r30 \n\t"
    "    push r31 \n\t"
    "    in   r31,__SREG__ \n\t"
    "    push r31          \n\t"
    "    lds  r16,adcChannels       ; ptrCh=adcChannels;           \n\t"
    "    lds  r17,adcChannels+1     ;                              \n\t"
    "    mov  r30,r16               ; current doublicate!          \n\t"
    "    mov  r31,r17               ;                              \n\t"
    "    lds  r28,adcBuffer         ; buf=adcBuffer;               \n\t"
    "    lds  r29,adcBuffer+1       ;                              \n\t"
    "    lds  r26,adcMaxSamples     ; samples=adcMaxSamples;       \n\t"
    "    lds  r23,adcMaxChannels    ; numCh = adcMaxChannels;      \n\t"
    "    lds  r22,adcShift          ; shift=adcShift;              \n\t"
    "    lds  r21,adcLevel          ; level=adcLevel;              \n\t"
    "    lds  r20,adcSign           ; sign=adcSign;                \n\t"
    "SAMPLES:                       ; do{                          \n\t"
    "    lds  r24,adcSampleLength   ; 19.measure=adcSampleLength;  \n\t"
    "    lds  r25,adcSampleLength   ; .                            \n\t"
// 0. Prepare ADMUX for channel[0]:
    "    ld   r18,Z                 ; .ADMUX = ptrCh->mux;         \n\t"
    "    sts  0x007c,r18            ; .                            \n\t"
// 1. search sinhrolevel:
    "    clr  r19                   ; .isOk = false                \n\t"
// 1.1. wait ADIF and read ADC data:
    "WAIT_L:                        ; ..while(ADCSRA&(1<<ADIF)==0); \n\t"
    "    lds  r18,122               ; 0...                           \n\t"
    "    sbrs r18,4                 ; 2...                           \n\t"
    "    rjmp WAIT_L                ; ...                           \n\t"
    "    andi r18,lo8(-17)          ; 4..ADCSRA &= ~(1<<ADIF);       \n\t"
    "    sts  122,r18               ; 5..                            \n\t"
    "    lds  r18,121               ; 7.._t = ADCH;                  \n\t"
// 1.2. control sinhro-level:
    "    cp   r18,r21               ; 9..SREG = ADCH ? level;        \n\t"
    "    sbrs r20,0                 ; 10..if( sign == 1)skip POS;    \n\t"
    "    rjmp POS                   ; 11                             \n\t"
    "    brlo ISOK                  ; 12..go if (NEG & LT)           \n\t"
    "FOUNDED:                       ;                               \n\t"
    "    ldi  r19,1                 ; ..NEG,POS are founded!        \n\t"
    "    rjmp WAIT_L                ; ..continue;                   \n\t"
    "POS:                           ;                               \n\t"
    "    brsh ISOK                  ; ..go if (POS & GE)            \n\t"
    "    rjmp FOUNDED               ;                               \n\t"
    "ISOK:                          ;                               \n\t"
    "    sbrs r19,0                 ; 14(15)..level is ok - start!  \n\t"
    "    rjmp WAIT_L                ; ..not founded - continue      \n\t"
// 2. Make shift for next sample if need:
    "    lds  r18,0x007a            ; 16(17)...stop ADC!            \n\t"
    "    andi r18,lo8(223)          ; 18...ADCSRA &= ~(1<<ADATE)    \n\t"
    "    sts  0x007a,r18            ; 19...                         \n\t"
    "    cpi  r22,0                 ; 21.if( _shift == 0 )          \n\t"
    "    breq START_ADC             ; 22.skip shift delay           \n\t"
    "    mov  r18,r22               ; 23._t=shift;                  \n\t"
    "SHIFT:                         ;                               \n\t"
    "    dec  r18                   ; 24/27.._t--                   \n\t"
    "    brne SHIFT                 ; 25/28.delay _t*250us          \n\t"
    "    dec  r22                   ; 26/29.shift--;                \n\t"
    "START_ADC:                     ;                               \n\t"
    "    lds  r18,0x007a            ; 24/27/30...start ADC!         \n\t"
    "    ori  r18,lo8(32)           ; 26/...ADCSRA |= (1<<ADATE)    \n\t"
    "    sts  0x007a,r18            ; 27/...                        \n\t"
// 3. start all measures for 1 sample:
    "MEASURE:                       ; .do{//measures    \n\t"
    "    mov  r19,r23               ; 29(+3)..numCh = adcMaxChannels;  \n\t"
    "CHANNEL:                       ; ..do{//channels                  \n\t"
// 3.1 prepare next admux before read!
    "    dec  r19                   ; 31...if( --_numChannel > 0 )    \n\t"
    "    breq LAST_CH               ; 32...goto else                  \n\t"
    "    adiw r30,3                 ; 33....ptrCh++; (sizeof()=3!)    \n\t"
    "    rjmp SET_NEXT              ; 34....                          \n\t"
    "LAST_CH:                       ; ...else                         \n\t"
    "    mov  r30,r16               ; 34....ptrCh=adcChannels;        \n\t"
    "    mov  r31,r17               ; 35....                          \n\t"
    "SET_NEXT:                      ;                                 \n\t"
    "    ld   r18,Z                 ; 36...ADMUX= ptrCh->mux;         \n\t"
    "    sts  0x007c,r18            ; 37...                           \n\t"
// 2.2 wait and get ADC result:
    "WAIT_2:                        ; ...while(ADCSRA&(1<<ADIF)==0); \n\t"
    "    lds  r18,122               ; 0...                           \n\t"
    "    sbrs r18,4                 ; 2...                           \n\t"
    "    rjmp WAIT_2                ; ...                           \n\t"
    "    andi r18,lo8(-17)          ; 4..ADCSRA &= ~(1<<ADIF);       \n\t"
    "    sts  122,r18               ; 5..                            \n\t"
    "    lds  r18,121               ; 7.._t = ADCH;                  \n\t"
    "    st   Y+,r18                ; 9...                           \n\t"
    "    tst  r19                   ; 11..}while( numCh > 0 );       \n\t"
    "    brne CHANNEL               ; 12..                           \n\t"
    "    sbiw r24,1                 ; 13.}while(--_measures > 0 );   \n\t"
    "    brne MEASURE               ; 15.                            \n\t"
    "    dec  r26                   ; 16}while( --_samples>0 );      \n\t"
    "    brne SAMPLES               ; 17                             \n\t"
    "    pop  r31          \n\t"
    "    out  __SREG__,r31 \n\t"
    "    pop  r31 \n\t"
    "    pop  r30 \n\t"
    "    pop  r29 \n\t"
    "    pop  r28 \n\t"
    "    pop  r27 \n\t"
    "    pop  r26 \n\t"
    "    pop  r25 \n\t"
    "    pop  r24 \n\t"
    "    pop  r23 \n\t"
    "    pop  r22 \n\t"
    "    pop  r21 \n\t"
    "    pop  r20 \n\t"
    "    pop  r19 \n\t"
    "    pop  r18 \n\t"
    "    pop  r17 \n\t"
    "    pop  r16 \n\t"
  ::);
*/
  AdcChannel * _ptrChannel = (AdcChannel *)adcChannels;
  uint8_t    * _buf        = (uint8_t *)adcBuffer;
  uint16_t     _measures;
  uint8_t      _samples    = adcMaxSamples;
  uint8_t      _level      = adcLevel;
  uint8_t      _sign       = adcSign;
  uint8_t      _shift      = adcShift;
  
  uint8_t      _adc, _isSign, _numChannel;

  // 0. Prepare ADMUX for channel[0]:
  ADMUX = _ptrChannel->mux;
  ADCSRA &= ~(1<<ADIF);
  do{
/*    // 1. search sinhrolevel:
    _isSign = 0;
    do{
_LEVEL:
      adcRead1(_adc);
      switch(_sign){
      case 0: //to positive //
          if( _adc < _level ){ _isSign = 1; goto _LEVEL; }
        break;
      case 1: // to negative //
          if( _adc > _level ){ _isSign = 1; goto _LEVEL; }
        break;
      }
    }while(_isSign == 0);

    // 2. Make shift for next sample if need:
    if( _shift > 0 ){ delayMicro16( (int)_shift); }
*/
    // 3. start measure for 1 sample:
    _measures   = adcSampleLength;
    do{
//      _numChannel = adcMaxChannels;
//      do{
        // 2.2 wait and get ADC result:
        adcRead1(_adc);
        *_buf++ = _adc;
        // 2.1 prepare next measure before read!
//        if( --_numChannel > 0 ){ _ptrChannel++;             }
//        else                   { _ptrChannel = (AdcChannel *)adcChannels; }
//        ADMUX = _ptrChannel->mux;
//      }while( _numChannel > 0 );
    }while(--_measures > 0 );
  }while( --_samples>0 );

}

#define MAX_RESULT (ADC_SAMPLE_LENGTH * ADC_MAX_CHANNELS)
uint8_t    resBuffer[MAX_RESULT];

}

void setup() {
  uint8_t _adc;
  unsigned long time;

  asm volatile ("nop \n\t"::);
  Serial.begin(9600);
  while (!Serial);

  TCCR1A = 128+32+8+1; // A,B,C normal + 01 - WGM1,WGM0 "1mode:PhaseCorrectPWM255"
  TCCR1B = 0+2;        // WGM3,WGM2=01-"5mode:FastPWM255", Prescaler:1=16Mhz, 2=2Mhz 
  OCR1A = 192;
  OCR1B = 128;
  OCR1C = 64;
  DDRB = _BV(5)|_BV(6)|_BV(7);   // T1 A,B,C for ATmega128a,ATmega2560

//  Serial.print("ADIF="); Serial.println(ADCSRA&(1<<ADIF), DEC);
  ADMUX = 64|32|0; // src=+5v + ADLAR<-left + port A0
//  DIDR0 = 1;
//  ADCSRB = TRIG_ROUND;
//  ADCSRA = (1<<ADEN) | (1<<ADSC) | (1<<ADATE) | 1; // 1:2 = 8Mhz
//  ADCSRA = (1<<ADEN) | (1<<ADSC) | (1<<ADFR) | 3; // 1:2 = 8Mhz
  ADCSRA = (1<<ADEN) | (1<<ADSC) | 3; // 1:2 = 8Mhz
  adcRead1(adcBuffer[0]);
//  ADCSRA &= ~(1<<ADIF);
/*
  time = micros();
  adcRead1(adcBuffer[0]);
  adcRead1(adcBuffer[1]);
  adcRead1(adcBuffer[2]);
  adcRead1(adcBuffer[3]);
  adcRead1(adcBuffer[4]);
  adcRead1(adcBuffer[5]);
  adcRead1(adcBuffer[6]);
  adcRead1(adcBuffer[7]);
  adcRead1(adcBuffer[8]);
  adcRead1(adcBuffer[9]);
  time = micros()-time;

  Serial.print("time="); Serial.println(time, DEC);
  Serial.print("ADIF="); Serial.println(ADCSRA&(1<<ADIF), DEC);
  for(uint8_t i=0; i<10; i++){ Serial.println(adcBuffer[i], DEC);}
*/
//  adcMaxChannels = 1;
  adcMaxSamples = 1;
  adcLevel = 20;
  adcChannels[0].mux = 64|32|0; // +5v, ADCH, pin A2
//  adcChannels[1].mux = 64|32|0; // +5v, ADCH, pin A0
  for(int i=0; i<ADC_MAX_BUFFER; i++){ adcBuffer[i]=0; }

//  Serial.println("ASCII Table ~ Character Map");
}

void loop() {

  int i,j;
  unsigned long time;
//  uint8_t * ptrRes;
  uint8_t * ptrBuf;

//  delay(5000);
  time = micros();
  adcMeasure();
  time = micros()-time;
//  Serial.print("time="); Serial.println(time, DEC);
/*
  ptrRes = resBuffer;
  ptrBuf = adcBuffer;
  for(i=0; i<adcSampleLength; i++){
    for(j=0; j<adcMaxChannels; j++){
      *ptrRes++ = *ptrBuf++;
    }
  }

//  Serial.print("Hello!");
  for(int k=0; k<adcMaxChannels; k++){
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    ptrBuf = (uint8_t *)adcBuffer + 1;
    for(int j=0; j<adcMaxSamples; j++){
      Serial.println(adcLevel, DEC);
      Serial.println(adcLevel, DEC);
      Serial.println(adcLevel, DEC);
      Serial.println(adcLevel, DEC);
      Serial.println(adcLevel, DEC);
      Serial.println(adcLevel, DEC);
      Serial.println(adcLevel, DEC);
      for(int i=0; i<adcSampleLength; i++){
        Serial.println( *ptrBuf, DEC);
        ptrBuf += 2;
      }
    }
  }
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);
*/
  // прямой вывод всего буфера:
  ptrBuf = (uint8_t *)adcBuffer;
  for(int i=0; i<(adcSampleLength*adcMaxSamples*adcMaxChannels); i++){
    Serial.println( *ptrBuf++, DEC);
  }

  delay(5000);

}

