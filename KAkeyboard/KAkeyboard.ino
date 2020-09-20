//
// Обработчик клавиатуры 4х4 кнопки
//
// Неблокирующее чтение матрицы клавиатуры, обработка дребезга контактов и
// возможность отслеживания изменения состояния любого количества кнопок
//
// kbdSetup() -- настройка на начало работы.
// kbdScan()  -- опрос состояния клавиатуры.
//
// kbdRows[], kbdCols[] -- номера пинов куда подключены строки и столбцы клавиатуры
//
// После вызова сканера можно смотреть количество и списки клавиш (из kbdChars[] !) в
// kbdCountPressed, kbdJustPressed[] -- кол-во и список нажатых клавиш (прошли дребезг).
// kbdCountLonged,  kbdJustLonged[]  -- кол-во и список удерживаемых клавиш.
// kbdCountUpped,   kbdJustUpped[]   -- кол-во и список отпущенных клавиш.
//
// Требует 5*16+2*8+3 = 99 байт ОЗУ.
//

#define KBD_MAX_ROWS 4
#define KBD_MAX_COLS 4
#define KBD_MAX_KEYS (KBD_MAX_ROWS * KBD_MAX_COLS)

// состояния кнопок клавиатуры: отпущена, нажата (старший бит)
#define KBD_KEY_FREE   0
#define KBD_KEY_PRESS  0x80
#define KBD_KEY_BOUNCE 0x40
#define KBD_KEY_LONG   0x20

// маска битов времени кнопки
#define KBD_MASK_TIMER 0x1F

// сдвиг времени в битах вправо - как грубо оцениваем дребезг и удержание (6: по 64мсек)
#define KBD_TIME_TICK  6

// время дребезга в местных единицах (1*64= 64мсек):
#define KBD_TIME_BOUNCE 1U

// время удержания в них же (максимально 31*64=1984мсек):
#define KBD_TIME_LONG  31U

// местная функция времени
#define kbdMillis() ((uint8_t)(KBD_MASK_TIMER & ( (uint8_t)(millis()>>KBD_TIME_TICK) )))

// получить время из кнопки
#define kbdTime(p) ((uint8_t)(KBD_MASK_TIMER & (p)))

uint8_t kbdRows[] = {2,3,4,5}; // пины "строки" матрицы клавиатуры (выходы)
uint8_t kbdCols[] = {6,7,8,9}; // пины "колонки" клавитурной матрицы (входы)

// массив текущего состояния кнопок клавиатуры:
uint8_t kbdKeys[KBD_MAX_KEYS];
uint8_t kbdChars[KBD_MAX_KEYS] = {
  '1', '2', '3', 'A',
  '4', '5', '6', 'B',
  '7', '8', '9', 'C',
  '*', '0', '#', 'D'
};

// списки клавиш в нужном состоянии:
uint8_t kbdJustPressed[KBD_MAX_KEYS];
uint8_t kbdJustUpped[KBD_MAX_KEYS];
uint8_t kbdJustLonged[KBD_MAX_KEYS];

uint8_t kbdCountPressed = 0;
uint8_t kbdCountLonged = 0;
uint8_t kbdCountUpped = 0;

// setup(): настройка входов/выходов и начального состояния
void kbdSetup()
{
  for(int8_t pin=0; pin<KBD_MAX_ROWS; pin++){ // строки на выход и в "1"
    pinMode( kbdRows[pin], OUTPUT);
    digitalWrite(kbdRows[pin], HIGH);
  }
  for(int8_t pin=0; pin<KBD_MAX_COLS; pin++){ // столбцы - входы
    pinMode( kbdCols[pin], INPUT_PULLUP);
  }

  kbdCountPressed = kbdCountLonged = kbdCountUpped = 0;

  for(uint8_t num=0; num<KBD_MAX_KEYS; num++ )
  {
    kbdKeys[num]=0;
  }
}

// сканер - проверяльщик текущего состояния кнопок на момент вызова:
void kbdScan()
{
  uint8_t _time = kbdMillis();
  kbdCountPressed = kbdCountLonged = kbdCountUpped = 0;

  for( int8_t row=0; row<KBD_MAX_ROWS; row++)  // сканируем строку
  {
    digitalWrite(kbdRows[row], LOW);       // прижимаем строку в "0"
    for(int8_t col=0; col<KBD_MAX_COLS; col++) // ищем нажатую кнопку в строке
    {
      uint8_t keyNum = row*KBD_MAX_ROWS + col;
      uint8_t keyVal = kbdKeys[keyNum];

      if(
          !(keyVal & KBD_KEY_PRESS) ||                  // кнопка ещё не нажата или
          (keyVal & KBD_KEY_BOUNCE) ||                  // уже прошла дребезг или
          (_time - kbdTime(keyVal) >= KBD_TIME_BOUNCE)  // вышло время дребезга
      ){
        // далее только для не нажатых кнопок или у которых прошла проверка дребезга

        uint8_t keyState = digitalRead(kbdCols[col]);

        if(keyState == LOW){                                                  // кнопка нажата:
          if( !(keyVal & KBD_KEY_PRESS) ){                                    // ..только что нажата?
            keyVal = KBD_KEY_PRESS | _time;                                   // ..и время для дребезга
          }else
            if( !(keyVal & KBD_KEY_BOUNCE) ){                                 // ..нажата, но проверяется дребезг?
              keyVal = KBD_KEY_PRESS | KBD_KEY_BOUNCE | _time;                // ..новое время для удержания
              kbdJustPressed[kbdCountPressed++] = kbdChars[keyNum];
            }else
              if( !(keyVal & KBD_KEY_LONG) ){                                 // .. проверка удержания?
                if( _time - kbdTime(keyVal) >= KBD_TIME_LONG ){
                  keyVal = KBD_KEY_PRESS | KBD_KEY_BOUNCE | KBD_KEY_LONG;     // .. теперь "удерживается"
                  kbdJustLonged[kbdCountLonged++] = kbdChars[keyNum];
                }else{
                  kbdJustPressed[kbdCountPressed++] = kbdChars[keyNum];       // .. все ещё PRESSED
                }
              }else{
                kbdJustLonged[kbdCountLonged++] = kbdChars[keyNum];         // .. всё ещё LONG
              }
        }else{                                                                // кнопка отпущена:
          if( keyVal == KBD_KEY_FREE ){ continue; }                           // .. и не была нажата. Пропуск.
          if( (keyVal & (KBD_KEY_BOUNCE | KBD_KEY_LONG)) != 0 ){              // .. отпуск нажатой или удерживаемой
            kbdJustUpped[kbdCountUpped++] = kbdChars[keyNum];
          }
          keyVal = KBD_KEY_FREE;
        }
        kbdKeys[keyNum] = keyVal;
      }
    } //end col
    digitalWrite(kbdRows[row], HIGH); // отжимаем строку обратно
  } // end row
}

// ============== собственно скетч: ===================

void setup() {
  kbdSetup();
  Serial.begin(115200);
}

void loop() {
  kbdScan();
  // далее можно смотреть счетчики нажатых, удерживаемых и отпущенных клавиш и их списки
  if( kbdCountPressed ){
    Serial.print("Just pressed ("); Serial.print(kbdCountPressed, DEC); Serial.print(") :");
    for(int i=0; i<kbdCountPressed; i++) Serial.print(kbdJustPressed[i]);
    Serial.println(":all pressed.");
  }

  if( kbdCountLonged ){
    Serial.print("Just long ("); Serial.print(kbdCountLonged, DEC); Serial.print(") :");
    for(int i=0; i<kbdCountLonged; i++) Serial.print(kbdJustLonged[i]);
    Serial.println(":all longed.");
  }

  if( kbdCountUpped ){
    Serial.print("Just upped ("); Serial.print(kbdCountUpped, DEC); Serial.print(") :");
    for(int i=0; i<kbdCountUpped; i++) Serial.print(kbdJustUpped[i]);
    Serial.println(":all upped.");
  }
}

