/**
 * Реализация функций для создания и управления конечными автоматами
 * @author Arhat109-201902..
 */
#include <Arduino.h>
#include <avr/pgmspace.h>

//#include "ka.h"

// ************ 2. КА по времени с таблицей состояний (мигалки) *********** //

// Принудительное изменение шага: и сразу исполняет его команду.
//   Если в таблице нет команды (==0) производит задержку до следующего выполнения, ничего не вызывает
//   Время исполнения текущей команды входит в интервал ожидания следующей!
//   Если таблица не задана или next<0 - ничего не выполняет (отключение автомата)
void kaTimeGo( KaTimeControl *_ka, uint8_t _toStep )
{
  if( _ka->table )                                               // есть таблица программы КА
  {
    int8_t res = 1;                                              // нет команды - значит "всё ок".

    _ka->started_at = kaMillis();                                // время ожидания: начало тут
    KaTimeStep * ptrStep = _ka->table + _toStep;                 // идем к строке
    _ka->timeout = ptrStep->timeout;                             // ждать будем столько

    if( ptrStep->command ){ res = (ptrStep->command)(_ka); }     // исполняем команду сразу тут

    _ka->nextState = (res? ptrStep->stateOk : ptrStep->stateNo); // следующий шаг
  }
}

// В loop(): исполнение шага, если прошел интервал с предыдущего (его помним)
void kaTimeRun( KaTimeControl *_ka )
{
  KaTime skippedTime = kaMillis() - _ka->started_at; // сколько уже прошло времени

  if( (_ka->nextState != KA_STATE_OFF) && (skippedTime >= _ka->timeout) )
  {
    kaTimeGo(_ka, _ka->nextState);
  }
}

// ====== 2.1 версии для размещения таблицы управления во flash ====== //

void pgmTimeGo( KaTimeControl *_ka, uint8_t _toStep )
{
  if( _ka->table )
  {
    _ka->started_at = kaMillis();   // время ожидания пошло
    {
      int8_t          res=1;
      KaTimeStep    * ptrStep = _ka->table + _toStep;  // flash-адрес!
      KaTimeCommand   command = ptrKaTimeCommand(pgm_read_word_near( &(ptrStep->command) ));

      _ka->timeout = pgm_read_word_near( &(ptrStep->timeout) );
      if( command ){ res=(command)(_ka); }
      _ka->nextState = res?
            pgm_read_byte_near( &(ptrStep->stateOk) )
          : pgm_read_byte_near( &(ptrStep->stateNo) )
      ;
    }
  }
}

void pgmTimeRun( KaTimeControl *_ka )
{
  KaTime skippedTime = kaMillis() - _ka->started_at; // сколько уже прошло времени

  if( (_ka->nextState != KA_STATE_OFF) && (skippedTime >= _ka->timeout) )
  {
    pgmTimeGo(_ka, _ka->nextState);
  }
}

// ************ 3. КА с входным потоком событий ************ //

// принудительный перевод в состояние. Ничего не исполняет и сбрасывает событие!
void kaGo(KaControl *_ka, int8_t _toState)
{
  _ka->state = _toState;
  _ka->event = 0;
}

// для loop(): опрашивает слушателя потока и если событие произошло, то запускает исполнителя
void kaRun( KaControl *_ka )
{
  if( _ka->state != KA_STATE_OFF )                              // включен?
  {
    int8_t res = 0;                                             // по умолчанию "нет события"

    if( _ka->listener ){ res = (_ka->listener)(_ka); }          // слушатель
    if( res || _ka->event )                                     // результат или событие
    {
      int8_t newState;

      if( _ka->command ){
        newState = (_ka->command)(_ka);                         // новое состояние
        if( newState != KA_STATE_NO ){ _ka->state = newState; } // сохраняем, если новое или выключить
      }
      _ka->event = 0;                                           // обработано
    }
  }
}

// ************ 4. КА Милли с таблицей состояний и входным потоком событий ************ //

// для setup(): установка таблицы состояний и переход к заданному. Ничего не исполняет!
void kaMilliSetup(KaMilliControl *_ka, KaMilliRow *_table, bool isProgmem, int8_t _startState)
{
  _ka->table = _table;
  _ka->base.command = isProgmem ? _pgmMilliDo : _kaMilliDo;
  kaGo( &(_ka->base), _startState);
}

// Виртуализация на "С": Функция для обощенного автомата как "исполнителя Милли"
// на самом деле должна получать указатель на KaMilliControl - нужна таблица поведения автомата
int8_t _kaMilliDo( KaControl *_ka )
{
  KaMilliControl * milli = ptrKaMilliControl(_ka); // приводим явно: он и ожидается

  if( milli->table ){
    // ищем событие и пробуем запустить команду состояния
    // 1. ищем список событий текущего состояния. Он может быть "дырявым" (не все события)
    KaMilliRow  * r   = (milli->table + milli->base.state);
    KaMilliStep * e   = r->row;
    uint8_t       num = r->maxEvents;

    // 2. ищем событие в списке:
    do{
      if( e->event == milli->base.event ){       // нашли?
        int8_t res2 = 1;                         // по умолчанию выбираем stateOk

        if( e->command ){ res2=(e->command)( ptrKaControl(milli) ); }

        return res2? e->stateOk : e->stateNo;
      }
      e++;
    }while(--num);
  }
  return KA_STATE_NO;
}

// ************ 4.1 КА Милли с таблицей состояний и входным потоком во FLASH ************ //

// на самом деле принимаем KaMilliControl *! С ним и работаем далее
int8_t _pgmMilliDo( KaControl * _ka )
{
  KaMilliControl * milli = ptrKaMilliControl(_ka);

  if( milli->table )
  {
    KaMilliRow  * r  = (milli->table + milli->base.state);              // into flash!
    KaMilliStep * e  = ptrKaMilliStep(pgm_read_word_near( &(r->row) )); // into flash too!
    uint8_t      num = pgm_read_byte_near( &(r->maxEvents) );

    // 2. ищем событие в списке во flash:
    do{
      int8_t event = pgm_read_byte_near( &(e->event) );

      if( event == milli->base.event ){ // нашли?
        KaCommand command = ptrKaCommand(pgm_read_word_near( &(e->command) ));
        int8_t    stateOk = pgm_read_byte_near( &(e->stateOk) );
        int8_t    stateNo = pgm_read_byte_near( &(e->stateNo) );
        int8_t    res2    = 1; // по умолчанию stateOk

        if( command ){ res2=(command)( ptrKaControl(milli) ); }
        return res2 ? stateOk : stateNo;
      }
      e++;
    }while(--num);
  }
  return KA_STATE_NO;
}

// *********************************** 5 КА Мура *********************************** //

// переключатель сотояний по заданному событию в ->base.event
int8_t kaMuraGo(KaControl *_ka)
{
  KaMuraControl * mura = ptrKaMuraControl(_ka);

  if( mura->events ) // есть таблица состояний
  {
    mura->base.state = *(mura->events + mura->base.event);
    mura->isTicks = KA_MURA_FIRST;
    return 1; // состояние изменено!
  }
  return 0; // а не на что менять - нет таблицы
}

// PRIVATE! внутренний исполнитель..
void _muraDo(KaMuraControl *_mura, int8_t _ticks, KaCommand _command)
{
  if( _mura->isTicks == KA_MURA_FIRST ){                         // первое исполнение - кешируем повторитель заново
    _mura->ticks = _ticks;
    _mura->isTicks = (_ticks? KA_MURA_COUNT : KA_MURA_ALL);      // если не задано, то "вечно"
  }
  if( _mura->isTicks==KA_MURA_ALL || (_mura->ticks--) > 0 )      // вечно или задано повторение (уменьшаем сразу)
  {
    if( _command ){ _command( &(_mura->base) ); }                // запуск команды
  }
}

// Исполнитель для базового КА. Всегда возвращает KA_STATE_NO. Вызывается из kaRun()
int8_t kaMuraDo(KaControl *_ka)
{
  KaMuraControl * mura = ptrKaMuraControl(_ka);
  KaMuraStep    * s = mura->states + mura->base.state;             // переход на шаг состояния

  _muraDo(mura, s->count, s->command);
  return KA_STATE_NO;
}

// ************ 5.1 КА Мура с таблицей состояний и входным потоком во FLASH ************ //
int8_t pgmMuraGo(KaControl *_ka)
{
  KaMuraControl * mura = ptrKaMuraControl(_ka);

  if( mura->events )
  {
    mura->base.state = pgm_read_byte_near(mura->events + mura->base.event); // in flash!
    mura->isTicks = KA_MURA_FIRST;
    return 1;
  }
  return 0;
}

int8_t pgmMuraDo(KaControl *_ka)
{
  KaMuraControl * mura = ptrKaMuraControl(_ka);
  KaMuraStep    * s = mura->states + mura->base.state;    // переход на шаг состояния во flash!

  _muraDo(mura, pgm_read_byte_near(s->count), ptrKaCommand(pgm_read_word_near( &(s->command) )));
  return KA_STATE_NO;
}
