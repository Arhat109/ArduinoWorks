/**
 * Модуль работы с моторами.
 * 
 * @author fvn-20171009
 */

#define MICROSTOP     6
#define MIN_SPEED    20
#define MAX_MOTORS    2

struct {
  uint8_t dir;
  uint8_t pwm;
  int     speed;
  int     old;
  bool    change;
} motor[MAX_MOTORS] = {
  { 4, 5, 0, 0, false},
  { 7, 6, 0, 0, false}
};
#define lmSpeed   (motor[0].speed)
#define rmSpeed   (motor[1].speed)
#define lmDir     (motor[0].dir)
#define lmPwm     (motor[0].pwm)
#define rmDir     (motor[1].dir)
#define rmPwm     (motor[1].pwm)
#define lmChange  (motor[0].change)
#define rmChange  (motor[1].change)

/**
 * Начальная установка: останавливаем моторы и выставляем их "вперед"
 */
void setupMotors()
{
  pinMode(lmDir, OUTPUT);
  pinMode(lmPwm, OUTPUT);
  pinMode(rmDir, OUTPUT);
  pinMode(rmPwm, OUTPUT);
  digitalWrite(lmDir, LOW);
  digitalWrite(rmDir, LOW);
  digitalWrite(lmPwm, LOW);
  digitalWrite(lmPwm, LOW);
  motor[0].old = motor[1].old = lmSpeed = rmSpeed = 0;
  lmChange = rmChange = false;
}

/**
 * Единая процедура управления обоими моторами через MOSFET-драйвер
 * 
 * Самостоятельно контролирует переключение моторов вперед/назад и выдерживает все паузы переключений.
 * Помнит предыдущую установленную скорость моторов.
 */
void moveMotors()
{
  bool isStop = false;

  lmChange = ((lmSpeed < 0) && (motor[0].old >=0)) || ((lmSpeed >=0) && (motor[0].old < 0));
  rmChange = ((rmSpeed < 0) && (motor[1].old >=0)) || ((rmSpeed >=0) && (motor[1].old < 0));

  // 1. Если надо - выключаем мотор(ы):
  if( (abs(lmSpeed) < MIN_SPEED) || lmChange )
  {
    digitalWrite( lmPwm, LOW );
    isStop = true;
  }
  if( (abs(rmSpeed) < MIN_SPEED) || rmChange )
  {
    digitalWrite( rmPwm, LOW );
    isStop = true;
  }
  // 2. Если останавливали мотор(ы) - держим паузу
  if( isStop ){ delay( MICROSTOP ); }

  // 3. Если надо - меняем направление:
  if( lmChange )
  {
    if( lmSpeed >= 0 ){ digitalWrite( lmDir , LOW );  isStop = true; }
    else              { digitalWrite( lmDir , HIGH ); isStop = true; }
  }
  if( rmChange ){
    if( rmSpeed >= 0 ){ digitalWrite( rmDir , LOW );  isStop = true; }
    else              { digitalWrite( rmDir , HIGH ); isStop = true; }
  }

  // 4. Если меняли направление - держим паузу:
  if( isStop ){ delay( MICROSTOP*2 ); }

  // 5. Если надо - задаем скорость моторов:
  if( abs(lmSpeed) >= MIN_SPEED ){ analogWrite( lmPwm, abs(lmSpeed) ); }
  if( abs(rmSpeed) >= MIN_SPEED ){ analogWrite( rmPwm, abs(rmSpeed) ); }

  // 6. Запоминаем текущие скорости как бывшие:  
  motor[0].old = lmSpeed;
  motor[1].old = rmSpeed;
}

/**
 * Проверка(вывод) данных по моторам в монитор
 * 
 * @param bool isAll -- выводить всё или только скорости?
 */
void printMotors( bool isAll)
{
  for(uint8_t i=0; i<MAX_MOTORS; i++)
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

