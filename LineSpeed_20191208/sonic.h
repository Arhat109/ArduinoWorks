/**
 * Модуль датчика HCSR-04 -- льтразвуковой замер расстояний
 * 
 * @author fvn-20171009
 */

#define echoPin 2
#define trigPin 3
#define MAX_DISTANCE 5000

uint16_t distance;

void setupSonic()
{
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

/** "Свисток" - запуск замера расстояния */
void sonicStart()
{
  digitalWrite( trigPin , HIGH );
  delayMicroseconds( 10 );
  digitalWrite( trigPin , LOW );
}

/** Обработчик INT0 (PD2 Nano!) прерывания на пине echo */

/**
 * Возвращает расстояние в миллиметрах, замеряя не далее 600мм (около 2мсек)
 * с точностью +- 5миллисекунд (+-8мм)
 * 
 * Сделана для того, чтобы ограничить время замера гарантированно..
 */
uint16_t getDistance()
{
  long duration;

  // Сначала генерируем короткий импульс длительностью 2-5 микросекунд.
  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);
  digitalWrite(trigPin, HIGH);
  // Выставив высокий уровень сигнала, ждем около 10 микросекунд. В этот момент датчик будет посылать сигналы с частотой 40 КГц.
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  //  Время задержки акустического сигнала на эхолокаторе. Ожидание в микросекундах
  duration = pulseIn(echoPin, HIGH, 2000);

  return duration? (uint16_t)(duration*343/2048) : MAX_DISTANCE;
}
/*
uint16_t getDistance()
{
  bool      isNotDistance = true;
  int       distCount     = 500;
  uint16_t  distance;

  // Запуск замера - подаем "свисток" датчиком:
  sonicStart();

  // Ждем конца свистка и начала ожидания эха (echo==HIGH) не дольше полмиллисекунды:
  while( (digitalRead(echoPin) == LOW) && (distCount>0) )
  {
    distCount--;
  }
  if( distCount == 0 ){ isNotDistance = false; }

  // замеряем длительность эха, не дольше 2 мсек или около 60см:
  distCount = 200;
  distance = 5000UL ;
  while( isNotDistance && (distCount>0) )
  {
    if( digitalRead(echoPin) == LOW )
    {
      isNotDistance = false;
      distance = (uint16_t)( ((200-distCount)*650UL) / 256) ;
    }else{
      delayMicroseconds( 10 );
    }
    distCount--;
  }
  return distance;
}
*/
