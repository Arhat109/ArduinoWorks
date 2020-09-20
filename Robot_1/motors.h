
#define m0f     22                                      // Управление 4-я моторами "f" - вперед, "b" - назад
#define m0b     23
#define m1f     24
#define m1b     25
#define m2f     26
#define m2b     27
#define m3f     28
#define m3b     29

#define m0s      4                                      // управление скоростью моторов через 8-бит ШИМ
#define m1s     13
#define m2s      9
#define m3s     10

#define m0e     65                                      // Энкодеры моторов тут PCINT2[0,1,2,3]
#define m1e     64
#define m2e     63
#define m3e     62

#define m0_id    0                                      // номера моторов в структуре pulses
#define m1_id    1
#define m2_id    2
#define m3_id    3

#define MIN_SPEED                 0                     // наименьшая скорость моторов
#define MAX_SPEED               255                     // Наибольшая задаваемая скорость мотора
#define MOTOR_WAIT_STOP          10                     // *3 тактов МК. Задержка на рассасывание зарядов в драйвере.

typedef struct{
  TSC_Simple      ctrl;                                 // тут будем хранить текущее состояние КА
  uint8_t         num;                                  // номер мотора для распознавания "чей" получен указатель
  uint8_t         speed;                                // заданная скорость разгона "до" [-MAX_SPEED .. MAX_SPEED]
} TSC_Motor;

#define ptrMotor(ptr) ((TSC_Motor *)(ptr))

#define MAX_MOTORS      4                               // Всего моторов
TSC_Motor     motor[MAX_MOTORS];                        // тут будем хранить текущее состояние КА моторов [0..3]

/**
 * Останов мотора
 */
void motorStop(uint8_t num)
{
  switch(num){
    case 0: pwmOff(m0s); pinOutLow(m0s); pinOutLow(m0f); pinOutLow(m0b); break;
    case 1: pwmOff(m1s); pinOutLow(m1s); pinOutLow(m1f); pinOutLow(m1b); break;
    case 2: pwmOff(m2s); pinOutLow(m2s); pinOutLow(m2f); pinOutLow(m2b); break;
    case 3: pwmOff(m3s); pinOutLow(m3s); pinOutLow(m3f); pinOutLow(m3b); break;
  }
  delayMicro8(MOTOR_WAIT_STOP);
}

/**
 * Устанавливает заданную скорость мотора
 */
void motorSpeed(uint8_t num)
{
  switch(num){
    case 0: pwmWrite(m0s, motor[num].speed); break;
    case 1: pwmWrite(m1s, motor[num].speed); break;
    case 2: pwmWrite(m2s, motor[num].speed); break;
    case 3: pwmWrite(m3s, motor[num].speed); break;
  }
}

/**
 * Включаем мотор "вперед"
 */
void motorForward(uint8_t num)
{
  motorStop(num);
  switch(num){
    case 0: pinOutHigh(m0f); pwmSet(m0s); break;
    case 1: pinOutHigh(m1f); pwmSet(m1s); break;
    case 2: pinOutHigh(m2f); pwmSet(m2s); break;
    case 3: pinOutHigh(m3f); pwmSet(m3s); break;
  }
  motorSpeed(num);
}

/**
 * Включаем мотор "назад"
 */
void motorBack(uint8_t num)
{
  motorStop(num);
  switch(num){
    case 0: pinOutHigh(m0b); pwmSet(m0s); break;
    case 1: pinOutHigh(m1b); pwmSet(m1s); break;
    case 2: pinOutHigh(m2b); pwmSet(m2s); break;
    case 3: pinOutHigh(m3b); pwmSet(m3s); break;
  }
  motorSpeed(num);
}

/**
 * Изменяет скорость мотора на заданный шаг
 */
void motorAddSpeed(uint8_t num, int8_t step)
{
    int speed = motor[num].speed;

    speed += step;
    if( speed < MIN_SPEED ){ speed = MIN_SPEED; }
    if( speed > MAX_SPEED ){ speed = MAX_SPEED; }
    motor[num].speed = (uint8_t)speed;
    motorSpeed(num);
}

