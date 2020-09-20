/**
 * Модуль работы с датчиками линии
 * 
 * @author fvn-2017109
 */

// для fvnEEPROM.h: адрес, с которого храним в EEPROM данные настройки датчиков:
#define snEEPROM    1000

void readEEPROM(int, int);
void writeEEPROM(int, int);

// количество усредняемых замеров
#define MAX_AVERAGE    4

// длительность в мсек. периода автонастройки уровней датчиков
#define MAX_AUTOLEVEL   10000

// всего датчиков линии. Оно же и ошибка направления - слева, + справа
// ВСЕГДА нечетное число .. важно!
#ifndef MAX_SENSORS
  #define MAX_SENSORS    5
#endif

/** данные по датчикам 12 байт на датчик */
typedef struct _sensor_ {
  uint8_t pin;
  int8_t  dir;   // "расстояние" датчика от середины: <0 - влево, >0 - вправо
  int     black; // автонастройка: минимальное черное
  int     white; // автонастройка: максимальное белое
  int     lvl;   // автонастройка: уровень между белым и черным;
  int     val;   // замер
  int     adc;   // результат преобразования в: 0 - белое, 1 - черное
} Sensors;
#define ptrSensor(p, n) (((Sensors *)(p))+n)

#ifndef sensor
  Sensors sensor[MAX_SENSORS] = {
    { A7, -4, 1024, -1, 0, 0, 0}, // самый левый
    { A6, -2, 1024, -1, 0, 0, 0},
    { A5,  0, 1024, -1, 0, 0, 0},
    { A4,  2, 1024, -1, 0, 0, 0},
    { A3,  4, 1024, -1, 0, 0, 0}, // самый правый
  };
#endif

#define snPin(p)        (sensor[(p)].pin)
#define snBlack(p)      (sensor[(p)].black)
#define snWhite(p)      (sensor[(p)].white)
#define snVal(p)        (sensor[(p)].val)
#define snLvl(p)        (sensor[(p)].lvl)
#define snAdc(p)        (sensor[(p)].adc)
#define snDir(p)        (sensor[(p)].dir)

/**
 * Вывод в монитор содержимого всех датчиков для проверок
 */
void printSensors()
{
  for( uint8_t i=0; i<MAX_SENSORS; i++){
    Serial.println();
    Serial.print("s="); Serial.print(i, DEC);
    Serial.print(", P="); Serial.print(snPin(i), DEC);
    Serial.print(", D="); Serial.print(snDir(i), DEC);
    Serial.print(", B="); Serial.print(snBlack(i), DEC);
    Serial.print(", W="); Serial.print(snWhite(i), DEC);
    Serial.print(", L="); Serial.print(snLvl(i), DEC);
    Serial.print(", V="); Serial.print(snVal(i), DEC);
    Serial.print(", A="); Serial.print(snAdc(i), DEC);
  }
}

/**
 * Начальная установка датчиков и зачистка данных по ним
 */
void setupSensors()
{
  for( uint8_t i=0; i<MAX_SENSORS; i++ ){
    pinMode( snPin(i), INPUT);
    snBlack(i) = 1024;
    snWhite(i) = -1;
    snVal(i) = snLvl(i) = snAdc(i) = 0;
  }
}

/** усреднение "бегущим средним" */
void getSensorsRun()
{
  for( uint8_t n=MAX_AVERAGE; n; n--){
    for( uint8_t i=0; i<MAX_SENSORS; i++){
      snVal(i) = (analogRead( snPin(i) )*5 + snVal(i)*3) / 8; // к-ты подбирать по устойчивости, если надо!
      snAdc(i) = (snVal(i) > snLvl(i)? 0 : 1);
    }
  }
}

/** усреднение арифметическое */
void getSensorsAvg()
{
  static int adcs[MAX_SENSORS][MAX_AVERAGE];
  int        summ;

  for( uint8_t n=MAX_AVERAGE; n; n--){
    for( uint8_t i=0; i<MAX_SENSORS; i++){
      adcs[i][n] = analogRead( snPin(i) );
    }
  }
  for( uint8_t i=0; i<MAX_SENSORS; i++){
    summ = 0;
    for( uint8_t n=MAX_AVERAGE; n; n--){
      summ += adcs[i][n];
    }
    snVal(i) = summ / MAX_AVERAGE;
    snAdc(i) = (snVal(i) > snLvl(i)? 0 : 1);
  }
}

/**
 * Чтение всех датчиков "оптом"
 * Усреднение удобно делать только на 4 замерах - деление заменяется свдигом!
 */
void getSensors()
{
  getSensorsRun();
}

/** Расчет уровней белого, черного и среднего на каждый вызов */
void calcLevel()
{
  getSensors();
  for(uint8_t i=0; i<MAX_SENSORS; i++)
  {
    if( snVal(i) < snBlack(i) ){ snBlack(i) = snVal(i); }
    if( snVal(i) > snWhite(i) ){ snWhite(i) = snVal(i); }
    snLvl(i) = (snWhite(i) - snBlack(i))/2 + snBlack(i);
  }
}

/**
 * Процедура автонастройки уровня датчиков
 * моргает всеми лампочками 3 раза быстро, настройка MAX_AUTOLEVEL сек, моргает 5 раз медленно
 */
void autoLevel()
{
  uint32_t time;

  blinkYellow(2, 150, 350);
  time = millis();
  while( millis() - time < MAX_AUTOLEVEL){
    blinkBlue(1,20,0);
    calcLevel();
  }
  blinkYellow(2, 500, 500);
}

/**
 * Проверяет как стоит машинка:
 * Считаем среднее кроме среднего датчика и если:
 * а) средний датчик показывает значительно меньше остальных, то он "на линии". Читаем уровни из EEPROM
 * б) иначе считаем что "все датчики на белом" - запускаем автонастройку
 * !!! Предполагается что все датчики показывают примерно одинаково на белом/черном !!!
 */
void getLevels()
{
  int avg = 0;
  int sensor0 = 0;

  getSensors();
  for( uint8_t i=0; i<MAX_SENSORS; i++){
    if( i != (MAX_SENSORS)/2 ){
      avg += snVal(i);
    }
  }
  avg /= (MAX_SENSORS - 1);
  sensor0 = snVal( (MAX_SENSORS)/2 );
//Serial.print(", sen0="); Serial.print((MAX_SENSORS)/2, DEC);
//Serial.print(", avg="); Serial.print(avg, DEC);
//Serial.print(", val0="); Serial.print(sensor0, DEC);
//Serial.println("");

  if( abs(avg - sensor0 ) > avg * 3/8 ){
    // стоим на линии, читаем и поехали:
    blinkBlue(4, 350, 150);
    readEEPROM(snEEPROM, (uint8_t *)sensor, sizeof(sensor));
  }else{
    blinkRed(3, 350, 150);
    autoLevel();
    writeEEPROM(snEEPROM, sensor, sizeof(sensor));
  }
}

