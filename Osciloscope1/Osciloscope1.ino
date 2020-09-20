
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

#define ADC_SAMPLE_LENGTH   250
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

#define adcWaitM()  {while((ADCSRA&(1<<ADSC))!=0);}
#define adcReadM(p) { adcWaitM(); (p)=ADCH; ADCSRA |= (1<<ADSC);}

#define adcWaitI()  {while((ADCSRA&(1<<ADIF))==0);}
#define adcReadI(p) { adcWaitI(); (p)=ADCH; ADCSRA |= (1<<ADIF);}

#define adcRead(p) adcReadI(p)

#define delayMicro16(__count) \
  __asm__ __volatile__ (      \
    "1: sbiw %0,1 \n\t"       \
       "brne 1b\n\t"          \
       :: "w" (__count)       \
)

void adcMeasure()
{
//  AdcChannel * _ptrChannel = (AdcChannel *)adcChannels;
  uint8_t    * _buf        = (uint8_t *)adcBuffer;
  uint16_t     _measures;
  uint8_t      _samples    = adcMaxSamples;
  uint8_t      _level      = adcLevel;
  uint8_t      _sign       = adcSign;
  uint8_t      _shift1      = adcShift;
  uint8_t      _adc, _isSign, _shift2;

  // 0. Prepare ADMUX for channel[0]:
//  ADMUX = _ptrChannel->mux;
//  ADCSRA |= (1<<ADIF);
//  ADCSRA |= (1<<ADSC);
  do{
    // 1. search sinhrolevel:
    _isSign = 0;
    do{
_LEVEL:
      adcRead(_adc);
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
    _shift2 = _shift1;
    ADCSRA &= ~(1<<ADSC);
    if( _shift1 > 0 ){ while(_shift2-- != 0); _shift1--; }
    ADCSRA |= (1<<ADSC);

    // 3. start measure for 1 sample:
    _measures   = adcSampleLength;
//    ADCSRA |= (1<<ADIF);
    do{
//      _numChannel = adcMaxChannels;
//      do{
        // 2.2 wait and get ADC result:
        adcRead(_adc);
        *_buf++ = _adc;
        // 2.1 prepare next measure before read!
//        if( --_numChannel > 0 ){ _ptrChannel++;             }
//        else                   { _ptrChannel = (AdcChannel *)adcChannels; }
//        ADMUX = _ptrChannel->mux;
//      }while( _numChannel > 0 );
    }while(--_measures > 0 );
  }while( --_samples>0 );
}

} // extern "C"

void setup()
{
  unsigned long time;

  Serial.begin(115200);
//  while (!Serial);

  TCCR1A = 128+32+8+1; // A,B,C normal + 01 - WGM1,WGM0 "1mode:PhaseCorrectPWM255"
  TCCR1B = 0+2;        // WGM3,WGM2=01-"5mode:FastPWM255", Prescaler:1=16Mhz, 2=2Mhz 
  OCR1A = 192;
  OCR1B = 128;
  OCR1C = 64;
  DDRB = _BV(5)|_BV(6)|_BV(7);   // T1 A,B,C for ATmega128a,ATmega2560

//  Serial.print("1 ADIF="); Serial.println(ADCSRA&(1<<ADIF), DEC);
  ADMUX = 64|32|0; // src=+5v + ADLAR<-left + port A0
//  DIDR0 = 1;
//  ADCSRB = TRIG_ROUND;
//  ADCSRA = (1<<ADEN) | (1<<ADSC) | (1<<ADATE) | 1; // 1:2 = 8Mhz
  ADCSRA = (1<<ADEN) | (1<<ADSC) | (1<<ADFR) | 2; // 1:2 = 8Mhz
//  ADCSRA = (1<<ADEN) | (1<<ADSC) | 1; // 1:2 = 8Mhz
  adcRead(adcBuffer[0]);
/*
  time = micros();
  adcRead(adcBuffer[0]);
  adcRead(adcBuffer[1]);
  adcRead(adcBuffer[2]);
  adcRead(adcBuffer[3]);
  adcRead(adcBuffer[4]);
  adcRead(adcBuffer[5]);
  adcRead(adcBuffer[6]);
  adcRead(adcBuffer[7]);
  adcRead(adcBuffer[8]);
  adcRead(adcBuffer[9]);
  time = micros()-time;

  Serial.print("time="); Serial.println(time, DEC);
  Serial.print("2 ADIF="); Serial.println(ADCSRA&(1<<ADIF), DEC);
  for(uint8_t i=0; i<10; i++){ Serial.println(adcBuffer[i], DEC);}
*/
//  adcMaxChannels = 1;
//  adcMaxSamples = 1;
  adcLevel = 20;
  adcShift = 0;
  adcChannels[0].mux = 64|32|0; // +5v, ADCH, pin A0
//  adcChannels[1].mux = 64|32|2; // +5v, ADCH, pin A2
  for(int i=0; i<ADC_MAX_BUFFER; i++){ adcBuffer[i]=0; }

//  Serial.println("ASCII Table ~ Character Map");
}

void loop() {

  unsigned long time;
  uint8_t * ptrBuf;
  uint16_t avgSum;

  delay(5000);
  time = micros();
  adcMeasure();
  time = micros()-time;
//  Serial.print("time="); Serial.println(time, DEC);

//  Serial.print("Average samples > 0");
    for(int j=0; j<adcSampleLength; j++){
      ptrBuf = (uint8_t *)adcBuffer + j; // + (adcMaxSamples-1)*adcSampleLength;
      avgSum = 0;
      for(int i=0; i<adcMaxSamples; i++){
        avgSum += (*ptrBuf);
        ptrBuf += adcSampleLength;
      }
      Serial.println( avgSum/adcMaxSamples, DEC);
    }
/*
//  Serial.print("Shift > 0");
    for(int j=0; j<adcSampleLength; j++){
      ptrBuf = (uint8_t *)adcBuffer + j; // + (adcMaxSamples-1)*adcSampleLength;
      for(int i=0; i<adcMaxSamples; i++){
        Serial.println( *ptrBuf, DEC);
        ptrBuf += adcSampleLength;
      }
    }
/*
//  Serial.print("Channels > 1");
  for(int k=0; k<adcMaxChannels; k++){
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    Serial.println(adcLevel, DEC);
    ptrBuf = (uint8_t *)adcBuffer + k;
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
        ptrBuf += adcMaxChannels;
      }
    }
  }
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);
  Serial.println(adcLevel, DEC);

  // прямой вывод всего буфера:
  ptrBuf = (uint8_t *)adcBuffer;
  for(int i=0; i<(adcSampleLength*adcMaxSamples*adcMaxChannels); i++){
    Serial.println( *ptrBuf++, DEC);
  }
*/
//  delay(50000);

}

