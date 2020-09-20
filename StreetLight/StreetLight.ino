#define fadePin1 10       // пин управления MOSFET транзистором
#define fadePin2  9       // пин управления MOSFET транзистором
#define fadePin3  6       // пин управления MOSFET транзистором

#define pirPin1 2         // пин подключения управляющего сигнала PIR датчика1
#define pirPin2 4         // пин подключения управляющего сигнала PIR датчика2

int calibrationTime = 30; // Время калибровки датчика (10-60 сек. по даташиту)

void setup()
{
  pinMode(pirPin1, INPUT);   // настариваем 2 пин как вход для сигналов с датчика
  pinMode(pirPin2, INPUT);   // настариваем 4 пин как вход для сигналов с датчика
  pinMode(fadePin1, OUTPUT); // пины на выход, для управления транзисотором
  pinMode(fadePin2, OUTPUT);
  pinMode(fadePin3, OUTPUT);

  Serial.begin(9600);
  Serial.print("Calibrating"); //дадим датчику время на калибровку
  for(int i = 0; i < calibrationTime; i++)
  {
    Serial.print(".");
    delay(1000);
  }
  Serial.println(" done");
  Serial.println("SENSOR ACTIVE");
  delay(50);
}

// структура - описание понятия "Лампа" - это пин и текущая яркость:
typedef struct{
  uint8_t pin;
  uint8_t bright;
} Led;

// теперь создадим список ламп, заодно и введем константу "всего ламп"
#define MAX_LED 3
Led  fades[MAX_LED] = {{fadePin1, 0}, {fadePin2, 0}, {fadePin3, 0}};

#define WAIT_1  10UL      // 10мсек - пауза между изменениями яркости
uint32_t startedAt = 0; // тут будем хранить время последнего запуска fadeLed
#define WAIT_PAUSE 100UL
uint32_t startedPause = 0; // тут будем вести отсчет паузы до выключения

int8_t       isGo1 = 0; // режим включения/выключения от левого датчика
uint8_t      lamp1 = 0; // номер текущей лампы управления левым датчиком
uint8_t      max1 = 0;  // последний номер режимов левого датчика

int8_t       isGo2 = 0; // режим включения/выключения от правого датчика
uint8_t      lamp2 = 0; // номер текущей лампы управления правого датчиком
uint8_t      max2 = 0;  // последний номер режимов правого датчика

uint8_t isDayNow(void){ return 0; }

/**
 * Функция изменения яркости на 1 шаг state РАЗ в 10 миллисекунд
 * @param state: +1 -- включение; -1 -- выключение
 */
void fadeLED(uint8_t lamp, int8_t state)
{
  Led * ptr = &(fades[lamp]);  // врем. лок. указатель на структуру "лампа"

  if(
          millis() - startedAt >= WAIT_1  // пора изменять яркость?
     && (
        (state==1 && ptr->bright < 255)   // включаем И есть куда?
        ||
        (state==-1 && ptr->bright > 0)    // или вЫключаем И есть куда?
      )
  ){
      startedAt = millis();                // новое время для отсчета следующей паузы

      ptr->bright += state;                // изменяем яркость
      analogWrite( ptr->pin, ptr->bright); // устанавливаем на выходе
      Serial.println(ptr->bright);         // передаем данные в порт для отладки
  }
}

//========== loop() ========
uint32_t curTime;
uint8_t pirOn = 0;

void loop()
{
  Serial.println(""); Serial.print("t="); Serial.print(millis(), 10); // заход с новой строки.

  // п.1. Если светло - выходим.
//  if( isDayNow() ) return;

  // п.2: проверяем датчики движения и запускаем включение если надо:
  if( pirOn == 0 /*digitalRead(pirPin1)*/ ){
    pirOn = 1;
    isGo1 =  1; lamp1=0;         max1 = MAX_LED;
    Serial.print(",r1! ");
  }
// пока не надо  if( digitalRead(pirPin2) ){ isGo2 =  1; lamp1=MAX_LED-1; max1 = -1;      }

  // п.3. поштучно включаем (п.5 - выключаем) лампы, если левый датчик сработал (2-й датчик точно также можно ниже .. не показан):
  curTime = millis();
  if(
        (isGo1 == 1) // если включаем лампы, то сразу
      || (
           (isGo1 == -1) // а вот если вЫключаем, то
           && (curTime - startedPause >= WAIT_PAUSE) // по истечению паузы
        )
  ){

Serial.print(":p3/p5:, isGo1="); Serial.print(isGo1, 10);
Serial.print(", t="); Serial.print(startedPause, 10);

    // 3.1. проверяем лампа уже горит? переходим к следующей:
    if( isGo1==1 && fades[lamp1].bright == 255 ){ lamp1++; Serial.print(" :+: "); Serial.print(lamp1, 10); }

    // 5.1. или лампа уже выключена? переходим к следующей:
    else if( isGo1 == -1 && fades[lamp1].bright == 0 ){ lamp1--; Serial.print(" :-: "); Serial.print(lamp1, 10);  }
    else{
Serial.print(" :f: "); Serial.print(fades[lamp1].bright, 10); 

      // 3.2. + 5.2 увеличиваем/уменьшаем яркость на 1 каждые 10мсек:
      fadeLED(lamp1, isGo1);
    }
    // 3.3., 5.3 проверяем лампы кончились? включаем паузу:
    if( lamp1 == max1 ){
Serial.print(" :max: ");
      if( isGo1 == 1){           // а мы лампы включали?
        startedPause = millis(); // .. время паузы "пошло".
        isGo1 = -1;              // .. после паузы будем выключать
        lamp1=MAX_LED-1;         // .. в обратном порядке
        max1 = -1;
Serial.print(" :m+: ");
Serial.print(",t="); Serial.print(startedPause, 10); 
Serial.print(",go="); Serial.print(isGo1, 10); 
Serial.print(",l="); Serial.print(lamp1, 10); 
      }else if( isGo1 == -1 ){    // нет, мы их выключали
        isGo1 = 0;                // .. ну и ладушки, всё погасло.
Serial.print(" :m-: ");
Serial.print(",go="); Serial.print(isGo1, 10); 
      }
    }else{
Serial.print(",!max: lamp=");Serial.print(lamp1, 10);
    }
  }else{
Serial.print(",not: go=");Serial.print(isGo1, 10);
Serial.print(",t0=");Serial.print(curTime, 10);
Serial.print(",t1=");Serial.print(startedPause, 10);
  }
}

