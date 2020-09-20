/**
 * Модуль расчета скоростей моторов по ситуации
 * 
 * @author fvn-20171009
 */

// номер адреса, с которого храним в EEPROM настройки для калькулятора:
#define calcEEPROM  2

#define MAX_STEPS   5

int8_t prevDir    = 0; // величина ошибки направления с предыдущего замера. Иначе никак не узнать куда потеряли линию..
int    dirCount   = 0; // текущий счетчик повтора направления (как долго уже едем с такой ошибкой)
int8_t lastDir    = 0; // предыдущее направление было таким
int    lastCount  = 0; // с ним ехали столько раз
int    lastDiff   = 0; // текущяя добавка к скоростям, если последний режим был тоже поворот
int    sumDir     = 0; // интегральное (суммарное) накопление общей ошибки движения по линии
int    curStep    = 5; // текущий шаг изменения скоростей
int    lPredictor = 0; // состояние левого автомата предсказателя
int    rPredictor = 0; // состояние правого автомата предсказателя

// Структура данных настройки калькулятора
struct {
  int maxRotate;          // MAX_ROTATE - макс. скорость внешнего колеса в поворотах
  int maxSpeed;           // MAX_SPEED  - макс. скорость по прямой
  int maxDiff;            // MAX_DIFF   - макс. изменение шага от последней ситуации
  int maxSumDir;          // MAX_SUMDIR - интегральный к-т учета суммарной ошибки движения
  int speedDown;          // SPEED_DOWN - насколько падают макс. скорости от предсказателя
  int tblProp[MAX_DIR+1]; // "пропорциональный к-т" - массив разниц скоростей моторов согласно ошибке (расстоянию) линии.
  int tblStep[MAX_STEPS]; // "дифференциальный к-т" - массив шагов изменения скоростей моторов: больше номер - медленнее повороты
} calc = {
  // MAX_ROTATE, MAX_SPEED, MAX_DIFF, MAX_SUMDIR, SPEED_DOWN
         130,       120,       8,         1000,      50,
  // dir: 1   2   3    4    5
//       { 34, 68, 102, 136, 170}, // расчетные значения по пред. настройке
       { 18, 54,  99, 144, 180}, // расчетные значения В-2
  // lastCount: <3, <9, <27, <81, >=81
              {  9,  8,  7,   6,   5}  // шаги изменения скорости от "как долго ехали стабильно"
};

// ПЕРЕИМЕНОВАНИЯ, дабы не писать длинно:
#define MAX_ROTATE calc.maxRotate
#define MAX_SPEED  calc.maxSpeed
#define MAX_DIFF   calc.maxDiff
#define MAX_SUMDIR calc.maxSumDir
#define SPEED_DOWN calc.speedDown
#define STEP       curStep
#define tblProp    calc.tblProp
#define tblStep    calc.tblStep

/**
 * Считает величину ошибки линии от середины машинки
 * влево < 0, вправо > 0, ==0 -- линия посередине
 */
int8_t calcDir()
{
  int      summ = 0;
  int8_t   count = 0;
  int8_t   dir;

  // считаем только по тем датчикам, которые смотрят на линию! Без предсказателей..
  for( uint8_t i=1; i<MAX_SENSORS-1; i++ ){
    summ += snAdc(i) * snDir(i);
    count += snAdc(i);
  }

  // смотрим что получилось: если есть датчики на линии, то ошибка = сумма расстояний поделить на число датчиков на линии
  // иначе: линия потеряна и надо смотреть "где была" в прошлый замер
  if( count>0 ){
    dir = summ/count; // @TODO: Не умеет делить - очень долго!!!
  }else{
    if     ( prevDir>0 ){ dir =  MAX_DIR; } // линия была справа - потерялась там же..
    else if( prevDir<0 ){ dir = -MAX_DIR; } // линия была слева ..
    else{
      // упс.. ехали прямо и потеряли линию .. продолжаем прямо
      dir = 0;
    }
  }

  // направление изменилось? нет: считаем сколько так уже едем, да: сохраняем текущее как "последнее" (last), начинаем заново
  if( prevDir == dir ){
    dirCount++;
  }else{
    lastCount = dirCount;
    lastDir   = dir;
    dirCount = 1;
  }

  // перевычисляем шаг изменений скоростей, смотря как ехали прошлый раз:
  {
    uint8_t stepNum;

    if     ( lastCount < 3  ){ stepNum = 0; }
    else if( lastCount < 9  ){ stepNum = 1; }
    else if( lastCount < 27 ){ stepNum = 2; }
    else if( lastCount < 81 ){ stepNum = 3; }
    else                     { stepNum = 4; }

    STEP = tblStep[stepNum];
  }
  return dir;
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
  if( speed > max - STEP ){ speed -= STEP; }
  else
    speed = max;
  return speed;
}

/** вычиталка скорости с контролем нижней границы в обратном направлении -max */
int subSpeed( int speed, int max)
{
  if( speed > STEP - max ){ speed -= STEP; }
  else
    speed = -max;
  return speed;
}

/**
 * Едем прямо:
 */
void calcForward()
{
  // 1. Если моторы крутятся с разной скоростью - пытаемся их выровнять
  if     ( lmSpeed - rmSpeed > 2*STEP ){ rmSpeed += STEP; lmSpeed -= STEP;          }
  else if( rmSpeed - lmSpeed > 2*STEP ){ lmSpeed += STEP; rmSpeed -= STEP;          }
  else                                 { rmSpeed = lmSpeed = (lmSpeed + rmSpeed)/2; }

  // 1.2 "диф. управление" при переходе на прямую: дополнительно выравниваем колеса, если в прошлый раз ехали в повороте:
  if( prevDir != 0 ){
    if     ( lmSpeed - rmSpeed > 2*STEP ){ rmSpeed += STEP; lmSpeed -= STEP;          }
    else if( rmSpeed - lmSpeed > 2*STEP ){ lmSpeed += STEP; rmSpeed -= STEP;          }
    else                                 { rmSpeed = lmSpeed = (lmSpeed + rmSpeed)/2; }
  }

  // 2. Если крутятся слишком быстро - притормаживаем мотор(ы)
  if( lmSpeed > MAX_SPEED ){ lmSpeed = downSpeed(lmSpeed, MAX_SPEED); }
  if( rmSpeed > MAX_SPEED ){ rmSpeed = downSpeed(rmSpeed, MAX_SPEED); }

  // 3. Если моторы крутятся слишком медленно - разгоняем машинку
  if( lmSpeed < MAX_SPEED ){ lmSpeed = addSpeed(lmSpeed, MAX_SPEED); }
  if( rmSpeed < MAX_SPEED ){ rmSpeed = addSpeed(rmSpeed, MAX_SPEED); }
}

/**
 * Поворот, хоть куда: вычисляем скорости внешнего и внутреннего колеса согласно расстоянию линии от середины
 * 
 * @param int8_t   dir -- величина отклонения линии от середины - всегда >0!
 * @param uint8_t  in  -- номер внутреннего колеса 0-левое, 1-правое
 * @param uint8_t  ex  -- номер внешнего колеса ..
 */
void calcTurn( int8_t dir, uint8_t in, uint8_t ex)
{
  // 1. "пропорциональное управление": если разница скоростей моторов меньше заданной для ошибки:
  if( motor[ex].speed - motor[in].speed < tblProp[dir] ){
    //, то пробуем ускорить внешнее колесо и уменьшить скорость внутреннего:
    motor[ex].speed = addSpeed( motor[ex].speed, MAX_ROTATE);
    motor[in].speed = subSpeed( motor[in].speed, MAX_ROTATE);
  }else if( motor[ex].speed - motor[in].speed > tblProp[dir] ){
    // иначе если больше: колеса поворот есть, но меньше чем был ранее - уменьшаем разницу:
    motor[ex].speed = subSpeed( motor[ex].speed, MAX_ROTATE);
    motor[in].speed = addSpeed( motor[in].speed, MAX_ROTATE);
  } // иначе (равно) - ничего не делаем.

  // 2. "дифференциальное управление": учет текущих изменений в ситуации:
  if( dir > abs(prevDir) ){
    // Упс .. ухудшение ситуации: прошлый раз ехали ближе к линии: дополнительно усиливаем поворот:
    motor[ex].speed = addSpeed( motor[ex].speed, MAX_ROTATE);
    motor[in].speed = subSpeed( motor[in].speed, MAX_ROTATE);
  }else{
    // О! .. в прошлый раз ехали хуже, стало ближе к линии: ещё уменьшаем силу поворота:
    motor[ex].speed = subSpeed( motor[ex].speed, MAX_ROTATE);
    motor[in].speed = addSpeed( motor[in].speed, MAX_ROTATE);
  }
  
  // 3. "дифф. управление" часть2: если последний режим был поворот, учитываем его тоже:
  if( lastDir != 0 ){
    if( dir != abs(prevDir) ){
      // Первое изменение - получаем доп. шаг для скоростей:
      lastDiff = MAX_DIFF;
    }
    if( lastDiff > 0 ){
      // "дифф. управление" -- учет улучшения или ухудшения от последнего режима
      if( dir > abs(lastDir) ){
        // Ухудшение (последний режим был ближе к линии):
        if( motor[ex].speed < MAX_ROTATE - lastDiff ){ motor[ex].speed += lastDiff; }
        if( motor[in].speed > lastDiff - MAX_ROTATE ){ motor[in].speed -= lastDiff; }
      }else{
        // Улучшение (последний режим был дальше):
        if( motor[in].speed < MAX_ROTATE - lastDiff ){ motor[in].speed += lastDiff; }
        if( motor[ex].speed > lastDiff - MAX_ROTATE ){ motor[ex].speed -= lastDiff; }
      }
      lastDiff /= 2;
    }
  }

  // 4. "интегральное управление" -- суммарный учет всех предыдущих ошибок
  sumDir += lastDir;
  {
    int sum1 = sumDir / MAX_SUMDIR;

    if( sum1 > 0 ){
      // >0 -- усредненная ошибка тяготеет вправо:
      if( rmSpeed > sum1 - MAX_ROTATE ){ rmSpeed -= sum1; }
      if( lmSpeed < MAX_ROTATE - sum1 ){ lmSpeed += sum1; }
    }else if( sum1 < 0 ){
      //    <0 -- а так - влево
      if( rmSpeed < MAX_ROTATE - sum1 ){ rmSpeed += sum1; }
      if( lmSpeed > sum1 - MAX_ROTATE ){ lmSpeed -= sum1; }
    }
  }
}

/**
 * Предсказатель крутого разворота или поворота на 90*
 * Конечный автомат состояний:
 * 0 - контроль датчиков - предсказателей
 * 1 - датчик сработал - снижение мах скоростей
 * 2 - разворот - контроль обратного прохождение предсказателей - сброс.
 */
void calcPredictor()
{
  // правый предсказатель: в любом состоянии сбрасываем левый предсказатель..
  switch( rPredictor ){
    case 0: // ожидание предсказания справа:
      if( snVal(MAX_SENSORS-1) > snLvl(MAX_SENSORS-1) ){
        // Есть линия справа: снижаем предельные скорости и переходим в след. состояние:
        MAX_ROTATE -= SPEED_DOWN;
        MAX_SPEED  -= SPEED_DOWN;
        rPredictor = 1;
        lPredictor = 0;
      }
      break;
    case 1: // есть! ждем крутой поворот справа:
      if( prevDir == MAX_DIR ){
        // потеря линии: переход в след. состояние, восстанавливаем мах. скорости:
        MAX_ROTATE += SPEED_DOWN;
        MAX_SPEED  += SPEED_DOWN;
        rPredictor = 2;
        lPredictor = 0;
      }
      break;
    case 2: // прошли поворот, ждем сброса предсказателя справа:
      if( snVal(MAX_SENSORS-1) > snLvl(MAX_SENSORS-1) ){
        // Прошли линию ещё раз (обратно) - переход в начальное состояние
        rPredictor = 0;
        lPredictor = 0;
      }
  }
  // левый предсказатель: в любом состоянии сбрасываем правый..
  switch( rPredictor ){
    case 0: // ожидание предсказания:
      if( snVal(0) > snLvl(0) ){
        // Есть линия справа: снижаем предельные скорости и переходим в след. состояние:
        MAX_ROTATE -= SPEED_DOWN;
        MAX_SPEED  -= SPEED_DOWN;
        lPredictor = 1;
        rPredictor = 0;
      }
      break;
    case 1: // есть! ждем крутой поворот:
      if( prevDir == MAX_DIR ){
        // потеря линии: переход в след. состояние, восстанавливаем мах. скорости:
        MAX_ROTATE += SPEED_DOWN;
        MAX_SPEED  += SPEED_DOWN;
        lPredictor = 2;
        rPredictor = 0;
      }
      break;
    case 2: // прошли поворот - сброс предсказателей:
      if( snVal(0) > snLvl(0) ){
        // Прошли линию ещё раз (обратно) - переход в начальное состояние
        lPredictor = 0;
        rPredictor = 0;
      }
  }
}

