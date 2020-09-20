/**
 * Тестовый скетч для проверки скорости и точности работы АЦП мег
 * в качестве исходного сигнала используется таймер Т1, с разным ШИМ
 * А = 3/4 периода, В = 1/2 и С = 1/4
 * Сигнал снимается со входа А0 в 8 бит с опорным напряжением +5в.
 *
 * 1. Проверка оверсэмплинга замеров за несколько периодов сигнала со сдвигом начала замера
 *
 * @author Arhat109
 * @author Arhat109-20180526 last modified !!! НЕДОПИСАН !!!
 * Arduino IDE v.1.6.4.
 */
extern "C" {

// макро функции для наглядности кода:
// запуск замеров, автосдвиг результата в ADCH для 8битного чтения
// старт/стоп обработчика прерывания, подключение АЦП к компаратору
#define adcStart()   (ADCSRA |=  _BV(ADSC))
#define adc8bit()    (ADMUX  |=  _BV(ADLAR))
#define adc10bit()   (ADMUX  &= ~_BV(ADLAR))
#define adcIntOn()   (ADCSRA |=  _BV(ADIE))
#define adcIntOff()  (ADCSRA &= ~_BV(ADIE))
#define adc2comp()   (ADCSRB |=  _BV(ACME))

// ADMUX:  REFS1(7), REFS0(6), ADLAR(5), MUX4..0
// ADCSRA: ADEN(7), ADSC(6), ADATE(5), ADIF(4), ADIE(3), ADPS0..2
// ADCSRB: ACME(6), ADMUX5(3),ADTS0..2
// DIDR0:  Closed PINx for noise redusing ADC7..0
// DIDR2:  Closed PINx for noise reducing ADC15..8
// PRR0:   bit0=1 ADC power off!

// ==================================== ГЛОБАЛЫ для хранения данных ================================ //

// Место под чтение сигнала: 4 блока по 160 байт = 640.
#define ADC_BUF_SIZE  160
#define ADC_BUFFERS     4
#define ADC_START       1
#define ADC_STOP        0
#define ADC_DONE        2


volatile int       adcCount;  // how much need to read samples
volatile uint8_t * adcBuffer; // pointer to buffer array
volatile uint16_t  adcDelay;  // delay to start ADC run in 250us for 1

uint8_t   adcLevel;                       // sinhro level 0..255
uint8_t   adcSign;                        // >0 - positive sinhro, <0 - negative, =0 not sinhro
uint8_t * adcBuffers[ADC_BUFFERS];        // buffers for adc signals

volatile uint8_t   adcState = ADC_START;

// ============================================== вариант ASM функций ============================== //

// ATmega128a имеет АЦП на других регистрах:
#define _adcRead128a()         \
    "     sbi  0x06,6    \n\t" \
    ".ADC_WAIT:          \n\t" \
    "     sbic 0x06,6    \n\t" \
    "     jmp  .ADC_WAIT \n\t" \
    "     in   r24,0x5   \n\t"

// ATmega328.. ATmega2560.. читаем байт так:
#define _adcRead2560()           \
    "     lds  r24,0x007A  \n\t" \
    "     ori  r24,lo8(64) \n\t" \
    "     sts  0x007A,r24  \n\t" \
    ".ADC_WAIT:            \n\t" \
    "     lds  r24,0x007A  \n\t" \
    "     sbrc r24,6       \n\t" \
    "     jmp  .ADC_WAIT   \n\t" \
    "     lds  r24,0x0079  \n\t" \
    "     nop              \n\t"

#define _adcProlog()                  \
  asm volatile(                       \
    "     push r24              \n\t" \
    "     push r28              \n\t" \
    "     push r29              \n\t" \
    "     push r30              \n\t" \
    "     push r31              \n\t" \
    "     lds  r30,adcBuffer    \n\t" \
    "     lds  r31,adcBuffer+1  \n\t" \
    "     lds  r28,adcDelay     \n\t" \
    "     lds  r29,adcDelay+1   \n\t" \
    "     or   r28,r29          \n\t" \
    "     breq .ADC_SKIP        \n\t" \
    "     nop                   \n\t" \
    ".ADC_DELAY:                \n\t" \
    "     sbiw r28,1            \n\t" \
    "     brne .ADC_DELAY       \n\t" \
    "     nop                   \n\t" \
    ".ADC_SKIP:                 \n\t" \
    "     lds  r28,adcCount     \n\t" \
    "     lds  r29,adcCount+1   \n\t" \
    ".ADC_LOOP:                 \n\t"

#define _adcEpilog()           \
    "     st   Z+,r24    \n\t" \
    "     sbiw r28,1     \n\t" \
    "     brne .ADC_LOOP \n\t" \
    ".ADC_END2:          \n\t" \
    "     pop  r31       \n\t" \
    "     pop  r30       \n\t" \
    "     pop  r29       \n\t" \
    "     pop  r28       \n\t" \
    "     pop  r24       \n\t" \
  ::)

/**
 * asm: fill adcBuffer[adcCount] from ADCH, starting: adcDelay*250us [0..]
 * 
 * prolog to first measure: +30*CPU fixed
 * epilog after last measure: +14*CPU fixed
 * F_CPU=16MHz:
 * ATmega128a = 11*CPU (ADPS=(1:2) => 400kHz    => 40*CPU)
 * ATmega2560 = 19*CPU (ADPS=(1:2) => 333.33kHz => 48*CPU)
 */
void adcReadBuffer0()
{
  _adcProlog()
#if defined(__AVR_ATmega128A__)
  _adcRead128a()
#elif defined(__AVR_ATmega2560__)
  _adcRead2560()
#else
#error *** Not defined read proc for this CPU type!!!
#endif
  _adcEpilog();
}

/**
 * fill buffer with offset 1*CPU
 * @see adcReadBuffer0()
 */
void adcReadBuffer1()
{
  _adcProlog()
  " nop \n\t"
#if defined(__AVR_ATmega128A__)
  _adcRead128a()
#elif defined(__AVR_ATmega2560__)
  _adcRead2560()
#else
#error *** Not defined read proc for this CPU type!!!
#endif
  _adcEpilog();
}

/**
 * fill buffer with offset 2*CPU
 * @see adcReadBuffer0()
 */
void adcReadBuffer2()
{
  _adcProlog()
  " nop \n\t"
  " nop \n\t"
#if defined(__AVR_ATmega128A__)
  _adcRead128a()
#elif defined(__AVR_ATmega2560__)
  _adcRead2560()
#else
#error *** Not defined read proc for this CPU type!!!
#endif
  _adcEpilog();
}

/**
 * fill buffer with offset 3*CPU
 * @see adcReadBuffer0()
 */
void adcReadBuffer3()
{
  _adcProlog()
  " nop \n\t"
  " nop \n\t"
  " nop \n\t"
#if defined(__AVR_ATmega128A__)
  _adcRead128a()
#elif defined(__AVR_ATmega2560__)
  _adcRead2560()
#else
#error *** Not defined read proc for this CPU type!!!
#endif
  _adcEpilog();
}

/**
 * sinhro-looker for start fill buffers by positive level
 */
void adcLookerPos()
{
  for(uint8_t num=0; num<ADC_BUFFERS; num++)
  {
    asm volatile (
      "    push r24          \n\t"
      "    push r31          \n\t"
      "    lds  r31,adcLevel \n\t"
      ".ADCL_DO:             \n\t"
#if defined(__AVR_ATmega128A__)
  _adcRead128a()
#elif defined(__AVR_ATmega2560__)
  _adcRead2560()
#else
#error *** Not defined read proc for this CPU type!!!
#endif
      "    cmp  r24,r31   \n\t"
      "    brlo .ADCL_DO  \n\t"
    );
    adcBuffer = adcBuffers[num];
    adcCount  = ADC_BUF_SIZE;
    adcDelay  = num;
    adcReadBuffer0();
    asm volatile (
      "    pop  r31       \n\t"
      "    pop  r24       \n\t"
    );
  }
}

/**
 * Процедура чтения АЦП (8бит старших) в обработчике прерывания .. медленно и пичально.
 */
ISR (ADC_vect, ISR_NAKED)
{
  asm volatile(
    "     push r24              \n\t"
    "     in   r24,__SREG__     \n\t"
    "     push r24              \n\t"
    "     push r30              \n\t"
    "     push r31              \n\t"
#if defined(__AVR_ATmega128A__)
    "     in   r24,0x5          \n\t"
#elif defined(__AVR_ATmega2560__)||defined(__AVR_ATmega328P__)
    "     lds  r24,0x0079       \n\t"
#else
#  error *** unknown MK-type! Must be: ATmega328p, ATmega128a, ATmega2560 or similar..
#endif
    "     lds  r30,adcBuffer    \n\t"
    "     lds  r31,adcBuffer+1  \n\t"
    "     st   Z+,r24           \n\t"
    "     sts  adcBuffer+1,r31  \n\t"
    "     sts  adcBuffer,r30    \n\t"

    "     lds  r30,adcCount     \n\t"
    "     lds  r31,adcCount+1   \n\t"
    "     sbiw r30,1            \n\t"
    "     sts  adcCount+1,r31   \n\t"
    "     sts  adcCount,r30     \n\t"
    "     brne .ADC_END         \n\t"
    ".ADC_STOP:                 \n\t"
    "     ldi  r24,lo8(2)       \n\t"
    "     sts  adcState,r24     \n\t"
#if defined(__AVR_ATmega128A__)
    "     cbi  0x6,3            \n\t"
#elif defined(__AVR_ATmega2560__)||defined(__AVR_ATmega328P__)
    "     lds  r24,0x007a       \n\t"
    "     cbr  r24,3            \n\t"
    "     sts  0x007a,r24       \n\t"
#else
#  error *** unknown MK-type! Must be: ATmega328p, ATmega128a, ATmega2560 or similar..
#endif
    ".ADC_END:                  \n\t"
    "     pop  r31              \n\t"
    "     pop  r30              \n\t"
    "     pop  r24              \n\t"
    "     out  __SREG__,r24     \n\t"
    "     pop  r24              \n\t"
    "     reti                  \n\t"
    ::
    );
}

/**
 * Запуск автозамеров АЦП по прерываниям
 */
void adcStart(uint8_t * from, int len, uint8_t speed)
{
  adcBuffer = from;
  adcCount = len;
  adcState = ADC_START;
#if defined(__AVR_ATmega128A__)

  ADCSRA |= _BV(ADSC) | _BV(ADIE) | _BV(ADFR) | (0x03 & speed); // present ADFR

#elif defined(__AVR_ATmega2560__)||defined(__AVR_ATmega328P__)

  ADCSRA |= _BV(ADSC) | _BV(ADIE) | _BV(ADATE) | (0x03 & speed); // has ADATE

#else
#  error *** unknown MK-type! Must be: ATmega328p, ATmega128a, ATmega2560 or similar..
#endif
}

/**
 * Однократное чтение АЦП 8-бит (старших)
 */
uint8_t adcRead1()
{
    ADCSRA |= _BV(ADSC);
    while( ADCSRA & _BV(ADSC) );
    return ADCH;
}

/**
 * Читаем АЦП ожиданием завершения замера по ADCSRA явно
 */
void test(int start, int len)
{
  uint8_t* ptr = &adcs[start];

  for(int i=start; i<len; i++){
    ADCSRA |= _BV(ADSC);
    while( ADCSRA & _BV(ADSC) );
    *(ptr++) = ADCH;
  }
}

} // extern "C"

/** ==================================== SETUP() ================================ **/

void setup() {

  Serial.begin(115200);

  // Set T1 for Pwm out for make test signal:
  TCCR1A = 128+32+8+1;           // A,B,C normal + WGM1,WGM0=1 "PhaseCorrectPWM255"
  TCCR1B = 0+2;                  // WGM3,WGM2=01-"5mode:FastPWM255", Prescaler:1=16Mhz, 2=2Mhz 
  OCR1A = 192;                   // PWMpulse length=3/4
  OCR1B = 128;                   // .. = 1/2
  OCR1C = 64;                    // .. = 1/4
#if defined(__AVR_ATmega128A__)||defined(__AVR_ATmega2560__)

  DDRB = _BV(5)|_BV(6)|_BV(7);   // T1 A,B,C for ATmega128a,ATmega2560

#elif defined(__AVR_ATmega328P__)

  DDRB = _BV(2)|_BV(3)|_BV(4);   // T1 A,B,C for ATmega328p to Output

#else
#  error *** unknown MK-type! Must be: ATmega328p, ATmega128a, ATmega2560 or similar..
#endif

  // Set ADC for work:
  ADMUX = 64|32;                 // src=+5v + ADLAR<-left
//  DIDR0 = 1;
//  ADCSRB = 0;
/*
  ADCSRA = _BV(ADEN) | 2;        // 1:4 = 8Mhz
  delayMicroseconds(10);
  test(0, MAX_BUF);
  for(int i=0; i<MAX_BUF; i++){
    Serial.println(adcs[i], DEC);
  }
*/
  ADCSRA = _BV(ADEN) | 1;        // 1:2 = 8Mhz
  adcRead1();
  delayMicroseconds(10);
  adcBuffer = adcs;
  adcCount = MAX_BUF;
  adcReadBuffer();
  for(int i=0; i<MAX_BUF; i++){
    Serial.println(adcs[i], DEC);
  }

  adcState = 0;
  delay(10000);
}

/** ===================================== LOOP() ================================= **/

void loop()
{
  adcBuffer = adcs;
  adcCount = MAX_BUF;
  adcReadBuffer();
  for(int i=0; i<MAX_BUF; i++){
    Serial.println(adcs[i], DEC);
  }
  delay(5000);
/*
  switch(adcState){
    case ADC_START:
      break;
    case ADC_DONE:
      for(int i=0; i<MAX_BUF; i++){
        Serial.println(adcs[i], DEC);
      }
      adcState=0;
      delay(10000);
    default:
      adcStart(&adcs[0], MAX_BUF, 2);
  }
*/
}

