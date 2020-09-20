#include <EEPROM.h>

/**
 * Модуль чтения-записи данных в/из EEPROM согласно их "типам":
 * умеет читать/писать данные автонастройки датчиков линии, а также
 * данные по группе настроек калькулятора линии
 * 
 * @author fvn-20171009
 * 
 * !!! Внимательно: подключать после файлов sensor.h, calculator.h и др.. 
 */

/** Читалка данных из EEPROM */
void readEEPROM(int adrFrom, byte *adrTo, uint16_t count)
{
  do{
    *(adrTo++) = EEPROM.read( (int)adrFrom++ );
  }while( --count );
}

/** Писалка данных в EEPROM */
void writeEEPROM(int adrTo, void *adrFrom, uint16_t count)
{
  byte * _ptrFrom = (byte *)adrFrom;

  do{
    EEPROM.write( adrTo++, (*_ptrFrom++) );
  }while( --count );
}

