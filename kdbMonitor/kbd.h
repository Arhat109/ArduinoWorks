
// статически настраиваем пины строк (будут выходами сканирования) и столбцов (входы опроса кнопок)
uint8_t kbdRows[] = {2,3,4,5};
uint8_t kbdCols[] = {A0,A1,A2,A3};

// перед подключением настраиваемся на конкретную клавиатуру
#define KBD_MAX_ROWS 4
#define KBD_MAX_COLS 4
#define KBD_MAX_RESULT 4

#include "keyboard.h"

// Теперь доступен тип Kbd, определяем глобал "клавиатура"
Kbd glKbd;

// монитор нажимаемых клавиш:
// 0-9 -- ввод числа.
// 'A' -- время горения красного в секундах (до 99сек)
// 'B' -- время горения желтого в секуднах (до 9)
// 'C' -- время непрерывного горения зеленого в секундах (до 99)
// '*' -- исправление неверно введенной цифры (backspace)
// '#' -- сохранение ввода в нужном месте.
//
// вводим признаки какая длительность вводится сейчас:
bool isRed=false, isYellow=false, isGreen=false;
// Всего можно ввести цифр в буфер:
#define DIGIT_MAX 5
// место для хранения цифр числа (символов) (+1 символ - конец строки)
char digitInput[] = {'0','0','0','0','0', '\x0'};
// количество введенных цифр:
int8_t digitCount = 0;

// перевод номера кнопки в символ
char kbdToChar[] = {
  '1', '2', '3', 'A', '4', '5', '6', 'B', '7', '8', '9', 'C', '*', '0', '#', 'D'
};

// монитор клавиатуры - классический автомат Милли: реакция на входное событие (клавишу)
// в зависимости от состояния:

// слущатель входного потока (клавиатуры) ищем только отпущенные кнопки:
int8_t kbdGetChar(KaControl *_ka)
{
  kbdScan( &glKbd );
  if( glKbd.countUpped > 0 ){
    _ka->event = (int8_t)(kbdToChar[glKbd.upped[0]]);
    Serial.println(""); Serial.print("upped "); Serial.print(glKbd.upped[0], DEC);
    Serial.print(", char="); Serial.println(_ka->event);
    return 1; // нашли кнопку!
  }
  return 0; // нет событий..
}

// очистить буфер ввода и количество введенных цифр
int8_t kbdClearDO(KaControl *_ka)
{
  int8_t count = DIGIT_MAX;
  do{
    digitInput[--count] = '0';
  }while(count);
  digitCount = 0;
  return 1;
}

// Продижение младшей цифры в старший разряд, ввод в младший
int8_t kbdMovingDO(KaControl *_ka)
{
  int8_t cur = 0;
  do{
    digitInput[cur] = digitInput[cur+1];
  }while( ++cur < (DIGIT_MAX-1) );
  digitInput[cur] = _ka->event; // слушатель потока уже сложил символ в событие
  return 1;
}

// Ввод цифры в позицию переход к следующей, если есть куда
int8_t kbdInputDO(KaControl *_ka)
{
  if( digitCount < DIGIT_MAX ){
    digitInput[digitCount++] = _ka->event;
  }else{
    kbdMovingDO(_ka);
  }
  Serial.println(digitInput);
  return 1;
}

// Исправление цифр (backspace)
int8_t kbdBackspaceDO(KaControl *_ka)
{
  if( digitCount > 0 ){
    digitCount--;
    digitInput[digitCount] = '0';
  }
  return 1;
}

// Переключение режима ввода 'A', 'B' или 'C'
int8_t kbdModeDO(KaControl *_ka)
{
  char newMode = (char)(_ka->event);

  isRed = isYellow = isGreen = false;
  switch(newMode){
    case 'A': isRed    = true;
    Serial.println(""); Serial.println("mode Red:");
    break;
    case 'B': isYellow = true;
    Serial.println(""); Serial.println("mode Yellow:");
    break;
    case 'C': isGreen  = true;
    Serial.println(""); Serial.println("mode Green:");
    break;
  }
  return 1;
}

// '#' (Enter) -- фиксация введенных цифр в переменной режима ввода
int8_t kbdEnterDO(KaControl *_ka)
{
  int res = atoi(digitInput);

       if( isRed    ){ rgbProg[1].timeout = res; }
  else if( isYellow ){ rgbProg[2].timeout = res; }
  else if( isGreen  ){ rgbProg[3].timeout = res; }

  Serial.print(" timeout="); Serial.print(res, DEC);
  return 1;
}

// фактически состояние одно: ждем нажатия клавиши(1):
const KaMilliStep stWork[] PROGMEM = {
  {'0', kbdInputDO,     1, 0},
  {'1', kbdInputDO,     1, 0},
  {'2', kbdInputDO,     1, 0},
  {'3', kbdInputDO,     1, 0},
  {'4', kbdInputDO,     1, 0},
  {'5', kbdInputDO,     1, 0},
  {'6', kbdInputDO,     1, 0},
  {'7', kbdInputDO,     1, 0},
  {'8', kbdInputDO,     1, 0},
  {'9', kbdInputDO,     1, 0},
  {'*', kbdBackspaceDO, 1, 0},
  {'#', kbdEnterDO,     1, 0},
  {'A', kbdModeDO,      1, 0},
  {'B', kbdModeDO,      1, 0},
  {'C', kbdModeDO,      1, 0},
};
// на всякий случай состояние "ошибка" - сброс всего
const KaMilliStep stError[] PROGMEM = {
  {0, kbdClearDO, 1, 1},
};

// создаем таблицу состояний монитора клавиатуры
const KaMilliRow kbdStates[] PROGMEM = {
  { 1, ptrKaMilliStep(stError) },
  { 15, ptrKaMilliStep(stWork) }
};

// Определяем автомат Милли:
KaMilliControl kbdMonitor = {
// поле base: listener, command, state, event
  { kbdGetChar, _pgmMilliDo, 1, 0},
  ptrKaMilliRow(kbdStates)
};

