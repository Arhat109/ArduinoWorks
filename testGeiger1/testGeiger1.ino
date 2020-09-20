/**
 * Тест накачки высокого обратноходовым импульсным преобразователем
 * В этом варианте показывает до 679 попугаев или 1384в на ВВ-трансфоматоре
 */

#include <util/delay.h>

extern "C" {

#define pinPWM   5   /* PORTD PORTD5*/
#define pinHV    0   /* analog pin A0! */

#define MAX_ADCS     2
#define MAX_SAMPLES 10
#define MAX_WAIT    10
int adcs[MAX_ADCS*MAX_SAMPLES];

#define pwmON()  (PORTD |= 0B00100000)
#define pwmOFF() (PORTD &= 0B11011111)

/**
 * INLINE: 16-bit counter: up to 65535*4 F_CPU for 16Mhz:[0.25 .. 16383.75] mcsec.
 * Короткие задержки по 4 цикла ЦПУ (кратно 250 нсек)
 * !!! Работает неверно !!!
 */
#define delayMicro16(__count) \
  __asm__ __volatile__ (      \
    "1: sbiw %0,1 \n\t"       \
       "brne 1b\n\t"          \
       : "=w" (__count)       \
       : "0"  (__count)       \
)
/** вроде работает: проверить время! */
#define delayUS(t)     \
{                      \
  do{;}while(--(t)>0); \
}

#define adcStart() (ADCSRA |= (1<<ADSC))
#define adcWait()  while(ADCSRA&(1<<ADSC))
/**
 * Однократное чтение АЦП 8-бит (младших)
 * Если замер завершен, то сначала запуск следующего.
 * Пока идет замер - работаем дальше
 */
#define adcReadFast(res)   \
{                          \
  adcWait();               \
  adcStart();              \
  (res)=ADC;               \
}

} // extern"C"

void setup()
{
  pinMode(pinPWM, OUTPUT);
  pwmOFF();

  Serial.begin(115200);

  ADCSRA = (1<<ADEN) | (4);               // включаем АЦП и устанавливаем делитель 1(8), 2(4), 3(2), 4(1), 5(0.5), 6(0.25), 7(0.125)
  ADMUX  = (0<<REFS1)|(1<<REFS0)|(pinHV); // 01 - опорное 5в, рабочий вход - 7
  ADCSRB = 0;                             // тут ничего не надо
  DIDR0  = 255;                           // отключаем от OUTPUT все входы АЦП, дабы не разбираться
  adcStart();                             // запуск и сразу
  adcWait();                              // пропуск первого чтения, ибо мусор и долго
}

void loop()
{
  uint16_t wait;
  int n, i, w=30;
  int *ptr = adcs;

  do{
    for(n=0; n<MAX_SAMPLES; n++){
      wait=w;
      ptr = adcs + MAX_ADCS*n;

      cli();
        pwmON();
        _delay_loop_2(wait);
        pwmOFF();
        adcStart();
        adcReadFast(*ptr++); // MAX_ADCS раз!
        adcReadFast(*ptr++);
//        adcReadFast(*ptr++);
//        adcReadFast(*ptr++);
      sei();
    }
  }while( --w > 20);

  // вывод попыток накачки на плоттер
  for(w=0; w<10; w++){
    for(i=0; i<5; i++){ Serial.println(n, DEC); }
    for(n=0; n<MAX_SAMPLES; n++){
      for(i=0; i<MAX_ADCS; i++){
        Serial.println( adcs[i+n*MAX_ADCS], DEC); // 5в / 1024 * 100,24 МОм / 0,24 МОм = 2,04 -- множитель попугаев в вольты!
      }
    }
  }
  delay(10000); // пауза для просмотра результатов
}

