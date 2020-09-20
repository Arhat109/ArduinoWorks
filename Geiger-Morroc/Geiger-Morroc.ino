#define CHARGE_WIDTH        20      // длительность импульса накачки в попугаях 
#define CHARGE_PIN_PORTD    5       // 5я нога ардуины
#define CHARGE_MIN_DELAY    8       // минимальная задержка
#define CHARGE_MAX_DELAY    65000   // максимальная задержка
                              
volatile uint16_t     xcharge_delay;
volatile uint16_t     charge_delay            = 254; // начальная пауза накачки (пауза между импульсами),
                                                     // больше - меньше U, максимум 65535;
volatile uint8_t      charge_delay_high       = 0;   // старший байт паузы 
unsigned long         currentMillis           = 0;

void setup() {
  pinMode(5,  OUTPUT); 
  ACSR=(1<<ACBG);                   // компаратор, включить сравнение с ион
  DIDR1 |= _BV(AIN1D) | _BV(AIN0D); 
                                                  
  /*
  // TCCR2B = (1<<CS21);                      // CLK/8
  // TCCR2B = (1<<CS20)|(1<<CS21);            // CLK/32
  // TCCR2B = (1<<CS22);                      // CLK/64
  // TCCR2B = (1<<CS20)|(1<<CS22);            // CLK/128
  // TCCR2B = (1<<CS21)|(1<<CS22);            // CLK/256
  // TCCR2B = (1<<CS20)|(1<<CS21)|(1<<CS22);  // CLK/1024
  */
  
  TCCR2A = 0;                                 // запускаем таймер2
  TCCR2B = (1<<CS20)|(1<<CS21)|(1<<CS22);     // CLK/1024
  TCNT2  = 1;
  TIMSK2 |= (1 << TOIE2);       
  Serial.begin(115200);
  currentMillis = millis();
}

// помним, что вызов прерывания и выход из него отожрут ~ 2-3us (не считая нашего кода прерывания)
ISR(TIMER2_OVF_vect) {
  TIMSK2 &= ~(1 << TOIE2);                    // запрещаем прерывание таймера/счетчика 2
    if (charge_delay_high > 0) {              // если старший байт паузы > 0 - пропускаем N циклов
      charge_delay_high = charge_delay_high - 1;
      TCNT2 = 1;
    } else {
      
      // импульс <
      PORTD|= (1<<CHARGE_PIN_PORTD);
      for (int i=0;i<CHARGE_WIDTH;i++) { asm volatile("nop"); };
      PORTD&=~(1<<CHARGE_PIN_PORTD);
      // импульс >

      // пауза перед считыванием состояния компаратора 
      // (подобрал экспериментально, если меньше - больше выходное напряжение "шатает")
      { 
        asm volatile("nop"); 
        asm volatile("nop");
        asm volatile("nop");
        asm volatile("nop");
        asm volatile("nop");
        asm volatile("nop");
        asm volatile("nop");
        asm volatile("nop");
        asm volatile("nop");
        asm volatile("nop");
        asm volatile("nop");
        asm volatile("nop");
      };
    if (!(ACSR & _BV(ACO))) {                     // если видим "выхлоп" - увеличиваем паузу 
      if (charge_delay < (CHARGE_MAX_DELAY/2)) {
        charge_delay = charge_delay * 2;
      } else {
        if ((charge_delay + ((CHARGE_MAX_DELAY - charge_delay) / 2)) > charge_delay)
          charge_delay = charge_delay + ((CHARGE_MAX_DELAY - charge_delay) / 2);
      }
    } else {                                      // если не видим "выхлоп" - уменьшаем паузу 
      if (charge_delay > (CHARGE_MIN_DELAY*2-1)) {
        charge_delay = charge_delay / 2;
      } else {
        if ((charge_delay - ((charge_delay - CHARGE_MIN_DELAY) / 2)) > (CHARGE_MIN_DELAY-1))
          charge_delay = charge_delay - ((charge_delay - CHARGE_MIN_DELAY) / 2);
      }
    }
    charge_delay_high      = charge_delay >> 8;  // заряжаем таймер на паузу
    TCNT2 = 255 - (charge_delay & 0xff);         // младший байт отрабатываем в первой итерации таймера 
  }
  TIFR2  &=  0xff;                               // очищаем флаги прерываний
  TIMSK2 |= (1 << TOIE2);                        // разрешаем прерывание таймера/счетчика 2
}

void loop() {
  if (charge_delay != xcharge_delay) {
    Serial.print("charge_delay  = ");
    Serial.println(charge_delay, DEC);
    xcharge_delay = charge_delay;
  }    
}
