/**
 * Модуль расчета скоростей моторов по ситуации
 * 
 * @author fvn-20171009
 */

// номер адреса, с которого храним в EEPROM настройки для калькулятора:
#define calcEEPROM  1500

// Всего состояний в каждом массиве: (влево или вправо) + прямо:
#define MAX_DIR   MAX_SENSORS + 1

int    dir        = 0; // текущее отклонение от линии
int    prevDir    = 0; // отклонение предыдущего цикла
int    dirCount   = 0; // текущий счетчик повтора направления (как долго уже едем с такой ошибкой)
int8_t lastDir    = 0; // предыдущее направление было таким
int    lastCount  = 0; // с ним ехали столько раз
int    prop       = 0; // текущий к-т пропорциональности
int    diff       = 0; // текущий к-т изменений движения
int    sumDir     = 0; // интегральное (суммарное) накопление общей ошибки движения по линии

// Структура данных настройки калькулятора
typedef struct _calcdata_ {
  int exSpeed[MAX_DIR]; // Максимальная скорость (+ прямо) внешнего колеса по трению колес или по факту
  int propOut[MAX_DIR]; // (1/128) "пропорциональный к-т" внутреннего колеса от ошибки (dir) уход с линии abs(dir) > abs(prevDir)
  int propIn[MAX_DIR];  // (1/128) "пропорциональный к-т" внутреннего колеса от ошибки "возврат к линии"
  int diff[MAX_DIR];    // (1/128) "дифференциальный к-т" подбор дифференциальных коэффициентов (влияние скорости движения)
  int step;             // приращение скорости за 1 цикл. По моменту инерции колес, тяговым параметрам моторов ..торопиться не надо..
  
} CalcData;
#define ptrCalcData(p) ((CalcData *)(p))

// Вся настройка тут:
CalcData calc = {
  {210, 255, 245, 170, 120, 170},   // exSpeed 1.0 - макс. скорость внешнего колеса по трению
  {128,  96,  58,  18, -16, -70},   // propOut 7.20, 1.80, 
  {128, 103,  68,  48,  32, -70},   // propIn 1.41  - возврат к линии
  {  8,  12,  16,  20,  24,  28},   // diff    - поправка от скорости
  10 // step
};

/* Расчетные данные для мини машинки M=225g, Vxx=11000rpm, Mmax=25g*cm, Kr=5.60 (12 : 24+10 : 28), KPD=75%
 * Lsens=16cm, Lwh=14cm, B=13.5cm, Hct=2.70cm, Lct=2.50cm, Kwh=0.03 / 0.72, Kdat=0.2 / 0.2, Dwh=4.32cm, Mwh=16.6g.
 * для линии 50мм, смещения: +-1: 3mm, +-2: 11mm, +-3: 25mm, +-4: 39mm, +-5: 53mm
 * 
CalcData calc = {
  {230, 255, 206, 141, 117, 104}, // exSpeed - макс. скорость внешнего колеса по трению
  {128,  99,  61,  53,  46, -33}, // propOut - уход с линии
  {128, 100,  64,  55,  50,  46}, // propIn  - возврат к линии
  {  0,   0,   0,   0,   0,   0}, // diff    - поправка от скорости
  10 // step
};
*/

/** Вывод всех глобалов на монитор */
void printCalc()
{
  Serial.println("");
  Serial.print(", dir="); Serial.print(dir, DEC);
  Serial.print(", dirCount="); Serial.print(dirCount, DEC);
  Serial.print(", lastDir="); Serial.print(lastDir, DEC);
  Serial.print(", lastCount="); Serial.print(lastCount, DEC);
  Serial.print(", prop="); Serial.print(prop, DEC);
  Serial.print(", diff="); Serial.print(diff, DEC);
  Serial.print(", summ="); Serial.print(sumDir, DEC);
}

// ПЕРЕИМЕНОВАНИЯ, дабы не писать длинно:
#define exMaxSpeed(n) (calc.exSpeed[(n)])
#define propIn(n)     (calc.propIn[(n)])
#define propOut(n)    (calc.propOut[(n)])
#define tblDiff(n)    (calc.diff[(n)])

// шаг из настроек:
#define STEP       (calc.step)

// макс скорость прямо dir==0:
#define MAX_SPEED  (calc.exSpeed[0])

// Тут используем только 2 первых мотора из motors.h !!!
#define lmSpeed      drvSpeed(0) // левый мотор
#define rmSpeed      drvSpeed(1) // правый мотор

/**
 * Считает величину ошибки линии от середины машинки
 * влево < 0, вправо > 0, ==0 -- линия посередине
 */
void calcDir()
{
  int      summ = 0;
  int8_t   count = 0;

//  Serial.println("");
  for( uint8_t i=0; i<MAX_SENSORS; i++ ){
    summ += snAdc(i) * snDir(i);
    count += snAdc(i);
    if( snAdc(i) == 1 ){
      digitalWrite(snLeds[i], HIGH);
    }else{
      digitalWrite(snLeds[i], LOW);
    }
  }
//  Serial.print("summ="); Serial.print(summ, DEC);
//  Serial.print(", count="); Serial.print(count, DEC);

  // смотрим что получилось: если есть датчики на линии, то ошибка = сумма расстояний поделить на число датчиков на линии
  // иначе: линия потеряна и надо смотреть "где была" в прошлый замер
  prevDir = dir;
  if( count>0 ){
    dir = summ/count;
  }else{
    if     ( lastDir>0 ){ dir =  MAX_SENSORS; } // линия была справа - потерялась там же..
    else if( lastDir<0 ){ dir = -MAX_SENSORS; } // линия была слева ..
    else{
      // упс.. ехали прямо и потеряли линию .. продолжаем прямо
      dir = 0;
    }
  }

  // направление изменилось? нет: считаем сколько так уже едем, да: сохраняем текущее как "последнее" (last..), начинаем заново
  if( prevDir == dir ){
    dirCount++;
  }else{
    lastCount = dirCount;
    lastDir   = prevDir;
    dirCount = 1;
  }
//  Serial.print(", prevDir="); Serial.print(prevDir, DEC);
//  Serial.print(", dirCount="); Serial.print(dirCount, DEC);
//  Serial.print(", lastDir="); Serial.print(lastDir, DEC);
//  Serial.print(", lastCount="); Serial.print(lastCount, DEC);
//  Serial.print(", dir="); Serial.print(dir, DEC);
}

/** Прибавлялка скорости мотору с контролем превышения предела */
int addSpeed( int speed, int max)
{
  if( speed < max - STEP ){ speed += STEP; }
  else
    speed = max;
  return speed;
}

/** уменьшалка скорости мотора до заданного предела */
int downSpeed( int speed, int max)
{
  if( speed > max + STEP ){ speed -= STEP; }
  else
    speed = max;
  return speed;
}

/**
 * Едем прямо:
 */
void calcForward()
{
//  Serial.println("");
  // 1. Если моторы крутятся с разной скоростью - пытаемся их выровнять
  if     ( lmSpeed - rmSpeed > 2*STEP ){ rmSpeed += STEP; lmSpeed -= STEP;          }
  else if( rmSpeed - lmSpeed > 2*STEP ){ lmSpeed += STEP; rmSpeed -= STEP;          }
  else if( lmSpeed != rmSpeed         ){ rmSpeed = lmSpeed = (lmSpeed + rmSpeed)/2; }
  // если одинаково, то пропуск..
//  Serial.print(", lmSpeed1="); Serial.print(lmSpeed, DEC);
//  Serial.print(", rmSpeed1="); Serial.print(rmSpeed, DEC);

  // 1.2 "диф. управление" при переходе на прямую: дополнительно выравниваем колеса, если в прошлый раз ехали в повороте ещё раз:
  if( prevDir != 0 ){
    if     ( lmSpeed - rmSpeed > 2*STEP ){ rmSpeed += STEP; lmSpeed -= STEP;          }
    else if( rmSpeed - lmSpeed > 2*STEP ){ lmSpeed += STEP; rmSpeed -= STEP;          }
    else if( lmSpeed != rmSpeed         ){ rmSpeed = lmSpeed = (lmSpeed + rmSpeed)/2; }
  }
//  Serial.print(", lmSpeed2="); Serial.print(lmSpeed, DEC);
//  Serial.print(", rmSpeed2="); Serial.print(rmSpeed, DEC);

  // 2. Если крутятся слишком быстро - притормаживаем мотор(ы)
  if( lmSpeed > MAX_SPEED ){ lmSpeed = downSpeed(lmSpeed, MAX_SPEED); }
  if( rmSpeed > MAX_SPEED ){ rmSpeed = downSpeed(rmSpeed, MAX_SPEED); }
//  Serial.print(", lmSpeed3="); Serial.print(lmSpeed, DEC);
//  Serial.print(", rmSpeed3="); Serial.print(rmSpeed, DEC);

  // 3. Если моторы крутятся слишком медленно - разгоняем машинку
  if( lmSpeed < MAX_SPEED ){ lmSpeed = addSpeed(lmSpeed, MAX_SPEED); }
  if( rmSpeed < MAX_SPEED ){ rmSpeed = addSpeed(rmSpeed, MAX_SPEED); }
//  Serial.print(", lmSpeed4="); Serial.print(lmSpeed, DEC);
//  Serial.print(", rmSpeed4="); Serial.print(rmSpeed, DEC);
}

// Внешнее и внутренние скорости колес от параметра процедуры:
#define outSpeed (drvSpeed(ex))
#define inSpeed  (drvSpeed(in))
/**
 * Поворот, хоть куда: вычисляем скорости внешнего и внутреннего колеса согласно расстоянию линии от середины
 * 
 * @param uint8_t  dir -- величина отклонения линии от середины - всегда >0!
 * @param uint8_t  in  -- номер внутреннего колеса 0-левое, 1-правое
 * @param uint8_t  ex  -- номер внешнего колеса ..
 */
void calcTurn( uint8_t _dir, uint8_t in, uint8_t ex)
{
  int     maxSpeed   = exMaxSpeed(_dir);                               // предел скорости внешнего колеса
  uint8_t absPrevDir = abs(prevDir);                                   // т.к. dir всегда > 0, смотрим предыдущую величину отклонения направления
  int     difV = 0;
  int     _out = outSpeed;                                             // локальное сохранение, т.к. ABS торможение меняет скорость драйвера

//  Serial.println("");
  // 1. Пробуем улучшить внешнее колесо:
  if( outSpeed < maxSpeed ){ _out = addSpeed(outSpeed, maxSpeed);  }  // 1.1. Можем поднять скорость внешнего колеса?
  if( outSpeed > maxSpeed ){ _out = downSpeed(outSpeed, maxSpeed); }  // 1.2. Надо притормаживать?
//  Serial.print(", locDir="); Serial.print(_dir, DEC);
//  Serial.print(", in="); Serial.print(in, DEC);
//  Serial.print(", out="); Serial.print(ex, DEC);
//  Serial.print(", maxExt="); Serial.print(maxSpeed, DEC);
//  Serial.print(", extSpeed="); Serial.print(_out, DEC);
//  Serial.print(", oP="); Serial.print(prop, DEC);
//  Serial.print(", oD="); Serial.print(diff, DEC);

  // 2. Ищем пропорциональный и дифференциальный коэффициенты:
  if( _dir > absPrevDir ){
    // Упс .. ухудшение ситуации: прошлый раз ехали ближе к линии: дополнительно усиливаем поворот
//    Serial.print(" bad ");
    prop = propOut(_dir);
    diff = -tblDiff(_dir); // надо шибче тормозить вн. колесо!

    if( 
      _dir >= 4 && (          // последний датчик И
        (lastCount > 12) ||   // .. перед ним ехали шустро ИЛИ
        (lastDir < 3)         // .. .. слишком резко ушла линия
      )
    ){ // и шли на 3 достаточно долго..
//      Serial.print(", ABS: dir>3 !!!");
      drvAbsStop(2);
      _out /= 2;
//      if( lastCount < 6 ){ // Хуже и сильно - ABS торможение
//        drvAbsStop(1);
//        Serial.print(", +ABS: "); Serial.print(10-lastCount, DEC);
//      }
    }
  }else
  if( _dir < absPrevDir ){
    // О! .. в прошлый раз ехали хуже, стало ближе к линии: уменьшаем силу поворота
//    Serial.print(" good ");
    prop = propIn(_dir);
    diff = tblDiff(_dir); // надо шибче ускорить вн. колесо!
  }else{
    // без изменений: просто уменьшаем diff, prop с предыдущего цикла "какой был":
//    Serial.print(" old ");
    diff = diff / 2;
  }
//  Serial.print(", prop="); Serial.print(prop, DEC);
//  Serial.print(", diff="); Serial.print(diff, DEC);
  // 3. Вычисляем добавку от diff по скорости машинки:
  difV = outSpeed * diff/128;
//  Serial.print(", difV="); Serial.print(difV, DEC);

  // 4. Считаем скорость внутреннего колеса:
  inSpeed = _out * prop / 128 + difV;
  outSpeed = _out;
//  Serial.print(", inSpeed="); Serial.print(inSpeed, DEC);
//  Serial.print(", outSpeed="); Serial.print(outSpeed, DEC);
}

/**
 * Собственно вычислялка скоростей колес тут:
 * 
 * @param int8_t dir -- текущее направление (ошибка от линии)
 * < 0 -- линия слева
 * > 0 -- линия справа
 * ==0 -- едем прямо по линии
 */
void calcSpeed()
{
  calcDir();

  if( dir<0 ){
    // линия слева, ПОВОРОТ ВПРАВО (правое - внешнее):
    calcTurn( -dir, 0, 1);
  }else
  if( dir>0 ){
    // линия справа, ПОВОРОТ ВЛЕВО:
    calcTurn( dir, 1, 0);
  } else{
    // едем прямо:
    calcForward();
  }
}

