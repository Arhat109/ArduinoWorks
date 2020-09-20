/**
 * Модуль работы с моторами и драйвером к ним "Ардуино как Лего".
 * 
 * Плата драйвера не имеет аппаратной защиты от сквозных токов через силовые ключи моторов.
 * Основное назначение: управление моторами с учетом задержек на переключение силовых ключей.
 * При остановке мотора по линии PWM=0 (N-канал) реальная задержка ключа драйвера менее 1мксек.
 * При изменении направления (линия DIR, P-канал) реальная задержка ключа в районе 3мксек.
 * Здесь взято с запасом для надежности: + стекание токов с индуктивности моторов.
 * 
 * Если ничего не задано до включения файла - предполагается создание типовой 
 * глобальной структуры motors[2] на 2 мотора и работа с ними.
 * 
 * DRV_MIN_SPEED - та минимальная скорость, при которой мотор ещё вращается под вашей нагрузкой реально.
 * Добавлено, дабы зря не расходовать батарейки.
 * 
 * Скорость измеряется в единицах ШИМ (0..255) как "вперед" (больше нуля, >0) так и назад (меньше нуля, <0)
 * поэтому число целое.. нулевая скорость тоже считается как "вперед" при переключении направлений.
 * 
 * @author fvn-20171009,
 * 20191208 -- добавлены комментарии, раздельное управление моторами.
 */

/** Микропаузы переключения драйвером мотора туда-обратно */
#define DRV_MICROSTOP     3
#define DRV_MICRODIR      (DRV_MICROSTOP * 3)

/** Допустимая минимальная скорость вращения (Pwm). Меньше === останов */
#ifndef DRV_MIN_SPEED
  #define DRV_MIN_SPEED 0
#endif

/** Описание мотора и текущая скорость */
typedef struct _dvr_motors_ {
  uint8_t dir;    // пин направления
  uint8_t pwm;    // пин скорости (ШИМ)
  int     speed;  // текущая скорость
  int     old;    // "предыдущая скорость"
  bool    change;
} DrvMotors;

/** Приведение указателя к структуре и получение адреса нужного мотора */
#define ptrDrvMotor(p)     ((DrvMotors *)(p))
#define ptrDrvMotors(p,n) (((DrvMotors *)(p))+(n))

/** Подключено моторов (до 4х) */
#ifndef DRV_MAX_MOTORS
  #define DRV_MAX_MOTORS    2
#endif

/** 2 мотора "по умолчанию" к 4,5 и 6,7 пинам НАНО(328) */
#ifndef motor
DrvMotors motor[DRV_MAX_MOTORS] =
{
  { 4, 5, 0, 0, false},
  { 7, 6, 0, 0, false}
};
#endif

/** Удобства для: */
#define drvPinDir(n)     (motor[(n)].dir)
#define drvPinPwm(n)     (motor[(n)].pwm)
#define drvSpeed(n)      (motor[(n)].speed)
#define drvOldSpeed(n)   (motor[(n)].old)
#define drvIsChange(n)   (motor[(n)].change)

// ==================================== DEBUG SECTION ========================================== //

/**
 * Проверка(вывод) данных по моторам в монитор
 * 
 * @param bool isAll -- выводить всё или только скорости?
 */
void drvPrintMotors( bool isAll)
{
  for(int8_t i=0; i<DRV_MAX_MOTORS; i++)
  {
    if( isAll ){ Serial.println(); }

    Serial.print("m="); Serial.print(i,DEC);

    if( isAll ){
      Serial.print(", chg="); Serial.print(motor[i].change, DEC);
      Serial.print(", old="); Serial.print(motor[i].old,    DEC);
    }

    Serial.print(", spd="); Serial.print(motor[i].speed, DEC);
  }
}

// ==================================== PRIVATE SECTION ========================================== //
// но вдруг кому(когда) понадобится ..

/**
 * private: Переключение заданного мотора c защитой от сквозного тока по его текущей скорости
 * .. останавливает мотор ..
 */
void _drvSwitchStop(uint8_t num)
{
   digitalWrite(drvPinPwm(num), LOW);
   delayMicroseconds(DRV_MICROSTOP);
   if( drvSpeed(num) >= 0 ){ digitalWrite(drvPinDir(num), LOW);  }
   else                    { digitalWrite(drvPinDir(num), HIGH); }
   delayMicroseconds(DRV_MICRODIR);
}

/** private: Включает заданную скорость с сохранением предыдущей в .old */
#define _drvSetSpeed(num)                            \
{                                                    \
  analogWrite( drvPinPwm(num), abs(drvSpeed(num)) ); \
  drvOldSpeed(num) = drvSpeed(num);                  \
}

/** private: Проверяет надо ли переключать мотор */
#define _drvMustChange(num) ((drvSpeed(num) < 0  && drvOldSpeed(num) >= 0) || (drvSpeed(num) >= 0 && drvOldSpeed(num) < 0))

// ==================================== PUBLIC METHODS ========================================== //

/**
 * в Setup(): останавливаем моторы и выставляем их "вперед" с 0 скоростью
 */
void setupMotors()
{
  uint8_t num=DRV_MAX_MOTORS;
  
  do{
    num--;

    pinMode(drvPinDir(num), OUTPUT);
    pinMode(drvPinPwm(num), OUTPUT);

    digitalWrite(drvPinPwm(num), LOW);
    digitalWrite(drvPinDir(num), LOW);
    delayMicroseconds(DRV_MICRODIR);

    drvOldSpeed(num) = 0;
    drvSpeed(num)    = 0;
    drvIsChange(num) = false;
  }while(num);
}

/**
 * public: Установить в заданный мотор новую скорость с переключением направления если надо
 */
void drvRunMotor(uint8_t num, int speed)
{
  if( _drvMustChange(num) ){ _drvSwitchStop(num); }

  drvSpeed(num) = speed;
  _drvSetSpeed(num);
}

/** public: остановить заданный мотор */
#define drvStopMotor(num) (drvRunMotor(num, 0))

/**
 * public: Одновременное(!) управление всеми моторами через MOSFET-драйвер
 * 
 * Самостоятельно контролирует переключение моторов вперед/назад и выдерживает все паузы переключений.
 * Помнит предыдущую установленную скорость моторов.
 * 
 * Назначение: максимально синхронное управление группой моторов для стиля конечных автоматов
 */
void drvMoveMotors()
{
  bool isStop = false;
  uint8_t num = DRV_MAX_MOTORS;

  // 1. Надо ли переключать какой-либо мотор? и выключаем сразу тут
  for( num = DRV_MAX_MOTORS; num; ){
    num--;
    drvIsChange(num) = _drvMustChange(num);
    if( drvIsChange(num) ){
      isStop = true;
      digitalWrite(drvPinPwm(num), LOW);
    }
  }

  // 2. Если останавливали мотор(ы) - держим паузу
  if( isStop ){
    delayMicroseconds( DRV_MICROSTOP );

    // 3. Если надо - меняем направление:
    for(num=DRV_MAX_MOTORS; num; ){
      num--;
      if( drvIsChange(num) ){
        if( drvSpeed(num) >= 0 ){ digitalWrite( drvPinDir(num) , LOW );  }
        else                    { digitalWrite( drvPinDir(num) , HIGH ); }
      }
    }
    // 4. Меняли направление - держим паузу:
    delayMicroseconds( DRV_MICRODIR );
  }

  // 5. Если надо - задаем скорость моторов и сохраняем предыдущую:
  for( num=DRV_MAX_MOTORS; num; ){
    num--;
    if( abs(drvSpeed(num)) >= DRV_MIN_SPEED ){ _drvSetSpeed(num); }
  }
}

/** public: останов всех моторов какие есть */
void drvStopMotors()
{
  for(uint8_t num = DRV_MAX_MOTORS; num; )
  {
    num--;
    drvSpeed(num) = 0;
  }
  drvMoveMotors();
}

/** ABS торможение всеми моторами */
void drvAbsStop(uint8_t absNum)
{
  do{
    drvStopMotors();
    delay(15);
    for(uint8_t num = DRV_MAX_MOTORS; num; )
    {
      num--;
      drvSpeed(num) = -160;
    }
    drvMoveMotors();
    delay(15);
  }while( --absNum );
  drvStopMotors();
}

