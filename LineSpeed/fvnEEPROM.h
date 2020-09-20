/**
 * Модуль чтения-записи данных в/из EEPROM согласно их "типам":
 * умеет читать/писать данные автонастройки датчиков линии, а также
 * данные по группе настроек калькулятора линии
 * 
 * @author fvn-20171009
 * 
 * !!! Внимательно: подключать после файлов sensor.h, calculator.h и др.. 
 */

#include <EEPROM.h>

#define MAX_EEPROM_DATA 3

// адреса типов данных, которые умеем хранить в EEPROM:
uint16_t adrEEPROM[MAX_EEPROM_DATA] = {
  0, 0, 100
};

/**
 * Читалка данных из EEPROM
 * Если это настройки калькулятора, то count - это НОМЕР группы настроек!
 * 
 * @param uint8_t  what  -- "что читаем" (определяет адрес EEPROM откуда и глобальный массив "куда")
 * @param uint16_t count -- Сколько элементов массива читаем
 */
void readEEPROM(uint8_t what, uint16_t count)
{
  uint16_t adrFrom;
  uint16_t adrTo;
  uint16_t eepromCount;

  switch( what )
  {
    case snEEPROM: // читаем данные для датчиков
      adrFrom = adrEEPROM[snEEPROM];
      adrTo = (uint16_t)sensor;
      eepromCount = sizeof(sensor[0]) * count;
      break;
    case calcEEPROM: // читаем настройки для калькулятора скоростей
      adrFrom = adrEEPROM[snEEPROM] + sizeof(calc)*count;
      adrTo = (uint16_t)&calc;
      eepromCount = sizeof(calc);
      break;
    default:
      // завешиваем МК: не знаем что читать!
      die();
  }
  while( eepromCount-- ){
    *((byte *)adrTo) = EEPROM.read( (int)adrFrom );
    adrTo++;
    adrFrom++;
  }
}

/**
 * Писалка данных в EEPROM согласно указанного типа
 * Если это настройки калькулятора, то count - это НОМЕР группы настроек!
 * 
 * @param uint8_t  what  -- "что читаем" (определяет адрес EEPROM откуда и глобальный массив "куда")
 * @param uint16_t count -- Сколько элементов массива читаем
 */
void writeEEPROM(uint8_t what, uint16_t count)
{
  uint16_t adrFrom;
  uint16_t adrTo;
  uint16_t eepromCount;

  switch( what )
  {
    case snEEPROM: // читаем данные для датчиков
      adrTo = adrEEPROM[snEEPROM];
      adrFrom = (uint16_t)sensor;
      eepromCount = sizeof(sensor[0]) * count;
      break;
    case calcEEPROM: // читаем настройки для калькулятора скоростей
      adrTo = adrEEPROM[snEEPROM] + sizeof(calc)*count;
      adrFrom = (uint16_t)&calc;
      eepromCount = sizeof(calc);
      break;
    default:
      // завешиваем МК: не знаем что читать!
      die();
  }
  while( eepromCount-- ){
    EEPROM.write( (int)adrTo, (*(byte *)adrFrom) );
    adrTo++;
    adrFrom++;
  }
}

