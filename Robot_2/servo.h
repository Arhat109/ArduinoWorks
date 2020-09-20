// ============ Общие константы и енумераторы для серводвигателей дописывать сюда ============ //

#define servo1   2                                      // Серводвигатели, сразу все 8 шт.
#define servo2   3
#define servo3   5
#define servo4   6
#define servo5   7
#define servo6   8
#define servo7   11
#define servo8   12

enum ServoTypes { SG90 = 1, MG90, MG995, MG996 };       // типы серводвигателей:
enum ServoDirs  { TO_LEFT, TO_RIGHT };                  // направления вращения если смотреть сверху на ось

#define SG90_0        140                               // SG90: минимальное значение ширины импульса будем считать это как "0 градусов" (вправо)
#define SG90_1          3                               // SG90: угол в градусах при повороте на 1 шаг
#define SG90_180      620                               // SG90: максимальное значение для моего двигателя. Будет "180 градусов" (влево)
#define SG90_STEP1      8                               // SG90: шаг с которым будем поворачивать двигатель (3 грд.)
#define SG90_WAIT1      5                               // SG90: =3*(120/60) + 2(запас) ТТХ сервы: за 0.12сек на 60грд!
#define SG90_STUPID   100                               // SG90: время задержки состояния "все сделано", чтобы "не так шустро носился".

#define MG90_0        150                               // @TODO: ПОДБИРАТЬ по реальным положениям серводвигателей .. примерные цифры.
#define MG90_1          3
#define MG90_180      614
#define MG90_STEP       8
#define MG90_WAIT       8
#define MG90_STUPID   100

#define MG995_0       150
#define MG995_1         3
#define MG995_180     614
#define MG995_STEP      8
#define MG995_WAIT      8
#define MG995_STUPID  100

#define MG996_0       150
#define MG995_1         3
#define MG996_180     614
#define MG996_STEP      8
#define MG996_WAIT      8
#define MG996_STUPID  100

typedef struct {
  TSC_Simple      ctrl;                                 // тут будем хранить текущее состояние КА серводвигателя
  uint16_t        position;                             // текущее положение серводвигателя
  ServoDirs       direction;                            // текущее направление куда крутимся вправо или влево?
} TSC_Servo;

#define ptrServo(ptr) ((TSC_Servo *)(ptr))              // преобразование в указатель на структуру КА для серводвигателей:

/* ======== Подключение серводвигателя датчика расстояний  ======== */

/**
 * Завершение текущей команды серводвигателя датчика: останов сервы и запуск измерений датчиком расстояний
 */
void servo_end(void *_ctrl)
{
//  Serial.print(", servo end");
  tsc_simple( &(ptrServo(_ctrl)->ctrl), 0, 1); // серве датчика: ничего не делать, проверять состояние каждую миллисекунду
  brain.state = BRAIN_SERVO_MOVED;
}

/**
 * Поворот серводвигателя на заданный угол:
 */
uint8_t srvServo_move(void *_tsc, uint16_t step)
{
    uint16_t tmpPos = ptrServo(_tsc)->position + step;

    if( (tmpPos >= SONIC_0) && (tmpPos <= SONIC_180) )
    {
        ptrServo(_tsc)->position = tmpPos;
        pwmWrite(pinSONIC, ptrServo(_tsc)->position);      // поворачиваем серводвигатель на угол
//Serial.print(", pos=");
//Serial.print(ptrServo(_tsc)->position);
        return 1;
    }
    return 0;
}

/**
 * Поворот серводвигателя (N1) датчика HCSR-04 на 1 шаг вперед (влево, TO_LEFT) или назад (вправо, TO_RIGHT):
 */
void srvSONIC_next(void *_tsc)
{
//Serial.print(", servo next ");
  if( ptrServo(_tsc)->direction == TO_LEFT )
  {
    if( !srvServo_move(_tsc, SONIC_STEP1) ){
        // Движение влево закончено, все замеры произведены.
        brain.state = BRAIN_SERVO_END_LEFT;
    }
  }
  else if( ptrServo(_tsc)->direction == TO_RIGHT )
  {
    if( !srvServo_move( _tsc, -SONIC_STEP1) ){
        // Движение вправо закончено, все замеры произведены.
        brain.state = BRAIN_SERVO_END_RIGHT;
    }
  }
  tsc_simple( &(ptrServo(_tsc)->ctrl), servo_end, SONIC_WAIT1); // запуск обработки "серва повернулась" через SOINC_WAIT1
}

