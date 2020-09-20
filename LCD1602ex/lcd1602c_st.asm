GAS LISTING /tmp/ccfXOBLh.s 			page 1


   1               		.file	"LCD1602ex.cpp"
   2               	__SP_H__ = 0x3e
   3               	__SP_L__ = 0x3d
   4               	__SREG__ = 0x3f
   5               	__RAMPZ__ = 0x3b
   6               	__tmp_reg__ = 0
   7               	__zero_reg__ = 1
   8               		.text
   9               	.Ltext0:
  10               		.cfi_sections	.debug_frame
  11               		.section	.text.twiSpeed,"ax",@progbits
  12               	.global	twiSpeed
  13               		.type	twiSpeed, @function
  14               	twiSpeed:
  15               	.LFB102:
  16               		.file 1 "/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h"
   1:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
   2:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Работа с TWI (I2C, 2-Wire) интерфейсом через аппаратные пре�
   3:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
   4:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ! Аппаратно не бывает одновременно режима Master-RX и Slave-
   5:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ! Нет никаких "проверок", настройка глобалов - обязате
   6:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Master-Transmitter: twiMT_Ptr, twiMT_Count                  -- откуда и сколько б
   7:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Master-Receiver:    twiRX_Ptr, twiRX_Count, twiMasterReader -- куда и сколько при
   8:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Slave-Receiver:     twiRX_Ptr, twiRX_Count, twiSlaveReader  -- куда и сколько при
   9:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Slave-Transmitter:  twiST_Ptr, twiST_Count, twiSlaveWriter  -- откуда и сколько о
  10:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
  11:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Особенности и отличия от типовых разработок (собран�
  12:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 1. Возможность одновременной работы как в режиме Master 
  13:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 2. Внешняя буферизация данных при необходимости. Раз�
  14:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 3. Возможность ведения статистики - управляется конс�
  15:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 4. Произвольная настройка скорости работы интерфейс�
  16:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 5. Возможность уменьшенной комплиции только режима Ma
  17:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
  18:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Константы компиляции #define и default_value:
  19:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * #define TWI_LOG_ON   1 // если не определено, то не компилироват
  20:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * #define TWI_SLAVE_ON 1 // если не определено, то не компилироват
  21:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
  22:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @author Arhat109-20160402. arhat109@mail.ru
  23:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @license:
  24:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *   1. This is a free software for any using and distributing without any warranties.
  25:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *   2. You should keep author tag with any changes. May be with adding.
  26:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *   Это свободное ПО для любого использования без каки�
  27:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *   Требуется сохранять тег @author при любых изменениях. �
  28:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
  29:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #ifndef ARHAT_TWI_H
  30:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define ARHAT_TWI_H 1
  31:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  32:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** //#include "arhat.h"
  33:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Compiler mode ONLY! Use as digits into #define TWI_ON before include this file ONLY!
  34:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // @TODO: to move into arhat.h
  35:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MASTER_TX    1
  36:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MASTER_RX    2
  37:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_IS_SLAVE_RX  4
  38:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_IS_SLAVE_TX  8
  39:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_LOG_ON      16
  40:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  41:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ------------ All states TWI status register AND twiState: ------------- //
GAS LISTING /tmp/ccfXOBLh.s 			page 2


  42:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Misc
  43:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ERROR                  0x00 // Misc: illegal start or stop condition
  44:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_NO_INFO                0xF8 // Misc: no state information available
  45:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  46:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // I am Master
  47:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_START                  0x08 // start condition transmitted
  48:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_REP_START              0x10 // repeated start condition transmitted
  49:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MTR_ARB_LOST           0x38 // arbitration lost in SLA+W or data
  50:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  51:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Master Transmitter
  52:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MT_SLA_ACK             0x18 // address: SLA+W transmitted, ACK received
  53:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MT_SLA_NACK            0x20 // address: SLA+W transmitted, NACK received
  54:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MT_DATA_ACK            0x28 // data: transmitted, ACK received
  55:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MT_DATA_NACK           0x30 // data: transmitted, NACK received
  56:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  57:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Master Receiver
  58:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MR_SLA_ACK             0x40 // address: SLA+R transmitted, ACK received
  59:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MR_SLA_NACK            0x48 // address: SLA+R transmitted, NACK received
  60:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MR_DATA_ACK            0x50 // data: received, ACK returned
  61:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MR_DATA_NACK           0x58 // data: received, NACK returned
  62:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  63:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // I am Slave
  64:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Slave Receiver
  65:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_SLA_ACK             0x60 // address: SLA+W received, ACK returned
  66:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_ARB_LOST_SLA_ACK    0x68 // arbitration lost in SLA+RW, SLA+W received, ACK returned
  67:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_GCALL_ACK           0x70 // general call received, ACK returned
  68:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_ARB_LOST_GCALL_ACK  0x78 // arbitration lost in SLA+RW, general call received, ACK r
  69:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_DATA_ACK            0x80 // data: received, ACK returned
  70:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_DATA_NACK           0x88 // data: received, NACK returned
  71:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_GCALL_DATA_ACK      0x90 // general call data received, ACK returned
  72:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_GCALL_DATA_NACK     0x98 // general call data received, NACK returned
  73:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_STOP                0xA0 // stop or repeated start condition received while selected
  74:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  75:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Slave Transmitter
  76:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_SLA_ACK             0xA8 // address: SLA+R received, ACK returned
  77:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_ARB_LOST_SLA_ACK    0xB0 // arbitration lost in SLA+RW, SLA+R received, ACK returned
  78:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_DATA_ACK            0xB8 // data: transmitted, ACK received
  79:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_DATA_NACK           0xC0 // data: transmitted, NACK received
  80:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_LAST_DATA           0xC8 // last data byte transmitted, ACK received
  81:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  82:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ------------ Macros for TWI ------------- //
  83:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  84:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_STATUS_MASK (_BV(TWS7)|_BV(TWS6)|_BV(TWS5)|_BV(TWS4)|_BV(TWS3)) // Two LSB are prescale
  85:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_STATUS      (TWSR & TWI_STATUS_MASK)                            // Get status from TWSR
  86:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  87:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_READ    1                   // for SLA+R address
  88:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_WRITE   0                   // SLA+W address
  89:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ACK     1
  90:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_NACK    0
  91:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  92:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiOn()       (PRR0 &= ~_BV(7)) // =0: TWI power is On (default on power!)
  93:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiOff()      (PRR0 |= _BV(7))  // =1: TWI power is Off
  94:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  95:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
  96:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Set twi bit rate and prescaler: _twbr:[0..255], _twsr:[0..3]
  97:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ------------------------------------------------------------
  98:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * _twsr = 3: scl freq. = [   490 .. 111_111] hz
GAS LISTING /tmp/ccfXOBLh.s 			page 3


  99:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * _twsr = 2: scl freq. = [ 1_960 .. 333_333] hz
 100:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * _twsr = 1: scl freq. = [ 7_782 .. 666_667] hz
 101:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * _twsr = 0: scl freq. = [30_418 .. 888_889] hz
 102:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * IF _twbr = 0: frequency equal 1 Mhz with any _twsr!
 103:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 104:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @example twiSetRate(72,0) : use 100_000hz standart mode
 105:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @example twiSetRate(12,0) : use 400_000hz standart mode
 106:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @example twiSetRate(0,0)  : use 1 Mhz mode
 107:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 108:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiSetRate(_twbr, _twsr)      \
 109:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {                                     \
 110:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   _SFR_BYTE(TWSR) = (uint8_t)(_twsr); \
 111:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   TWBR = (uint8_t)(_twbr);            \
 112:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 113:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 114:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Макросы управления автоматом TWI: последняя команда в
 115:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 116:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @param bool ack -- есть ли режимы Slave, надо ли слушать шину?
 117:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 118:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * twiStart()      -- включаем, разрешаем, сброс прерывание(зап�
 119:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * twiReply()      -- оно же, только без старта
 120:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * twiReleaseBus() -- включаем, сброс прерывание(запуск КА), а во
 121:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * twiStop()       -- оно же, только ещё и отправляем "стоп" в шин
 122:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 123:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiStart(ack)                   (_BV(TWEN)|_BV(TWINT)|_BV(TWIE)|_BV(TWSTA)|((ack)?_BV(TWEA)
 124:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiReply(ack)                   (_BV(TWEN)|_BV(TWINT)|_BV(TWIE)|((ack)? _BV(TWEA):0))
 125:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiReleaseBus(ack)              (_BV(TWEN)|_BV(TWINT)|((ack)? _BV(TWEA)|_BV(TWIE):0))
 126:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiSetAddress(address, isGcall) (TWAR  = (uint8_t)(((address) << 1)|((isGcall)&0x01)))
 127:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiSetMaskAddress(mask)         (TWAMR = (uint8_t)(mask))
 128:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiStop(ack)                    \
 129:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {                                       \
 130:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   TWCR = _BV(TWSTO)|twiReleaseBus(ack); \
 131:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   while(TWCR & _BV(TWSTO));             \
 132:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   twiMode |= TWI_READY;                 \
 133:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 134:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 135:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #ifdef __cplusplus
 136:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     extern "C" {
 137:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif
 138:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ------------ TWI internal variables ------------- //
 139:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 140:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** enum TWI_Modes {
 141:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****      TWI_IS_SLAVE  = 1                                  // have I slave mode too?
 142:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     ,TWI_SEND_STOP = 2                                  // is need send stop when Master is ending?
 143:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     ,TWI_READY     = 4                                  // previous work is ended
 144:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** };
 145:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 146:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t    twiMode;
 147:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t    twiState;                           // state TWI automat
 148:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t    twiSLARW;                           // address for send to (SLARW)
 149:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 150:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t   twiMT_Count;                         // остаток байт для пере�
 151:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t  * twiMT_Ptr;                          // указатель текущего ба
 152:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 153:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t   twiRX_Count;                         // остаток байт для прие�
 154:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t  * twiRX_Ptr;                          // указатель текущего ба
 155:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
GAS LISTING /tmp/ccfXOBLh.s 			page 4


 156:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t   twiST_Count;                         // остаток байт для пере�
 157:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t  * twiST_Ptr;                          // указатель текущего ба
 158:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 159:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile void    (* twiHookRestart)(void) = 0;          // указатель на функцию �
 160:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile void    (* twiMasterReader)(void) = 0;         // указатель на функцию "
 161:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile void    (* twiSlaveReader)(void) = 0;          // указатель на функцию "
 162:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile void    (* twiSlaveWriter)(void) = 0;          // указатель на функцию "
 163:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 164:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #ifdef TWI_LOG_ON
 165:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 166:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** typedef struct {
 167:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint16_t   starts,restarts,stops,losts,noslarw,mtx,mrx,srx,grx,stx;
 168:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** } TWI_Stat;
 169:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define ptrTWI_Stat(ptr)  ((TWI_Stat *)(ptr))
 170:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** static volatile TWI_Stat    twiStatistic;
 171:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 172:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_LOG_ON
 173:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 174:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ------------ TWI functions ------------- //
 175:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 176:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 177:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Autocalculate and set twi prescaler and bit rate
 178:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 1Mhz      .. 30.418khz : TWSR=0!
 179:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 30.42khz  ..  7.782khz : TWSR=1
 180:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *  7.782khz ..  1.960khz : TWSR=2
 181:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *  1/960khz ..  0.490khz : TWSR=3
 182:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 183:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiSpeed(uint32_t freq)
 184:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
  17               		.loc 1 184 0
  18               		.cfi_startproc
  19               	.LVL0:
  20               	/* prologue: function */
  21               	/* frame size = 0 */
  22               	/* stack size = 0 */
  23               	.L__stack_usage = 0
  24 0000 9B01      		movw r18,r22
  25 0002 AC01      		movw r20,r24
  26               	.LBB2:
 185:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint16_t bitRate = (F_CPU / freq) - 16;
  27               		.loc 1 185 0
  28 0004 60E0      		ldi r22,0
  29 0006 74E2      		ldi r23,lo8(36)
  30 0008 84EF      		ldi r24,lo8(-12)
  31 000a 90E0      		ldi r25,0
  32               	.LVL1:
  33 000c 0E94 0000 		call __udivmodsi4
  34               	.LVL2:
  35 0010 2051      		subi r18,16
  36 0012 3109      		sbc r19,__zero_reg__
  37               	.LVL3:
 186:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t  bitMul  = 0;
  38               		.loc 1 186 0
  39 0014 80E0      		ldi r24,0
  40               	.LVL4:
  41               	.L2:
 187:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
GAS LISTING /tmp/ccfXOBLh.s 			page 5


 188:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     while( (bitRate > 511) && (bitMul < 3) ){
  42               		.loc 1 188 0 discriminator 1
  43 0016 2115      		cp r18,__zero_reg__
  44 0018 92E0      		ldi r25,2
  45 001a 3907      		cpc r19,r25
  46 001c 00F0      		brlo .L3
  47               		.loc 1 188 0 is_stmt 0 discriminator 2
  48 001e 8330      		cpi r24,lo8(3)
  49 0020 01F0      		breq .L3
 189:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         bitRate /= 4; bitRate += 1; bitMul++;
  50               		.loc 1 189 0 is_stmt 1
  51 0022 3695      		lsr r19
  52 0024 2795      		ror r18
  53 0026 3695      		lsr r19
  54 0028 2795      		ror r18
  55               	.LVL5:
  56 002a 2F5F      		subi r18,-1
  57 002c 3F4F      		sbci r19,-1
  58               	.LVL6:
  59 002e 8F5F      		subi r24,lo8(-(1))
  60               	.LVL7:
  61 0030 00C0      		rjmp .L2
  62               	.L3:
 190:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }
 191:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     bitRate /= 2;
  63               		.loc 1 191 0
  64 0032 3695      		lsr r19
  65 0034 2795      		ror r18
  66               	.LVL8:
 192:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if( bitRate > 255 ) return;
  67               		.loc 1 192 0
  68 0036 2F3F      		cpi r18,-1
  69 0038 3105      		cpc r19,__zero_reg__
  70 003a 01F0      		breq .+2
  71 003c 00F4      		brsh .L1
 193:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSetRate(bitRate, bitMul);
  72               		.loc 1 193 0
  73 003e 8093 B900 		sts 185,r24
  74 0042 2093 B800 		sts 184,r18
  75               	.L1:
  76 0046 0895      		ret
  77               	.LBE2:
  78               		.cfi_endproc
  79               	.LFE102:
  80               		.size	twiSpeed, .-twiSpeed
  81               		.section	.text.twiSetup,"ax",@progbits
  82               	.global	twiSetup
  83               		.type	twiSetup, @function
  84               	twiSetup:
  85               	.LFB103:
 194:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 195:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 196:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 197:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * for Arduino setup() as Master or Slave or Both modes
 198:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * freq:[490 .. 1 000 000], mode:[0,TWI_IS_SLAVE]
 199:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 200:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiSetup(uint32_t freq, uint8_t mode)
GAS LISTING /tmp/ccfXOBLh.s 			page 6


 201:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
  86               		.loc 1 201 0
  87               		.cfi_startproc
  88               	.LVL9:
  89 0000 CF93      		push r28
  90               	.LCFI0:
  91               		.cfi_def_cfa_offset 4
  92               		.cfi_offset 28, -3
  93 0002 DF93      		push r29
  94               	.LCFI1:
  95               		.cfi_def_cfa_offset 5
  96               		.cfi_offset 29, -4
  97 0004 1F92      		push __zero_reg__
  98               	.LCFI2:
  99               		.cfi_def_cfa_offset 6
 100 0006 CDB7      		in r28,__SP_L__
 101 0008 DEB7      		in r29,__SP_H__
 102               	.LCFI3:
 103               		.cfi_def_cfa_register 28
 104               	/* prologue: function */
 105               	/* frame size = 1 */
 106               	/* stack size = 3 */
 107               	.L__stack_usage = 3
 202:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     digitalWrite(I2C_SDA, HIGH);                                  // internal pullup is ON.
 108               		.loc 1 202 0
 109 000a 599A      		sbi 0xb,1
 203:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     digitalWrite(I2C_SCL, HIGH);
 110               		.loc 1 203 0
 111 000c 589A      		sbi 0xb,0
 204:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSpeed(freq);                                               // set bitrate and prescaler for 
 112               		.loc 1 204 0
 113 000e 4983      		std Y+1,r20
 114 0010 0E94 0000 		call twiSpeed
 115               	.LVL10:
 205:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode = mode;
 116               		.loc 1 205 0
 117 0014 4981      		ldd r20,Y+1
 118 0016 4093 0000 		sts twiMode,r20
 206:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = _BV(TWEN)|_BV(TWIE)|((mode&TWI_IS_SLAVE)?_BV(TWEA):0); // module, acks, and interrupt is
 119               		.loc 1 206 0
 120 001a 40FF      		sbrs r20,0
 121 001c 00C0      		rjmp .L9
 122 001e 85E4      		ldi r24,lo8(69)
 123 0020 00C0      		rjmp .L8
 124               	.L9:
 125 0022 85E0      		ldi r24,lo8(5)
 126               	.L8:
 127               		.loc 1 206 0 is_stmt 0 discriminator 3
 128 0024 8093 BC00 		sts 188,r24
 129               	/* epilogue start */
 207:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 130               		.loc 1 207 0 is_stmt 1 discriminator 3
 131 0028 0F90      		pop __tmp_reg__
 132 002a DF91      		pop r29
 133 002c CF91      		pop r28
 134 002e 0895      		ret
 135               		.cfi_endproc
GAS LISTING /tmp/ccfXOBLh.s 			page 7


 136               	.LFE103:
 137               		.size	twiSetup, .-twiSetup
 138               		.section	.text.twiSendStop,"ax",@progbits
 139               	.global	twiSendStop
 140               		.type	twiSendStop, @function
 141               	twiSendStop:
 142               	.LFB104:
 208:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 209:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 210:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * for ISR(TWI): control restart conditions in all modes:
 211:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 212:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 1. Освобождать шину, или надо ещё (напр. прием после пе
 213:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * да: Сеанс завершен. Ждем прямо тут прохождения стопа!
 214:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * нет, рестарт:
 215:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * .. есть Хук? процедура подготовки след. посылки: указа
 216:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * .. а нет Хука! Типовой режим "чтение после записи"
 217:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * в любом случае отправляем restart
 218:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 219:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @return command for TWCR
 220:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *//*
 221:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiSendStop(_md, _cr)                                \
 222:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {                                                            \
 223:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if (_md & TWI_SEND_STOP)                                 \
 224:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     {                                                        \
 225:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         TWCR = _BV(TWSTO)|twiReleaseBus(_md & TWI_IS_SLAVE); \
 226:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         while(TWCR & _BV(TWSTO));                            \
 227:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         twiMode |= TWI_READY;                                \
 228:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         return;                                              \
 229:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }else{                                                   \
 230:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( twiHookRestart ){                                \
 231:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiHookRestart();                                \
 232:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         } else {                                             \
 233:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSLARW |= TWI_READ;                            \
 234:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }                                                    \
 235:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         _cr = twiStart(_md & TWI_IS_SLAVE);                  \
 236:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }                                                        \
 237:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 238:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** */
 239:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiSendStop(uint8_t _md)
 240:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 143               		.loc 1 240 0
 144               		.cfi_startproc
 145               	.LVL11:
 146 0000 CF93      		push r28
 147               	.LCFI4:
 148               		.cfi_def_cfa_offset 4
 149               		.cfi_offset 28, -3
 150               	/* prologue: function */
 151               	/* frame size = 0 */
 152               	/* stack size = 1 */
 153               	.L__stack_usage = 1
 154 0002 C82F      		mov r28,r24
 155 0004 C170      		andi r28,lo8(1)
 241:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if (_md & TWI_SEND_STOP)
 156               		.loc 1 241 0
 157 0006 81FF      		sbrs r24,1
 158 0008 00C0      		rjmp .L11
GAS LISTING /tmp/ccfXOBLh.s 			page 8


 242:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     {
 243:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         TWCR = _BV(TWSTO)|twiReleaseBus(_md & TWI_IS_SLAVE);
 159               		.loc 1 243 0
 160 000a CC23      		tst r28
 161 000c 01F0      		breq .L19
 162 000e 85ED      		ldi r24,lo8(-43)
 163               	.LVL12:
 164 0010 00C0      		rjmp .L12
 165               	.LVL13:
 166               	.L19:
 167 0012 84E9      		ldi r24,lo8(-108)
 168               	.LVL14:
 169               	.L12:
 170               		.loc 1 243 0 is_stmt 0 discriminator 3
 171 0014 8093 BC00 		sts 188,r24
 172               	.L14:
 244:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         while(TWCR & _BV(TWSTO));
 173               		.loc 1 244 0 is_stmt 1 discriminator 1
 174 0018 8091 BC00 		lds r24,188
 175 001c 84FD      		sbrc r24,4
 176 001e 00C0      		rjmp .L14
 245:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         twiMode |= TWI_READY;
 177               		.loc 1 245 0
 178 0020 8091 0000 		lds r24,twiMode
 179 0024 8460      		ori r24,lo8(4)
 180 0026 8093 0000 		sts twiMode,r24
 181 002a 00C0      		rjmp .L10
 182               	.LVL15:
 183               	.L11:
 246:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }else{
 247:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( twiHookRestart ){
 184               		.loc 1 247 0
 185 002c E091 0000 		lds r30,twiHookRestart
 186 0030 F091 0000 		lds r31,twiHookRestart+1
 187 0034 3097      		sbiw r30,0
 188 0036 01F0      		breq .L16
 248:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiHookRestart();
 189               		.loc 1 248 0
 190 0038 1995      		eicall
 191               	.LVL16:
 192 003a 00C0      		rjmp .L17
 193               	.LVL17:
 194               	.L16:
 249:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         } else {
 250:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSLARW |= TWI_READ;
 195               		.loc 1 250 0
 196 003c 8091 0000 		lds r24,twiSLARW
 197               	.LVL18:
 198 0040 8160      		ori r24,lo8(1)
 199 0042 8093 0000 		sts twiSLARW,r24
 200               	.L17:
 251:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 252:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         TWCR = twiStart(_md & TWI_IS_SLAVE);
 201               		.loc 1 252 0
 202 0046 CC23      		tst r28
 203 0048 01F0      		breq .L20
 204 004a 85EE      		ldi r24,lo8(-27)
GAS LISTING /tmp/ccfXOBLh.s 			page 9


 205 004c 00C0      		rjmp .L18
 206               	.L20:
 207 004e 85EA      		ldi r24,lo8(-91)
 208               	.L18:
 209               		.loc 1 252 0 is_stmt 0 discriminator 3
 210 0050 8093 BC00 		sts 188,r24
 211               	.L10:
 212               	/* epilogue start */
 253:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }
 254:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 213               		.loc 1 254 0 is_stmt 1
 214 0054 CF91      		pop r28
 215 0056 0895      		ret
 216               		.cfi_endproc
 217               	.LFE104:
 218               		.size	twiSendStop, .-twiSendStop
 219               		.section	.text.__vector_39,"ax",@progbits
 220               	.global	__vector_39
 221               		.type	__vector_39, @function
 222               	__vector_39:
 223               	.LFB105:
 255:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 256:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 257:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ISR for TWI interface: realised master and slave modes
 258:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ------------------------------------------------------
 259:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 260:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** ISR(TWI_vect)
 261:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 224               		.loc 1 261 0
 225               		.cfi_startproc
 226 0000 1F92      		push r1
 227               	.LCFI5:
 228               		.cfi_def_cfa_offset 4
 229               		.cfi_offset 1, -3
 230 0002 0F92      		push r0
 231               	.LCFI6:
 232               		.cfi_def_cfa_offset 5
 233               		.cfi_offset 0, -4
 234 0004 0FB6      		in r0,__SREG__
 235 0006 0F92      		push r0
 236 0008 1124      		clr __zero_reg__
 237 000a 0BB6      		in r0,__RAMPZ__
 238 000c 0F92      		push r0
 239 000e 2F93      		push r18
 240               	.LCFI7:
 241               		.cfi_def_cfa_offset 6
 242               		.cfi_offset 18, -5
 243 0010 3F93      		push r19
 244               	.LCFI8:
 245               		.cfi_def_cfa_offset 7
 246               		.cfi_offset 19, -6
 247 0012 4F93      		push r20
 248               	.LCFI9:
 249               		.cfi_def_cfa_offset 8
 250               		.cfi_offset 20, -7
 251 0014 5F93      		push r21
 252               	.LCFI10:
GAS LISTING /tmp/ccfXOBLh.s 			page 10


 253               		.cfi_def_cfa_offset 9
 254               		.cfi_offset 21, -8
 255 0016 6F93      		push r22
 256               	.LCFI11:
 257               		.cfi_def_cfa_offset 10
 258               		.cfi_offset 22, -9
 259 0018 7F93      		push r23
 260               	.LCFI12:
 261               		.cfi_def_cfa_offset 11
 262               		.cfi_offset 23, -10
 263 001a 8F93      		push r24
 264               	.LCFI13:
 265               		.cfi_def_cfa_offset 12
 266               		.cfi_offset 24, -11
 267 001c 9F93      		push r25
 268               	.LCFI14:
 269               		.cfi_def_cfa_offset 13
 270               		.cfi_offset 25, -12
 271 001e AF93      		push r26
 272               	.LCFI15:
 273               		.cfi_def_cfa_offset 14
 274               		.cfi_offset 26, -13
 275 0020 BF93      		push r27
 276               	.LCFI16:
 277               		.cfi_def_cfa_offset 15
 278               		.cfi_offset 27, -14
 279 0022 EF93      		push r30
 280               	.LCFI17:
 281               		.cfi_def_cfa_offset 16
 282               		.cfi_offset 30, -15
 283 0024 FF93      		push r31
 284               	.LCFI18:
 285               		.cfi_def_cfa_offset 17
 286               		.cfi_offset 31, -16
 287               	/* prologue: Signal */
 288               	/* frame size = 0 */
 289               	/* stack size = 16 */
 290               	.L__stack_usage = 16
 291               	.LBB3:
 262:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _cr;
 263:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _md = twiMode;
 292               		.loc 1 263 0
 293 0026 3091 0000 		lds r19,twiMode
 294               	.LVL19:
 264:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _st = twiState=TWI_STATUS;
 295               		.loc 1 264 0
 296 002a 8091 B900 		lds r24,185
 297 002e 982F      		mov r25,r24
 298 0030 987F      		andi r25,lo8(-8)
 299 0032 9093 0000 		sts twiState,r25
 300               	.LVL20:
 265:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 266:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
 267:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if( _st >= TWI_SR_SLA_ACK )
 301               		.loc 1 267 0
 302 0036 9036      		cpi r25,lo8(96)
 303 0038 00F0      		brlo .L22
GAS LISTING /tmp/ccfXOBLh.s 			page 11


 268:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     {
 269:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if (TWI_ON & TWI_IS_SLAVE_TX)
 270:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( (_st == TWI_ST_DATA_NACK) || (_st == TWI_ST_LAST_DATA) )
 304               		.loc 1 270 0
 305 003a 482F      		mov r20,r24
 306 003c 407F      		andi r20,lo8(-16)
 307 003e 403C      		cpi r20,lo8(-64)
 308 0040 01F4      		brne .L23
 271:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         {
 272:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // ST: Был последний байт, мастер наелся ..
 273:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // ST: Был наш последний байт: предупреждали масте
 274:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSlaveWriter();                                   // Хук - обязателен!
 309               		.loc 1 274 0
 310 0042 E091 0000 		lds r30,twiSlaveWriter
 311 0046 F091 0000 		lds r31,twiSlaveWriter+1
 312 004a 1995      		eicall
 313               	.LVL21:
 275:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             _md=twiMode;                                        // возможно изменен�
 314               		.loc 1 275 0
 315 004c 8091 0000 		lds r24,twiMode
 316               	.LVL22:
 276:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSendStop(_md); return;
 317               		.loc 1 276 0
 318 0050 0E94 0000 		call twiSendStop
 319               	.LVL23:
 320 0054 00C0      		rjmp .L21
 321               	.LVL24:
 322               	.L23:
 277:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 278:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_ST_ARB_LOST_SLA_ACK) || (_st == TWI_ST_SLA_ACK || _st == TWI_ST_DATA_AC
 323               		.loc 1 278 0
 324 0056 903B      		cpi r25,lo8(-80)
 325 0058 01F0      		breq .L25
 326               		.loc 1 278 0 is_stmt 0 discriminator 1
 327 005a 887E      		andi r24,lo8(-24)
 328 005c 883A      		cpi r24,lo8(-88)
 329 005e 01F4      		brne .L22
 330               	.L25:
 279:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 280:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // ST: Моего мастера заткнули и просят данные ..
 281:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // ST: Мой адрес, начинаем ..
 282:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // ST: Отправлено успешно, продолжаем ..
 283:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 TWDR = *twiST_Ptr++;
 331               		.loc 1 283 0 is_stmt 1
 332 0060 E091 0000 		lds r30,twiST_Ptr
 333 0064 F091 0000 		lds r31,twiST_Ptr+1
 334 0068 CF01      		movw r24,r30
 335 006a 0196      		adiw r24,1
 336 006c 9093 0000 		sts twiST_Ptr+1,r25
 337 0070 8093 0000 		sts twiST_Ptr,r24
 338 0074 8081      		ld r24,Z
 339 0076 8093 BB00 		sts 187,r24
 284:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 _cr = twiReply(--twiST_Count);
 340               		.loc 1 284 0
 341 007a 8091 0000 		lds r24,twiST_Count
 342 007e 8150      		subi r24,lo8(-(-1))
 343 0080 8093 0000 		sts twiST_Count,r24
GAS LISTING /tmp/ccfXOBLh.s 			page 12


 344 0084 8823      		tst r24
 345 0086 01F0      		breq .L26
 346 0088 25EC      		ldi r18,lo8(-59)
 347 008a 00C0      		rjmp .L22
 348               	.L26:
 349 008c 25E8      		ldi r18,lo8(-123)
 350               	.L22:
 351               	.LVL25:
 285:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }else{
 286:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_IS_SLAVE_TX
 287:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if (TWI_ON & TWI_IS_SLAVE_RX)
 288:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( (_st == TWI_SR_GCALL_DATA_NACK) || (_st == TWI_SR_DATA_NACK) || (_st == TWI_SR_
 289:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 {
 290:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_SR_GCALL_DATA_NACK) || (_st == TWI_SR_DATA_NACK) )
 291:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 292:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: УПС. GCall - туда же.
 293:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: УПС. Получен байт, мастеру уже был отп
 294:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         *twiRX_Ptr = TWDR;
 295:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 296:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // SR: Обнаружен stop или restart в процессе приема 
 297:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSlaveReader();                           // Хук обязателен! э�
 298:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _md=twiMode;                                // возможно изменен�
 299:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSendStop(_md); return;
 300:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 301:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_SR_GCALL_DATA_ACK) || (_st == TWI_SR_DATA_ACK) )
 302:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 303:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: пришел байт всем - аналогично
 304:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: пришел байт, можно ещё принять
 305:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         *(twiRX_Ptr++) = TWDR;
 306:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 307:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_ARB_LOST_SLA_ACK   SR: Мастер потерял шину: нет �
 308:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_ARB_LOST_GCALL_ACK SR: Вызов всем потерял шину (�
 309:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_SLA_ACK            SR: Адрес принят, ещё только �
 310:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_GCALL_ACK          SR: Вызов всем принят оно же
 311:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReply(--twiRX_Count);              // .. приняли байт и о
 312:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }
 313:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_IS_SLAVE_RX
 314:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if (TWI_ON & TWI_IS_SLAVE_TX)
 315:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 316:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 317:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_IS_SLAVE_TX
 318:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }else{
 319:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 320:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_SLAVE..
 321:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON & TWI_MASTER_TX)
 322:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         // Master Transmiter or Reciever modes
 323:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( (_st == TWI_START) || (_st == TWI_REP_START) )
 324:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         {
 325:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка стартовой посылки
 326:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка повторного старта
 327:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             TWDR = twiSLARW;
 328:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             _cr = twiReply(_md & TWI_IS_SLAVE);
 329:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 330:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_NACK) || (_st == TWI_MT_DATA_NACK) )
 331:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 332:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_DATA_NACK MT:: Упс. data NACK: Получатель не хотит?
 333:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_SLA_NACK  MT:: Упс. Получатель NACK .. не откликае
GAS LISTING /tmp/ccfXOBLh.s 			page 13


 334:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 twiSendStop(_md); return;
 335:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 336:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_ACK)  || (_st == TWI_MT_DATA_ACK) )
 337:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 338:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Адрес получателя отправлен успешно, начи�
 339:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Байт данных отправлен, продолжаем
 340:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( twiMT_Count-- ){
 341:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     TWDR = *twiMT_Ptr++;
 342:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReply(_md & TWI_IS_SLAVE);
 343:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 344:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSendStop(_md); return;
 345:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }
 346:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }else{
 347:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_TX
 348:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON & TWI_MASTER_RX)
 349:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( _st == TWI_MTR_ARB_LOST )
 350:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 {
 351:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // MT,MR: Упс. Мастер потерял шину: освобождаем 
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _md |= TWI_READY;
 353:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 354:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 355:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_MR_DATA_ACK) || (_st == TWI_MR_SLA_ACK) )
 356:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 357:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_ACK ){
 358:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: байт принят, ACK отправлен
 359:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *(twiRX_Ptr++) = TWDR;
 360:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 361:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // MR: Отправитель найден, начинаем прием
 362:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         _cr = twiReply( --twiRX_Count );        // .. Можно ещё приня�
 363:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }else{
 364:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_ERROR ) return;
 365:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_NACK )
 366:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         {
 367:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: Упс. Получен последний байт дальше 
 368:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *twiRX_Ptr = TWDR;
 369:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             if( twiMasterReader ) twiMasterReader();
 370:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** //                            goto TWI_RET_HOOK;
 371:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             _md=twiMode;                        // возможно изменен�
 372:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 373:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // All other Master states: stop/restart if need
 374:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // TWI_MR_SLA_NACK  MR:: Упс. Отправитель NACK .. не отк
 375:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         twiSendStop(_md); return;
 376:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 377:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }
 378:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_RX
 379:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON&TWI_MASTER_TX)
 380:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 381:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 382:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_TX
 383:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
 384:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }
 385:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_SLAVE_ON
 386:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode = _md;
 352               		.loc 1 386 0
 353 008e 3093 0000 		sts twiMode,r19
 387:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = _cr;
 354               		.loc 1 387 0
GAS LISTING /tmp/ccfXOBLh.s 			page 14


 355 0092 2093 BC00 		sts 188,r18
 356               	.LVL26:
 357               	.L21:
 358               	/* epilogue start */
 359               	.LBE3:
 388:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** } //end ISR()
 360               		.loc 1 388 0
 361 0096 FF91      		pop r31
 362 0098 EF91      		pop r30
 363 009a BF91      		pop r27
 364 009c AF91      		pop r26
 365 009e 9F91      		pop r25
 366 00a0 8F91      		pop r24
 367 00a2 7F91      		pop r23
 368 00a4 6F91      		pop r22
 369 00a6 5F91      		pop r21
 370 00a8 4F91      		pop r20
 371 00aa 3F91      		pop r19
 372 00ac 2F91      		pop r18
 373 00ae 0F90      		pop r0
 374 00b0 0BBE      		out __RAMPZ__,r0
 375 00b2 0F90      		pop r0
 376 00b4 0FBE      		out __SREG__,r0
 377 00b6 0F90      		pop r0
 378 00b8 1F90      		pop r1
 379 00ba 1895      		reti
 380               		.cfi_endproc
 381               	.LFE105:
 382               		.size	__vector_39, .-__vector_39
 383               		.section	.text._twiStartTo,"ax",@progbits
 384               	.global	_twiStartTo
 385               		.type	_twiStartTo, @function
 386               	_twiStartTo:
 387               	.LFB106:
 389:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 390:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // -------------------------              (PROTECTED)             ------------------------- //
 391:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Внутренние методы интерфейса, могут пригодится для �
 392:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ---------------------------------------------------------------------------------------- //
 393:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 394:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 395:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * INTERNAL:: Простая передача. Запись адреса собеседника и 
 396:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 397:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @see twiWrite(), twiRead()
 398:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 399:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartTo(uint8_t address)
 400:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 388               		.loc 1 400 0
 389               		.cfi_startproc
 390               	.LVL27:
 391               	/* prologue: function */
 392               	/* frame size = 0 */
 393               	/* stack size = 0 */
 394               	.L__stack_usage = 0
 401:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 395               		.loc 1 401 0
 396 0000 8093 0000 		sts twiSLARW,r24
 402:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode |= TWI_SEND_STOP;                           // только 1 бит! Могли быт
GAS LISTING /tmp/ccfXOBLh.s 			page 15


 397               		.loc 1 402 0
 398 0004 8091 0000 		lds r24,twiMode
 399               	.LVL28:
 400 0008 8260      		ori r24,lo8(2)
 401 000a 8093 0000 		sts twiMode,r24
 402               	.LVL29:
 403:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 403               		.loc 1 403 0
 404 000e 8091 0000 		lds r24,twiMode
 405 0012 80FF      		sbrs r24,0
 406 0014 00C0      		rjmp .L32
 407 0016 85EE      		ldi r24,lo8(-27)
 408 0018 00C0      		rjmp .L31
 409               	.L32:
 410 001a 85EA      		ldi r24,lo8(-91)
 411               	.L31:
 412               		.loc 1 403 0 is_stmt 0 discriminator 3
 413 001c 8093 BC00 		sts 188,r24
 414 0020 0895      		ret
 415               		.cfi_endproc
 416               	.LFE106:
 417               		.size	_twiStartTo, .-_twiStartTo
 418               		.section	.text._twiStartRe,"ax",@progbits
 419               	.global	_twiStartRe
 420               		.type	_twiStartRe, @function
 421               	_twiStartRe:
 422               	.LFB107:
 404:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 405:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 406:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 407:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * INTERNAL:: Передача с рестартом. Запись адреса собеседни�
 408:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 409:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @see twiWrite(), twiRead()
 410:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 411:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartRe(uint8_t address)
 412:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 423               		.loc 1 412 0 is_stmt 1
 424               		.cfi_startproc
 425               	.LVL30:
 426               	/* prologue: function */
 427               	/* frame size = 0 */
 428               	/* stack size = 0 */
 429               	.L__stack_usage = 0
 413:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 430               		.loc 1 413 0
 431 0000 8093 0000 		sts twiSLARW,r24
 414:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // только 1 бит! Могли быт
 432               		.loc 1 414 0
 433 0004 8091 0000 		lds r24,twiMode
 434               	.LVL31:
 435 0008 8D7F      		andi r24,lo8(-3)
 436 000a 8093 0000 		sts twiMode,r24
 437               	.LVL32:
 415:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 438               		.loc 1 415 0
 439 000e 8091 0000 		lds r24,twiMode
 440 0012 80FF      		sbrs r24,0
GAS LISTING /tmp/ccfXOBLh.s 			page 16


 441 0014 00C0      		rjmp .L35
 442 0016 85EE      		ldi r24,lo8(-27)
 443 0018 00C0      		rjmp .L34
 444               	.L35:
 445 001a 85EA      		ldi r24,lo8(-91)
 446               	.L34:
 447               		.loc 1 415 0 is_stmt 0 discriminator 3
 448 001c 8093 BC00 		sts 188,r24
 449 0020 0895      		ret
 450               		.cfi_endproc
 451               	.LFE107:
 452               		.size	_twiStartRe, .-_twiStartRe
 453               		.section	.text.twiWrite,"ax",@progbits
 454               	.global	twiWrite
 455               		.type	twiWrite, @function
 456               	twiWrite:
 457               	.LFB108:
 416:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 417:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 418:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define _twiWaitReady()             {while(!(TWI_READY & twiMode)); twiMode &= ~TWI_READY;}
 419:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define _twiMT_Buffer(data, length) (twiMT_Ptr=(volatile uint8_t *)(data), twiMT_Count=(volatile ui
 420:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define _twiRX_Buffer(data, length) (twiRX_Ptr=(volatile uint8_t *)(data), twiRX_Count=(volatile ui
 421:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define _twiST_Buffer(data, length) (twiST_Ptr=(volatile uint8_t *)(data), twiST_Count=(volatile ui
 422:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 423:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // -------------------------                PUBLIC                ------------------------- //
 424:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ---------------------------------------------------------------------------------------- //
 425:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 426:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 427:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Master-TX:: Передача length байт по адресу получателя. Тольк�
 428:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 429:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiWrite(uint8_t address, const uint8_t * data, uint8_t length)
 430:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 458               		.loc 1 430 0 is_stmt 1
 459               		.cfi_startproc
 460               	/* prologue: function */
 461               	/* frame size = 0 */
 462               	/* stack size = 0 */
 463               	.L__stack_usage = 0
 464               	.LVL33:
 465               	.L38:
 431:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 466               		.loc 1 431 0 discriminator 1
 467 0000 9091 0000 		lds r25,twiMode
 468 0004 92FF      		sbrs r25,2
 469 0006 00C0      		rjmp .L38
 470               		.loc 1 431 0 is_stmt 0 discriminator 2
 471 0008 9091 0000 		lds r25,twiMode
 472 000c 9B7F      		andi r25,lo8(-5)
 473 000e 9093 0000 		sts twiMode,r25
 432:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(data, length);
 474               		.loc 1 432 0 is_stmt 1 discriminator 2
 475 0012 7093 0000 		sts twiMT_Ptr+1,r23
 476 0016 6093 0000 		sts twiMT_Ptr,r22
 477 001a 4093 0000 		sts twiMT_Count,r20
 433:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_WRITE );            // Режим передачи!
 478               		.loc 1 433 0 discriminator 2
 479 001e 880F      		lsl r24
GAS LISTING /tmp/ccfXOBLh.s 			page 17


 480               	.LVL34:
 481 0020 0C94 0000 		jmp _twiStartTo
 482               	.LVL35:
 483               		.cfi_endproc
 484               	.LFE108:
 485               		.size	twiWrite, .-twiWrite
 486               		.section	.text.twiRead,"ax",@progbits
 487               	.global	twiRead
 488               		.type	twiRead, @function
 489               	twiRead:
 490               	.LFB109:
 434:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 435:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 436:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 437:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * MASTER-RX:: Прием length байт из адреса отправителя. Только з
 438:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 439:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRead(uint8_t address, uint8_t * data, uint8_t length)
 440:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 491               		.loc 1 440 0
 492               		.cfi_startproc
 493               	/* prologue: function */
 494               	/* frame size = 0 */
 495               	/* stack size = 0 */
 496               	.L__stack_usage = 0
 497               	.LVL36:
 498               	.L41:
 441:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 499               		.loc 1 441 0 discriminator 1
 500 0000 9091 0000 		lds r25,twiMode
 501 0004 92FF      		sbrs r25,2
 502 0006 00C0      		rjmp .L41
 503               		.loc 1 441 0 is_stmt 0 discriminator 2
 504 0008 9091 0000 		lds r25,twiMode
 505 000c 9B7F      		andi r25,lo8(-5)
 506 000e 9093 0000 		sts twiMode,r25
 442:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, length);
 507               		.loc 1 442 0 is_stmt 1 discriminator 2
 508 0012 7093 0000 		sts twiRX_Ptr+1,r23
 509 0016 6093 0000 		sts twiRX_Ptr,r22
 510 001a 4093 0000 		sts twiRX_Count,r20
 443:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_READ );             // Режим приема данных!
 511               		.loc 1 443 0 discriminator 2
 512 001e 880F      		lsl r24
 513               	.LVL37:
 514 0020 8160      		ori r24,lo8(1)
 515 0022 0C94 0000 		jmp _twiStartTo
 516               	.LVL38:
 517               		.cfi_endproc
 518               	.LFE109:
 519               		.size	twiRead, .-twiRead
 520               		.section	.text.twiRAW,"ax",@progbits
 521               	.global	twiRAW
 522               		.type	twiRAW, @function
 523               	twiRAW:
 524               	.LFB110:
 444:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 445:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
GAS LISTING /tmp/ccfXOBLh.s 			page 18


 446:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 447:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Master Read-after-Write:: Чтение данных после отправки команды. 
 448:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * !!! Не совместимо с Slave Receive Mode - буфер приема общий !!!
 449:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 450:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRAW(uint8_t address                             // адрес устройства
 451:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** , uint8_t* command, uint8_t clength                     // команда и её длина
 452:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** , uint8_t* data, uint8_t dlength                        // буфер приема данных и 
 453:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** ){
 525               		.loc 1 453 0
 526               		.cfi_startproc
 527               	.LVL39:
 528 0000 0F93      		push r16
 529               	.LCFI19:
 530               		.cfi_def_cfa_offset 4
 531               		.cfi_offset 16, -3
 532               	/* prologue: function */
 533               	/* frame size = 0 */
 534               	/* stack size = 1 */
 535               	.L__stack_usage = 1
 536               	.L44:
 454:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 537               		.loc 1 454 0 discriminator 1
 538 0002 9091 0000 		lds r25,twiMode
 539 0006 92FF      		sbrs r25,2
 540 0008 00C0      		rjmp .L44
 541               		.loc 1 454 0 is_stmt 0 discriminator 2
 542 000a 9091 0000 		lds r25,twiMode
 543 000e 9B7F      		andi r25,lo8(-5)
 544 0010 9093 0000 		sts twiMode,r25
 455:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(command, clength);
 545               		.loc 1 455 0 is_stmt 1 discriminator 2
 546 0014 7093 0000 		sts twiMT_Ptr+1,r23
 547 0018 6093 0000 		sts twiMT_Ptr,r22
 548 001c 4093 0000 		sts twiMT_Count,r20
 456:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, dlength);
 549               		.loc 1 456 0 discriminator 2
 550 0020 3093 0000 		sts twiRX_Ptr+1,r19
 551 0024 2093 0000 		sts twiRX_Ptr,r18
 552 0028 0093 0000 		sts twiRX_Count,r16
 457:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 458:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiHookRestart = 0;                                 // типовой переход на чт�
 553               		.loc 1 458 0 discriminator 2
 554 002c 1092 0000 		sts twiHookRestart+1,__zero_reg__
 555 0030 1092 0000 		sts twiHookRestart,__zero_reg__
 459:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // рестарт после отправк
 556               		.loc 1 459 0 discriminator 2
 557 0034 9091 0000 		lds r25,twiMode
 558 0038 9D7F      		andi r25,lo8(-3)
 559 003a 9093 0000 		sts twiMode,r25
 460:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = (address<<1 | TWI_WRITE);                // Сначала режим передач
 560               		.loc 1 460 0 discriminator 2
 561 003e 880F      		lsl r24
 562               	.LVL40:
 563 0040 8093 0000 		sts twiSLARW,r24
 461:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 564               		.loc 1 461 0 discriminator 2
 565 0044 8091 0000 		lds r24,twiMode
GAS LISTING /tmp/ccfXOBLh.s 			page 19


 566 0048 80FF      		sbrs r24,0
 567 004a 00C0      		rjmp .L46
 568               		.loc 1 461 0 is_stmt 0
 569 004c 85EE      		ldi r24,lo8(-27)
 570 004e 00C0      		rjmp .L45
 571               	.L46:
 572 0050 85EA      		ldi r24,lo8(-91)
 573               	.L45:
 574               		.loc 1 461 0 discriminator 3
 575 0052 8093 BC00 		sts 188,r24
 576               	/* epilogue start */
 462:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 577               		.loc 1 462 0 is_stmt 1 discriminator 3
 578 0056 0F91      		pop r16
 579               	.LVL41:
 580 0058 0895      		ret
 581               		.cfi_endproc
 582               	.LFE110:
 583               		.size	twiRAW, .-twiRAW
 584               		.section	.text.lcdPrepare,"ax",@progbits
 585               	.global	lcdPrepare
 586               		.type	lcdPrepare, @function
 587               	lcdPrepare:
 588               	.LFB111:
 589               		.file 2 "LCD1602ex.ino"
   1:LCD1602ex.ino **** 
 590               		.loc 2 490 0
 591               		.cfi_startproc
 592               	.LVL42:
 593               	/* prologue: function */
 594               	/* frame size = 0 */
 595               	/* stack size = 0 */
 596               	.L__stack_usage = 0
 597               	.LBB4:
 598               		.loc 2 491 0
 599 0000 2091 0000 		lds r18,lcdBackLight
 600 0004 982F      		mov r25,r24
 601 0006 907F      		andi r25,lo8(-16)
 602 0008 922B      		or r25,r18
 603               	.LVL43:
 604               		.loc 2 493 0
 605 000a 6111      		cpse r22,__zero_reg__
 606               		.loc 2 493 0 is_stmt 0 discriminator 1
 607 000c 9160      		ori r25,lo8(1)
 608               	.LVL44:
 609               	.L48:
 610               		.loc 2 494 0 is_stmt 1
 611 000e 9093 0000 		sts lcdBuffer,r25
 612 0012 9093 0000 		sts lcdBuffer+2,r25
 613               	.LVL45:
 614               		.loc 2 495 0
 615 0016 9460      		ori r25,lo8(4)
 616               	.LVL46:
 617               		.loc 2 496 0
 618 0018 9093 0000 		sts lcdBuffer+1,r25
 619               		.loc 2 498 0
 620 001c 30E1      		ldi r19,lo8(16)
GAS LISTING /tmp/ccfXOBLh.s 			page 20


 621 001e 839F      		mul r24,r19
 622 0020 C001      		movw r24,r0
 623 0022 1124      		clr __zero_reg__
 624               	.LVL47:
 625 0024 822B      		or r24,r18
 626               	.LVL48:
 627               		.loc 2 500 0
 628 0026 6111      		cpse r22,__zero_reg__
 629               		.loc 2 500 0 is_stmt 0 discriminator 1
 630 0028 8160      		ori r24,lo8(1)
 631               	.LVL49:
 632               	.L49:
 633               		.loc 2 501 0 is_stmt 1
 634 002a 8093 0000 		sts lcdBuffer+3,r24
 635 002e 8093 0000 		sts lcdBuffer+5,r24
 636               	.LVL50:
 637               		.loc 2 502 0
 638 0032 8460      		ori r24,lo8(4)
 639               	.LVL51:
 640               		.loc 2 503 0
 641 0034 8093 0000 		sts lcdBuffer+4,r24
 642 0038 0895      		ret
 643               	.LBE4:
 644               		.cfi_endproc
 645               	.LFE111:
 646               		.size	lcdPrepare, .-lcdPrepare
 647               		.section	.text.lcdWrite,"ax",@progbits
 648               	.global	lcdWrite
 649               		.type	lcdWrite, @function
 650               	lcdWrite:
 651               	.LFB112:
 652               		.loc 2 511 0
 653               		.cfi_startproc
 654               	.LVL52:
 655 0000 1F93      		push r17
 656               	.LCFI20:
 657               		.cfi_def_cfa_offset 4
 658               		.cfi_offset 17, -3
 659 0002 CF93      		push r28
 660               	.LCFI21:
 661               		.cfi_def_cfa_offset 5
 662               		.cfi_offset 28, -4
 663 0004 DF93      		push r29
 664               	.LCFI22:
 665               		.cfi_def_cfa_offset 6
 666               		.cfi_offset 29, -5
 667               	/* prologue: function */
 668               	/* frame size = 0 */
 669               	/* stack size = 3 */
 670               	.L__stack_usage = 3
 671 0006 162F      		mov r17,r22
 672               	.LVL53:
 673               	.LBB5:
 674               		.loc 2 515 0
 675 0008 2091 0000 		lds r18,twiMode
 676 000c 2260      		ori r18,lo8(2)
 677 000e 2093 0000 		sts twiMode,r18
GAS LISTING /tmp/ccfXOBLh.s 			page 21


 678               		.loc 2 516 0
 679 0012 C82F      		mov r28,r24
 680 0014 D92F      		mov r29,r25
 681 0016 180F      		add r17,r24
 682               	.LVL54:
 683               	.L57:
 684               		.loc 2 516 0 is_stmt 0 discriminator 1
 685 0018 1C17      		cp r17,r28
 686 001a 01F0      		breq .L59
 687               	.LVL55:
 688               		.loc 2 517 0 is_stmt 1
 689 001c 61E0      		ldi r22,lo8(1)
 690 001e 8991      		ld r24,Y+
 691               	.LVL56:
 692 0020 0E94 0000 		call lcdPrepare
 693               	.LVL57:
 694 0024 46E0      		ldi r20,lo8(6)
 695 0026 60E0      		ldi r22,lo8(lcdBuffer)
 696 0028 70E0      		ldi r23,hi8(lcdBuffer)
 697 002a 8091 0000 		lds r24,lcdAddress
 698 002e 0E94 0000 		call twiWrite
 699               	.LVL58:
 700 0032 85E0      		ldi r24,lo8(5)
 701 0034 90E0      		ldi r25,0
 702 0036 0E94 0000 		call time_delay16
 703               	.LVL59:
 704 003a 00C0      		rjmp .L57
 705               	.LVL60:
 706               	.L59:
 707               	/* epilogue start */
 708               	.LBE5:
 709               		.loc 2 518 0
 710 003c DF91      		pop r29
 711 003e CF91      		pop r28
 712               	.LVL61:
 713 0040 1F91      		pop r17
 714 0042 0895      		ret
 715               		.cfi_endproc
 716               	.LFE112:
 717               		.size	lcdWrite, .-lcdWrite
 718               		.section	.text.lcdInit,"ax",@progbits
 719               	.global	lcdInit
 720               		.type	lcdInit, @function
 721               	lcdInit:
 722               	.LFB113:
 723               		.loc 2 524 0
 724               		.cfi_startproc
 725               	/* prologue: function */
 726               	/* frame size = 0 */
 727               	/* stack size = 0 */
 728               	.L__stack_usage = 0
 729               		.loc 2 525 0
 730 0000 60E0      		ldi r22,0
 731 0002 8091 0000 		lds r24,lcdModes
 732 0006 0E94 0000 		call lcdPrepare
 733               	.LVL62:
 734 000a 46E0      		ldi r20,lo8(6)
GAS LISTING /tmp/ccfXOBLh.s 			page 22


 735 000c 60E0      		ldi r22,lo8(lcdBuffer)
 736 000e 70E0      		ldi r23,hi8(lcdBuffer)
 737 0010 8091 0000 		lds r24,lcdAddress
 738 0014 0E94 0000 		call twiWrite
 739               	.LVL63:
 740 0018 85E0      		ldi r24,lo8(5)
 741 001a 90E0      		ldi r25,0
 742 001c 0E94 0000 		call time_delay16
 743               	.LVL64:
 744               		.loc 2 526 0
 745 0020 60E0      		ldi r22,0
 746 0022 8091 0000 		lds r24,lcdShows
 747 0026 0E94 0000 		call lcdPrepare
 748               	.LVL65:
 749 002a 46E0      		ldi r20,lo8(6)
 750 002c 60E0      		ldi r22,lo8(lcdBuffer)
 751 002e 70E0      		ldi r23,hi8(lcdBuffer)
 752 0030 8091 0000 		lds r24,lcdAddress
 753 0034 0E94 0000 		call twiWrite
 754               	.LVL66:
 755 0038 85E0      		ldi r24,lo8(5)
 756 003a 90E0      		ldi r25,0
 757 003c 0E94 0000 		call time_delay16
 758               	.LVL67:
 759               		.loc 2 527 0
 760 0040 60E0      		ldi r22,0
 761 0042 8091 0000 		lds r24,lcdShifts
 762 0046 0E94 0000 		call lcdPrepare
 763               	.LVL68:
 764 004a 46E0      		ldi r20,lo8(6)
 765 004c 60E0      		ldi r22,lo8(lcdBuffer)
 766 004e 70E0      		ldi r23,hi8(lcdBuffer)
 767 0050 8091 0000 		lds r24,lcdAddress
 768 0054 0E94 0000 		call twiWrite
 769               	.LVL69:
 770 0058 85E0      		ldi r24,lo8(5)
 771 005a 90E0      		ldi r25,0
 772 005c 0E94 0000 		call time_delay16
 773               	.LVL70:
 774               		.loc 2 528 0
 775 0060 60E0      		ldi r22,0
 776 0062 81E0      		ldi r24,lo8(1)
 777 0064 0E94 0000 		call lcdPrepare
 778               	.LVL71:
 779 0068 46E0      		ldi r20,lo8(6)
 780 006a 60E0      		ldi r22,lo8(lcdBuffer)
 781 006c 70E0      		ldi r23,hi8(lcdBuffer)
 782 006e 8091 0000 		lds r24,lcdAddress
 783 0072 0E94 0000 		call twiWrite
 784               	.LVL72:
 785 0076 85E0      		ldi r24,lo8(5)
 786 0078 90E0      		ldi r25,0
 787 007a 0E94 0000 		call time_delay16
 788               	.LVL73:
 789 007e 80E1      		ldi r24,lo8(16)
 790 0080 90E0      		ldi r25,0
 791 0082 0E94 0000 		call time_delay16
GAS LISTING /tmp/ccfXOBLh.s 			page 23


 792               	.LVL74:
 793               		.loc 2 529 0
 794 0086 60E0      		ldi r22,0
 795 0088 82E0      		ldi r24,lo8(2)
 796 008a 0E94 0000 		call lcdPrepare
 797               	.LVL75:
 798 008e 46E0      		ldi r20,lo8(6)
 799 0090 60E0      		ldi r22,lo8(lcdBuffer)
 800 0092 70E0      		ldi r23,hi8(lcdBuffer)
 801 0094 8091 0000 		lds r24,lcdAddress
 802 0098 0E94 0000 		call twiWrite
 803               	.LVL76:
 804 009c 85E0      		ldi r24,lo8(5)
 805 009e 90E0      		ldi r25,0
 806 00a0 0C94 0000 		jmp time_delay16
 807               	.LVL77:
 808               		.cfi_endproc
 809               	.LFE113:
 810               		.size	lcdInit, .-lcdInit
 811               		.section	.text.lcdSetup,"ax",@progbits
 812               	.global	lcdSetup
 813               		.type	lcdSetup, @function
 814               	lcdSetup:
 815               	.LFB114:
 816               		.loc 2 536 0
 817               		.cfi_startproc
 818               	.LVL78:
 819 0000 CF93      		push r28
 820               	.LCFI23:
 821               		.cfi_def_cfa_offset 4
 822               		.cfi_offset 28, -3
 823               	/* prologue: function */
 824               	/* frame size = 0 */
 825               	/* stack size = 1 */
 826               	.L__stack_usage = 1
 827 0002 C42F      		mov r28,r20
 828               		.loc 2 537 0
 829 0004 8093 0000 		sts lcdAddress,r24
 830               		.loc 2 538 0
 831 0008 6093 0000 		sts lcdCols,r22
 832               		.loc 2 539 0
 833 000c 4093 0000 		sts lcdRows,r20
 834               		.loc 2 540 0
 835 0010 2223      		tst r18
 836 0012 01F0      		breq .L64
 837 0014 88E0      		ldi r24,lo8(8)
 838               	.LVL79:
 839 0016 00C0      		rjmp .L62
 840               	.LVL80:
 841               	.L64:
 842 0018 80E0      		ldi r24,0
 843               	.LVL81:
 844               	.L62:
 845               		.loc 2 540 0 is_stmt 0 discriminator 3
 846 001a 8093 0000 		sts lcdBackLight,r24
 847               		.loc 2 541 0 is_stmt 1 discriminator 3
 848 001e 80E2      		ldi r24,lo8(32)
GAS LISTING /tmp/ccfXOBLh.s 			page 24


 849 0020 8093 0000 		sts lcdModes,r24
 850               		.loc 2 542 0 discriminator 3
 851 0024 86E0      		ldi r24,lo8(6)
 852 0026 8093 0000 		sts lcdShifts,r24
 853               		.loc 2 543 0 discriminator 3
 854 002a 8CE0      		ldi r24,lo8(12)
 855 002c 8093 0000 		sts lcdShows,r24
 856               		.loc 2 547 0 discriminator 3
 857 0030 46E0      		ldi r20,lo8(6)
 858               	.LVL82:
 859 0032 60EA      		ldi r22,lo8(-96)
 860 0034 76E8      		ldi r23,lo8(-122)
 861 0036 81E0      		ldi r24,lo8(1)
 862 0038 90E0      		ldi r25,0
 863               	.LVL83:
 864 003a 0E94 0000 		call twiSetup
 865               	.LVL84:
 866               		.loc 2 551 0 discriminator 3
 867 003e C230      		cpi r28,lo8(2)
 868 0040 00F0      		brlo .L63
 869               		.loc 2 551 0 is_stmt 0 discriminator 1
 870 0042 8091 0000 		lds r24,lcdModes
 871 0046 8860      		ori r24,lo8(8)
 872 0048 8093 0000 		sts lcdModes,r24
 873               	.L63:
 874               		.loc 2 555 0 is_stmt 1
 875 004c 60E0      		ldi r22,0
 876 004e 80E3      		ldi r24,lo8(48)
 877 0050 0E94 0000 		call lcdPrepare
 878               	.LVL85:
 879               		.loc 2 557 0
 880 0054 8FE0      		ldi r24,lo8(15)
 881 0056 90E0      		ldi r25,0
 882 0058 0E94 0000 		call time_delay16
 883               	.LVL86:
 884               		.loc 2 558 0
 885 005c 43E0      		ldi r20,lo8(3)
 886 005e 60E0      		ldi r22,lo8(lcdBuffer)
 887 0060 70E0      		ldi r23,hi8(lcdBuffer)
 888 0062 8091 0000 		lds r24,lcdAddress
 889 0066 0E94 0000 		call twiWrite
 890               	.LVL87:
 891 006a 85E0      		ldi r24,lo8(5)
 892 006c 90E0      		ldi r25,0
 893 006e 0E94 0000 		call time_delay16
 894               	.LVL88:
 895               		.loc 2 559 0
 896 0072 85E0      		ldi r24,lo8(5)
 897 0074 90E0      		ldi r25,0
 898 0076 0E94 0000 		call time_delay16
 899               	.LVL89:
 900               		.loc 2 560 0
 901 007a 43E0      		ldi r20,lo8(3)
 902 007c 60E0      		ldi r22,lo8(lcdBuffer)
 903 007e 70E0      		ldi r23,hi8(lcdBuffer)
 904 0080 8091 0000 		lds r24,lcdAddress
 905 0084 0E94 0000 		call twiWrite
GAS LISTING /tmp/ccfXOBLh.s 			page 25


 906               	.LVL90:
 907 0088 85E0      		ldi r24,lo8(5)
 908 008a 90E0      		ldi r25,0
 909 008c 0E94 0000 		call time_delay16
 910               	.LVL91:
 911               		.loc 2 561 0
 912 0090 80E9      		ldi r24,lo8(-112)
 913 0092 91E0      		ldi r25,lo8(1)
 914               	/* #APP */
 915               	 ;  561 "LCD1602ex.ino" 1
 916 0094 0197      		1: sbiw r24,1 
 917 0096 01F4      		brne 1b
 918               		
 919               	 ;  0 "" 2
 920               		.loc 2 562 0
 921               	/* #NOAPP */
 922 0098 43E0      		ldi r20,lo8(3)
 923 009a 60E0      		ldi r22,lo8(lcdBuffer)
 924 009c 70E0      		ldi r23,hi8(lcdBuffer)
 925 009e 8091 0000 		lds r24,lcdAddress
 926 00a2 0E94 0000 		call twiWrite
 927               	.LVL92:
 928 00a6 85E0      		ldi r24,lo8(5)
 929 00a8 90E0      		ldi r25,0
 930 00aa 0E94 0000 		call time_delay16
 931               	.LVL93:
 932               		.loc 2 564 0
 933 00ae 60E0      		ldi r22,0
 934 00b0 80E2      		ldi r24,lo8(32)
 935 00b2 0E94 0000 		call lcdPrepare
 936               	.LVL94:
 937               		.loc 2 565 0
 938 00b6 43E0      		ldi r20,lo8(3)
 939 00b8 60E0      		ldi r22,lo8(lcdBuffer)
 940 00ba 70E0      		ldi r23,hi8(lcdBuffer)
 941 00bc 8091 0000 		lds r24,lcdAddress
 942 00c0 0E94 0000 		call twiWrite
 943               	.LVL95:
 944 00c4 85E0      		ldi r24,lo8(5)
 945 00c6 90E0      		ldi r25,0
 946 00c8 0E94 0000 		call time_delay16
 947               	.LVL96:
 948               		.loc 2 567 0
 949 00cc 0E94 0000 		call lcdInit
 950               	.LVL97:
 951               		.loc 2 568 0
 952 00d0 84EF      		ldi r24,lo8(-12)
 953 00d2 91E0      		ldi r25,lo8(1)
 954               	/* epilogue start */
 955               		.loc 2 569 0
 956 00d4 CF91      		pop r28
 957               	.LVL98:
 958               		.loc 2 568 0
 959 00d6 0C94 0000 		jmp time_delay16
 960               	.LVL99:
 961               		.cfi_endproc
 962               	.LFE114:
GAS LISTING /tmp/ccfXOBLh.s 			page 26


 963               		.size	lcdSetup, .-lcdSetup
 964               		.section	.rodata.str1.1,"aMS",@progbits,1
 965               	.LC0:
 966 0000 4865 6C6C 		.string	"Hello, AAAAAA"
 966      6F2C 2041 
 966      4141 4141 
 966      4100 
 967               		.section	.text.setup,"ax",@progbits
 968               	.global	setup
 969               		.type	setup, @function
 970               	setup:
 971               	.LFB115:
 972               		.loc 2 577 0
 973               		.cfi_startproc
 974               	/* prologue: function */
 975               	/* frame size = 0 */
 976               	/* stack size = 0 */
 977               	.L__stack_usage = 0
 978               	.LBB6:
 979               		.loc 2 581 0
 980 0000 21E0      		ldi r18,lo8(1)
 981 0002 42E0      		ldi r20,lo8(2)
 982 0004 60E1      		ldi r22,lo8(16)
 983 0006 87E2      		ldi r24,lo8(39)
 984 0008 0E94 0000 		call lcdSetup
 985               	.LVL100:
 986               		.loc 2 582 0
 987 000c 6DE0      		ldi r22,lo8(13)
 988 000e 80E0      		ldi r24,lo8(.LC0)
 989 0010 90E0      		ldi r25,hi8(.LC0)
 990 0012 0C94 0000 		jmp lcdWrite
 991               	.LVL101:
 992               	.LBE6:
 993               		.cfi_endproc
 994               	.LFE115:
 995               		.size	setup, .-setup
 996               		.section	.text.loop,"ax",@progbits
 997               	.global	loop
 998               		.type	loop, @function
 999               	loop:
 1000               	.LFB116:
 1001               		.loc 2 588 0
 1002               		.cfi_startproc
 1003               	/* prologue: function */
 1004               	/* frame size = 0 */
 1005               	/* stack size = 0 */
 1006               	.L__stack_usage = 0
 1007 0000 0895      		ret
 1008               		.cfi_endproc
 1009               	.LFE116:
 1010               		.size	loop, .-loop
 1011               	.global	lcdBuffer
 1012               		.section	.bss.lcdBuffer,"aw",@nobits
 1013               		.type	lcdBuffer, @object
 1014               		.size	lcdBuffer, 6
 1015               	lcdBuffer:
 1016 0000 0000 0000 		.zero	6
GAS LISTING /tmp/ccfXOBLh.s 			page 27


 1016      0000 
 1017               	.global	lcdRows
 1018               		.section	.data.lcdRows,"aw",@progbits
 1019               		.type	lcdRows, @object
 1020               		.size	lcdRows, 1
 1021               	lcdRows:
 1022 0000 02        		.byte	2
 1023               	.global	lcdCols
 1024               		.section	.data.lcdCols,"aw",@progbits
 1025               		.type	lcdCols, @object
 1026               		.size	lcdCols, 1
 1027               	lcdCols:
 1028 0000 10        		.byte	16
 1029               	.global	lcdAddress
 1030               		.section	.data.lcdAddress,"aw",@progbits
 1031               		.type	lcdAddress, @object
 1032               		.size	lcdAddress, 1
 1033               	lcdAddress:
 1034 0000 27        		.byte	39
 1035               	.global	lcdBackLight
 1036               		.section	.data.lcdBackLight,"aw",@progbits
 1037               		.type	lcdBackLight, @object
 1038               		.size	lcdBackLight, 1
 1039               	lcdBackLight:
 1040 0000 08        		.byte	8
 1041               	.global	lcdShows
 1042               		.section	.data.lcdShows,"aw",@progbits
 1043               		.type	lcdShows, @object
 1044               		.size	lcdShows, 1
 1045               	lcdShows:
 1046 0000 08        		.byte	8
 1047               	.global	lcdShifts
 1048               		.section	.data.lcdShifts,"aw",@progbits
 1049               		.type	lcdShifts, @object
 1050               		.size	lcdShifts, 1
 1051               	lcdShifts:
 1052 0000 06        		.byte	6
 1053               	.global	lcdModes
 1054               		.section	.data.lcdModes,"aw",@progbits
 1055               		.type	lcdModes, @object
 1056               		.size	lcdModes, 1
 1057               	lcdModes:
 1058 0000 30        		.byte	48
 1059               		.section	.bss._ZL12twiStatistic,"aw",@nobits
 1060               		.type	_ZL12twiStatistic, @object
 1061               		.size	_ZL12twiStatistic, 20
 1062               	_ZL12twiStatistic:
 1063 0000 0000 0000 		.zero	20
 1063      0000 0000 
 1063      0000 0000 
 1063      0000 0000 
 1063      0000 0000 
 1064               	.global	twiSlaveWriter
 1065               		.section	.bss.twiSlaveWriter,"aw",@nobits
 1066               		.type	twiSlaveWriter, @object
 1067               		.size	twiSlaveWriter, 2
 1068               	twiSlaveWriter:
GAS LISTING /tmp/ccfXOBLh.s 			page 28


 1069 0000 0000      		.zero	2
 1070               	.global	twiSlaveReader
 1071               		.section	.bss.twiSlaveReader,"aw",@nobits
 1072               		.type	twiSlaveReader, @object
 1073               		.size	twiSlaveReader, 2
 1074               	twiSlaveReader:
 1075 0000 0000      		.zero	2
 1076               	.global	twiMasterReader
 1077               		.section	.bss.twiMasterReader,"aw",@nobits
 1078               		.type	twiMasterReader, @object
 1079               		.size	twiMasterReader, 2
 1080               	twiMasterReader:
 1081 0000 0000      		.zero	2
 1082               	.global	twiHookRestart
 1083               		.section	.bss.twiHookRestart,"aw",@nobits
 1084               		.type	twiHookRestart, @object
 1085               		.size	twiHookRestart, 2
 1086               	twiHookRestart:
 1087 0000 0000      		.zero	2
 1088               	.global	twiST_Ptr
 1089               		.section	.bss.twiST_Ptr,"aw",@nobits
 1090               		.type	twiST_Ptr, @object
 1091               		.size	twiST_Ptr, 2
 1092               	twiST_Ptr:
 1093 0000 0000      		.zero	2
 1094               	.global	twiST_Count
 1095               		.section	.bss.twiST_Count,"aw",@nobits
 1096               		.type	twiST_Count, @object
 1097               		.size	twiST_Count, 1
 1098               	twiST_Count:
 1099 0000 00        		.zero	1
 1100               	.global	twiRX_Ptr
 1101               		.section	.bss.twiRX_Ptr,"aw",@nobits
 1102               		.type	twiRX_Ptr, @object
 1103               		.size	twiRX_Ptr, 2
 1104               	twiRX_Ptr:
 1105 0000 0000      		.zero	2
 1106               	.global	twiRX_Count
 1107               		.section	.bss.twiRX_Count,"aw",@nobits
 1108               		.type	twiRX_Count, @object
 1109               		.size	twiRX_Count, 1
 1110               	twiRX_Count:
 1111 0000 00        		.zero	1
 1112               	.global	twiMT_Ptr
 1113               		.section	.bss.twiMT_Ptr,"aw",@nobits
 1114               		.type	twiMT_Ptr, @object
 1115               		.size	twiMT_Ptr, 2
 1116               	twiMT_Ptr:
 1117 0000 0000      		.zero	2
 1118               	.global	twiMT_Count
 1119               		.section	.bss.twiMT_Count,"aw",@nobits
 1120               		.type	twiMT_Count, @object
 1121               		.size	twiMT_Count, 1
 1122               	twiMT_Count:
 1123 0000 00        		.zero	1
 1124               	.global	twiSLARW
 1125               		.section	.bss.twiSLARW,"aw",@nobits
GAS LISTING /tmp/ccfXOBLh.s 			page 29


 1126               		.type	twiSLARW, @object
 1127               		.size	twiSLARW, 1
 1128               	twiSLARW:
 1129 0000 00        		.zero	1
 1130               	.global	twiState
 1131               		.section	.bss.twiState,"aw",@nobits
 1132               		.type	twiState, @object
 1133               		.size	twiState, 1
 1134               	twiState:
 1135 0000 00        		.zero	1
 1136               	.global	twiMode
 1137               		.section	.bss.twiMode,"aw",@nobits
 1138               		.type	twiMode, @object
 1139               		.size	twiMode, 1
 1140               	twiMode:
 1141 0000 00        		.zero	1
 1142               		.text
 1143               	.Letext0:
 1144               		.file 3 "/home/arhat109/progs/arduino-1.6.4/hardware/tools/avr/avr/include/stdint.h"
 1145               		.file 4 "/home/arhat109/Arduino/libraries/Arhat/arhat.h"
 1146               		.section	.debug_info,"",@progbits
 1147               	.Ldebug_info0:
 1148 0000 260B 0000 		.long	0xb26
 1149 0004 0200      		.word	0x2
 1150 0006 0000 0000 		.long	.Ldebug_abbrev0
 1151 000a 04        		.byte	0x4
 1152 000b 01        		.uleb128 0x1
 1153 000c 0000 0000 		.long	.LASF77
 1154 0010 04        		.byte	0x4
 1155 0011 0000 0000 		.long	.LASF78
 1156 0015 0000 0000 		.long	.LASF79
 1157 0019 0000 0000 		.long	.Ldebug_ranges0+0
 1158 001d 0000 0000 		.long	0
 1159 0021 0000 0000 		.long	0
 1160 0025 0000 0000 		.long	.Ldebug_line0
 1161 0029 02        		.uleb128 0x2
 1162 002a 01        		.byte	0x1
 1163 002b 06        		.byte	0x6
 1164 002c 0000 0000 		.long	.LASF0
 1165 0030 03        		.uleb128 0x3
 1166 0031 0000 0000 		.long	.LASF2
 1167 0035 03        		.byte	0x3
 1168 0036 7A        		.byte	0x7a
 1169 0037 3B00 0000 		.long	0x3b
 1170 003b 02        		.uleb128 0x2
 1171 003c 01        		.byte	0x1
 1172 003d 08        		.byte	0x8
 1173 003e 0000 0000 		.long	.LASF1
 1174 0042 04        		.uleb128 0x4
 1175 0043 02        		.byte	0x2
 1176 0044 05        		.byte	0x5
 1177 0045 696E 7400 		.string	"int"
 1178 0049 03        		.uleb128 0x3
 1179 004a 0000 0000 		.long	.LASF3
 1180 004e 03        		.byte	0x3
 1181 004f 7C        		.byte	0x7c
 1182 0050 5400 0000 		.long	0x54
GAS LISTING /tmp/ccfXOBLh.s 			page 30


 1183 0054 02        		.uleb128 0x2
 1184 0055 02        		.byte	0x2
 1185 0056 07        		.byte	0x7
 1186 0057 0000 0000 		.long	.LASF4
 1187 005b 02        		.uleb128 0x2
 1188 005c 04        		.byte	0x4
 1189 005d 05        		.byte	0x5
 1190 005e 0000 0000 		.long	.LASF5
 1191 0062 03        		.uleb128 0x3
 1192 0063 0000 0000 		.long	.LASF6
 1193 0067 03        		.byte	0x3
 1194 0068 7E        		.byte	0x7e
 1195 0069 6D00 0000 		.long	0x6d
 1196 006d 02        		.uleb128 0x2
 1197 006e 04        		.byte	0x4
 1198 006f 07        		.byte	0x7
 1199 0070 0000 0000 		.long	.LASF7
 1200 0074 02        		.uleb128 0x2
 1201 0075 08        		.byte	0x8
 1202 0076 05        		.byte	0x5
 1203 0077 0000 0000 		.long	.LASF8
 1204 007b 02        		.uleb128 0x2
 1205 007c 08        		.byte	0x8
 1206 007d 07        		.byte	0x7
 1207 007e 0000 0000 		.long	.LASF9
 1208 0082 02        		.uleb128 0x2
 1209 0083 01        		.byte	0x1
 1210 0084 02        		.byte	0x2
 1211 0085 0000 0000 		.long	.LASF10
 1212 0089 05        		.uleb128 0x5
 1213 008a 02        		.byte	0x2
 1214 008b 8F00 0000 		.long	0x8f
 1215 008f 06        		.uleb128 0x6
 1216 0090 02        		.uleb128 0x2
 1217 0091 01        		.byte	0x1
 1218 0092 06        		.byte	0x6
 1219 0093 0000 0000 		.long	.LASF11
 1220 0097 02        		.uleb128 0x2
 1221 0098 04        		.byte	0x4
 1222 0099 04        		.byte	0x4
 1223 009a 0000 0000 		.long	.LASF12
 1224 009e 02        		.uleb128 0x2
 1225 009f 04        		.byte	0x4
 1226 00a0 04        		.byte	0x4
 1227 00a1 0000 0000 		.long	.LASF13
 1228 00a5 02        		.uleb128 0x2
 1229 00a6 02        		.byte	0x2
 1230 00a7 07        		.byte	0x7
 1231 00a8 0000 0000 		.long	.LASF14
 1232 00ac 07        		.uleb128 0x7
 1233 00ad 0000 0000 		.long	.LASF80
 1234 00b1 02        		.byte	0x2
 1235 00b2 01        		.byte	0x1
 1236 00b3 8C        		.byte	0x8c
 1237 00b4 CB00 0000 		.long	0xcb
 1238 00b8 08        		.uleb128 0x8
 1239 00b9 0000 0000 		.long	.LASF15
GAS LISTING /tmp/ccfXOBLh.s 			page 31


 1240 00bd 01        		.sleb128 1
 1241 00be 08        		.uleb128 0x8
 1242 00bf 0000 0000 		.long	.LASF16
 1243 00c3 02        		.sleb128 2
 1244 00c4 08        		.uleb128 0x8
 1245 00c5 0000 0000 		.long	.LASF17
 1246 00c9 04        		.sleb128 4
 1247 00ca 00        		.byte	0
 1248 00cb 09        		.uleb128 0x9
 1249 00cc 14        		.byte	0x14
 1250 00cd 01        		.byte	0x1
 1251 00ce A6        		.byte	0xa6
 1252 00cf 0000 0000 		.long	.LASF81
 1253 00d3 6401 0000 		.long	0x164
 1254 00d7 0A        		.uleb128 0xa
 1255 00d8 0000 0000 		.long	.LASF18
 1256 00dc 01        		.byte	0x1
 1257 00dd A7        		.byte	0xa7
 1258 00de 4900 0000 		.long	0x49
 1259 00e2 02        		.byte	0x2
 1260 00e3 23        		.byte	0x23
 1261 00e4 00        		.uleb128 0
 1262 00e5 0A        		.uleb128 0xa
 1263 00e6 0000 0000 		.long	.LASF19
 1264 00ea 01        		.byte	0x1
 1265 00eb A7        		.byte	0xa7
 1266 00ec 4900 0000 		.long	0x49
 1267 00f0 02        		.byte	0x2
 1268 00f1 23        		.byte	0x23
 1269 00f2 02        		.uleb128 0x2
 1270 00f3 0A        		.uleb128 0xa
 1271 00f4 0000 0000 		.long	.LASF20
 1272 00f8 01        		.byte	0x1
 1273 00f9 A7        		.byte	0xa7
 1274 00fa 4900 0000 		.long	0x49
 1275 00fe 02        		.byte	0x2
 1276 00ff 23        		.byte	0x23
 1277 0100 04        		.uleb128 0x4
 1278 0101 0A        		.uleb128 0xa
 1279 0102 0000 0000 		.long	.LASF21
 1280 0106 01        		.byte	0x1
 1281 0107 A7        		.byte	0xa7
 1282 0108 4900 0000 		.long	0x49
 1283 010c 02        		.byte	0x2
 1284 010d 23        		.byte	0x23
 1285 010e 06        		.uleb128 0x6
 1286 010f 0A        		.uleb128 0xa
 1287 0110 0000 0000 		.long	.LASF22
 1288 0114 01        		.byte	0x1
 1289 0115 A7        		.byte	0xa7
 1290 0116 4900 0000 		.long	0x49
 1291 011a 02        		.byte	0x2
 1292 011b 23        		.byte	0x23
 1293 011c 08        		.uleb128 0x8
 1294 011d 0B        		.uleb128 0xb
 1295 011e 6D74 7800 		.string	"mtx"
 1296 0122 01        		.byte	0x1
GAS LISTING /tmp/ccfXOBLh.s 			page 32


 1297 0123 A7        		.byte	0xa7
 1298 0124 4900 0000 		.long	0x49
 1299 0128 02        		.byte	0x2
 1300 0129 23        		.byte	0x23
 1301 012a 0A        		.uleb128 0xa
 1302 012b 0B        		.uleb128 0xb
 1303 012c 6D72 7800 		.string	"mrx"
 1304 0130 01        		.byte	0x1
 1305 0131 A7        		.byte	0xa7
 1306 0132 4900 0000 		.long	0x49
 1307 0136 02        		.byte	0x2
 1308 0137 23        		.byte	0x23
 1309 0138 0C        		.uleb128 0xc
 1310 0139 0B        		.uleb128 0xb
 1311 013a 7372 7800 		.string	"srx"
 1312 013e 01        		.byte	0x1
 1313 013f A7        		.byte	0xa7
 1314 0140 4900 0000 		.long	0x49
 1315 0144 02        		.byte	0x2
 1316 0145 23        		.byte	0x23
 1317 0146 0E        		.uleb128 0xe
 1318 0147 0B        		.uleb128 0xb
 1319 0148 6772 7800 		.string	"grx"
 1320 014c 01        		.byte	0x1
 1321 014d A7        		.byte	0xa7
 1322 014e 4900 0000 		.long	0x49
 1323 0152 02        		.byte	0x2
 1324 0153 23        		.byte	0x23
 1325 0154 10        		.uleb128 0x10
 1326 0155 0B        		.uleb128 0xb
 1327 0156 7374 7800 		.string	"stx"
 1328 015a 01        		.byte	0x1
 1329 015b A7        		.byte	0xa7
 1330 015c 4900 0000 		.long	0x49
 1331 0160 02        		.byte	0x2
 1332 0161 23        		.byte	0x23
 1333 0162 12        		.uleb128 0x12
 1334 0163 00        		.byte	0
 1335 0164 03        		.uleb128 0x3
 1336 0165 0000 0000 		.long	.LASF23
 1337 0169 01        		.byte	0x1
 1338 016a A8        		.byte	0xa8
 1339 016b CB00 0000 		.long	0xcb
 1340 016f 05        		.uleb128 0x5
 1341 0170 02        		.byte	0x2
 1342 0171 3000 0000 		.long	0x30
 1343 0175 0C        		.uleb128 0xc
 1344 0176 01        		.byte	0x1
 1345 0177 0000 0000 		.long	.LASF26
 1346 017b 01        		.byte	0x1
 1347 017c B7        		.byte	0xb7
 1348 017d 0000 0000 		.long	.LFB102
 1349 0181 0000 0000 		.long	.LFE102
 1350 0185 03        		.byte	0x3
 1351 0186 92        		.byte	0x92
 1352 0187 20        		.uleb128 0x20
 1353 0188 03        		.sleb128 3
GAS LISTING /tmp/ccfXOBLh.s 			page 33


 1354 0189 01        		.byte	0x1
 1355 018a C901 0000 		.long	0x1c9
 1356 018e 0D        		.uleb128 0xd
 1357 018f 0000 0000 		.long	.LASF28
 1358 0193 01        		.byte	0x1
 1359 0194 B7        		.byte	0xb7
 1360 0195 6200 0000 		.long	0x62
 1361 0199 0000 0000 		.long	.LLST0
 1362 019d 0E        		.uleb128 0xe
 1363 019e 0000 0000 		.long	.LBB2
 1364 01a2 0000 0000 		.long	.LBE2
 1365 01a6 0F        		.uleb128 0xf
 1366 01a7 0000 0000 		.long	.LASF24
 1367 01ab 01        		.byte	0x1
 1368 01ac B9        		.byte	0xb9
 1369 01ad 4900 0000 		.long	0x49
 1370 01b1 06        		.byte	0x6
 1371 01b2 62        		.byte	0x62
 1372 01b3 93        		.byte	0x93
 1373 01b4 01        		.uleb128 0x1
 1374 01b5 63        		.byte	0x63
 1375 01b6 93        		.byte	0x93
 1376 01b7 01        		.uleb128 0x1
 1377 01b8 10        		.uleb128 0x10
 1378 01b9 0000 0000 		.long	.LASF25
 1379 01bd 01        		.byte	0x1
 1380 01be BA        		.byte	0xba
 1381 01bf 3000 0000 		.long	0x30
 1382 01c3 0000 0000 		.long	.LLST1
 1383 01c7 00        		.byte	0
 1384 01c8 00        		.byte	0
 1385 01c9 11        		.uleb128 0x11
 1386 01ca 01        		.byte	0x1
 1387 01cb 0000 0000 		.long	.LASF27
 1388 01cf 01        		.byte	0x1
 1389 01d0 C8        		.byte	0xc8
 1390 01d1 0000 0000 		.long	.LFB103
 1391 01d5 0000 0000 		.long	.LFE103
 1392 01d9 0000 0000 		.long	.LLST2
 1393 01dd 01        		.byte	0x1
 1394 01de 1D02 0000 		.long	0x21d
 1395 01e2 0D        		.uleb128 0xd
 1396 01e3 0000 0000 		.long	.LASF28
 1397 01e7 01        		.byte	0x1
 1398 01e8 C8        		.byte	0xc8
 1399 01e9 6200 0000 		.long	0x62
 1400 01ed 0000 0000 		.long	.LLST3
 1401 01f1 0D        		.uleb128 0xd
 1402 01f2 0000 0000 		.long	.LASF29
 1403 01f6 01        		.byte	0x1
 1404 01f7 C8        		.byte	0xc8
 1405 01f8 3000 0000 		.long	0x30
 1406 01fc 0000 0000 		.long	.LLST4
 1407 0200 12        		.uleb128 0x12
 1408 0201 0000 0000 		.long	.LVL10
 1409 0205 7501 0000 		.long	0x175
 1410 0209 13        		.uleb128 0x13
GAS LISTING /tmp/ccfXOBLh.s 			page 34


 1411 020a 0C        		.byte	0xc
 1412 020b 66        		.byte	0x66
 1413 020c 93        		.byte	0x93
 1414 020d 01        		.uleb128 0x1
 1415 020e 67        		.byte	0x67
 1416 020f 93        		.byte	0x93
 1417 0210 01        		.uleb128 0x1
 1418 0211 68        		.byte	0x68
 1419 0212 93        		.byte	0x93
 1420 0213 01        		.uleb128 0x1
 1421 0214 69        		.byte	0x69
 1422 0215 93        		.byte	0x93
 1423 0216 01        		.uleb128 0x1
 1424 0217 03        		.byte	0x3
 1425 0218 F3        		.byte	0xf3
 1426 0219 01        		.uleb128 0x1
 1427 021a 66        		.byte	0x66
 1428 021b 00        		.byte	0
 1429 021c 00        		.byte	0
 1430 021d 14        		.uleb128 0x14
 1431 021e 01        		.byte	0x1
 1432 021f 0000 0000 		.long	.LASF30
 1433 0223 01        		.byte	0x1
 1434 0224 EF        		.byte	0xef
 1435 0225 0000 0000 		.long	.LFB104
 1436 0229 0000 0000 		.long	.LFE104
 1437 022d 0000 0000 		.long	.LLST5
 1438 0231 01        		.byte	0x1
 1439 0232 4602 0000 		.long	0x246
 1440 0236 15        		.uleb128 0x15
 1441 0237 5F6D 6400 		.string	"_md"
 1442 023b 01        		.byte	0x1
 1443 023c EF        		.byte	0xef
 1444 023d 3000 0000 		.long	0x30
 1445 0241 0000 0000 		.long	.LLST6
 1446 0245 00        		.byte	0
 1447 0246 16        		.uleb128 0x16
 1448 0247 01        		.byte	0x1
 1449 0248 0000 0000 		.long	.LASF31
 1450 024c 01        		.byte	0x1
 1451 024d 0401      		.word	0x104
 1452 024f 0000 0000 		.long	.LFB105
 1453 0253 0000 0000 		.long	.LFE105
 1454 0257 0000 0000 		.long	.LLST7
 1455 025b 01        		.byte	0x1
 1456 025c A402 0000 		.long	0x2a4
 1457 0260 0E        		.uleb128 0xe
 1458 0261 0000 0000 		.long	.LBB3
 1459 0265 0000 0000 		.long	.LBE3
 1460 0269 17        		.uleb128 0x17
 1461 026a 5F63 7200 		.string	"_cr"
 1462 026e 01        		.byte	0x1
 1463 026f 0601      		.word	0x106
 1464 0271 3000 0000 		.long	0x30
 1465 0275 0000 0000 		.long	.LLST8
 1466 0279 17        		.uleb128 0x17
 1467 027a 5F6D 6400 		.string	"_md"
GAS LISTING /tmp/ccfXOBLh.s 			page 35


 1468 027e 01        		.byte	0x1
 1469 027f 0701      		.word	0x107
 1470 0281 3000 0000 		.long	0x30
 1471 0285 0000 0000 		.long	.LLST9
 1472 0289 17        		.uleb128 0x17
 1473 028a 5F73 7400 		.string	"_st"
 1474 028e 01        		.byte	0x1
 1475 028f 0801      		.word	0x108
 1476 0291 3000 0000 		.long	0x30
 1477 0295 0000 0000 		.long	.LLST10
 1478 0299 18        		.uleb128 0x18
 1479 029a 0000 0000 		.long	.LVL23
 1480 029e 1D02 0000 		.long	0x21d
 1481 02a2 00        		.byte	0
 1482 02a3 00        		.byte	0
 1483 02a4 19        		.uleb128 0x19
 1484 02a5 01        		.byte	0x1
 1485 02a6 0000 0000 		.long	.LASF32
 1486 02aa 01        		.byte	0x1
 1487 02ab 8F01      		.word	0x18f
 1488 02ad 0000 0000 		.long	.LFB106
 1489 02b1 0000 0000 		.long	.LFE106
 1490 02b5 03        		.byte	0x3
 1491 02b6 92        		.byte	0x92
 1492 02b7 20        		.uleb128 0x20
 1493 02b8 03        		.sleb128 3
 1494 02b9 01        		.byte	0x1
 1495 02ba CF02 0000 		.long	0x2cf
 1496 02be 1A        		.uleb128 0x1a
 1497 02bf 0000 0000 		.long	.LASF33
 1498 02c3 01        		.byte	0x1
 1499 02c4 8F01      		.word	0x18f
 1500 02c6 3000 0000 		.long	0x30
 1501 02ca 0000 0000 		.long	.LLST11
 1502 02ce 00        		.byte	0
 1503 02cf 19        		.uleb128 0x19
 1504 02d0 01        		.byte	0x1
 1505 02d1 0000 0000 		.long	.LASF34
 1506 02d5 01        		.byte	0x1
 1507 02d6 9B01      		.word	0x19b
 1508 02d8 0000 0000 		.long	.LFB107
 1509 02dc 0000 0000 		.long	.LFE107
 1510 02e0 03        		.byte	0x3
 1511 02e1 92        		.byte	0x92
 1512 02e2 20        		.uleb128 0x20
 1513 02e3 03        		.sleb128 3
 1514 02e4 01        		.byte	0x1
 1515 02e5 FA02 0000 		.long	0x2fa
 1516 02e9 1A        		.uleb128 0x1a
 1517 02ea 0000 0000 		.long	.LASF33
 1518 02ee 01        		.byte	0x1
 1519 02ef 9B01      		.word	0x19b
 1520 02f1 3000 0000 		.long	0x30
 1521 02f5 0000 0000 		.long	.LLST12
 1522 02f9 00        		.byte	0
 1523 02fa 19        		.uleb128 0x19
 1524 02fb 01        		.byte	0x1
GAS LISTING /tmp/ccfXOBLh.s 			page 36


 1525 02fc 0000 0000 		.long	.LASF35
 1526 0300 01        		.byte	0x1
 1527 0301 AD01      		.word	0x1ad
 1528 0303 0000 0000 		.long	.LFB108
 1529 0307 0000 0000 		.long	.LFE108
 1530 030b 03        		.byte	0x3
 1531 030c 92        		.byte	0x92
 1532 030d 20        		.uleb128 0x20
 1533 030e 03        		.sleb128 3
 1534 030f 01        		.byte	0x1
 1535 0310 5903 0000 		.long	0x359
 1536 0314 1A        		.uleb128 0x1a
 1537 0315 0000 0000 		.long	.LASF33
 1538 0319 01        		.byte	0x1
 1539 031a AD01      		.word	0x1ad
 1540 031c 3000 0000 		.long	0x30
 1541 0320 0000 0000 		.long	.LLST13
 1542 0324 1A        		.uleb128 0x1a
 1543 0325 0000 0000 		.long	.LASF36
 1544 0329 01        		.byte	0x1
 1545 032a AD01      		.word	0x1ad
 1546 032c 5903 0000 		.long	0x359
 1547 0330 0000 0000 		.long	.LLST14
 1548 0334 1A        		.uleb128 0x1a
 1549 0335 0000 0000 		.long	.LASF37
 1550 0339 01        		.byte	0x1
 1551 033a AD01      		.word	0x1ad
 1552 033c 3000 0000 		.long	0x30
 1553 0340 0000 0000 		.long	.LLST15
 1554 0344 1B        		.uleb128 0x1b
 1555 0345 0000 0000 		.long	.LVL35
 1556 0349 01        		.byte	0x1
 1557 034a A402 0000 		.long	0x2a4
 1558 034e 13        		.uleb128 0x13
 1559 034f 01        		.byte	0x1
 1560 0350 68        		.byte	0x68
 1561 0351 05        		.byte	0x5
 1562 0352 F3        		.byte	0xf3
 1563 0353 01        		.uleb128 0x1
 1564 0354 68        		.byte	0x68
 1565 0355 31        		.byte	0x31
 1566 0356 24        		.byte	0x24
 1567 0357 00        		.byte	0
 1568 0358 00        		.byte	0
 1569 0359 05        		.uleb128 0x5
 1570 035a 02        		.byte	0x2
 1571 035b 5F03 0000 		.long	0x35f
 1572 035f 1C        		.uleb128 0x1c
 1573 0360 3000 0000 		.long	0x30
 1574 0364 19        		.uleb128 0x19
 1575 0365 01        		.byte	0x1
 1576 0366 0000 0000 		.long	.LASF38
 1577 036a 01        		.byte	0x1
 1578 036b B701      		.word	0x1b7
 1579 036d 0000 0000 		.long	.LFB109
 1580 0371 0000 0000 		.long	.LFE109
 1581 0375 03        		.byte	0x3
GAS LISTING /tmp/ccfXOBLh.s 			page 37


 1582 0376 92        		.byte	0x92
 1583 0377 20        		.uleb128 0x20
 1584 0378 03        		.sleb128 3
 1585 0379 01        		.byte	0x1
 1586 037a C503 0000 		.long	0x3c5
 1587 037e 1A        		.uleb128 0x1a
 1588 037f 0000 0000 		.long	.LASF33
 1589 0383 01        		.byte	0x1
 1590 0384 B701      		.word	0x1b7
 1591 0386 3000 0000 		.long	0x30
 1592 038a 0000 0000 		.long	.LLST16
 1593 038e 1A        		.uleb128 0x1a
 1594 038f 0000 0000 		.long	.LASF36
 1595 0393 01        		.byte	0x1
 1596 0394 B701      		.word	0x1b7
 1597 0396 6F01 0000 		.long	0x16f
 1598 039a 0000 0000 		.long	.LLST17
 1599 039e 1A        		.uleb128 0x1a
 1600 039f 0000 0000 		.long	.LASF37
 1601 03a3 01        		.byte	0x1
 1602 03a4 B701      		.word	0x1b7
 1603 03a6 3000 0000 		.long	0x30
 1604 03aa 0000 0000 		.long	.LLST18
 1605 03ae 1B        		.uleb128 0x1b
 1606 03af 0000 0000 		.long	.LVL38
 1607 03b3 01        		.byte	0x1
 1608 03b4 A402 0000 		.long	0x2a4
 1609 03b8 13        		.uleb128 0x13
 1610 03b9 01        		.byte	0x1
 1611 03ba 68        		.byte	0x68
 1612 03bb 07        		.byte	0x7
 1613 03bc F3        		.byte	0xf3
 1614 03bd 01        		.uleb128 0x1
 1615 03be 68        		.byte	0x68
 1616 03bf 31        		.byte	0x31
 1617 03c0 24        		.byte	0x24
 1618 03c1 31        		.byte	0x31
 1619 03c2 21        		.byte	0x21
 1620 03c3 00        		.byte	0
 1621 03c4 00        		.byte	0
 1622 03c5 1D        		.uleb128 0x1d
 1623 03c6 01        		.byte	0x1
 1624 03c7 0000 0000 		.long	.LASF39
 1625 03cb 01        		.byte	0x1
 1626 03cc C201      		.word	0x1c2
 1627 03ce 0000 0000 		.long	.LFB110
 1628 03d2 0000 0000 		.long	.LFE110
 1629 03d6 0000 0000 		.long	.LLST19
 1630 03da 01        		.byte	0x1
 1631 03db 3404 0000 		.long	0x434
 1632 03df 1A        		.uleb128 0x1a
 1633 03e0 0000 0000 		.long	.LASF33
 1634 03e4 01        		.byte	0x1
 1635 03e5 C201      		.word	0x1c2
 1636 03e7 3000 0000 		.long	0x30
 1637 03eb 0000 0000 		.long	.LLST20
 1638 03ef 1E        		.uleb128 0x1e
GAS LISTING /tmp/ccfXOBLh.s 			page 38


 1639 03f0 0000 0000 		.long	.LASF40
 1640 03f4 01        		.byte	0x1
 1641 03f5 C301      		.word	0x1c3
 1642 03f7 6F01 0000 		.long	0x16f
 1643 03fb 06        		.byte	0x6
 1644 03fc 66        		.byte	0x66
 1645 03fd 93        		.byte	0x93
 1646 03fe 01        		.uleb128 0x1
 1647 03ff 67        		.byte	0x67
 1648 0400 93        		.byte	0x93
 1649 0401 01        		.uleb128 0x1
 1650 0402 1E        		.uleb128 0x1e
 1651 0403 0000 0000 		.long	.LASF41
 1652 0407 01        		.byte	0x1
 1653 0408 C301      		.word	0x1c3
 1654 040a 3000 0000 		.long	0x30
 1655 040e 01        		.byte	0x1
 1656 040f 64        		.byte	0x64
 1657 0410 1E        		.uleb128 0x1e
 1658 0411 0000 0000 		.long	.LASF36
 1659 0415 01        		.byte	0x1
 1660 0416 C401      		.word	0x1c4
 1661 0418 6F01 0000 		.long	0x16f
 1662 041c 06        		.byte	0x6
 1663 041d 62        		.byte	0x62
 1664 041e 93        		.byte	0x93
 1665 041f 01        		.uleb128 0x1
 1666 0420 63        		.byte	0x63
 1667 0421 93        		.byte	0x93
 1668 0422 01        		.uleb128 0x1
 1669 0423 1A        		.uleb128 0x1a
 1670 0424 0000 0000 		.long	.LASF42
 1671 0428 01        		.byte	0x1
 1672 0429 C401      		.word	0x1c4
 1673 042b 3000 0000 		.long	0x30
 1674 042f 0000 0000 		.long	.LLST21
 1675 0433 00        		.byte	0
 1676 0434 19        		.uleb128 0x19
 1677 0435 01        		.byte	0x1
 1678 0436 0000 0000 		.long	.LASF43
 1679 043a 02        		.byte	0x2
 1680 043b E901      		.word	0x1e9
 1681 043d 0000 0000 		.long	.LFB111
 1682 0441 0000 0000 		.long	.LFE111
 1683 0445 03        		.byte	0x3
 1684 0446 92        		.byte	0x92
 1685 0447 20        		.uleb128 0x20
 1686 0448 03        		.sleb128 3
 1687 0449 01        		.byte	0x1
 1688 044a 8704 0000 		.long	0x487
 1689 044e 1A        		.uleb128 0x1a
 1690 044f 0000 0000 		.long	.LASF44
 1691 0453 02        		.byte	0x2
 1692 0454 E901      		.word	0x1e9
 1693 0456 3000 0000 		.long	0x30
 1694 045a 0000 0000 		.long	.LLST22
 1695 045e 1F        		.uleb128 0x1f
GAS LISTING /tmp/ccfXOBLh.s 			page 39


 1696 045f 5F72 7300 		.string	"_rs"
 1697 0463 02        		.byte	0x2
 1698 0464 E901      		.word	0x1e9
 1699 0466 3000 0000 		.long	0x30
 1700 046a 01        		.byte	0x1
 1701 046b 66        		.byte	0x66
 1702 046c 0E        		.uleb128 0xe
 1703 046d 0000 0000 		.long	.LBB4
 1704 0471 0000 0000 		.long	.LBE4
 1705 0475 20        		.uleb128 0x20
 1706 0476 0000 0000 		.long	.LASF45
 1707 047a 02        		.byte	0x2
 1708 047b EB01      		.word	0x1eb
 1709 047d 3000 0000 		.long	0x30
 1710 0481 0000 0000 		.long	.LLST23
 1711 0485 00        		.byte	0
 1712 0486 00        		.byte	0
 1713 0487 1D        		.uleb128 0x1d
 1714 0488 01        		.byte	0x1
 1715 0489 0000 0000 		.long	.LASF46
 1716 048d 02        		.byte	0x2
 1717 048e FE01      		.word	0x1fe
 1718 0490 0000 0000 		.long	.LFB112
 1719 0494 0000 0000 		.long	.LFE112
 1720 0498 0000 0000 		.long	.LLST24
 1721 049c 01        		.byte	0x1
 1722 049d 3205 0000 		.long	0x532
 1723 04a1 21        		.uleb128 0x21
 1724 04a2 6275 6600 		.string	"buf"
 1725 04a6 02        		.byte	0x2
 1726 04a7 FE01      		.word	0x1fe
 1727 04a9 8900 0000 		.long	0x89
 1728 04ad 0000 0000 		.long	.LLST25
 1729 04b1 21        		.uleb128 0x21
 1730 04b2 6C65 6E00 		.string	"len"
 1731 04b6 02        		.byte	0x2
 1732 04b7 FE01      		.word	0x1fe
 1733 04b9 3000 0000 		.long	0x30
 1734 04bd 0000 0000 		.long	.LLST26
 1735 04c1 0E        		.uleb128 0xe
 1736 04c2 0000 0000 		.long	.LBB5
 1737 04c6 0000 0000 		.long	.LBE5
 1738 04ca 17        		.uleb128 0x17
 1739 04cb 5F62 00   		.string	"_b"
 1740 04ce 02        		.byte	0x2
 1741 04cf 0002      		.word	0x200
 1742 04d1 6F01 0000 		.long	0x16f
 1743 04d5 0000 0000 		.long	.LLST27
 1744 04d9 17        		.uleb128 0x17
 1745 04da 5F6C 00   		.string	"_l"
 1746 04dd 02        		.byte	0x2
 1747 04de 0102      		.word	0x201
 1748 04e0 3000 0000 		.long	0x30
 1749 04e4 0000 0000 		.long	.LLST28
 1750 04e8 22        		.uleb128 0x22
 1751 04e9 0000 0000 		.long	.LVL57
 1752 04ed 3404 0000 		.long	0x434
GAS LISTING /tmp/ccfXOBLh.s 			page 40


 1753 04f1 FB04 0000 		.long	0x4fb
 1754 04f5 13        		.uleb128 0x13
 1755 04f6 01        		.byte	0x1
 1756 04f7 66        		.byte	0x66
 1757 04f8 01        		.byte	0x1
 1758 04f9 31        		.byte	0x31
 1759 04fa 00        		.byte	0
 1760 04fb 22        		.uleb128 0x22
 1761 04fc 0000 0000 		.long	.LVL58
 1762 0500 FA02 0000 		.long	0x2fa
 1763 0504 1C05 0000 		.long	0x51c
 1764 0508 13        		.uleb128 0x13
 1765 0509 06        		.byte	0x6
 1766 050a 66        		.byte	0x66
 1767 050b 93        		.byte	0x93
 1768 050c 01        		.uleb128 0x1
 1769 050d 67        		.byte	0x67
 1770 050e 93        		.byte	0x93
 1771 050f 01        		.uleb128 0x1
 1772 0510 05        		.byte	0x5
 1773 0511 03        		.byte	0x3
 1774 0512 0000 0000 		.long	lcdBuffer
 1775 0516 13        		.uleb128 0x13
 1776 0517 01        		.byte	0x1
 1777 0518 64        		.byte	0x64
 1778 0519 01        		.byte	0x1
 1779 051a 36        		.byte	0x36
 1780 051b 00        		.byte	0
 1781 051c 12        		.uleb128 0x12
 1782 051d 0000 0000 		.long	.LVL59
 1783 0521 190B 0000 		.long	0xb19
 1784 0525 13        		.uleb128 0x13
 1785 0526 06        		.byte	0x6
 1786 0527 68        		.byte	0x68
 1787 0528 93        		.byte	0x93
 1788 0529 01        		.uleb128 0x1
 1789 052a 69        		.byte	0x69
 1790 052b 93        		.byte	0x93
 1791 052c 01        		.uleb128 0x1
 1792 052d 01        		.byte	0x1
 1793 052e 35        		.byte	0x35
 1794 052f 00        		.byte	0
 1795 0530 00        		.byte	0
 1796 0531 00        		.byte	0
 1797 0532 19        		.uleb128 0x19
 1798 0533 01        		.byte	0x1
 1799 0534 0000 0000 		.long	.LASF47
 1800 0538 02        		.byte	0x2
 1801 0539 0B02      		.word	0x20b
 1802 053b 0000 0000 		.long	.LFB113
 1803 053f 0000 0000 		.long	.LFE113
 1804 0543 03        		.byte	0x3
 1805 0544 92        		.byte	0x92
 1806 0545 20        		.uleb128 0x20
 1807 0546 03        		.sleb128 3
 1808 0547 01        		.byte	0x1
 1809 0548 E806 0000 		.long	0x6e8
GAS LISTING /tmp/ccfXOBLh.s 			page 41


 1810 054c 22        		.uleb128 0x22
 1811 054d 0000 0000 		.long	.LVL62
 1812 0551 3404 0000 		.long	0x434
 1813 0555 5F05 0000 		.long	0x55f
 1814 0559 13        		.uleb128 0x13
 1815 055a 01        		.byte	0x1
 1816 055b 66        		.byte	0x66
 1817 055c 01        		.byte	0x1
 1818 055d 30        		.byte	0x30
 1819 055e 00        		.byte	0
 1820 055f 22        		.uleb128 0x22
 1821 0560 0000 0000 		.long	.LVL63
 1822 0564 FA02 0000 		.long	0x2fa
 1823 0568 8005 0000 		.long	0x580
 1824 056c 13        		.uleb128 0x13
 1825 056d 06        		.byte	0x6
 1826 056e 66        		.byte	0x66
 1827 056f 93        		.byte	0x93
 1828 0570 01        		.uleb128 0x1
 1829 0571 67        		.byte	0x67
 1830 0572 93        		.byte	0x93
 1831 0573 01        		.uleb128 0x1
 1832 0574 05        		.byte	0x5
 1833 0575 03        		.byte	0x3
 1834 0576 0000 0000 		.long	lcdBuffer
 1835 057a 13        		.uleb128 0x13
 1836 057b 01        		.byte	0x1
 1837 057c 64        		.byte	0x64
 1838 057d 01        		.byte	0x1
 1839 057e 36        		.byte	0x36
 1840 057f 00        		.byte	0
 1841 0580 22        		.uleb128 0x22
 1842 0581 0000 0000 		.long	.LVL64
 1843 0585 190B 0000 		.long	0xb19
 1844 0589 9805 0000 		.long	0x598
 1845 058d 13        		.uleb128 0x13
 1846 058e 06        		.byte	0x6
 1847 058f 68        		.byte	0x68
 1848 0590 93        		.byte	0x93
 1849 0591 01        		.uleb128 0x1
 1850 0592 69        		.byte	0x69
 1851 0593 93        		.byte	0x93
 1852 0594 01        		.uleb128 0x1
 1853 0595 01        		.byte	0x1
 1854 0596 35        		.byte	0x35
 1855 0597 00        		.byte	0
 1856 0598 22        		.uleb128 0x22
 1857 0599 0000 0000 		.long	.LVL65
 1858 059d 3404 0000 		.long	0x434
 1859 05a1 AB05 0000 		.long	0x5ab
 1860 05a5 13        		.uleb128 0x13
 1861 05a6 01        		.byte	0x1
 1862 05a7 66        		.byte	0x66
 1863 05a8 01        		.byte	0x1
 1864 05a9 30        		.byte	0x30
 1865 05aa 00        		.byte	0
 1866 05ab 22        		.uleb128 0x22
GAS LISTING /tmp/ccfXOBLh.s 			page 42


 1867 05ac 0000 0000 		.long	.LVL66
 1868 05b0 FA02 0000 		.long	0x2fa
 1869 05b4 CC05 0000 		.long	0x5cc
 1870 05b8 13        		.uleb128 0x13
 1871 05b9 06        		.byte	0x6
 1872 05ba 66        		.byte	0x66
 1873 05bb 93        		.byte	0x93
 1874 05bc 01        		.uleb128 0x1
 1875 05bd 67        		.byte	0x67
 1876 05be 93        		.byte	0x93
 1877 05bf 01        		.uleb128 0x1
 1878 05c0 05        		.byte	0x5
 1879 05c1 03        		.byte	0x3
 1880 05c2 0000 0000 		.long	lcdBuffer
 1881 05c6 13        		.uleb128 0x13
 1882 05c7 01        		.byte	0x1
 1883 05c8 64        		.byte	0x64
 1884 05c9 01        		.byte	0x1
 1885 05ca 36        		.byte	0x36
 1886 05cb 00        		.byte	0
 1887 05cc 22        		.uleb128 0x22
 1888 05cd 0000 0000 		.long	.LVL67
 1889 05d1 190B 0000 		.long	0xb19
 1890 05d5 E405 0000 		.long	0x5e4
 1891 05d9 13        		.uleb128 0x13
 1892 05da 06        		.byte	0x6
 1893 05db 68        		.byte	0x68
 1894 05dc 93        		.byte	0x93
 1895 05dd 01        		.uleb128 0x1
 1896 05de 69        		.byte	0x69
 1897 05df 93        		.byte	0x93
 1898 05e0 01        		.uleb128 0x1
 1899 05e1 01        		.byte	0x1
 1900 05e2 35        		.byte	0x35
 1901 05e3 00        		.byte	0
 1902 05e4 22        		.uleb128 0x22
 1903 05e5 0000 0000 		.long	.LVL68
 1904 05e9 3404 0000 		.long	0x434
 1905 05ed F705 0000 		.long	0x5f7
 1906 05f1 13        		.uleb128 0x13
 1907 05f2 01        		.byte	0x1
 1908 05f3 66        		.byte	0x66
 1909 05f4 01        		.byte	0x1
 1910 05f5 30        		.byte	0x30
 1911 05f6 00        		.byte	0
 1912 05f7 22        		.uleb128 0x22
 1913 05f8 0000 0000 		.long	.LVL69
 1914 05fc FA02 0000 		.long	0x2fa
 1915 0600 1806 0000 		.long	0x618
 1916 0604 13        		.uleb128 0x13
 1917 0605 06        		.byte	0x6
 1918 0606 66        		.byte	0x66
 1919 0607 93        		.byte	0x93
 1920 0608 01        		.uleb128 0x1
 1921 0609 67        		.byte	0x67
 1922 060a 93        		.byte	0x93
 1923 060b 01        		.uleb128 0x1
GAS LISTING /tmp/ccfXOBLh.s 			page 43


 1924 060c 05        		.byte	0x5
 1925 060d 03        		.byte	0x3
 1926 060e 0000 0000 		.long	lcdBuffer
 1927 0612 13        		.uleb128 0x13
 1928 0613 01        		.byte	0x1
 1929 0614 64        		.byte	0x64
 1930 0615 01        		.byte	0x1
 1931 0616 36        		.byte	0x36
 1932 0617 00        		.byte	0
 1933 0618 22        		.uleb128 0x22
 1934 0619 0000 0000 		.long	.LVL70
 1935 061d 190B 0000 		.long	0xb19
 1936 0621 3006 0000 		.long	0x630
 1937 0625 13        		.uleb128 0x13
 1938 0626 06        		.byte	0x6
 1939 0627 68        		.byte	0x68
 1940 0628 93        		.byte	0x93
 1941 0629 01        		.uleb128 0x1
 1942 062a 69        		.byte	0x69
 1943 062b 93        		.byte	0x93
 1944 062c 01        		.uleb128 0x1
 1945 062d 01        		.byte	0x1
 1946 062e 35        		.byte	0x35
 1947 062f 00        		.byte	0
 1948 0630 22        		.uleb128 0x22
 1949 0631 0000 0000 		.long	.LVL71
 1950 0635 3404 0000 		.long	0x434
 1951 0639 4806 0000 		.long	0x648
 1952 063d 13        		.uleb128 0x13
 1953 063e 01        		.byte	0x1
 1954 063f 68        		.byte	0x68
 1955 0640 01        		.byte	0x1
 1956 0641 31        		.byte	0x31
 1957 0642 13        		.uleb128 0x13
 1958 0643 01        		.byte	0x1
 1959 0644 66        		.byte	0x66
 1960 0645 01        		.byte	0x1
 1961 0646 30        		.byte	0x30
 1962 0647 00        		.byte	0
 1963 0648 22        		.uleb128 0x22
 1964 0649 0000 0000 		.long	.LVL72
 1965 064d FA02 0000 		.long	0x2fa
 1966 0651 6906 0000 		.long	0x669
 1967 0655 13        		.uleb128 0x13
 1968 0656 06        		.byte	0x6
 1969 0657 66        		.byte	0x66
 1970 0658 93        		.byte	0x93
 1971 0659 01        		.uleb128 0x1
 1972 065a 67        		.byte	0x67
 1973 065b 93        		.byte	0x93
 1974 065c 01        		.uleb128 0x1
 1975 065d 05        		.byte	0x5
 1976 065e 03        		.byte	0x3
 1977 065f 0000 0000 		.long	lcdBuffer
 1978 0663 13        		.uleb128 0x13
 1979 0664 01        		.byte	0x1
 1980 0665 64        		.byte	0x64
GAS LISTING /tmp/ccfXOBLh.s 			page 44


 1981 0666 01        		.byte	0x1
 1982 0667 36        		.byte	0x36
 1983 0668 00        		.byte	0
 1984 0669 22        		.uleb128 0x22
 1985 066a 0000 0000 		.long	.LVL73
 1986 066e 190B 0000 		.long	0xb19
 1987 0672 8106 0000 		.long	0x681
 1988 0676 13        		.uleb128 0x13
 1989 0677 06        		.byte	0x6
 1990 0678 68        		.byte	0x68
 1991 0679 93        		.byte	0x93
 1992 067a 01        		.uleb128 0x1
 1993 067b 69        		.byte	0x69
 1994 067c 93        		.byte	0x93
 1995 067d 01        		.uleb128 0x1
 1996 067e 01        		.byte	0x1
 1997 067f 35        		.byte	0x35
 1998 0680 00        		.byte	0
 1999 0681 22        		.uleb128 0x22
 2000 0682 0000 0000 		.long	.LVL74
 2001 0686 190B 0000 		.long	0xb19
 2002 068a 9906 0000 		.long	0x699
 2003 068e 13        		.uleb128 0x13
 2004 068f 06        		.byte	0x6
 2005 0690 68        		.byte	0x68
 2006 0691 93        		.byte	0x93
 2007 0692 01        		.uleb128 0x1
 2008 0693 69        		.byte	0x69
 2009 0694 93        		.byte	0x93
 2010 0695 01        		.uleb128 0x1
 2011 0696 01        		.byte	0x1
 2012 0697 40        		.byte	0x40
 2013 0698 00        		.byte	0
 2014 0699 22        		.uleb128 0x22
 2015 069a 0000 0000 		.long	.LVL75
 2016 069e 3404 0000 		.long	0x434
 2017 06a2 B106 0000 		.long	0x6b1
 2018 06a6 13        		.uleb128 0x13
 2019 06a7 01        		.byte	0x1
 2020 06a8 68        		.byte	0x68
 2021 06a9 01        		.byte	0x1
 2022 06aa 32        		.byte	0x32
 2023 06ab 13        		.uleb128 0x13
 2024 06ac 01        		.byte	0x1
 2025 06ad 66        		.byte	0x66
 2026 06ae 01        		.byte	0x1
 2027 06af 30        		.byte	0x30
 2028 06b0 00        		.byte	0
 2029 06b1 22        		.uleb128 0x22
 2030 06b2 0000 0000 		.long	.LVL76
 2031 06b6 FA02 0000 		.long	0x2fa
 2032 06ba D206 0000 		.long	0x6d2
 2033 06be 13        		.uleb128 0x13
 2034 06bf 06        		.byte	0x6
 2035 06c0 66        		.byte	0x66
 2036 06c1 93        		.byte	0x93
 2037 06c2 01        		.uleb128 0x1
GAS LISTING /tmp/ccfXOBLh.s 			page 45


 2038 06c3 67        		.byte	0x67
 2039 06c4 93        		.byte	0x93
 2040 06c5 01        		.uleb128 0x1
 2041 06c6 05        		.byte	0x5
 2042 06c7 03        		.byte	0x3
 2043 06c8 0000 0000 		.long	lcdBuffer
 2044 06cc 13        		.uleb128 0x13
 2045 06cd 01        		.byte	0x1
 2046 06ce 64        		.byte	0x64
 2047 06cf 01        		.byte	0x1
 2048 06d0 36        		.byte	0x36
 2049 06d1 00        		.byte	0
 2050 06d2 1B        		.uleb128 0x1b
 2051 06d3 0000 0000 		.long	.LVL77
 2052 06d7 01        		.byte	0x1
 2053 06d8 190B 0000 		.long	0xb19
 2054 06dc 13        		.uleb128 0x13
 2055 06dd 06        		.byte	0x6
 2056 06de 68        		.byte	0x68
 2057 06df 93        		.byte	0x93
 2058 06e0 01        		.uleb128 0x1
 2059 06e1 69        		.byte	0x69
 2060 06e2 93        		.byte	0x93
 2061 06e3 01        		.uleb128 0x1
 2062 06e4 01        		.byte	0x1
 2063 06e5 35        		.byte	0x35
 2064 06e6 00        		.byte	0
 2065 06e7 00        		.byte	0
 2066 06e8 1D        		.uleb128 0x1d
 2067 06e9 01        		.byte	0x1
 2068 06ea 0000 0000 		.long	.LASF48
 2069 06ee 02        		.byte	0x2
 2070 06ef 1702      		.word	0x217
 2071 06f1 0000 0000 		.long	.LFB114
 2072 06f5 0000 0000 		.long	.LFE114
 2073 06f9 0000 0000 		.long	.LLST29
 2074 06fd 01        		.byte	0x1
 2075 06fe D008 0000 		.long	0x8d0
 2076 0702 1A        		.uleb128 0x1a
 2077 0703 0000 0000 		.long	.LASF49
 2078 0707 02        		.byte	0x2
 2079 0708 1702      		.word	0x217
 2080 070a 3000 0000 		.long	0x30
 2081 070e 0000 0000 		.long	.LLST30
 2082 0712 1A        		.uleb128 0x1a
 2083 0713 0000 0000 		.long	.LASF50
 2084 0717 02        		.byte	0x2
 2085 0718 1702      		.word	0x217
 2086 071a 3000 0000 		.long	0x30
 2087 071e 0000 0000 		.long	.LLST31
 2088 0722 1A        		.uleb128 0x1a
 2089 0723 0000 0000 		.long	.LASF51
 2090 0727 02        		.byte	0x2
 2091 0728 1702      		.word	0x217
 2092 072a 3000 0000 		.long	0x30
 2093 072e 0000 0000 		.long	.LLST32
 2094 0732 1A        		.uleb128 0x1a
GAS LISTING /tmp/ccfXOBLh.s 			page 46


 2095 0733 0000 0000 		.long	.LASF52
 2096 0737 02        		.byte	0x2
 2097 0738 1702      		.word	0x217
 2098 073a 3000 0000 		.long	0x30
 2099 073e 0000 0000 		.long	.LLST33
 2100 0742 22        		.uleb128 0x22
 2101 0743 0000 0000 		.long	.LVL84
 2102 0747 C901 0000 		.long	0x1c9
 2103 074b 6907 0000 		.long	0x769
 2104 074f 13        		.uleb128 0x13
 2105 0750 0C        		.byte	0xc
 2106 0751 66        		.byte	0x66
 2107 0752 93        		.byte	0x93
 2108 0753 01        		.uleb128 0x1
 2109 0754 67        		.byte	0x67
 2110 0755 93        		.byte	0x93
 2111 0756 01        		.uleb128 0x1
 2112 0757 68        		.byte	0x68
 2113 0758 93        		.byte	0x93
 2114 0759 01        		.uleb128 0x1
 2115 075a 69        		.byte	0x69
 2116 075b 93        		.byte	0x93
 2117 075c 01        		.uleb128 0x1
 2118 075d 05        		.byte	0x5
 2119 075e 0C        		.byte	0xc
 2120 075f A086 0100 		.long	0x186a0
 2121 0763 13        		.uleb128 0x13
 2122 0764 01        		.byte	0x1
 2123 0765 64        		.byte	0x64
 2124 0766 01        		.byte	0x1
 2125 0767 36        		.byte	0x36
 2126 0768 00        		.byte	0
 2127 0769 22        		.uleb128 0x22
 2128 076a 0000 0000 		.long	.LVL85
 2129 076e 3404 0000 		.long	0x434
 2130 0772 8207 0000 		.long	0x782
 2131 0776 13        		.uleb128 0x13
 2132 0777 01        		.byte	0x1
 2133 0778 68        		.byte	0x68
 2134 0779 02        		.byte	0x2
 2135 077a 08        		.byte	0x8
 2136 077b 30        		.byte	0x30
 2137 077c 13        		.uleb128 0x13
 2138 077d 01        		.byte	0x1
 2139 077e 66        		.byte	0x66
 2140 077f 01        		.byte	0x1
 2141 0780 30        		.byte	0x30
 2142 0781 00        		.byte	0
 2143 0782 22        		.uleb128 0x22
 2144 0783 0000 0000 		.long	.LVL86
 2145 0787 190B 0000 		.long	0xb19
 2146 078b 9A07 0000 		.long	0x79a
 2147 078f 13        		.uleb128 0x13
 2148 0790 06        		.byte	0x6
 2149 0791 68        		.byte	0x68
 2150 0792 93        		.byte	0x93
 2151 0793 01        		.uleb128 0x1
GAS LISTING /tmp/ccfXOBLh.s 			page 47


 2152 0794 69        		.byte	0x69
 2153 0795 93        		.byte	0x93
 2154 0796 01        		.uleb128 0x1
 2155 0797 01        		.byte	0x1
 2156 0798 3F        		.byte	0x3f
 2157 0799 00        		.byte	0
 2158 079a 22        		.uleb128 0x22
 2159 079b 0000 0000 		.long	.LVL87
 2160 079f FA02 0000 		.long	0x2fa
 2161 07a3 BB07 0000 		.long	0x7bb
 2162 07a7 13        		.uleb128 0x13
 2163 07a8 06        		.byte	0x6
 2164 07a9 66        		.byte	0x66
 2165 07aa 93        		.byte	0x93
 2166 07ab 01        		.uleb128 0x1
 2167 07ac 67        		.byte	0x67
 2168 07ad 93        		.byte	0x93
 2169 07ae 01        		.uleb128 0x1
 2170 07af 05        		.byte	0x5
 2171 07b0 03        		.byte	0x3
 2172 07b1 0000 0000 		.long	lcdBuffer
 2173 07b5 13        		.uleb128 0x13
 2174 07b6 01        		.byte	0x1
 2175 07b7 64        		.byte	0x64
 2176 07b8 01        		.byte	0x1
 2177 07b9 33        		.byte	0x33
 2178 07ba 00        		.byte	0
 2179 07bb 22        		.uleb128 0x22
 2180 07bc 0000 0000 		.long	.LVL88
 2181 07c0 190B 0000 		.long	0xb19
 2182 07c4 D307 0000 		.long	0x7d3
 2183 07c8 13        		.uleb128 0x13
 2184 07c9 06        		.byte	0x6
 2185 07ca 68        		.byte	0x68
 2186 07cb 93        		.byte	0x93
 2187 07cc 01        		.uleb128 0x1
 2188 07cd 69        		.byte	0x69
 2189 07ce 93        		.byte	0x93
 2190 07cf 01        		.uleb128 0x1
 2191 07d0 01        		.byte	0x1
 2192 07d1 35        		.byte	0x35
 2193 07d2 00        		.byte	0
 2194 07d3 22        		.uleb128 0x22
 2195 07d4 0000 0000 		.long	.LVL89
 2196 07d8 190B 0000 		.long	0xb19
 2197 07dc EB07 0000 		.long	0x7eb
 2198 07e0 13        		.uleb128 0x13
 2199 07e1 06        		.byte	0x6
 2200 07e2 68        		.byte	0x68
 2201 07e3 93        		.byte	0x93
 2202 07e4 01        		.uleb128 0x1
 2203 07e5 69        		.byte	0x69
 2204 07e6 93        		.byte	0x93
 2205 07e7 01        		.uleb128 0x1
 2206 07e8 01        		.byte	0x1
 2207 07e9 35        		.byte	0x35
 2208 07ea 00        		.byte	0
GAS LISTING /tmp/ccfXOBLh.s 			page 48


 2209 07eb 22        		.uleb128 0x22
 2210 07ec 0000 0000 		.long	.LVL90
 2211 07f0 FA02 0000 		.long	0x2fa
 2212 07f4 0C08 0000 		.long	0x80c
 2213 07f8 13        		.uleb128 0x13
 2214 07f9 06        		.byte	0x6
 2215 07fa 66        		.byte	0x66
 2216 07fb 93        		.byte	0x93
 2217 07fc 01        		.uleb128 0x1
 2218 07fd 67        		.byte	0x67
 2219 07fe 93        		.byte	0x93
 2220 07ff 01        		.uleb128 0x1
 2221 0800 05        		.byte	0x5
 2222 0801 03        		.byte	0x3
 2223 0802 0000 0000 		.long	lcdBuffer
 2224 0806 13        		.uleb128 0x13
 2225 0807 01        		.byte	0x1
 2226 0808 64        		.byte	0x64
 2227 0809 01        		.byte	0x1
 2228 080a 33        		.byte	0x33
 2229 080b 00        		.byte	0
 2230 080c 22        		.uleb128 0x22
 2231 080d 0000 0000 		.long	.LVL91
 2232 0811 190B 0000 		.long	0xb19
 2233 0815 2408 0000 		.long	0x824
 2234 0819 13        		.uleb128 0x13
 2235 081a 06        		.byte	0x6
 2236 081b 68        		.byte	0x68
 2237 081c 93        		.byte	0x93
 2238 081d 01        		.uleb128 0x1
 2239 081e 69        		.byte	0x69
 2240 081f 93        		.byte	0x93
 2241 0820 01        		.uleb128 0x1
 2242 0821 01        		.byte	0x1
 2243 0822 35        		.byte	0x35
 2244 0823 00        		.byte	0
 2245 0824 22        		.uleb128 0x22
 2246 0825 0000 0000 		.long	.LVL92
 2247 0829 FA02 0000 		.long	0x2fa
 2248 082d 4508 0000 		.long	0x845
 2249 0831 13        		.uleb128 0x13
 2250 0832 06        		.byte	0x6
 2251 0833 66        		.byte	0x66
 2252 0834 93        		.byte	0x93
 2253 0835 01        		.uleb128 0x1
 2254 0836 67        		.byte	0x67
 2255 0837 93        		.byte	0x93
 2256 0838 01        		.uleb128 0x1
 2257 0839 05        		.byte	0x5
 2258 083a 03        		.byte	0x3
 2259 083b 0000 0000 		.long	lcdBuffer
 2260 083f 13        		.uleb128 0x13
 2261 0840 01        		.byte	0x1
 2262 0841 64        		.byte	0x64
 2263 0842 01        		.byte	0x1
 2264 0843 33        		.byte	0x33
 2265 0844 00        		.byte	0
GAS LISTING /tmp/ccfXOBLh.s 			page 49


 2266 0845 22        		.uleb128 0x22
 2267 0846 0000 0000 		.long	.LVL93
 2268 084a 190B 0000 		.long	0xb19
 2269 084e 5D08 0000 		.long	0x85d
 2270 0852 13        		.uleb128 0x13
 2271 0853 06        		.byte	0x6
 2272 0854 68        		.byte	0x68
 2273 0855 93        		.byte	0x93
 2274 0856 01        		.uleb128 0x1
 2275 0857 69        		.byte	0x69
 2276 0858 93        		.byte	0x93
 2277 0859 01        		.uleb128 0x1
 2278 085a 01        		.byte	0x1
 2279 085b 35        		.byte	0x35
 2280 085c 00        		.byte	0
 2281 085d 22        		.uleb128 0x22
 2282 085e 0000 0000 		.long	.LVL94
 2283 0862 3404 0000 		.long	0x434
 2284 0866 7608 0000 		.long	0x876
 2285 086a 13        		.uleb128 0x13
 2286 086b 01        		.byte	0x1
 2287 086c 68        		.byte	0x68
 2288 086d 02        		.byte	0x2
 2289 086e 08        		.byte	0x8
 2290 086f 20        		.byte	0x20
 2291 0870 13        		.uleb128 0x13
 2292 0871 01        		.byte	0x1
 2293 0872 66        		.byte	0x66
 2294 0873 01        		.byte	0x1
 2295 0874 30        		.byte	0x30
 2296 0875 00        		.byte	0
 2297 0876 22        		.uleb128 0x22
 2298 0877 0000 0000 		.long	.LVL95
 2299 087b FA02 0000 		.long	0x2fa
 2300 087f 9708 0000 		.long	0x897
 2301 0883 13        		.uleb128 0x13
 2302 0884 06        		.byte	0x6
 2303 0885 66        		.byte	0x66
 2304 0886 93        		.byte	0x93
 2305 0887 01        		.uleb128 0x1
 2306 0888 67        		.byte	0x67
 2307 0889 93        		.byte	0x93
 2308 088a 01        		.uleb128 0x1
 2309 088b 05        		.byte	0x5
 2310 088c 03        		.byte	0x3
 2311 088d 0000 0000 		.long	lcdBuffer
 2312 0891 13        		.uleb128 0x13
 2313 0892 01        		.byte	0x1
 2314 0893 64        		.byte	0x64
 2315 0894 01        		.byte	0x1
 2316 0895 33        		.byte	0x33
 2317 0896 00        		.byte	0
 2318 0897 22        		.uleb128 0x22
 2319 0898 0000 0000 		.long	.LVL96
 2320 089c 190B 0000 		.long	0xb19
 2321 08a0 AF08 0000 		.long	0x8af
 2322 08a4 13        		.uleb128 0x13
GAS LISTING /tmp/ccfXOBLh.s 			page 50


 2323 08a5 06        		.byte	0x6
 2324 08a6 68        		.byte	0x68
 2325 08a7 93        		.byte	0x93
 2326 08a8 01        		.uleb128 0x1
 2327 08a9 69        		.byte	0x69
 2328 08aa 93        		.byte	0x93
 2329 08ab 01        		.uleb128 0x1
 2330 08ac 01        		.byte	0x1
 2331 08ad 35        		.byte	0x35
 2332 08ae 00        		.byte	0
 2333 08af 18        		.uleb128 0x18
 2334 08b0 0000 0000 		.long	.LVL97
 2335 08b4 3205 0000 		.long	0x532
 2336 08b8 1B        		.uleb128 0x1b
 2337 08b9 0000 0000 		.long	.LVL99
 2338 08bd 01        		.byte	0x1
 2339 08be 190B 0000 		.long	0xb19
 2340 08c2 13        		.uleb128 0x13
 2341 08c3 06        		.byte	0x6
 2342 08c4 68        		.byte	0x68
 2343 08c5 93        		.byte	0x93
 2344 08c6 01        		.uleb128 0x1
 2345 08c7 69        		.byte	0x69
 2346 08c8 93        		.byte	0x93
 2347 08c9 01        		.uleb128 0x1
 2348 08ca 03        		.byte	0x3
 2349 08cb 0A        		.byte	0xa
 2350 08cc F401      		.word	0x1f4
 2351 08ce 00        		.byte	0
 2352 08cf 00        		.byte	0
 2353 08d0 19        		.uleb128 0x19
 2354 08d1 01        		.byte	0x1
 2355 08d2 0000 0000 		.long	.LASF53
 2356 08d6 02        		.byte	0x2
 2357 08d7 4102      		.word	0x241
 2358 08d9 0000 0000 		.long	.LFB115
 2359 08dd 0000 0000 		.long	.LFE115
 2360 08e1 03        		.byte	0x3
 2361 08e2 92        		.byte	0x92
 2362 08e3 20        		.uleb128 0x20
 2363 08e4 03        		.sleb128 3
 2364 08e5 01        		.byte	0x1
 2365 08e6 4209 0000 		.long	0x942
 2366 08ea 0E        		.uleb128 0xe
 2367 08eb 0000 0000 		.long	.LBB6
 2368 08ef 0000 0000 		.long	.LBE6
 2369 08f3 23        		.uleb128 0x23
 2370 08f4 0000 0000 		.long	.LASF82
 2371 08f8 02        		.byte	0x2
 2372 08f9 4202      		.word	0x242
 2373 08fb 4900 0000 		.long	0x49
 2374 08ff 22        		.uleb128 0x22
 2375 0900 0000 0000 		.long	.LVL100
 2376 0904 E806 0000 		.long	0x6e8
 2377 0908 2209 0000 		.long	0x922
 2378 090c 13        		.uleb128 0x13
 2379 090d 01        		.byte	0x1
GAS LISTING /tmp/ccfXOBLh.s 			page 51


 2380 090e 68        		.byte	0x68
 2381 090f 02        		.byte	0x2
 2382 0910 08        		.byte	0x8
 2383 0911 27        		.byte	0x27
 2384 0912 13        		.uleb128 0x13
 2385 0913 01        		.byte	0x1
 2386 0914 66        		.byte	0x66
 2387 0915 01        		.byte	0x1
 2388 0916 40        		.byte	0x40
 2389 0917 13        		.uleb128 0x13
 2390 0918 01        		.byte	0x1
 2391 0919 64        		.byte	0x64
 2392 091a 01        		.byte	0x1
 2393 091b 32        		.byte	0x32
 2394 091c 13        		.uleb128 0x13
 2395 091d 01        		.byte	0x1
 2396 091e 62        		.byte	0x62
 2397 091f 01        		.byte	0x1
 2398 0920 31        		.byte	0x31
 2399 0921 00        		.byte	0
 2400 0922 1B        		.uleb128 0x1b
 2401 0923 0000 0000 		.long	.LVL101
 2402 0927 01        		.byte	0x1
 2403 0928 8704 0000 		.long	0x487
 2404 092c 13        		.uleb128 0x13
 2405 092d 06        		.byte	0x6
 2406 092e 68        		.byte	0x68
 2407 092f 93        		.byte	0x93
 2408 0930 01        		.uleb128 0x1
 2409 0931 69        		.byte	0x69
 2410 0932 93        		.byte	0x93
 2411 0933 01        		.uleb128 0x1
 2412 0934 05        		.byte	0x5
 2413 0935 03        		.byte	0x3
 2414 0936 0000 0000 		.long	.LC0
 2415 093a 13        		.uleb128 0x13
 2416 093b 01        		.byte	0x1
 2417 093c 66        		.byte	0x66
 2418 093d 01        		.byte	0x1
 2419 093e 3D        		.byte	0x3d
 2420 093f 00        		.byte	0
 2421 0940 00        		.byte	0
 2422 0941 00        		.byte	0
 2423 0942 24        		.uleb128 0x24
 2424 0943 01        		.byte	0x1
 2425 0944 0000 0000 		.long	.LASF83
 2426 0948 02        		.byte	0x2
 2427 0949 4C02      		.word	0x24c
 2428 094b 0000 0000 		.long	.LFB116
 2429 094f 0000 0000 		.long	.LFE116
 2430 0953 03        		.byte	0x3
 2431 0954 92        		.byte	0x92
 2432 0955 20        		.uleb128 0x20
 2433 0956 03        		.sleb128 3
 2434 0957 01        		.byte	0x1
 2435 0958 25        		.uleb128 0x25
 2436 0959 0000 0000 		.long	.LASF54
GAS LISTING /tmp/ccfXOBLh.s 			page 52


 2437 095d 01        		.byte	0x1
 2438 095e 92        		.byte	0x92
 2439 095f 6A09 0000 		.long	0x96a
 2440 0963 01        		.byte	0x1
 2441 0964 05        		.byte	0x5
 2442 0965 03        		.byte	0x3
 2443 0966 0000 0000 		.long	twiMode
 2444 096a 26        		.uleb128 0x26
 2445 096b 3000 0000 		.long	0x30
 2446 096f 25        		.uleb128 0x25
 2447 0970 0000 0000 		.long	.LASF55
 2448 0974 01        		.byte	0x1
 2449 0975 93        		.byte	0x93
 2450 0976 6A09 0000 		.long	0x96a
 2451 097a 01        		.byte	0x1
 2452 097b 05        		.byte	0x5
 2453 097c 03        		.byte	0x3
 2454 097d 0000 0000 		.long	twiState
 2455 0981 25        		.uleb128 0x25
 2456 0982 0000 0000 		.long	.LASF56
 2457 0986 01        		.byte	0x1
 2458 0987 94        		.byte	0x94
 2459 0988 6A09 0000 		.long	0x96a
 2460 098c 01        		.byte	0x1
 2461 098d 05        		.byte	0x5
 2462 098e 03        		.byte	0x3
 2463 098f 0000 0000 		.long	twiSLARW
 2464 0993 25        		.uleb128 0x25
 2465 0994 0000 0000 		.long	.LASF57
 2466 0998 01        		.byte	0x1
 2467 0999 96        		.byte	0x96
 2468 099a 6A09 0000 		.long	0x96a
 2469 099e 01        		.byte	0x1
 2470 099f 05        		.byte	0x5
 2471 09a0 03        		.byte	0x3
 2472 09a1 0000 0000 		.long	twiMT_Count
 2473 09a5 25        		.uleb128 0x25
 2474 09a6 0000 0000 		.long	.LASF58
 2475 09aa 01        		.byte	0x1
 2476 09ab 97        		.byte	0x97
 2477 09ac B709 0000 		.long	0x9b7
 2478 09b0 01        		.byte	0x1
 2479 09b1 05        		.byte	0x5
 2480 09b2 03        		.byte	0x3
 2481 09b3 0000 0000 		.long	twiMT_Ptr
 2482 09b7 05        		.uleb128 0x5
 2483 09b8 02        		.byte	0x2
 2484 09b9 6A09 0000 		.long	0x96a
 2485 09bd 25        		.uleb128 0x25
 2486 09be 0000 0000 		.long	.LASF59
 2487 09c2 01        		.byte	0x1
 2488 09c3 99        		.byte	0x99
 2489 09c4 6A09 0000 		.long	0x96a
 2490 09c8 01        		.byte	0x1
 2491 09c9 05        		.byte	0x5
 2492 09ca 03        		.byte	0x3
 2493 09cb 0000 0000 		.long	twiRX_Count
GAS LISTING /tmp/ccfXOBLh.s 			page 53


 2494 09cf 25        		.uleb128 0x25
 2495 09d0 0000 0000 		.long	.LASF60
 2496 09d4 01        		.byte	0x1
 2497 09d5 9A        		.byte	0x9a
 2498 09d6 B709 0000 		.long	0x9b7
 2499 09da 01        		.byte	0x1
 2500 09db 05        		.byte	0x5
 2501 09dc 03        		.byte	0x3
 2502 09dd 0000 0000 		.long	twiRX_Ptr
 2503 09e1 25        		.uleb128 0x25
 2504 09e2 0000 0000 		.long	.LASF61
 2505 09e6 01        		.byte	0x1
 2506 09e7 9C        		.byte	0x9c
 2507 09e8 6A09 0000 		.long	0x96a
 2508 09ec 01        		.byte	0x1
 2509 09ed 05        		.byte	0x5
 2510 09ee 03        		.byte	0x3
 2511 09ef 0000 0000 		.long	twiST_Count
 2512 09f3 25        		.uleb128 0x25
 2513 09f4 0000 0000 		.long	.LASF62
 2514 09f8 01        		.byte	0x1
 2515 09f9 9D        		.byte	0x9d
 2516 09fa B709 0000 		.long	0x9b7
 2517 09fe 01        		.byte	0x1
 2518 09ff 05        		.byte	0x5
 2519 0a00 03        		.byte	0x3
 2520 0a01 0000 0000 		.long	twiST_Ptr
 2521 0a05 27        		.uleb128 0x27
 2522 0a06 25        		.uleb128 0x25
 2523 0a07 0000 0000 		.long	.LASF63
 2524 0a0b 01        		.byte	0x1
 2525 0a0c 9F        		.byte	0x9f
 2526 0a0d 180A 0000 		.long	0xa18
 2527 0a11 01        		.byte	0x1
 2528 0a12 05        		.byte	0x5
 2529 0a13 03        		.byte	0x3
 2530 0a14 0000 0000 		.long	twiHookRestart
 2531 0a18 05        		.uleb128 0x5
 2532 0a19 02        		.byte	0x2
 2533 0a1a 050A 0000 		.long	0xa05
 2534 0a1e 25        		.uleb128 0x25
 2535 0a1f 0000 0000 		.long	.LASF64
 2536 0a23 01        		.byte	0x1
 2537 0a24 A0        		.byte	0xa0
 2538 0a25 180A 0000 		.long	0xa18
 2539 0a29 01        		.byte	0x1
 2540 0a2a 05        		.byte	0x5
 2541 0a2b 03        		.byte	0x3
 2542 0a2c 0000 0000 		.long	twiMasterReader
 2543 0a30 25        		.uleb128 0x25
 2544 0a31 0000 0000 		.long	.LASF65
 2545 0a35 01        		.byte	0x1
 2546 0a36 A1        		.byte	0xa1
 2547 0a37 180A 0000 		.long	0xa18
 2548 0a3b 01        		.byte	0x1
 2549 0a3c 05        		.byte	0x5
 2550 0a3d 03        		.byte	0x3
GAS LISTING /tmp/ccfXOBLh.s 			page 54


 2551 0a3e 0000 0000 		.long	twiSlaveReader
 2552 0a42 25        		.uleb128 0x25
 2553 0a43 0000 0000 		.long	.LASF66
 2554 0a47 01        		.byte	0x1
 2555 0a48 A2        		.byte	0xa2
 2556 0a49 180A 0000 		.long	0xa18
 2557 0a4d 01        		.byte	0x1
 2558 0a4e 05        		.byte	0x5
 2559 0a4f 03        		.byte	0x3
 2560 0a50 0000 0000 		.long	twiSlaveWriter
 2561 0a54 0F        		.uleb128 0xf
 2562 0a55 0000 0000 		.long	.LASF67
 2563 0a59 01        		.byte	0x1
 2564 0a5a AA        		.byte	0xaa
 2565 0a5b 650A 0000 		.long	0xa65
 2566 0a5f 05        		.byte	0x5
 2567 0a60 03        		.byte	0x3
 2568 0a61 0000 0000 		.long	_ZL12twiStatistic
 2569 0a65 26        		.uleb128 0x26
 2570 0a66 6401 0000 		.long	0x164
 2571 0a6a 28        		.uleb128 0x28
 2572 0a6b 0000 0000 		.long	.LASF68
 2573 0a6f 02        		.byte	0x2
 2574 0a70 DB01      		.word	0x1db
 2575 0a72 3000 0000 		.long	0x30
 2576 0a76 01        		.byte	0x1
 2577 0a77 05        		.byte	0x5
 2578 0a78 03        		.byte	0x3
 2579 0a79 0000 0000 		.long	lcdModes
 2580 0a7d 28        		.uleb128 0x28
 2581 0a7e 0000 0000 		.long	.LASF69
 2582 0a82 02        		.byte	0x2
 2583 0a83 DC01      		.word	0x1dc
 2584 0a85 3000 0000 		.long	0x30
 2585 0a89 01        		.byte	0x1
 2586 0a8a 05        		.byte	0x5
 2587 0a8b 03        		.byte	0x3
 2588 0a8c 0000 0000 		.long	lcdShifts
 2589 0a90 28        		.uleb128 0x28
 2590 0a91 0000 0000 		.long	.LASF70
 2591 0a95 02        		.byte	0x2
 2592 0a96 DD01      		.word	0x1dd
 2593 0a98 3000 0000 		.long	0x30
 2594 0a9c 01        		.byte	0x1
 2595 0a9d 05        		.byte	0x5
 2596 0a9e 03        		.byte	0x3
 2597 0a9f 0000 0000 		.long	lcdShows
 2598 0aa3 28        		.uleb128 0x28
 2599 0aa4 0000 0000 		.long	.LASF71
 2600 0aa8 02        		.byte	0x2
 2601 0aa9 DE01      		.word	0x1de
 2602 0aab 3000 0000 		.long	0x30
 2603 0aaf 01        		.byte	0x1
 2604 0ab0 05        		.byte	0x5
 2605 0ab1 03        		.byte	0x3
 2606 0ab2 0000 0000 		.long	lcdBackLight
 2607 0ab6 28        		.uleb128 0x28
GAS LISTING /tmp/ccfXOBLh.s 			page 55


 2608 0ab7 0000 0000 		.long	.LASF72
 2609 0abb 02        		.byte	0x2
 2610 0abc E001      		.word	0x1e0
 2611 0abe 3000 0000 		.long	0x30
 2612 0ac2 01        		.byte	0x1
 2613 0ac3 05        		.byte	0x5
 2614 0ac4 03        		.byte	0x3
 2615 0ac5 0000 0000 		.long	lcdAddress
 2616 0ac9 28        		.uleb128 0x28
 2617 0aca 0000 0000 		.long	.LASF73
 2618 0ace 02        		.byte	0x2
 2619 0acf E101      		.word	0x1e1
 2620 0ad1 3000 0000 		.long	0x30
 2621 0ad5 01        		.byte	0x1
 2622 0ad6 05        		.byte	0x5
 2623 0ad7 03        		.byte	0x3
 2624 0ad8 0000 0000 		.long	lcdCols
 2625 0adc 28        		.uleb128 0x28
 2626 0add 0000 0000 		.long	.LASF74
 2627 0ae1 02        		.byte	0x2
 2628 0ae2 E201      		.word	0x1e2
 2629 0ae4 3000 0000 		.long	0x30
 2630 0ae8 01        		.byte	0x1
 2631 0ae9 05        		.byte	0x5
 2632 0aea 03        		.byte	0x3
 2633 0aeb 0000 0000 		.long	lcdRows
 2634 0aef 29        		.uleb128 0x29
 2635 0af0 3B00 0000 		.long	0x3b
 2636 0af4 FF0A 0000 		.long	0xaff
 2637 0af8 2A        		.uleb128 0x2a
 2638 0af9 FF0A 0000 		.long	0xaff
 2639 0afd 05        		.byte	0x5
 2640 0afe 00        		.byte	0
 2641 0aff 02        		.uleb128 0x2
 2642 0b00 02        		.byte	0x2
 2643 0b01 07        		.byte	0x7
 2644 0b02 0000 0000 		.long	.LASF75
 2645 0b06 28        		.uleb128 0x28
 2646 0b07 0000 0000 		.long	.LASF76
 2647 0b0b 02        		.byte	0x2
 2648 0b0c E301      		.word	0x1e3
 2649 0b0e EF0A 0000 		.long	0xaef
 2650 0b12 01        		.byte	0x1
 2651 0b13 05        		.byte	0x5
 2652 0b14 03        		.byte	0x3
 2653 0b15 0000 0000 		.long	lcdBuffer
 2654 0b19 2B        		.uleb128 0x2b
 2655 0b1a 01        		.byte	0x1
 2656 0b1b 0000 0000 		.long	.LASF84
 2657 0b1f 04        		.byte	0x4
 2658 0b20 E101      		.word	0x1e1
 2659 0b22 01        		.byte	0x1
 2660 0b23 2C        		.uleb128 0x2c
 2661 0b24 4900 0000 		.long	0x49
 2662 0b28 00        		.byte	0
 2663 0b29 00        		.byte	0
 2664               		.section	.debug_abbrev,"",@progbits
GAS LISTING /tmp/ccfXOBLh.s 			page 56


 2665               	.Ldebug_abbrev0:
 2666 0000 01        		.uleb128 0x1
 2667 0001 11        		.uleb128 0x11
 2668 0002 01        		.byte	0x1
 2669 0003 25        		.uleb128 0x25
 2670 0004 0E        		.uleb128 0xe
 2671 0005 13        		.uleb128 0x13
 2672 0006 0B        		.uleb128 0xb
 2673 0007 03        		.uleb128 0x3
 2674 0008 0E        		.uleb128 0xe
 2675 0009 1B        		.uleb128 0x1b
 2676 000a 0E        		.uleb128 0xe
 2677 000b 55        		.uleb128 0x55
 2678 000c 06        		.uleb128 0x6
 2679 000d 11        		.uleb128 0x11
 2680 000e 01        		.uleb128 0x1
 2681 000f 52        		.uleb128 0x52
 2682 0010 01        		.uleb128 0x1
 2683 0011 10        		.uleb128 0x10
 2684 0012 06        		.uleb128 0x6
 2685 0013 00        		.byte	0
 2686 0014 00        		.byte	0
 2687 0015 02        		.uleb128 0x2
 2688 0016 24        		.uleb128 0x24
 2689 0017 00        		.byte	0
 2690 0018 0B        		.uleb128 0xb
 2691 0019 0B        		.uleb128 0xb
 2692 001a 3E        		.uleb128 0x3e
 2693 001b 0B        		.uleb128 0xb
 2694 001c 03        		.uleb128 0x3
 2695 001d 0E        		.uleb128 0xe
 2696 001e 00        		.byte	0
 2697 001f 00        		.byte	0
 2698 0020 03        		.uleb128 0x3
 2699 0021 16        		.uleb128 0x16
 2700 0022 00        		.byte	0
 2701 0023 03        		.uleb128 0x3
 2702 0024 0E        		.uleb128 0xe
 2703 0025 3A        		.uleb128 0x3a
 2704 0026 0B        		.uleb128 0xb
 2705 0027 3B        		.uleb128 0x3b
 2706 0028 0B        		.uleb128 0xb
 2707 0029 49        		.uleb128 0x49
 2708 002a 13        		.uleb128 0x13
 2709 002b 00        		.byte	0
 2710 002c 00        		.byte	0
 2711 002d 04        		.uleb128 0x4
 2712 002e 24        		.uleb128 0x24
 2713 002f 00        		.byte	0
 2714 0030 0B        		.uleb128 0xb
 2715 0031 0B        		.uleb128 0xb
 2716 0032 3E        		.uleb128 0x3e
 2717 0033 0B        		.uleb128 0xb
 2718 0034 03        		.uleb128 0x3
 2719 0035 08        		.uleb128 0x8
 2720 0036 00        		.byte	0
 2721 0037 00        		.byte	0
GAS LISTING /tmp/ccfXOBLh.s 			page 57


 2722 0038 05        		.uleb128 0x5
 2723 0039 0F        		.uleb128 0xf
 2724 003a 00        		.byte	0
 2725 003b 0B        		.uleb128 0xb
 2726 003c 0B        		.uleb128 0xb
 2727 003d 49        		.uleb128 0x49
 2728 003e 13        		.uleb128 0x13
 2729 003f 00        		.byte	0
 2730 0040 00        		.byte	0
 2731 0041 06        		.uleb128 0x6
 2732 0042 26        		.uleb128 0x26
 2733 0043 00        		.byte	0
 2734 0044 00        		.byte	0
 2735 0045 00        		.byte	0
 2736 0046 07        		.uleb128 0x7
 2737 0047 04        		.uleb128 0x4
 2738 0048 01        		.byte	0x1
 2739 0049 03        		.uleb128 0x3
 2740 004a 0E        		.uleb128 0xe
 2741 004b 0B        		.uleb128 0xb
 2742 004c 0B        		.uleb128 0xb
 2743 004d 3A        		.uleb128 0x3a
 2744 004e 0B        		.uleb128 0xb
 2745 004f 3B        		.uleb128 0x3b
 2746 0050 0B        		.uleb128 0xb
 2747 0051 01        		.uleb128 0x1
 2748 0052 13        		.uleb128 0x13
 2749 0053 00        		.byte	0
 2750 0054 00        		.byte	0
 2751 0055 08        		.uleb128 0x8
 2752 0056 28        		.uleb128 0x28
 2753 0057 00        		.byte	0
 2754 0058 03        		.uleb128 0x3
 2755 0059 0E        		.uleb128 0xe
 2756 005a 1C        		.uleb128 0x1c
 2757 005b 0D        		.uleb128 0xd
 2758 005c 00        		.byte	0
 2759 005d 00        		.byte	0
 2760 005e 09        		.uleb128 0x9
 2761 005f 13        		.uleb128 0x13
 2762 0060 01        		.byte	0x1
 2763 0061 0B        		.uleb128 0xb
 2764 0062 0B        		.uleb128 0xb
 2765 0063 3A        		.uleb128 0x3a
 2766 0064 0B        		.uleb128 0xb
 2767 0065 3B        		.uleb128 0x3b
 2768 0066 0B        		.uleb128 0xb
 2769 0067 8740      		.uleb128 0x2007
 2770 0069 0E        		.uleb128 0xe
 2771 006a 01        		.uleb128 0x1
 2772 006b 13        		.uleb128 0x13
 2773 006c 00        		.byte	0
 2774 006d 00        		.byte	0
 2775 006e 0A        		.uleb128 0xa
 2776 006f 0D        		.uleb128 0xd
 2777 0070 00        		.byte	0
 2778 0071 03        		.uleb128 0x3
GAS LISTING /tmp/ccfXOBLh.s 			page 58


 2779 0072 0E        		.uleb128 0xe
 2780 0073 3A        		.uleb128 0x3a
 2781 0074 0B        		.uleb128 0xb
 2782 0075 3B        		.uleb128 0x3b
 2783 0076 0B        		.uleb128 0xb
 2784 0077 49        		.uleb128 0x49
 2785 0078 13        		.uleb128 0x13
 2786 0079 38        		.uleb128 0x38
 2787 007a 0A        		.uleb128 0xa
 2788 007b 00        		.byte	0
 2789 007c 00        		.byte	0
 2790 007d 0B        		.uleb128 0xb
 2791 007e 0D        		.uleb128 0xd
 2792 007f 00        		.byte	0
 2793 0080 03        		.uleb128 0x3
 2794 0081 08        		.uleb128 0x8
 2795 0082 3A        		.uleb128 0x3a
 2796 0083 0B        		.uleb128 0xb
 2797 0084 3B        		.uleb128 0x3b
 2798 0085 0B        		.uleb128 0xb
 2799 0086 49        		.uleb128 0x49
 2800 0087 13        		.uleb128 0x13
 2801 0088 38        		.uleb128 0x38
 2802 0089 0A        		.uleb128 0xa
 2803 008a 00        		.byte	0
 2804 008b 00        		.byte	0
 2805 008c 0C        		.uleb128 0xc
 2806 008d 2E        		.uleb128 0x2e
 2807 008e 01        		.byte	0x1
 2808 008f 3F        		.uleb128 0x3f
 2809 0090 0C        		.uleb128 0xc
 2810 0091 03        		.uleb128 0x3
 2811 0092 0E        		.uleb128 0xe
 2812 0093 3A        		.uleb128 0x3a
 2813 0094 0B        		.uleb128 0xb
 2814 0095 3B        		.uleb128 0x3b
 2815 0096 0B        		.uleb128 0xb
 2816 0097 11        		.uleb128 0x11
 2817 0098 01        		.uleb128 0x1
 2818 0099 12        		.uleb128 0x12
 2819 009a 01        		.uleb128 0x1
 2820 009b 40        		.uleb128 0x40
 2821 009c 0A        		.uleb128 0xa
 2822 009d 9742      		.uleb128 0x2117
 2823 009f 0C        		.uleb128 0xc
 2824 00a0 01        		.uleb128 0x1
 2825 00a1 13        		.uleb128 0x13
 2826 00a2 00        		.byte	0
 2827 00a3 00        		.byte	0
 2828 00a4 0D        		.uleb128 0xd
 2829 00a5 05        		.uleb128 0x5
 2830 00a6 00        		.byte	0
 2831 00a7 03        		.uleb128 0x3
 2832 00a8 0E        		.uleb128 0xe
 2833 00a9 3A        		.uleb128 0x3a
 2834 00aa 0B        		.uleb128 0xb
 2835 00ab 3B        		.uleb128 0x3b
GAS LISTING /tmp/ccfXOBLh.s 			page 59


 2836 00ac 0B        		.uleb128 0xb
 2837 00ad 49        		.uleb128 0x49
 2838 00ae 13        		.uleb128 0x13
 2839 00af 02        		.uleb128 0x2
 2840 00b0 06        		.uleb128 0x6
 2841 00b1 00        		.byte	0
 2842 00b2 00        		.byte	0
 2843 00b3 0E        		.uleb128 0xe
 2844 00b4 0B        		.uleb128 0xb
 2845 00b5 01        		.byte	0x1
 2846 00b6 11        		.uleb128 0x11
 2847 00b7 01        		.uleb128 0x1
 2848 00b8 12        		.uleb128 0x12
 2849 00b9 01        		.uleb128 0x1
 2850 00ba 00        		.byte	0
 2851 00bb 00        		.byte	0
 2852 00bc 0F        		.uleb128 0xf
 2853 00bd 34        		.uleb128 0x34
 2854 00be 00        		.byte	0
 2855 00bf 03        		.uleb128 0x3
 2856 00c0 0E        		.uleb128 0xe
 2857 00c1 3A        		.uleb128 0x3a
 2858 00c2 0B        		.uleb128 0xb
 2859 00c3 3B        		.uleb128 0x3b
 2860 00c4 0B        		.uleb128 0xb
 2861 00c5 49        		.uleb128 0x49
 2862 00c6 13        		.uleb128 0x13
 2863 00c7 02        		.uleb128 0x2
 2864 00c8 0A        		.uleb128 0xa
 2865 00c9 00        		.byte	0
 2866 00ca 00        		.byte	0
 2867 00cb 10        		.uleb128 0x10
 2868 00cc 34        		.uleb128 0x34
 2869 00cd 00        		.byte	0
 2870 00ce 03        		.uleb128 0x3
 2871 00cf 0E        		.uleb128 0xe
 2872 00d0 3A        		.uleb128 0x3a
 2873 00d1 0B        		.uleb128 0xb
 2874 00d2 3B        		.uleb128 0x3b
 2875 00d3 0B        		.uleb128 0xb
 2876 00d4 49        		.uleb128 0x49
 2877 00d5 13        		.uleb128 0x13
 2878 00d6 02        		.uleb128 0x2
 2879 00d7 06        		.uleb128 0x6
 2880 00d8 00        		.byte	0
 2881 00d9 00        		.byte	0
 2882 00da 11        		.uleb128 0x11
 2883 00db 2E        		.uleb128 0x2e
 2884 00dc 01        		.byte	0x1
 2885 00dd 3F        		.uleb128 0x3f
 2886 00de 0C        		.uleb128 0xc
 2887 00df 03        		.uleb128 0x3
 2888 00e0 0E        		.uleb128 0xe
 2889 00e1 3A        		.uleb128 0x3a
 2890 00e2 0B        		.uleb128 0xb
 2891 00e3 3B        		.uleb128 0x3b
 2892 00e4 0B        		.uleb128 0xb
GAS LISTING /tmp/ccfXOBLh.s 			page 60


 2893 00e5 11        		.uleb128 0x11
 2894 00e6 01        		.uleb128 0x1
 2895 00e7 12        		.uleb128 0x12
 2896 00e8 01        		.uleb128 0x1
 2897 00e9 40        		.uleb128 0x40
 2898 00ea 06        		.uleb128 0x6
 2899 00eb 9742      		.uleb128 0x2117
 2900 00ed 0C        		.uleb128 0xc
 2901 00ee 01        		.uleb128 0x1
 2902 00ef 13        		.uleb128 0x13
 2903 00f0 00        		.byte	0
 2904 00f1 00        		.byte	0
 2905 00f2 12        		.uleb128 0x12
 2906 00f3 8982 01   		.uleb128 0x4109
 2907 00f6 01        		.byte	0x1
 2908 00f7 11        		.uleb128 0x11
 2909 00f8 01        		.uleb128 0x1
 2910 00f9 31        		.uleb128 0x31
 2911 00fa 13        		.uleb128 0x13
 2912 00fb 00        		.byte	0
 2913 00fc 00        		.byte	0
 2914 00fd 13        		.uleb128 0x13
 2915 00fe 8A82 01   		.uleb128 0x410a
 2916 0101 00        		.byte	0
 2917 0102 02        		.uleb128 0x2
 2918 0103 0A        		.uleb128 0xa
 2919 0104 9142      		.uleb128 0x2111
 2920 0106 0A        		.uleb128 0xa
 2921 0107 00        		.byte	0
 2922 0108 00        		.byte	0
 2923 0109 14        		.uleb128 0x14
 2924 010a 2E        		.uleb128 0x2e
 2925 010b 01        		.byte	0x1
 2926 010c 3F        		.uleb128 0x3f
 2927 010d 0C        		.uleb128 0xc
 2928 010e 03        		.uleb128 0x3
 2929 010f 0E        		.uleb128 0xe
 2930 0110 3A        		.uleb128 0x3a
 2931 0111 0B        		.uleb128 0xb
 2932 0112 3B        		.uleb128 0x3b
 2933 0113 0B        		.uleb128 0xb
 2934 0114 11        		.uleb128 0x11
 2935 0115 01        		.uleb128 0x1
 2936 0116 12        		.uleb128 0x12
 2937 0117 01        		.uleb128 0x1
 2938 0118 40        		.uleb128 0x40
 2939 0119 06        		.uleb128 0x6
 2940 011a 9642      		.uleb128 0x2116
 2941 011c 0C        		.uleb128 0xc
 2942 011d 01        		.uleb128 0x1
 2943 011e 13        		.uleb128 0x13
 2944 011f 00        		.byte	0
 2945 0120 00        		.byte	0
 2946 0121 15        		.uleb128 0x15
 2947 0122 05        		.uleb128 0x5
 2948 0123 00        		.byte	0
 2949 0124 03        		.uleb128 0x3
GAS LISTING /tmp/ccfXOBLh.s 			page 61


 2950 0125 08        		.uleb128 0x8
 2951 0126 3A        		.uleb128 0x3a
 2952 0127 0B        		.uleb128 0xb
 2953 0128 3B        		.uleb128 0x3b
 2954 0129 0B        		.uleb128 0xb
 2955 012a 49        		.uleb128 0x49
 2956 012b 13        		.uleb128 0x13
 2957 012c 02        		.uleb128 0x2
 2958 012d 06        		.uleb128 0x6
 2959 012e 00        		.byte	0
 2960 012f 00        		.byte	0
 2961 0130 16        		.uleb128 0x16
 2962 0131 2E        		.uleb128 0x2e
 2963 0132 01        		.byte	0x1
 2964 0133 3F        		.uleb128 0x3f
 2965 0134 0C        		.uleb128 0xc
 2966 0135 03        		.uleb128 0x3
 2967 0136 0E        		.uleb128 0xe
 2968 0137 3A        		.uleb128 0x3a
 2969 0138 0B        		.uleb128 0xb
 2970 0139 3B        		.uleb128 0x3b
 2971 013a 05        		.uleb128 0x5
 2972 013b 11        		.uleb128 0x11
 2973 013c 01        		.uleb128 0x1
 2974 013d 12        		.uleb128 0x12
 2975 013e 01        		.uleb128 0x1
 2976 013f 40        		.uleb128 0x40
 2977 0140 06        		.uleb128 0x6
 2978 0141 9642      		.uleb128 0x2116
 2979 0143 0C        		.uleb128 0xc
 2980 0144 01        		.uleb128 0x1
 2981 0145 13        		.uleb128 0x13
 2982 0146 00        		.byte	0
 2983 0147 00        		.byte	0
 2984 0148 17        		.uleb128 0x17
 2985 0149 34        		.uleb128 0x34
 2986 014a 00        		.byte	0
 2987 014b 03        		.uleb128 0x3
 2988 014c 08        		.uleb128 0x8
 2989 014d 3A        		.uleb128 0x3a
 2990 014e 0B        		.uleb128 0xb
 2991 014f 3B        		.uleb128 0x3b
 2992 0150 05        		.uleb128 0x5
 2993 0151 49        		.uleb128 0x49
 2994 0152 13        		.uleb128 0x13
 2995 0153 02        		.uleb128 0x2
 2996 0154 06        		.uleb128 0x6
 2997 0155 00        		.byte	0
 2998 0156 00        		.byte	0
 2999 0157 18        		.uleb128 0x18
 3000 0158 8982 01   		.uleb128 0x4109
 3001 015b 00        		.byte	0
 3002 015c 11        		.uleb128 0x11
 3003 015d 01        		.uleb128 0x1
 3004 015e 31        		.uleb128 0x31
 3005 015f 13        		.uleb128 0x13
 3006 0160 00        		.byte	0
GAS LISTING /tmp/ccfXOBLh.s 			page 62


 3007 0161 00        		.byte	0
 3008 0162 19        		.uleb128 0x19
 3009 0163 2E        		.uleb128 0x2e
 3010 0164 01        		.byte	0x1
 3011 0165 3F        		.uleb128 0x3f
 3012 0166 0C        		.uleb128 0xc
 3013 0167 03        		.uleb128 0x3
 3014 0168 0E        		.uleb128 0xe
 3015 0169 3A        		.uleb128 0x3a
 3016 016a 0B        		.uleb128 0xb
 3017 016b 3B        		.uleb128 0x3b
 3018 016c 05        		.uleb128 0x5
 3019 016d 11        		.uleb128 0x11
 3020 016e 01        		.uleb128 0x1
 3021 016f 12        		.uleb128 0x12
 3022 0170 01        		.uleb128 0x1
 3023 0171 40        		.uleb128 0x40
 3024 0172 0A        		.uleb128 0xa
 3025 0173 9742      		.uleb128 0x2117
 3026 0175 0C        		.uleb128 0xc
 3027 0176 01        		.uleb128 0x1
 3028 0177 13        		.uleb128 0x13
 3029 0178 00        		.byte	0
 3030 0179 00        		.byte	0
 3031 017a 1A        		.uleb128 0x1a
 3032 017b 05        		.uleb128 0x5
 3033 017c 00        		.byte	0
 3034 017d 03        		.uleb128 0x3
 3035 017e 0E        		.uleb128 0xe
 3036 017f 3A        		.uleb128 0x3a
 3037 0180 0B        		.uleb128 0xb
 3038 0181 3B        		.uleb128 0x3b
 3039 0182 05        		.uleb128 0x5
 3040 0183 49        		.uleb128 0x49
 3041 0184 13        		.uleb128 0x13
 3042 0185 02        		.uleb128 0x2
 3043 0186 06        		.uleb128 0x6
 3044 0187 00        		.byte	0
 3045 0188 00        		.byte	0
 3046 0189 1B        		.uleb128 0x1b
 3047 018a 8982 01   		.uleb128 0x4109
 3048 018d 01        		.byte	0x1
 3049 018e 11        		.uleb128 0x11
 3050 018f 01        		.uleb128 0x1
 3051 0190 9542      		.uleb128 0x2115
 3052 0192 0C        		.uleb128 0xc
 3053 0193 31        		.uleb128 0x31
 3054 0194 13        		.uleb128 0x13
 3055 0195 00        		.byte	0
 3056 0196 00        		.byte	0
 3057 0197 1C        		.uleb128 0x1c
 3058 0198 26        		.uleb128 0x26
 3059 0199 00        		.byte	0
 3060 019a 49        		.uleb128 0x49
 3061 019b 13        		.uleb128 0x13
 3062 019c 00        		.byte	0
 3063 019d 00        		.byte	0
GAS LISTING /tmp/ccfXOBLh.s 			page 63


 3064 019e 1D        		.uleb128 0x1d
 3065 019f 2E        		.uleb128 0x2e
 3066 01a0 01        		.byte	0x1
 3067 01a1 3F        		.uleb128 0x3f
 3068 01a2 0C        		.uleb128 0xc
 3069 01a3 03        		.uleb128 0x3
 3070 01a4 0E        		.uleb128 0xe
 3071 01a5 3A        		.uleb128 0x3a
 3072 01a6 0B        		.uleb128 0xb
 3073 01a7 3B        		.uleb128 0x3b
 3074 01a8 05        		.uleb128 0x5
 3075 01a9 11        		.uleb128 0x11
 3076 01aa 01        		.uleb128 0x1
 3077 01ab 12        		.uleb128 0x12
 3078 01ac 01        		.uleb128 0x1
 3079 01ad 40        		.uleb128 0x40
 3080 01ae 06        		.uleb128 0x6
 3081 01af 9742      		.uleb128 0x2117
 3082 01b1 0C        		.uleb128 0xc
 3083 01b2 01        		.uleb128 0x1
 3084 01b3 13        		.uleb128 0x13
 3085 01b4 00        		.byte	0
 3086 01b5 00        		.byte	0
 3087 01b6 1E        		.uleb128 0x1e
 3088 01b7 05        		.uleb128 0x5
 3089 01b8 00        		.byte	0
 3090 01b9 03        		.uleb128 0x3
 3091 01ba 0E        		.uleb128 0xe
 3092 01bb 3A        		.uleb128 0x3a
 3093 01bc 0B        		.uleb128 0xb
 3094 01bd 3B        		.uleb128 0x3b
 3095 01be 05        		.uleb128 0x5
 3096 01bf 49        		.uleb128 0x49
 3097 01c0 13        		.uleb128 0x13
 3098 01c1 02        		.uleb128 0x2
 3099 01c2 0A        		.uleb128 0xa
 3100 01c3 00        		.byte	0
 3101 01c4 00        		.byte	0
 3102 01c5 1F        		.uleb128 0x1f
 3103 01c6 05        		.uleb128 0x5
 3104 01c7 00        		.byte	0
 3105 01c8 03        		.uleb128 0x3
 3106 01c9 08        		.uleb128 0x8
 3107 01ca 3A        		.uleb128 0x3a
 3108 01cb 0B        		.uleb128 0xb
 3109 01cc 3B        		.uleb128 0x3b
 3110 01cd 05        		.uleb128 0x5
 3111 01ce 49        		.uleb128 0x49
 3112 01cf 13        		.uleb128 0x13
 3113 01d0 02        		.uleb128 0x2
 3114 01d1 0A        		.uleb128 0xa
 3115 01d2 00        		.byte	0
 3116 01d3 00        		.byte	0
 3117 01d4 20        		.uleb128 0x20
 3118 01d5 34        		.uleb128 0x34
 3119 01d6 00        		.byte	0
 3120 01d7 03        		.uleb128 0x3
GAS LISTING /tmp/ccfXOBLh.s 			page 64


 3121 01d8 0E        		.uleb128 0xe
 3122 01d9 3A        		.uleb128 0x3a
 3123 01da 0B        		.uleb128 0xb
 3124 01db 3B        		.uleb128 0x3b
 3125 01dc 05        		.uleb128 0x5
 3126 01dd 49        		.uleb128 0x49
 3127 01de 13        		.uleb128 0x13
 3128 01df 02        		.uleb128 0x2
 3129 01e0 06        		.uleb128 0x6
 3130 01e1 00        		.byte	0
 3131 01e2 00        		.byte	0
 3132 01e3 21        		.uleb128 0x21
 3133 01e4 05        		.uleb128 0x5
 3134 01e5 00        		.byte	0
 3135 01e6 03        		.uleb128 0x3
 3136 01e7 08        		.uleb128 0x8
 3137 01e8 3A        		.uleb128 0x3a
 3138 01e9 0B        		.uleb128 0xb
 3139 01ea 3B        		.uleb128 0x3b
 3140 01eb 05        		.uleb128 0x5
 3141 01ec 49        		.uleb128 0x49
 3142 01ed 13        		.uleb128 0x13
 3143 01ee 02        		.uleb128 0x2
 3144 01ef 06        		.uleb128 0x6
 3145 01f0 00        		.byte	0
 3146 01f1 00        		.byte	0
 3147 01f2 22        		.uleb128 0x22
 3148 01f3 8982 01   		.uleb128 0x4109
 3149 01f6 01        		.byte	0x1
 3150 01f7 11        		.uleb128 0x11
 3151 01f8 01        		.uleb128 0x1
 3152 01f9 31        		.uleb128 0x31
 3153 01fa 13        		.uleb128 0x13
 3154 01fb 01        		.uleb128 0x1
 3155 01fc 13        		.uleb128 0x13
 3156 01fd 00        		.byte	0
 3157 01fe 00        		.byte	0
 3158 01ff 23        		.uleb128 0x23
 3159 0200 34        		.uleb128 0x34
 3160 0201 00        		.byte	0
 3161 0202 03        		.uleb128 0x3
 3162 0203 0E        		.uleb128 0xe
 3163 0204 3A        		.uleb128 0x3a
 3164 0205 0B        		.uleb128 0xb
 3165 0206 3B        		.uleb128 0x3b
 3166 0207 05        		.uleb128 0x5
 3167 0208 49        		.uleb128 0x49
 3168 0209 13        		.uleb128 0x13
 3169 020a 00        		.byte	0
 3170 020b 00        		.byte	0
 3171 020c 24        		.uleb128 0x24
 3172 020d 2E        		.uleb128 0x2e
 3173 020e 00        		.byte	0
 3174 020f 3F        		.uleb128 0x3f
 3175 0210 0C        		.uleb128 0xc
 3176 0211 03        		.uleb128 0x3
 3177 0212 0E        		.uleb128 0xe
GAS LISTING /tmp/ccfXOBLh.s 			page 65


 3178 0213 3A        		.uleb128 0x3a
 3179 0214 0B        		.uleb128 0xb
 3180 0215 3B        		.uleb128 0x3b
 3181 0216 05        		.uleb128 0x5
 3182 0217 11        		.uleb128 0x11
 3183 0218 01        		.uleb128 0x1
 3184 0219 12        		.uleb128 0x12
 3185 021a 01        		.uleb128 0x1
 3186 021b 40        		.uleb128 0x40
 3187 021c 0A        		.uleb128 0xa
 3188 021d 9742      		.uleb128 0x2117
 3189 021f 0C        		.uleb128 0xc
 3190 0220 00        		.byte	0
 3191 0221 00        		.byte	0
 3192 0222 25        		.uleb128 0x25
 3193 0223 34        		.uleb128 0x34
 3194 0224 00        		.byte	0
 3195 0225 03        		.uleb128 0x3
 3196 0226 0E        		.uleb128 0xe
 3197 0227 3A        		.uleb128 0x3a
 3198 0228 0B        		.uleb128 0xb
 3199 0229 3B        		.uleb128 0x3b
 3200 022a 0B        		.uleb128 0xb
 3201 022b 49        		.uleb128 0x49
 3202 022c 13        		.uleb128 0x13
 3203 022d 3F        		.uleb128 0x3f
 3204 022e 0C        		.uleb128 0xc
 3205 022f 02        		.uleb128 0x2
 3206 0230 0A        		.uleb128 0xa
 3207 0231 00        		.byte	0
 3208 0232 00        		.byte	0
 3209 0233 26        		.uleb128 0x26
 3210 0234 35        		.uleb128 0x35
 3211 0235 00        		.byte	0
 3212 0236 49        		.uleb128 0x49
 3213 0237 13        		.uleb128 0x13
 3214 0238 00        		.byte	0
 3215 0239 00        		.byte	0
 3216 023a 27        		.uleb128 0x27
 3217 023b 15        		.uleb128 0x15
 3218 023c 00        		.byte	0
 3219 023d 00        		.byte	0
 3220 023e 00        		.byte	0
 3221 023f 28        		.uleb128 0x28
 3222 0240 34        		.uleb128 0x34
 3223 0241 00        		.byte	0
 3224 0242 03        		.uleb128 0x3
 3225 0243 0E        		.uleb128 0xe
 3226 0244 3A        		.uleb128 0x3a
 3227 0245 0B        		.uleb128 0xb
 3228 0246 3B        		.uleb128 0x3b
 3229 0247 05        		.uleb128 0x5
 3230 0248 49        		.uleb128 0x49
 3231 0249 13        		.uleb128 0x13
 3232 024a 3F        		.uleb128 0x3f
 3233 024b 0C        		.uleb128 0xc
 3234 024c 02        		.uleb128 0x2
GAS LISTING /tmp/ccfXOBLh.s 			page 66


 3235 024d 0A        		.uleb128 0xa
 3236 024e 00        		.byte	0
 3237 024f 00        		.byte	0
 3238 0250 29        		.uleb128 0x29
 3239 0251 01        		.uleb128 0x1
 3240 0252 01        		.byte	0x1
 3241 0253 49        		.uleb128 0x49
 3242 0254 13        		.uleb128 0x13
 3243 0255 01        		.uleb128 0x1
 3244 0256 13        		.uleb128 0x13
 3245 0257 00        		.byte	0
 3246 0258 00        		.byte	0
 3247 0259 2A        		.uleb128 0x2a
 3248 025a 21        		.uleb128 0x21
 3249 025b 00        		.byte	0
 3250 025c 49        		.uleb128 0x49
 3251 025d 13        		.uleb128 0x13
 3252 025e 2F        		.uleb128 0x2f
 3253 025f 0B        		.uleb128 0xb
 3254 0260 00        		.byte	0
 3255 0261 00        		.byte	0
 3256 0262 2B        		.uleb128 0x2b
 3257 0263 2E        		.uleb128 0x2e
 3258 0264 01        		.byte	0x1
 3259 0265 3F        		.uleb128 0x3f
 3260 0266 0C        		.uleb128 0xc
 3261 0267 03        		.uleb128 0x3
 3262 0268 0E        		.uleb128 0xe
 3263 0269 3A        		.uleb128 0x3a
 3264 026a 0B        		.uleb128 0xb
 3265 026b 3B        		.uleb128 0x3b
 3266 026c 05        		.uleb128 0x5
 3267 026d 3C        		.uleb128 0x3c
 3268 026e 0C        		.uleb128 0xc
 3269 026f 00        		.byte	0
 3270 0270 00        		.byte	0
 3271 0271 2C        		.uleb128 0x2c
 3272 0272 05        		.uleb128 0x5
 3273 0273 00        		.byte	0
 3274 0274 49        		.uleb128 0x49
 3275 0275 13        		.uleb128 0x13
 3276 0276 00        		.byte	0
 3277 0277 00        		.byte	0
 3278 0278 00        		.byte	0
 3279               		.section	.debug_loc,"",@progbits
 3280               	.Ldebug_loc0:
 3281               	.LLST0:
 3282 0000 0000 0000 		.long	.LVL0
 3283 0004 0000 0000 		.long	.LVL1
 3284 0008 0C00      		.word	0xc
 3285 000a 66        		.byte	0x66
 3286 000b 93        		.byte	0x93
 3287 000c 01        		.uleb128 0x1
 3288 000d 67        		.byte	0x67
 3289 000e 93        		.byte	0x93
 3290 000f 01        		.uleb128 0x1
 3291 0010 68        		.byte	0x68
GAS LISTING /tmp/ccfXOBLh.s 			page 67


 3292 0011 93        		.byte	0x93
 3293 0012 01        		.uleb128 0x1
 3294 0013 69        		.byte	0x69
 3295 0014 93        		.byte	0x93
 3296 0015 01        		.uleb128 0x1
 3297 0016 0000 0000 		.long	.LVL1
 3298 001a 0000 0000 		.long	.LVL2
 3299 001e 0C00      		.word	0xc
 3300 0020 62        		.byte	0x62
 3301 0021 93        		.byte	0x93
 3302 0022 01        		.uleb128 0x1
 3303 0023 63        		.byte	0x63
 3304 0024 93        		.byte	0x93
 3305 0025 01        		.uleb128 0x1
 3306 0026 64        		.byte	0x64
 3307 0027 93        		.byte	0x93
 3308 0028 01        		.uleb128 0x1
 3309 0029 65        		.byte	0x65
 3310 002a 93        		.byte	0x93
 3311 002b 01        		.uleb128 0x1
 3312 002c 0000 0000 		.long	.LVL2
 3313 0030 0000 0000 		.long	.LFE102
 3314 0034 0400      		.word	0x4
 3315 0036 F3        		.byte	0xf3
 3316 0037 01        		.uleb128 0x1
 3317 0038 66        		.byte	0x66
 3318 0039 9F        		.byte	0x9f
 3319 003a 0000 0000 		.long	0
 3320 003e 0000 0000 		.long	0
 3321               	.LLST1:
 3322 0042 0000 0000 		.long	.LVL3
 3323 0046 0000 0000 		.long	.LVL4
 3324 004a 0200      		.word	0x2
 3325 004c 30        		.byte	0x30
 3326 004d 9F        		.byte	0x9f
 3327 004e 0000 0000 		.long	.LVL4
 3328 0052 0000 0000 		.long	.LFE102
 3329 0056 0100      		.word	0x1
 3330 0058 68        		.byte	0x68
 3331 0059 0000 0000 		.long	0
 3332 005d 0000 0000 		.long	0
 3333               	.LLST2:
 3334 0061 0000 0000 		.long	.LFB103
 3335 0065 0000 0000 		.long	.LCFI0
 3336 0069 0300      		.word	0x3
 3337 006b 92        		.byte	0x92
 3338 006c 20        		.uleb128 0x20
 3339 006d 03        		.sleb128 3
 3340 006e 0000 0000 		.long	.LCFI0
 3341 0072 0000 0000 		.long	.LCFI1
 3342 0076 0300      		.word	0x3
 3343 0078 92        		.byte	0x92
 3344 0079 20        		.uleb128 0x20
 3345 007a 04        		.sleb128 4
 3346 007b 0000 0000 		.long	.LCFI1
 3347 007f 0000 0000 		.long	.LCFI2
 3348 0083 0300      		.word	0x3
GAS LISTING /tmp/ccfXOBLh.s 			page 68


 3349 0085 92        		.byte	0x92
 3350 0086 20        		.uleb128 0x20
 3351 0087 05        		.sleb128 5
 3352 0088 0000 0000 		.long	.LCFI2
 3353 008c 0000 0000 		.long	.LCFI3
 3354 0090 0300      		.word	0x3
 3355 0092 92        		.byte	0x92
 3356 0093 20        		.uleb128 0x20
 3357 0094 06        		.sleb128 6
 3358 0095 0000 0000 		.long	.LCFI3
 3359 0099 0000 0000 		.long	.LFE103
 3360 009d 0200      		.word	0x2
 3361 009f 8C        		.byte	0x8c
 3362 00a0 06        		.sleb128 6
 3363 00a1 0000 0000 		.long	0
 3364 00a5 0000 0000 		.long	0
 3365               	.LLST3:
 3366 00a9 0000 0000 		.long	.LVL9
 3367 00ad 0000 0000 		.long	.LVL10-1
 3368 00b1 0C00      		.word	0xc
 3369 00b3 66        		.byte	0x66
 3370 00b4 93        		.byte	0x93
 3371 00b5 01        		.uleb128 0x1
 3372 00b6 67        		.byte	0x67
 3373 00b7 93        		.byte	0x93
 3374 00b8 01        		.uleb128 0x1
 3375 00b9 68        		.byte	0x68
 3376 00ba 93        		.byte	0x93
 3377 00bb 01        		.uleb128 0x1
 3378 00bc 69        		.byte	0x69
 3379 00bd 93        		.byte	0x93
 3380 00be 01        		.uleb128 0x1
 3381 00bf 0000 0000 		.long	.LVL10-1
 3382 00c3 0000 0000 		.long	.LFE103
 3383 00c7 0400      		.word	0x4
 3384 00c9 F3        		.byte	0xf3
 3385 00ca 01        		.uleb128 0x1
 3386 00cb 66        		.byte	0x66
 3387 00cc 9F        		.byte	0x9f
 3388 00cd 0000 0000 		.long	0
 3389 00d1 0000 0000 		.long	0
 3390               	.LLST4:
 3391 00d5 0000 0000 		.long	.LVL9
 3392 00d9 0000 0000 		.long	.LVL10-1
 3393 00dd 0100      		.word	0x1
 3394 00df 64        		.byte	0x64
 3395 00e0 0000 0000 		.long	.LVL10-1
 3396 00e4 0000 0000 		.long	.LFE103
 3397 00e8 0400      		.word	0x4
 3398 00ea F3        		.byte	0xf3
 3399 00eb 01        		.uleb128 0x1
 3400 00ec 64        		.byte	0x64
 3401 00ed 9F        		.byte	0x9f
 3402 00ee 0000 0000 		.long	0
 3403 00f2 0000 0000 		.long	0
 3404               	.LLST5:
 3405 00f6 0000 0000 		.long	.LFB104
GAS LISTING /tmp/ccfXOBLh.s 			page 69


 3406 00fa 0000 0000 		.long	.LCFI4
 3407 00fe 0300      		.word	0x3
 3408 0100 92        		.byte	0x92
 3409 0101 20        		.uleb128 0x20
 3410 0102 03        		.sleb128 3
 3411 0103 0000 0000 		.long	.LCFI4
 3412 0107 0000 0000 		.long	.LFE104
 3413 010b 0300      		.word	0x3
 3414 010d 92        		.byte	0x92
 3415 010e 20        		.uleb128 0x20
 3416 010f 04        		.sleb128 4
 3417 0110 0000 0000 		.long	0
 3418 0114 0000 0000 		.long	0
 3419               	.LLST6:
 3420 0118 0000 0000 		.long	.LVL11
 3421 011c 0000 0000 		.long	.LVL12
 3422 0120 0100      		.word	0x1
 3423 0122 68        		.byte	0x68
 3424 0123 0000 0000 		.long	.LVL12
 3425 0127 0000 0000 		.long	.LVL13
 3426 012b 0400      		.word	0x4
 3427 012d F3        		.byte	0xf3
 3428 012e 01        		.uleb128 0x1
 3429 012f 68        		.byte	0x68
 3430 0130 9F        		.byte	0x9f
 3431 0131 0000 0000 		.long	.LVL13
 3432 0135 0000 0000 		.long	.LVL14
 3433 0139 0100      		.word	0x1
 3434 013b 68        		.byte	0x68
 3435 013c 0000 0000 		.long	.LVL14
 3436 0140 0000 0000 		.long	.LVL15
 3437 0144 0400      		.word	0x4
 3438 0146 F3        		.byte	0xf3
 3439 0147 01        		.uleb128 0x1
 3440 0148 68        		.byte	0x68
 3441 0149 9F        		.byte	0x9f
 3442 014a 0000 0000 		.long	.LVL15
 3443 014e 0000 0000 		.long	.LVL16-1
 3444 0152 0100      		.word	0x1
 3445 0154 68        		.byte	0x68
 3446 0155 0000 0000 		.long	.LVL16-1
 3447 0159 0000 0000 		.long	.LVL17
 3448 015d 0400      		.word	0x4
 3449 015f F3        		.byte	0xf3
 3450 0160 01        		.uleb128 0x1
 3451 0161 68        		.byte	0x68
 3452 0162 9F        		.byte	0x9f
 3453 0163 0000 0000 		.long	.LVL17
 3454 0167 0000 0000 		.long	.LVL18
 3455 016b 0100      		.word	0x1
 3456 016d 68        		.byte	0x68
 3457 016e 0000 0000 		.long	.LVL18
 3458 0172 0000 0000 		.long	.LFE104
 3459 0176 0400      		.word	0x4
 3460 0178 F3        		.byte	0xf3
 3461 0179 01        		.uleb128 0x1
 3462 017a 68        		.byte	0x68
GAS LISTING /tmp/ccfXOBLh.s 			page 70


 3463 017b 9F        		.byte	0x9f
 3464 017c 0000 0000 		.long	0
 3465 0180 0000 0000 		.long	0
 3466               	.LLST7:
 3467 0184 0000 0000 		.long	.LFB105
 3468 0188 0000 0000 		.long	.LCFI5
 3469 018c 0300      		.word	0x3
 3470 018e 92        		.byte	0x92
 3471 018f 20        		.uleb128 0x20
 3472 0190 03        		.sleb128 3
 3473 0191 0000 0000 		.long	.LCFI5
 3474 0195 0000 0000 		.long	.LCFI6
 3475 0199 0300      		.word	0x3
 3476 019b 92        		.byte	0x92
 3477 019c 20        		.uleb128 0x20
 3478 019d 04        		.sleb128 4
 3479 019e 0000 0000 		.long	.LCFI6
 3480 01a2 0000 0000 		.long	.LCFI7
 3481 01a6 0300      		.word	0x3
 3482 01a8 92        		.byte	0x92
 3483 01a9 20        		.uleb128 0x20
 3484 01aa 05        		.sleb128 5
 3485 01ab 0000 0000 		.long	.LCFI7
 3486 01af 0000 0000 		.long	.LCFI8
 3487 01b3 0300      		.word	0x3
 3488 01b5 92        		.byte	0x92
 3489 01b6 20        		.uleb128 0x20
 3490 01b7 06        		.sleb128 6
 3491 01b8 0000 0000 		.long	.LCFI8
 3492 01bc 0000 0000 		.long	.LCFI9
 3493 01c0 0300      		.word	0x3
 3494 01c2 92        		.byte	0x92
 3495 01c3 20        		.uleb128 0x20
 3496 01c4 07        		.sleb128 7
 3497 01c5 0000 0000 		.long	.LCFI9
 3498 01c9 0000 0000 		.long	.LCFI10
 3499 01cd 0300      		.word	0x3
 3500 01cf 92        		.byte	0x92
 3501 01d0 20        		.uleb128 0x20
 3502 01d1 08        		.sleb128 8
 3503 01d2 0000 0000 		.long	.LCFI10
 3504 01d6 0000 0000 		.long	.LCFI11
 3505 01da 0300      		.word	0x3
 3506 01dc 92        		.byte	0x92
 3507 01dd 20        		.uleb128 0x20
 3508 01de 09        		.sleb128 9
 3509 01df 0000 0000 		.long	.LCFI11
 3510 01e3 0000 0000 		.long	.LCFI12
 3511 01e7 0300      		.word	0x3
 3512 01e9 92        		.byte	0x92
 3513 01ea 20        		.uleb128 0x20
 3514 01eb 0A        		.sleb128 10
 3515 01ec 0000 0000 		.long	.LCFI12
 3516 01f0 0000 0000 		.long	.LCFI13
 3517 01f4 0300      		.word	0x3
 3518 01f6 92        		.byte	0x92
 3519 01f7 20        		.uleb128 0x20
GAS LISTING /tmp/ccfXOBLh.s 			page 71


 3520 01f8 0B        		.sleb128 11
 3521 01f9 0000 0000 		.long	.LCFI13
 3522 01fd 0000 0000 		.long	.LCFI14
 3523 0201 0300      		.word	0x3
 3524 0203 92        		.byte	0x92
 3525 0204 20        		.uleb128 0x20
 3526 0205 0C        		.sleb128 12
 3527 0206 0000 0000 		.long	.LCFI14
 3528 020a 0000 0000 		.long	.LCFI15
 3529 020e 0300      		.word	0x3
 3530 0210 92        		.byte	0x92
 3531 0211 20        		.uleb128 0x20
 3532 0212 0D        		.sleb128 13
 3533 0213 0000 0000 		.long	.LCFI15
 3534 0217 0000 0000 		.long	.LCFI16
 3535 021b 0300      		.word	0x3
 3536 021d 92        		.byte	0x92
 3537 021e 20        		.uleb128 0x20
 3538 021f 0E        		.sleb128 14
 3539 0220 0000 0000 		.long	.LCFI16
 3540 0224 0000 0000 		.long	.LCFI17
 3541 0228 0300      		.word	0x3
 3542 022a 92        		.byte	0x92
 3543 022b 20        		.uleb128 0x20
 3544 022c 0F        		.sleb128 15
 3545 022d 0000 0000 		.long	.LCFI17
 3546 0231 0000 0000 		.long	.LCFI18
 3547 0235 0300      		.word	0x3
 3548 0237 92        		.byte	0x92
 3549 0238 20        		.uleb128 0x20
 3550 0239 10        		.sleb128 16
 3551 023a 0000 0000 		.long	.LCFI18
 3552 023e 0000 0000 		.long	.LFE105
 3553 0242 0300      		.word	0x3
 3554 0244 92        		.byte	0x92
 3555 0245 20        		.uleb128 0x20
 3556 0246 11        		.sleb128 17
 3557 0247 0000 0000 		.long	0
 3558 024b 0000 0000 		.long	0
 3559               	.LLST8:
 3560 024f 0000 0000 		.long	.LVL25
 3561 0253 0000 0000 		.long	.LVL26
 3562 0257 0100      		.word	0x1
 3563 0259 62        		.byte	0x62
 3564 025a 0000 0000 		.long	0
 3565 025e 0000 0000 		.long	0
 3566               	.LLST9:
 3567 0262 0000 0000 		.long	.LVL19
 3568 0266 0000 0000 		.long	.LVL21-1
 3569 026a 0100      		.word	0x1
 3570 026c 63        		.byte	0x63
 3571 026d 0000 0000 		.long	.LVL22
 3572 0271 0000 0000 		.long	.LVL23-1
 3573 0275 0100      		.word	0x1
 3574 0277 68        		.byte	0x68
 3575 0278 0000 0000 		.long	.LVL24
 3576 027c 0000 0000 		.long	.LVL26
GAS LISTING /tmp/ccfXOBLh.s 			page 72


 3577 0280 0100      		.word	0x1
 3578 0282 63        		.byte	0x63
 3579 0283 0000 0000 		.long	0
 3580 0287 0000 0000 		.long	0
 3581               	.LLST10:
 3582 028b 0000 0000 		.long	.LVL20
 3583 028f 0000 0000 		.long	.LVL21-1
 3584 0293 0100      		.word	0x1
 3585 0295 69        		.byte	0x69
 3586 0296 0000 0000 		.long	.LVL24
 3587 029a 0000 0000 		.long	.LVL26
 3588 029e 0100      		.word	0x1
 3589 02a0 69        		.byte	0x69
 3590 02a1 0000 0000 		.long	0
 3591 02a5 0000 0000 		.long	0
 3592               	.LLST11:
 3593 02a9 0000 0000 		.long	.LVL27
 3594 02ad 0000 0000 		.long	.LVL28
 3595 02b1 0100      		.word	0x1
 3596 02b3 68        		.byte	0x68
 3597 02b4 0000 0000 		.long	.LVL28
 3598 02b8 0000 0000 		.long	.LVL29
 3599 02bc 0500      		.word	0x5
 3600 02be 03        		.byte	0x3
 3601 02bf 0000 0000 		.long	twiSLARW
 3602 02c3 0000 0000 		.long	.LVL29
 3603 02c7 0000 0000 		.long	.LFE106
 3604 02cb 0400      		.word	0x4
 3605 02cd F3        		.byte	0xf3
 3606 02ce 01        		.uleb128 0x1
 3607 02cf 68        		.byte	0x68
 3608 02d0 9F        		.byte	0x9f
 3609 02d1 0000 0000 		.long	0
 3610 02d5 0000 0000 		.long	0
 3611               	.LLST12:
 3612 02d9 0000 0000 		.long	.LVL30
 3613 02dd 0000 0000 		.long	.LVL31
 3614 02e1 0100      		.word	0x1
 3615 02e3 68        		.byte	0x68
 3616 02e4 0000 0000 		.long	.LVL31
 3617 02e8 0000 0000 		.long	.LVL32
 3618 02ec 0500      		.word	0x5
 3619 02ee 03        		.byte	0x3
 3620 02ef 0000 0000 		.long	twiSLARW
 3621 02f3 0000 0000 		.long	.LVL32
 3622 02f7 0000 0000 		.long	.LFE107
 3623 02fb 0400      		.word	0x4
 3624 02fd F3        		.byte	0xf3
 3625 02fe 01        		.uleb128 0x1
 3626 02ff 68        		.byte	0x68
 3627 0300 9F        		.byte	0x9f
 3628 0301 0000 0000 		.long	0
 3629 0305 0000 0000 		.long	0
 3630               	.LLST13:
 3631 0309 0000 0000 		.long	.LVL33
 3632 030d 0000 0000 		.long	.LVL34
 3633 0311 0100      		.word	0x1
GAS LISTING /tmp/ccfXOBLh.s 			page 73


 3634 0313 68        		.byte	0x68
 3635 0314 0000 0000 		.long	.LVL34
 3636 0318 0000 0000 		.long	.LFE108
 3637 031c 0400      		.word	0x4
 3638 031e F3        		.byte	0xf3
 3639 031f 01        		.uleb128 0x1
 3640 0320 68        		.byte	0x68
 3641 0321 9F        		.byte	0x9f
 3642 0322 0000 0000 		.long	0
 3643 0326 0000 0000 		.long	0
 3644               	.LLST14:
 3645 032a 0000 0000 		.long	.LVL33
 3646 032e 0000 0000 		.long	.LVL35-1
 3647 0332 0600      		.word	0x6
 3648 0334 66        		.byte	0x66
 3649 0335 93        		.byte	0x93
 3650 0336 01        		.uleb128 0x1
 3651 0337 67        		.byte	0x67
 3652 0338 93        		.byte	0x93
 3653 0339 01        		.uleb128 0x1
 3654 033a 0000 0000 		.long	.LVL35-1
 3655 033e 0000 0000 		.long	.LFE108
 3656 0342 0400      		.word	0x4
 3657 0344 F3        		.byte	0xf3
 3658 0345 01        		.uleb128 0x1
 3659 0346 66        		.byte	0x66
 3660 0347 9F        		.byte	0x9f
 3661 0348 0000 0000 		.long	0
 3662 034c 0000 0000 		.long	0
 3663               	.LLST15:
 3664 0350 0000 0000 		.long	.LVL33
 3665 0354 0000 0000 		.long	.LVL35-1
 3666 0358 0100      		.word	0x1
 3667 035a 64        		.byte	0x64
 3668 035b 0000 0000 		.long	.LVL35-1
 3669 035f 0000 0000 		.long	.LFE108
 3670 0363 0400      		.word	0x4
 3671 0365 F3        		.byte	0xf3
 3672 0366 01        		.uleb128 0x1
 3673 0367 64        		.byte	0x64
 3674 0368 9F        		.byte	0x9f
 3675 0369 0000 0000 		.long	0
 3676 036d 0000 0000 		.long	0
 3677               	.LLST16:
 3678 0371 0000 0000 		.long	.LVL36
 3679 0375 0000 0000 		.long	.LVL37
 3680 0379 0100      		.word	0x1
 3681 037b 68        		.byte	0x68
 3682 037c 0000 0000 		.long	.LVL37
 3683 0380 0000 0000 		.long	.LFE109
 3684 0384 0400      		.word	0x4
 3685 0386 F3        		.byte	0xf3
 3686 0387 01        		.uleb128 0x1
 3687 0388 68        		.byte	0x68
 3688 0389 9F        		.byte	0x9f
 3689 038a 0000 0000 		.long	0
 3690 038e 0000 0000 		.long	0
GAS LISTING /tmp/ccfXOBLh.s 			page 74


 3691               	.LLST17:
 3692 0392 0000 0000 		.long	.LVL36
 3693 0396 0000 0000 		.long	.LVL38-1
 3694 039a 0600      		.word	0x6
 3695 039c 66        		.byte	0x66
 3696 039d 93        		.byte	0x93
 3697 039e 01        		.uleb128 0x1
 3698 039f 67        		.byte	0x67
 3699 03a0 93        		.byte	0x93
 3700 03a1 01        		.uleb128 0x1
 3701 03a2 0000 0000 		.long	.LVL38-1
 3702 03a6 0000 0000 		.long	.LFE109
 3703 03aa 0400      		.word	0x4
 3704 03ac F3        		.byte	0xf3
 3705 03ad 01        		.uleb128 0x1
 3706 03ae 66        		.byte	0x66
 3707 03af 9F        		.byte	0x9f
 3708 03b0 0000 0000 		.long	0
 3709 03b4 0000 0000 		.long	0
 3710               	.LLST18:
 3711 03b8 0000 0000 		.long	.LVL36
 3712 03bc 0000 0000 		.long	.LVL38-1
 3713 03c0 0100      		.word	0x1
 3714 03c2 64        		.byte	0x64
 3715 03c3 0000 0000 		.long	.LVL38-1
 3716 03c7 0000 0000 		.long	.LFE109
 3717 03cb 0400      		.word	0x4
 3718 03cd F3        		.byte	0xf3
 3719 03ce 01        		.uleb128 0x1
 3720 03cf 64        		.byte	0x64
 3721 03d0 9F        		.byte	0x9f
 3722 03d1 0000 0000 		.long	0
 3723 03d5 0000 0000 		.long	0
 3724               	.LLST19:
 3725 03d9 0000 0000 		.long	.LFB110
 3726 03dd 0000 0000 		.long	.LCFI19
 3727 03e1 0300      		.word	0x3
 3728 03e3 92        		.byte	0x92
 3729 03e4 20        		.uleb128 0x20
 3730 03e5 03        		.sleb128 3
 3731 03e6 0000 0000 		.long	.LCFI19
 3732 03ea 0000 0000 		.long	.LFE110
 3733 03ee 0300      		.word	0x3
 3734 03f0 92        		.byte	0x92
 3735 03f1 20        		.uleb128 0x20
 3736 03f2 04        		.sleb128 4
 3737 03f3 0000 0000 		.long	0
 3738 03f7 0000 0000 		.long	0
 3739               	.LLST20:
 3740 03fb 0000 0000 		.long	.LVL39
 3741 03ff 0000 0000 		.long	.LVL40
 3742 0403 0100      		.word	0x1
 3743 0405 68        		.byte	0x68
 3744 0406 0000 0000 		.long	.LVL40
 3745 040a 0000 0000 		.long	.LFE110
 3746 040e 0400      		.word	0x4
 3747 0410 F3        		.byte	0xf3
GAS LISTING /tmp/ccfXOBLh.s 			page 75


 3748 0411 01        		.uleb128 0x1
 3749 0412 68        		.byte	0x68
 3750 0413 9F        		.byte	0x9f
 3751 0414 0000 0000 		.long	0
 3752 0418 0000 0000 		.long	0
 3753               	.LLST21:
 3754 041c 0000 0000 		.long	.LVL39
 3755 0420 0000 0000 		.long	.LVL41
 3756 0424 0100      		.word	0x1
 3757 0426 60        		.byte	0x60
 3758 0427 0000 0000 		.long	.LVL41
 3759 042b 0000 0000 		.long	.LFE110
 3760 042f 0400      		.word	0x4
 3761 0431 F3        		.byte	0xf3
 3762 0432 01        		.uleb128 0x1
 3763 0433 60        		.byte	0x60
 3764 0434 9F        		.byte	0x9f
 3765 0435 0000 0000 		.long	0
 3766 0439 0000 0000 		.long	0
 3767               	.LLST22:
 3768 043d 0000 0000 		.long	.LVL42
 3769 0441 0000 0000 		.long	.LVL47
 3770 0445 0100      		.word	0x1
 3771 0447 68        		.byte	0x68
 3772 0448 0000 0000 		.long	.LVL47
 3773 044c 0000 0000 		.long	.LFE111
 3774 0450 0400      		.word	0x4
 3775 0452 F3        		.byte	0xf3
 3776 0453 01        		.uleb128 0x1
 3777 0454 68        		.byte	0x68
 3778 0455 9F        		.byte	0x9f
 3779 0456 0000 0000 		.long	0
 3780 045a 0000 0000 		.long	0
 3781               	.LLST23:
 3782 045e 0000 0000 		.long	.LVL43
 3783 0462 0000 0000 		.long	.LVL45
 3784 0466 0100      		.word	0x1
 3785 0468 69        		.byte	0x69
 3786 0469 0000 0000 		.long	.LVL45
 3787 046d 0000 0000 		.long	.LVL46
 3788 0471 0500      		.word	0x5
 3789 0473 89        		.byte	0x89
 3790 0474 00        		.sleb128 0
 3791 0475 34        		.byte	0x34
 3792 0476 21        		.byte	0x21
 3793 0477 9F        		.byte	0x9f
 3794 0478 0000 0000 		.long	.LVL46
 3795 047c 0000 0000 		.long	.LVL48
 3796 0480 0100      		.word	0x1
 3797 0482 69        		.byte	0x69
 3798 0483 0000 0000 		.long	.LVL48
 3799 0487 0000 0000 		.long	.LVL50
 3800 048b 0100      		.word	0x1
 3801 048d 68        		.byte	0x68
 3802 048e 0000 0000 		.long	.LVL50
 3803 0492 0000 0000 		.long	.LVL51
 3804 0496 0500      		.word	0x5
GAS LISTING /tmp/ccfXOBLh.s 			page 76


 3805 0498 88        		.byte	0x88
 3806 0499 00        		.sleb128 0
 3807 049a 34        		.byte	0x34
 3808 049b 21        		.byte	0x21
 3809 049c 9F        		.byte	0x9f
 3810 049d 0000 0000 		.long	.LVL51
 3811 04a1 0000 0000 		.long	.LFE111
 3812 04a5 0100      		.word	0x1
 3813 04a7 68        		.byte	0x68
 3814 04a8 0000 0000 		.long	0
 3815 04ac 0000 0000 		.long	0
 3816               	.LLST24:
 3817 04b0 0000 0000 		.long	.LFB112
 3818 04b4 0000 0000 		.long	.LCFI20
 3819 04b8 0300      		.word	0x3
 3820 04ba 92        		.byte	0x92
 3821 04bb 20        		.uleb128 0x20
 3822 04bc 03        		.sleb128 3
 3823 04bd 0000 0000 		.long	.LCFI20
 3824 04c1 0000 0000 		.long	.LCFI21
 3825 04c5 0300      		.word	0x3
 3826 04c7 92        		.byte	0x92
 3827 04c8 20        		.uleb128 0x20
 3828 04c9 04        		.sleb128 4
 3829 04ca 0000 0000 		.long	.LCFI21
 3830 04ce 0000 0000 		.long	.LCFI22
 3831 04d2 0300      		.word	0x3
 3832 04d4 92        		.byte	0x92
 3833 04d5 20        		.uleb128 0x20
 3834 04d6 05        		.sleb128 5
 3835 04d7 0000 0000 		.long	.LCFI22
 3836 04db 0000 0000 		.long	.LFE112
 3837 04df 0300      		.word	0x3
 3838 04e1 92        		.byte	0x92
 3839 04e2 20        		.uleb128 0x20
 3840 04e3 06        		.sleb128 6
 3841 04e4 0000 0000 		.long	0
 3842 04e8 0000 0000 		.long	0
 3843               	.LLST25:
 3844 04ec 0000 0000 		.long	.LVL52
 3845 04f0 0000 0000 		.long	.LVL54
 3846 04f4 0600      		.word	0x6
 3847 04f6 68        		.byte	0x68
 3848 04f7 93        		.byte	0x93
 3849 04f8 01        		.uleb128 0x1
 3850 04f9 69        		.byte	0x69
 3851 04fa 93        		.byte	0x93
 3852 04fb 01        		.uleb128 0x1
 3853 04fc 0000 0000 		.long	.LVL54
 3854 0500 0000 0000 		.long	.LFE112
 3855 0504 0400      		.word	0x4
 3856 0506 F3        		.byte	0xf3
 3857 0507 01        		.uleb128 0x1
 3858 0508 68        		.byte	0x68
 3859 0509 9F        		.byte	0x9f
 3860 050a 0000 0000 		.long	0
 3861 050e 0000 0000 		.long	0
GAS LISTING /tmp/ccfXOBLh.s 			page 77


 3862               	.LLST26:
 3863 0512 0000 0000 		.long	.LVL52
 3864 0516 0000 0000 		.long	.LVL54
 3865 051a 0100      		.word	0x1
 3866 051c 66        		.byte	0x66
 3867 051d 0000 0000 		.long	.LVL54
 3868 0521 0000 0000 		.long	.LFE112
 3869 0525 0400      		.word	0x4
 3870 0527 F3        		.byte	0xf3
 3871 0528 01        		.uleb128 0x1
 3872 0529 66        		.byte	0x66
 3873 052a 9F        		.byte	0x9f
 3874 052b 0000 0000 		.long	0
 3875 052f 0000 0000 		.long	0
 3876               	.LLST27:
 3877 0533 0000 0000 		.long	.LVL53
 3878 0537 0000 0000 		.long	.LVL54
 3879 053b 0600      		.word	0x6
 3880 053d 68        		.byte	0x68
 3881 053e 93        		.byte	0x93
 3882 053f 01        		.uleb128 0x1
 3883 0540 69        		.byte	0x69
 3884 0541 93        		.byte	0x93
 3885 0542 01        		.uleb128 0x1
 3886 0543 0000 0000 		.long	.LVL54
 3887 0547 0000 0000 		.long	.LVL55
 3888 054b 0600      		.word	0x6
 3889 054d 6C        		.byte	0x6c
 3890 054e 93        		.byte	0x93
 3891 054f 01        		.uleb128 0x1
 3892 0550 6D        		.byte	0x6d
 3893 0551 93        		.byte	0x93
 3894 0552 01        		.uleb128 0x1
 3895 0553 0000 0000 		.long	.LVL55
 3896 0557 0000 0000 		.long	.LVL56
 3897 055b 0300      		.word	0x3
 3898 055d 8C        		.byte	0x8c
 3899 055e 01        		.sleb128 1
 3900 055f 9F        		.byte	0x9f
 3901 0560 0000 0000 		.long	.LVL56
 3902 0564 0000 0000 		.long	.LVL61
 3903 0568 0600      		.word	0x6
 3904 056a 6C        		.byte	0x6c
 3905 056b 93        		.byte	0x93
 3906 056c 01        		.uleb128 0x1
 3907 056d 6D        		.byte	0x6d
 3908 056e 93        		.byte	0x93
 3909 056f 01        		.uleb128 0x1
 3910 0570 0000 0000 		.long	0
 3911 0574 0000 0000 		.long	0
 3912               	.LLST28:
 3913 0578 0000 0000 		.long	.LVL53
 3914 057c 0000 0000 		.long	.LVL54
 3915 0580 0100      		.word	0x1
 3916 0582 66        		.byte	0x66
 3917 0583 0000 0000 		.long	.LVL54
 3918 0587 0000 0000 		.long	.LVL56
GAS LISTING /tmp/ccfXOBLh.s 			page 78


 3919 058b 0C00      		.word	0xc
 3920 058d 8C        		.byte	0x8c
 3921 058e 00        		.sleb128 0
 3922 058f 20        		.byte	0x20
 3923 0590 F3        		.byte	0xf3
 3924 0591 01        		.uleb128 0x1
 3925 0592 66        		.byte	0x66
 3926 0593 22        		.byte	0x22
 3927 0594 F3        		.byte	0xf3
 3928 0595 01        		.uleb128 0x1
 3929 0596 68        		.byte	0x68
 3930 0597 22        		.byte	0x22
 3931 0598 9F        		.byte	0x9f
 3932 0599 0000 0000 		.long	.LVL56
 3933 059d 0000 0000 		.long	.LVL60
 3934 05a1 0B00      		.word	0xb
 3935 05a3 F3        		.byte	0xf3
 3936 05a4 01        		.uleb128 0x1
 3937 05a5 66        		.byte	0x66
 3938 05a6 8C        		.byte	0x8c
 3939 05a7 00        		.sleb128 0
 3940 05a8 1C        		.byte	0x1c
 3941 05a9 F3        		.byte	0xf3
 3942 05aa 01        		.uleb128 0x1
 3943 05ab 68        		.byte	0x68
 3944 05ac 22        		.byte	0x22
 3945 05ad 9F        		.byte	0x9f
 3946 05ae 0000 0000 		.long	.LVL60
 3947 05b2 0000 0000 		.long	.LVL61
 3948 05b6 0C00      		.word	0xc
 3949 05b8 8C        		.byte	0x8c
 3950 05b9 00        		.sleb128 0
 3951 05ba 20        		.byte	0x20
 3952 05bb F3        		.byte	0xf3
 3953 05bc 01        		.uleb128 0x1
 3954 05bd 66        		.byte	0x66
 3955 05be 22        		.byte	0x22
 3956 05bf F3        		.byte	0xf3
 3957 05c0 01        		.uleb128 0x1
 3958 05c1 68        		.byte	0x68
 3959 05c2 22        		.byte	0x22
 3960 05c3 9F        		.byte	0x9f
 3961 05c4 0000 0000 		.long	0
 3962 05c8 0000 0000 		.long	0
 3963               	.LLST29:
 3964 05cc 0000 0000 		.long	.LFB114
 3965 05d0 0000 0000 		.long	.LCFI23
 3966 05d4 0300      		.word	0x3
 3967 05d6 92        		.byte	0x92
 3968 05d7 20        		.uleb128 0x20
 3969 05d8 03        		.sleb128 3
 3970 05d9 0000 0000 		.long	.LCFI23
 3971 05dd 0000 0000 		.long	.LFE114
 3972 05e1 0300      		.word	0x3
 3973 05e3 92        		.byte	0x92
 3974 05e4 20        		.uleb128 0x20
 3975 05e5 04        		.sleb128 4
GAS LISTING /tmp/ccfXOBLh.s 			page 79


 3976 05e6 0000 0000 		.long	0
 3977 05ea 0000 0000 		.long	0
 3978               	.LLST30:
 3979 05ee 0000 0000 		.long	.LVL78
 3980 05f2 0000 0000 		.long	.LVL79
 3981 05f6 0100      		.word	0x1
 3982 05f8 68        		.byte	0x68
 3983 05f9 0000 0000 		.long	.LVL79
 3984 05fd 0000 0000 		.long	.LVL80
 3985 0601 0500      		.word	0x5
 3986 0603 03        		.byte	0x3
 3987 0604 0000 0000 		.long	lcdAddress
 3988 0608 0000 0000 		.long	.LVL80
 3989 060c 0000 0000 		.long	.LVL81
 3990 0610 0100      		.word	0x1
 3991 0612 68        		.byte	0x68
 3992 0613 0000 0000 		.long	.LVL81
 3993 0617 0000 0000 		.long	.LVL84-1
 3994 061b 0500      		.word	0x5
 3995 061d 03        		.byte	0x3
 3996 061e 0000 0000 		.long	lcdAddress
 3997 0622 0000 0000 		.long	.LVL84-1
 3998 0626 0000 0000 		.long	.LFE114
 3999 062a 0400      		.word	0x4
 4000 062c F3        		.byte	0xf3
 4001 062d 01        		.uleb128 0x1
 4002 062e 68        		.byte	0x68
 4003 062f 9F        		.byte	0x9f
 4004 0630 0000 0000 		.long	0
 4005 0634 0000 0000 		.long	0
 4006               	.LLST31:
 4007 0638 0000 0000 		.long	.LVL78
 4008 063c 0000 0000 		.long	.LVL83
 4009 0640 0100      		.word	0x1
 4010 0642 66        		.byte	0x66
 4011 0643 0000 0000 		.long	.LVL83
 4012 0647 0000 0000 		.long	.LVL84-1
 4013 064b 0500      		.word	0x5
 4014 064d 03        		.byte	0x3
 4015 064e 0000 0000 		.long	lcdCols
 4016 0652 0000 0000 		.long	.LVL84-1
 4017 0656 0000 0000 		.long	.LFE114
 4018 065a 0400      		.word	0x4
 4019 065c F3        		.byte	0xf3
 4020 065d 01        		.uleb128 0x1
 4021 065e 66        		.byte	0x66
 4022 065f 9F        		.byte	0x9f
 4023 0660 0000 0000 		.long	0
 4024 0664 0000 0000 		.long	0
 4025               	.LLST32:
 4026 0668 0000 0000 		.long	.LVL78
 4027 066c 0000 0000 		.long	.LVL82
 4028 0670 0100      		.word	0x1
 4029 0672 64        		.byte	0x64
 4030 0673 0000 0000 		.long	.LVL82
 4031 0677 0000 0000 		.long	.LVL98
 4032 067b 0100      		.word	0x1
GAS LISTING /tmp/ccfXOBLh.s 			page 80


 4033 067d 6C        		.byte	0x6c
 4034 067e 0000 0000 		.long	.LVL98
 4035 0682 0000 0000 		.long	.LFE114
 4036 0686 0400      		.word	0x4
 4037 0688 F3        		.byte	0xf3
 4038 0689 01        		.uleb128 0x1
 4039 068a 64        		.byte	0x64
 4040 068b 9F        		.byte	0x9f
 4041 068c 0000 0000 		.long	0
 4042 0690 0000 0000 		.long	0
 4043               	.LLST33:
 4044 0694 0000 0000 		.long	.LVL78
 4045 0698 0000 0000 		.long	.LVL84-1
 4046 069c 0100      		.word	0x1
 4047 069e 62        		.byte	0x62
 4048 069f 0000 0000 		.long	.LVL84-1
 4049 06a3 0000 0000 		.long	.LFE114
 4050 06a7 0400      		.word	0x4
 4051 06a9 F3        		.byte	0xf3
 4052 06aa 01        		.uleb128 0x1
 4053 06ab 62        		.byte	0x62
 4054 06ac 9F        		.byte	0x9f
 4055 06ad 0000 0000 		.long	0
 4056 06b1 0000 0000 		.long	0
 4057               		.section	.debug_aranges,"",@progbits
 4058 0000 8C00 0000 		.long	0x8c
 4059 0004 0200      		.word	0x2
 4060 0006 0000 0000 		.long	.Ldebug_info0
 4061 000a 04        		.byte	0x4
 4062 000b 00        		.byte	0
 4063 000c 0000      		.word	0
 4064 000e 0000      		.word	0
 4065 0010 0000 0000 		.long	.LFB102
 4066 0014 4800 0000 		.long	.LFE102-.LFB102
 4067 0018 0000 0000 		.long	.LFB103
 4068 001c 3000 0000 		.long	.LFE103-.LFB103
 4069 0020 0000 0000 		.long	.LFB104
 4070 0024 5800 0000 		.long	.LFE104-.LFB104
 4071 0028 0000 0000 		.long	.LFB105
 4072 002c BC00 0000 		.long	.LFE105-.LFB105
 4073 0030 0000 0000 		.long	.LFB106
 4074 0034 2200 0000 		.long	.LFE106-.LFB106
 4075 0038 0000 0000 		.long	.LFB107
 4076 003c 2200 0000 		.long	.LFE107-.LFB107
 4077 0040 0000 0000 		.long	.LFB108
 4078 0044 2400 0000 		.long	.LFE108-.LFB108
 4079 0048 0000 0000 		.long	.LFB109
 4080 004c 2600 0000 		.long	.LFE109-.LFB109
 4081 0050 0000 0000 		.long	.LFB110
 4082 0054 5A00 0000 		.long	.LFE110-.LFB110
 4083 0058 0000 0000 		.long	.LFB111
 4084 005c 3A00 0000 		.long	.LFE111-.LFB111
 4085 0060 0000 0000 		.long	.LFB112
 4086 0064 4400 0000 		.long	.LFE112-.LFB112
 4087 0068 0000 0000 		.long	.LFB113
 4088 006c A400 0000 		.long	.LFE113-.LFB113
 4089 0070 0000 0000 		.long	.LFB114
GAS LISTING /tmp/ccfXOBLh.s 			page 81


 4090 0074 DA00 0000 		.long	.LFE114-.LFB114
 4091 0078 0000 0000 		.long	.LFB115
 4092 007c 1600 0000 		.long	.LFE115-.LFB115
 4093 0080 0000 0000 		.long	.LFB116
 4094 0084 0200 0000 		.long	.LFE116-.LFB116
 4095 0088 0000 0000 		.long	0
 4096 008c 0000 0000 		.long	0
 4097               		.section	.debug_ranges,"",@progbits
 4098               	.Ldebug_ranges0:
 4099 0000 0000 0000 		.long	.LFB102
 4100 0004 0000 0000 		.long	.LFE102
 4101 0008 0000 0000 		.long	.LFB103
 4102 000c 0000 0000 		.long	.LFE103
 4103 0010 0000 0000 		.long	.LFB104
 4104 0014 0000 0000 		.long	.LFE104
 4105 0018 0000 0000 		.long	.LFB105
 4106 001c 0000 0000 		.long	.LFE105
 4107 0020 0000 0000 		.long	.LFB106
 4108 0024 0000 0000 		.long	.LFE106
 4109 0028 0000 0000 		.long	.LFB107
 4110 002c 0000 0000 		.long	.LFE107
 4111 0030 0000 0000 		.long	.LFB108
 4112 0034 0000 0000 		.long	.LFE108
 4113 0038 0000 0000 		.long	.LFB109
 4114 003c 0000 0000 		.long	.LFE109
 4115 0040 0000 0000 		.long	.LFB110
 4116 0044 0000 0000 		.long	.LFE110
 4117 0048 0000 0000 		.long	.LFB111
 4118 004c 0000 0000 		.long	.LFE111
 4119 0050 0000 0000 		.long	.LFB112
 4120 0054 0000 0000 		.long	.LFE112
 4121 0058 0000 0000 		.long	.LFB113
 4122 005c 0000 0000 		.long	.LFE113
 4123 0060 0000 0000 		.long	.LFB114
 4124 0064 0000 0000 		.long	.LFE114
 4125 0068 0000 0000 		.long	.LFB115
 4126 006c 0000 0000 		.long	.LFE115
 4127 0070 0000 0000 		.long	.LFB116
 4128 0074 0000 0000 		.long	.LFE116
 4129 0078 0000 0000 		.long	0
 4130 007c 0000 0000 		.long	0
 4131               		.section	.debug_line,"",@progbits
 4132               	.Ldebug_line0:
 4133 0000 E402 0000 		.section	.debug_str,"MS",@progbits,1
 4133      0200 B400 
 4133      0000 0201 
 4133      FB0E 0D00 
 4133      0101 0101 
 4134               	.LASF27:
 4135 0000 7477 6953 		.string	"twiSetup"
 4135      6574 7570 
 4135      00
 4136               	.LASF44:
 4137 0009 5F64 6174 		.string	"_data"
 4137      6100 
 4138               	.LASF9:
 4139 000f 6C6F 6E67 		.string	"long long unsigned int"
GAS LISTING /tmp/ccfXOBLh.s 			page 82


 4139      206C 6F6E 
 4139      6720 756E 
 4139      7369 676E 
 4139      6564 2069 
 4140               	.LASF18:
 4141 0026 7374 6172 		.string	"starts"
 4141      7473 00
 4142               	.LASF69:
 4143 002d 6C63 6453 		.string	"lcdShifts"
 4143      6869 6674 
 4143      7300 
 4144               	.LASF59:
 4145 0037 7477 6952 		.string	"twiRX_Count"
 4145      585F 436F 
 4145      756E 7400 
 4146               	.LASF8:
 4147 0043 6C6F 6E67 		.string	"long long int"
 4147      206C 6F6E 
 4147      6720 696E 
 4147      7400 
 4148               	.LASF0:
 4149 0051 7369 676E 		.string	"signed char"
 4149      6564 2063 
 4149      6861 7200 
 4150               	.LASF28:
 4151 005d 6672 6571 		.string	"freq"
 4151      00
 4152               	.LASF20:
 4153 0062 7374 6F70 		.string	"stops"
 4153      7300 
 4154               	.LASF17:
 4155 0068 5457 495F 		.string	"TWI_READY"
 4155      5245 4144 
 4155      5900 
 4156               	.LASF70:
 4157 0072 6C63 6453 		.string	"lcdShows"
 4157      686F 7773 
 4157      00
 4158               	.LASF5:
 4159 007b 6C6F 6E67 		.string	"long int"
 4159      2069 6E74 
 4159      00
 4160               	.LASF31:
 4161 0084 5F5F 7665 		.string	"__vector_39"
 4161      6374 6F72 
 4161      5F33 3900 
 4162               	.LASF67:
 4163 0090 7477 6953 		.string	"twiStatistic"
 4163      7461 7469 
 4163      7374 6963 
 4163      00
 4164               	.LASF3:
 4165 009d 7569 6E74 		.string	"uint16_t"
 4165      3136 5F74 
 4165      00
 4166               	.LASF13:
 4167 00a6 646F 7562 		.string	"double"
GAS LISTING /tmp/ccfXOBLh.s 			page 83


 4167      6C65 00
 4168               	.LASF41:
 4169 00ad 636C 656E 		.string	"clength"
 4169      6774 6800 
 4170               	.LASF66:
 4171 00b5 7477 6953 		.string	"twiSlaveWriter"
 4171      6C61 7665 
 4171      5772 6974 
 4171      6572 00
 4172               	.LASF39:
 4173 00c4 7477 6952 		.string	"twiRAW"
 4173      4157 00
 4174               	.LASF46:
 4175 00cb 6C63 6457 		.string	"lcdWrite"
 4175      7269 7465 
 4175      00
 4176               	.LASF38:
 4177 00d4 7477 6952 		.string	"twiRead"
 4177      6561 6400 
 4178               	.LASF25:
 4179 00dc 6269 744D 		.string	"bitMul"
 4179      756C 00
 4180               	.LASF4:
 4181 00e3 756E 7369 		.string	"unsigned int"
 4181      676E 6564 
 4181      2069 6E74 
 4181      00
 4182               	.LASF72:
 4183 00f0 6C63 6441 		.string	"lcdAddress"
 4183      6464 7265 
 4183      7373 00
 4184               	.LASF60:
 4185 00fb 7477 6952 		.string	"twiRX_Ptr"
 4185      585F 5074 
 4185      7200 
 4186               	.LASF40:
 4187 0105 636F 6D6D 		.string	"command"
 4187      616E 6400 
 4188               	.LASF83:
 4189 010d 6C6F 6F70 		.string	"loop"
 4189      00
 4190               	.LASF48:
 4191 0112 6C63 6453 		.string	"lcdSetup"
 4191      6574 7570 
 4191      00
 4192               	.LASF7:
 4193 011b 6C6F 6E67 		.string	"long unsigned int"
 4193      2075 6E73 
 4193      6967 6E65 
 4193      6420 696E 
 4193      7400 
 4194               	.LASF56:
 4195 012d 7477 6953 		.string	"twiSLARW"
 4195      4C41 5257 
 4195      00
 4196               	.LASF49:
 4197 0136 5F61 6464 		.string	"_address"
GAS LISTING /tmp/ccfXOBLh.s 			page 84


 4197      7265 7373 
 4197      00
 4198               	.LASF36:
 4199 013f 6461 7461 		.string	"data"
 4199      00
 4200               	.LASF14:
 4201 0144 7368 6F72 		.string	"short unsigned int"
 4201      7420 756E 
 4201      7369 676E 
 4201      6564 2069 
 4201      6E74 00
 4202               	.LASF23:
 4203 0157 5457 495F 		.string	"TWI_Stat"
 4203      5374 6174 
 4203      00
 4204               	.LASF51:
 4205 0160 5F72 6F77 		.string	"_rows"
 4205      7300 
 4206               	.LASF10:
 4207 0166 626F 6F6C 		.string	"bool"
 4207      00
 4208               	.LASF54:
 4209 016b 7477 694D 		.string	"twiMode"
 4209      6F64 6500 
 4210               	.LASF64:
 4211 0173 7477 694D 		.string	"twiMasterReader"
 4211      6173 7465 
 4211      7252 6561 
 4211      6465 7200 
 4212               	.LASF80:
 4213 0183 5457 495F 		.string	"TWI_Modes"
 4213      4D6F 6465 
 4213      7300 
 4214               	.LASF57:
 4215 018d 7477 694D 		.string	"twiMT_Count"
 4215      545F 436F 
 4215      756E 7400 
 4216               	.LASF30:
 4217 0199 7477 6953 		.string	"twiSendStop"
 4217      656E 6453 
 4217      746F 7000 
 4218               	.LASF33:
 4219 01a5 6164 6472 		.string	"address"
 4219      6573 7300 
 4220               	.LASF32:
 4221 01ad 5F74 7769 		.string	"_twiStartTo"
 4221      5374 6172 
 4221      7454 6F00 
 4222               	.LASF53:
 4223 01b9 7365 7475 		.string	"setup"
 4223      7000 
 4224               	.LASF12:
 4225 01bf 666C 6F61 		.string	"float"
 4225      7400 
 4226               	.LASF74:
 4227 01c5 6C63 6452 		.string	"lcdRows"
 4227      6F77 7300 
GAS LISTING /tmp/ccfXOBLh.s 			page 85


 4228               	.LASF84:
 4229 01cd 7469 6D65 		.string	"time_delay16"
 4229      5F64 656C 
 4229      6179 3136 
 4229      00
 4230               	.LASF58:
 4231 01da 7477 694D 		.string	"twiMT_Ptr"
 4231      545F 5074 
 4231      7200 
 4232               	.LASF43:
 4233 01e4 6C63 6450 		.string	"lcdPrepare"
 4233      7265 7061 
 4233      7265 00
 4234               	.LASF19:
 4235 01ef 7265 7374 		.string	"restarts"
 4235      6172 7473 
 4235      00
 4236               	.LASF52:
 4237 01f8 5F62 6163 		.string	"_backLight"
 4237      6B4C 6967 
 4237      6874 00
 4238               	.LASF77:
 4239 0203 474E 5520 		.string	"GNU C++ 4.8.1 -mmcu=atmega2560 -g -Os -ffunction-sections -fdata-sections -fno-threadsafe
 4239      432B 2B20 
 4239      342E 382E 
 4239      3120 2D6D 
 4239      6D63 753D 
 4240               	.LASF1:
 4241 0295 756E 7369 		.string	"unsigned char"
 4241      676E 6564 
 4241      2063 6861 
 4241      7200 
 4242               	.LASF50:
 4243 02a3 5F63 6F6C 		.string	"_cols"
 4243      7300 
 4244               	.LASF79:
 4245 02a9 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp"
 4245      2F62 7569 
 4245      6C64 3132 
 4245      3336 3837 
 4245      3935 3737 
 4246               	.LASF24:
 4247 02cb 6269 7452 		.string	"bitRate"
 4247      6174 6500 
 4248               	.LASF55:
 4249 02d3 7477 6953 		.string	"twiState"
 4249      7461 7465 
 4249      00
 4250               	.LASF78:
 4251 02dc 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp/LCD1602ex.cpp"
 4251      2F62 7569 
 4251      6C64 3132 
 4251      3336 3837 
 4251      3935 3737 
 4252               	.LASF6:
 4253 030c 7569 6E74 		.string	"uint32_t"
 4253      3332 5F74 
GAS LISTING /tmp/ccfXOBLh.s 			page 86


 4253      00
 4254               	.LASF76:
 4255 0315 6C63 6442 		.string	"lcdBuffer"
 4255      7566 6665 
 4255      7200 
 4256               	.LASF22:
 4257 031f 6E6F 736C 		.string	"noslarw"
 4257      6172 7700 
 4258               	.LASF37:
 4259 0327 6C65 6E67 		.string	"length"
 4259      7468 00
 4260               	.LASF11:
 4261 032e 6368 6172 		.string	"char"
 4261      00
 4262               	.LASF42:
 4263 0333 646C 656E 		.string	"dlength"
 4263      6774 6800 
 4264               	.LASF29:
 4265 033b 6D6F 6465 		.string	"mode"
 4265      00
 4266               	.LASF73:
 4267 0340 6C63 6443 		.string	"lcdCols"
 4267      6F6C 7300 
 4268               	.LASF21:
 4269 0348 6C6F 7374 		.string	"losts"
 4269      7300 
 4270               	.LASF82:
 4271 034e 7469 6D65 		.string	"time"
 4271      00
 4272               	.LASF26:
 4273 0353 7477 6953 		.string	"twiSpeed"
 4273      7065 6564 
 4273      00
 4274               	.LASF16:
 4275 035c 5457 495F 		.string	"TWI_SEND_STOP"
 4275      5345 4E44 
 4275      5F53 544F 
 4275      5000 
 4276               	.LASF71:
 4277 036a 6C63 6442 		.string	"lcdBackLight"
 4277      6163 6B4C 
 4277      6967 6874 
 4277      00
 4278               	.LASF2:
 4279 0377 7569 6E74 		.string	"uint8_t"
 4279      385F 7400 
 4280               	.LASF81:
 4281 037f 3854 5749 		.string	"8TWI_Stat"
 4281      5F53 7461 
 4281      7400 
 4282               	.LASF75:
 4283 0389 7369 7A65 		.string	"sizetype"
 4283      7479 7065 
 4283      00
 4284               	.LASF47:
 4285 0392 6C63 6449 		.string	"lcdInit"
 4285      6E69 7400 
GAS LISTING /tmp/ccfXOBLh.s 			page 87


 4286               	.LASF65:
 4287 039a 7477 6953 		.string	"twiSlaveReader"
 4287      6C61 7665 
 4287      5265 6164 
 4287      6572 00
 4288               	.LASF63:
 4289 03a9 7477 6948 		.string	"twiHookRestart"
 4289      6F6F 6B52 
 4289      6573 7461 
 4289      7274 00
 4290               	.LASF62:
 4291 03b8 7477 6953 		.string	"twiST_Ptr"
 4291      545F 5074 
 4291      7200 
 4292               	.LASF34:
 4293 03c2 5F74 7769 		.string	"_twiStartRe"
 4293      5374 6172 
 4293      7452 6500 
 4294               	.LASF35:
 4295 03ce 7477 6957 		.string	"twiWrite"
 4295      7269 7465 
 4295      00
 4296               	.LASF68:
 4297 03d7 6C63 644D 		.string	"lcdModes"
 4297      6F64 6573 
 4297      00
 4298               	.LASF45:
 4299 03e0 6E69 6262 		.string	"nibble"
 4299      6C65 00
 4300               	.LASF61:
 4301 03e7 7477 6953 		.string	"twiST_Count"
 4301      545F 436F 
 4301      756E 7400 
 4302               	.LASF15:
 4303 03f3 5457 495F 		.string	"TWI_IS_SLAVE"
 4303      4953 5F53 
 4303      4C41 5645 
 4303      00
 4304               		.ident	"GCC: (GNU) 4.8.1"
 4305               	.global __do_copy_data
 4306               	.global __do_clear_bss
GAS LISTING /tmp/ccfXOBLh.s 			page 88


DEFINED SYMBOLS
                            *ABS*:0000000000000000 LCD1602ex.cpp
     /tmp/ccfXOBLh.s:2      *ABS*:000000000000003e __SP_H__
     /tmp/ccfXOBLh.s:3      *ABS*:000000000000003d __SP_L__
     /tmp/ccfXOBLh.s:4      *ABS*:000000000000003f __SREG__
     /tmp/ccfXOBLh.s:5      *ABS*:000000000000003b __RAMPZ__
     /tmp/ccfXOBLh.s:6      *ABS*:0000000000000000 __tmp_reg__
     /tmp/ccfXOBLh.s:7      *ABS*:0000000000000001 __zero_reg__
     /tmp/ccfXOBLh.s:14     .text.twiSpeed:0000000000000000 twiSpeed
     /tmp/ccfXOBLh.s:84     .text.twiSetup:0000000000000000 twiSetup
     /tmp/ccfXOBLh.s:1140   .bss.twiMode:0000000000000000 twiMode
     /tmp/ccfXOBLh.s:141    .text.twiSendStop:0000000000000000 twiSendStop
     /tmp/ccfXOBLh.s:1086   .bss.twiHookRestart:0000000000000000 twiHookRestart
     /tmp/ccfXOBLh.s:1128   .bss.twiSLARW:0000000000000000 twiSLARW
     /tmp/ccfXOBLh.s:222    .text.__vector_39:0000000000000000 __vector_39
     /tmp/ccfXOBLh.s:1134   .bss.twiState:0000000000000000 twiState
     /tmp/ccfXOBLh.s:1068   .bss.twiSlaveWriter:0000000000000000 twiSlaveWriter
     /tmp/ccfXOBLh.s:1092   .bss.twiST_Ptr:0000000000000000 twiST_Ptr
     /tmp/ccfXOBLh.s:1098   .bss.twiST_Count:0000000000000000 twiST_Count
     /tmp/ccfXOBLh.s:386    .text._twiStartTo:0000000000000000 _twiStartTo
     /tmp/ccfXOBLh.s:421    .text._twiStartRe:0000000000000000 _twiStartRe
     /tmp/ccfXOBLh.s:456    .text.twiWrite:0000000000000000 twiWrite
     /tmp/ccfXOBLh.s:1116   .bss.twiMT_Ptr:0000000000000000 twiMT_Ptr
     /tmp/ccfXOBLh.s:1122   .bss.twiMT_Count:0000000000000000 twiMT_Count
     /tmp/ccfXOBLh.s:489    .text.twiRead:0000000000000000 twiRead
     /tmp/ccfXOBLh.s:1104   .bss.twiRX_Ptr:0000000000000000 twiRX_Ptr
     /tmp/ccfXOBLh.s:1110   .bss.twiRX_Count:0000000000000000 twiRX_Count
     /tmp/ccfXOBLh.s:523    .text.twiRAW:0000000000000000 twiRAW
     /tmp/ccfXOBLh.s:587    .text.lcdPrepare:0000000000000000 lcdPrepare
     /tmp/ccfXOBLh.s:1039   .data.lcdBackLight:0000000000000000 lcdBackLight
     /tmp/ccfXOBLh.s:1015   .bss.lcdBuffer:0000000000000000 lcdBuffer
     /tmp/ccfXOBLh.s:650    .text.lcdWrite:0000000000000000 lcdWrite
     /tmp/ccfXOBLh.s:1033   .data.lcdAddress:0000000000000000 lcdAddress
     /tmp/ccfXOBLh.s:721    .text.lcdInit:0000000000000000 lcdInit
     /tmp/ccfXOBLh.s:1057   .data.lcdModes:0000000000000000 lcdModes
     /tmp/ccfXOBLh.s:1045   .data.lcdShows:0000000000000000 lcdShows
     /tmp/ccfXOBLh.s:1051   .data.lcdShifts:0000000000000000 lcdShifts
     /tmp/ccfXOBLh.s:814    .text.lcdSetup:0000000000000000 lcdSetup
     /tmp/ccfXOBLh.s:1027   .data.lcdCols:0000000000000000 lcdCols
     /tmp/ccfXOBLh.s:1021   .data.lcdRows:0000000000000000 lcdRows
     /tmp/ccfXOBLh.s:970    .text.setup:0000000000000000 setup
     /tmp/ccfXOBLh.s:999    .text.loop:0000000000000000 loop
     /tmp/ccfXOBLh.s:1062   .bss._ZL12twiStatistic:0000000000000000 _ZL12twiStatistic
     /tmp/ccfXOBLh.s:1074   .bss.twiSlaveReader:0000000000000000 twiSlaveReader
     /tmp/ccfXOBLh.s:1080   .bss.twiMasterReader:0000000000000000 twiMasterReader

UNDEFINED SYMBOLS
__udivmodsi4
time_delay16
__do_copy_data
__do_clear_bss
