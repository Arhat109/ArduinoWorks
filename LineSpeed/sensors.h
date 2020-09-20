/**
 * Модуль работы с датчиками линии
 * 
 * @author fvn-2017109
 */

// для fvnEEPROM.h: номер адреса, с которого храним в EEPROM данные настройки датчиков (12байт * 7шт = 84 байт):
#define snEEPROM    1

void readEEPROM(int, int);
void writeEEPROM(int, int);

// количество усредняемых замеров
#define MAX_AVERAGE    3

// длительность в мсек. периода автонастройки уровней датчиков
#define MAX_AUTOLEVEL   10000

// ошибка направления в случае потери линии всеми датчиками
#define MAX_DIR  5

#define MAX_SENSORS    7
struct{
  uint8_t pin;
  int8_t  dir;   // "расстояние" датчика от середины: <0 - влево, >0 - вправо
  int     black; // автонастройка: минимальное черное
  int     white; // автонастройка: максимальное белое
  int     lvl;   // автонастройка: уровень между белым и черным;
  int     val;   // замер
  int     adc;   // результат преобразования в: 0 - белое, 1 - черное
} sensor[MAX_SENSORS] = {
  { A0,  0, 1024, -1, 0, 0, 0}, // предсказатель левый, не датчик линии
  { A1, -4, 1024, -1, 0, 0, 0},
  { A2, -2, 1024, -1, 0, 0, 0},
  { A3,  0, 1024, -1, 0, 0, 0},
  { A4,  2, 1024, -1, 0, 0, 0},
  { A5,  4, 1024, -1, 0, 0, 0},
  { A6,  0, 1024, -1, 0, 0, 0}, // предсказатель правый..
};
#define snPin(p)    (sensor[(p)].pin)
#define snBlack(p)  (sensor[(p)].black)
#define snWhite(p)  (sensor[(p)].white)
#define snVal(p)    (sensor[(p)].val)
#define snLvl(p)    (sensor[(p)].lvl)
#define snAdc(p)    (sensor[(p)].adc)
#define snDir(p)    (sensor[(p)].dir)

/**
 * Начальная установка датчиков
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

/**
 * Чтение всех датчиков "оптом"
 * Усреднение удобно делать только на 4 замерах - деление заменяется свдигом!
 * 
 * @param bool isAuto -- проводить автокалибровку датчиков или нет
 */
void getSensors( bool isAuto )
{
  for( uint8_t n=MAX_AVERAGE; n; n--){
    for( uint8_t i=0; i<MAX_SENSORS; i++){
      snVal(i) = (analogRead( snPin(i) )*5 + snVal(i)*3) / 8;
      if( isAuto ){
        if( snVal(i) < snBlack(i) ){ snBlack(i) = snVal(i); }
        if( snVal(i) > snWhite(i) ){ snWhite(i) = snVal(i); }
        snLvl(i) = (snWhite(i) - snBlack(i))/2 + snBlack(i);
      }
      snAdc(i) = (snVal(i) > snLvl(i)? 0 : 1);
    }
  }
}

/**
 * Вывод в монитор содержимого всех датчиков для проверок
 */
void printSensors()
{
  for( uint8_t i=0; i<MAX_SENSORS; i++){
    Serial.println();
    Serial.print("s="); Serial.print(i, DEC);
    Serial.print(", B="); Serial.print(snBlack(i), DEC);
    Serial.print(", W="); Serial.print(snWhite(i), DEC);
    Serial.print(", L="); Serial.print(snLvl(i), DEC);
    Serial.print(", V="); Serial.print(snVal(i), DEC);
    Serial.print(", A="); Serial.print(snAdc(i), DEC);
  }
}

/**
 * Процедура автонастройки уровня датчиков
 * моргает 3 раза быстро, настройка 10сек, морагет 5 раз медленно
 */
void autoLevel()
{
  uint32_t time;

  blink(3, 150, 350);
  time = millis();
  while( millis() - time < MAX_AUTOLEVEL){
    getSensors( true );
  }
  blink(5, 500, 500);
}

/**
 * Проверяет как стоит машинка:
 * Считаем среднее кроме крайних и среднего датчика и если:
 * а) средний датчик показывает значительно меньше среднего, то он "на линии". Читаем уровни из EEPROM
 * б) иначе считаем что "все датчики на белом" - запускаем автонастройку
 * !!! Предполагается что все датчики показывают примерно одинаково на белом/черном !!!
 */
void getLevels()
{
  int avg = 0;

  getSensors( false );
  for( uint8_t i=1; i<MAX_SENSORS-1; i++){
    if( i != MAX_SENSORS/2 ){
      avg += snVal(i);
    }
  }
  avg /= (MAX_SENSORS - 3);

  if( abs(snVal(MAX_SENSORS/2) - avg) > avg/2 ){
    blink(3, 350, 150);
    readEEPROM(snEEPROM, MAX_SENSORS);
  }else{
    autoLevel();
    writeEEPROM(snEEPROM, MAX_SENSORS);
  }
}

