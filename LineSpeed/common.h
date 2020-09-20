/**
 * Набор "общих" процедур и функций
 * 
 * @author fvn-20171009
 */

#define pinLed  13

/**
 * Моргалка:
 * @param uint8_t count -- сколько раз моргнуть
 * @param int     on    -- как долго светить в мсек
 * @param int     off   -- как долго ждать след. моргания (выкл)
 */
void blink(uint8_t count, int on, int off)
{
  while( count-- ){
    digitalWrite(pinLed, HIGH);
    delay(on);
    digitalWrite(pinLed, LOW);
    delay(off);
  }
}

/** Завешивалка микоконтроллера (моргает и только) на случай обнаружения фатальных ошибок в программе или при иных проблемах */
void die()
{
  while(1){
    blink(3, 150,150);
    delay(500);
  }
}
