
// 4. Назначем пины светофору и делаем функцию инициализации:
#define pinRed    6
#define pinYellow 7
#define pinGreen  8

void rgbSetup(){
  pinMode(pinRed,    OUTPUT);
  pinMode(pinYellow, OUTPUT);
  pinMode(pinGreen,  OUTPUT);
}

// 3. Создаем "команды" светофора:
int8_t doRGB_Off(KaTimeControl *_ka)
{
  digitalWrite(pinRed, LOW);
  digitalWrite(pinYellow, LOW);
  digitalWrite(pinGreen, LOW);
  return 1;
}
int8_t doRGB_Red(KaTimeControl *_ka)
{
  doRGB_Off(_ka);
  digitalWrite(pinRed, HIGH);
  return 1;
}
int8_t doRGB_Yellow(KaTimeControl *_ka)
{
  doRGB_Off(_ka);
  digitalWrite(pinYellow, HIGH);
  return 1;
}
int8_t doRGB_Green(KaTimeControl *_ka)
{
  doRGB_Off(_ka);
  digitalWrite(pinGreen, HIGH);
  return 1;
}
int8_t doRGB_All(KaTimeControl *_ka)
{
  digitalWrite(pinRed, HIGH);
  digitalWrite(pinYellow, HIGH);
  digitalWrite(pinGreen, HIGH);
  return 1;
}

// генератор ошибки (примера для)
int8_t doRGB_Error(KaTimeControl *_ka)
{
  return (rand()%100 > 10? 1 : 0);
}

// 2. Создаем "программу" для светофора
// Закомментирован вариант объявления (и запуска) с размещением программы во flash
// Возврат любой командой "ошибки" (0) приведет к аварии "морганию всеми светодиодами"

//const KaTimeStep rgbProg[] PROGMEM = {
KaTimeStep rgbProg[] = {
// поля:  command,    timeout,       nextOk,      nextNo
       { doRGB_Off,       0,KA_STATE_OFF,KA_STATE_OFF}, //  0: светофор выключен и стоит в этом шаге
       { doRGB_Red,    3000,  2,  9}, //  1: включить красный на 3сек
       { doRGB_Yellow,  500,  3,  9}, //  2: включить желтый на 0.5сек
       { doRGB_Green,  1000,  4,  9}, //  3: включить зеленый на 1 сек
       { doRGB_Off,     250,  5,  9}, //  4: выключить
       { doRGB_Green,   250,  6,  9}, //  5: мигаем зеленым
       { doRGB_Off,     250,  7,  9}, //  6: выключить
       { doRGB_Green,   250,  8,  9}, //  7: мигаем зеленым
       { doRGB_Error,     0,  1,  9}, //  8: ошибка? повторяем программу или переходим на обработку ошибки

       { doRGB_All,     250, 10, 10}, //  9: Ошибка светофора! Включаем все на 0.25сек
       { doRGB_Off,     250, 11, 11}, // 10: Ошибка светофора! Выключаем всё на 0.25сек или стоп.
       { doRGB_Error,     0,  1,  0}, // 11: ошибка? повторная ошибка выключает светофор..
};

// 1. Определяем глобальную структуру для светофора (тут задан старт с первой, а не нулевой записи!):
KaTimeControl rgb = {
// поля: started_at, timeout, nextState, table
              0,        0,        1,    ptrKaTimeStep(rgbProg) // желательно явное приведение при размещении во flash
};

