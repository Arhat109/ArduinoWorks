/**
 * Модуль датчика HCSR-04 -- льтразвуковой замер расстояний
 * 
 * @author fvn-20171009
 */

#define trigPin 3
#define echoPin 8
#define MAX_DISTANCE 5000

/**
 * Возвращает расстояние в миллиметрах, замеряя не далее 600мм (около 2мсек)
 * с точностью +- 5миллисекунд (+-8мм)
 * 
 * Сделана для того, чтобы ограничить время замера гарантированно..
 */
uint16_t getDistance()
{
  bool      isNotDistance = true;
  int       distCount     = 500;
  uint16_t  distance;

  // Запуск замера - подаем "свисток" датчиком:
  digitalWrite( trigPin , HIGH );
  delayMicroseconds( 10 );
  digitalWrite( trigPin , LOW );

  // Ждем конца свистка и начала ожидания эха (echo==HIGH) не дольше полмиллисекунды:
  while( (digitalRead(echoPin) == LOW) && (distCount>0) )
  {
    delayMicroseconds( 1 );
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
      distance = (uint16_t)( ((200-distCount)*681UL) / 256) ;
    }else{
      delayMicroseconds( 10 );
    }
    distCount--;
  }
  return distance;
}

