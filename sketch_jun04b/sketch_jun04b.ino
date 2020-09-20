int vec_sensors[5];

int vec_sensorsBlack[5];

int vec_sensorsWhite[5];

int vec_levels[5];

int _ABVAR_1_MIN_SPEED = 0 ;
int _ABVAR_2_dirMS = 0 ;
int _ABVAR_3_msCount = 0 ;
int _ABVAR_4_oldCount = 0 ;
int _ABVAR_5_oldDirMS = 0 ;
bool _ABVAR_6_isAutoLevel= false ;
int _ABVAR_7_speedLeft = 0 ;
int _ABVAR_8_speedRight = 0 ;
int _ABVAR_9_oldSpeedLeft = 0 ;
int _ABVAR_10_oldSpeedRight = 0 ;
int _ABVAR_11_a;
unsigned long _ABVAR_12_distance = 0UL ;
unsigned long _ABVAR_13_time = 0UL ;
int _ABVAR_14_dCount = 0 ;
int _ABVAR_15_MAX_SPEED = 0 ;
int vec_tblSpeed2[6];

int _ABVAR_16_num = 0 ;
int __ardublockAnalogRead(int pinNumber)
{
  pinMode(pinNumber, INPUT);
  return analogRead(pinNumber);
}


int _ABVAR_17_sum = 0 ;
int _ABVAR_18_count = 0 ;
int _ABVAR_19_ds = 0 ;
int _ABVAR_20_prevDir = 0 ;
int _ABVAR_21_turnDir = 0 ;
int _ABVAR_22_STEP = 0 ;
int _ABVAR_23_MAX_ROTATE = 0 ;
int vec_tblProps[6];

int vec_tblDiffs[6];

int vec_tblTurns[6];

int _ABVAR_24_dir = 0 ;
int _ABVAR_25_speedEx = 0 ;
void __ardublockDigitalWrite(int pinNumber, boolean status)
{
  pinMode(pinNumber, OUTPUT);
  digitalWrite(pinNumber, status);
}

bool _ABVAR_26_isStop= false ;
bool _ABVAR_27_isLeftChange= false ;
bool _ABVAR_28_isRightChange= false ;
int _ABVAR_29_diff = 0 ;
int _ABVAR_30_prop = 0 ;
int vec_D1[100];

int vec_D2[100];

int vec_D3[100];

int vec_D4[100];

int _ABVAR_31_num1 = 0 ;
int _ABVAR_32_a;
int _ABVAR_33_a;
int _ABVAR_34_adc = 0 ;
bool _ABVAR_35_isNotDistance= false ;
int _ABVAR_36_distCount = 0 ;
boolean __ardublockDigitalRead(int pinNumber)
{
  pinMode(pinNumber, INPUT);
  return digitalRead(pinNumber);
}


int _ABVAR_37_turnCount = 0 ;
int _ABVAR_38_MAX_SPEED_D = 0 ;
int _ABVAR_39_MAX_SPEED_DN = 0 ;
int vec_tblSpeedLeft[6];

int vec_tblSpeedRight[6];

int _ABVAR_40_speedIn = 0 ;
int _ABVAR_41_ROTATE = 0 ;
int _ABVAR_42_MAX_SPEED_D2 = 0 ;
int _ABVAR_43_summ = 0 ;

void getSensors();
void stopMotors();
void calcDiff();
void calcDiff1();
void printSpeed();
void calcSpeed1();
void motorsTest();
void calcTurn();
void testCount();
void printMotors();
void calcSpeed4();
void calcSpeed2();
void getSensors2();
void printSensors();
void setupSpeed1();
void check250();
void moveMotors();
void calcDirMS();
void setupSpeed2();
void setupSpeed4();
void calcProp();
void autoLevel();
void setupSensors();
void printDirMS();
void setupSpeed();
void blink();
void printSpeed3();
void getDistance();
void calcDir();
void calcSpeed();
void getSensors3();

void setup()
{
  for (int i=0;i<5;i++) vec_sensors[i]=0;

  for (int i=0;i<5;i++) vec_sensorsBlack[i]=0;

  for (int i=0;i<5;i++) vec_sensorsWhite[i]=0;

  for (int i=0;i<5;i++) vec_levels[i]=0;

  for (int i=0;i<6;i++) vec_tblSpeed2[i]=0;

  Serial.begin(9600);
  for (int i=0;i<6;i++) vec_tblProps[i]=0;

  for (int i=0;i<6;i++) vec_tblDiffs[i]=0;

  for (int i=0;i<6;i++) vec_tblTurns[i]=0;

  for (int i=0;i<100;i++) vec_D1[i]=0;

  for (int i=0;i<100;i++) vec_D2[i]=0;

  for (int i=0;i<100;i++) vec_D3[i]=0;

  for (int i=0;i<100;i++) vec_D4[i]=0;

  for (int i=0;i<6;i++) vec_tblSpeedLeft[i]=0;

  for (int i=0;i<6;i++) vec_tblSpeedRight[i]=0;





  _ABVAR_1_MIN_SPEED = 20 ;

  _ABVAR_2_dirMS = 0 ;

  _ABVAR_3_msCount = 0 ;

  _ABVAR_4_oldCount = 0 ;

  _ABVAR_5_oldDirMS = 0 ;

  _ABVAR_6_isAutoLevel = HIGH ;

  _ABVAR_7_speedLeft = 0 ;

  _ABVAR_8_speedRight = 0 ;

  _ABVAR_9_oldSpeedLeft = 0 ;

  _ABVAR_10_oldSpeedRight = 0 ;

  setupSpeed();

  setupSensors();

  autoLevel();

  for (_ABVAR_11_a=1; _ABVAR_11_a<= ( 6 ); ++_ABVAR_11_a )
  {
    blink();
  }

  _ABVAR_12_distance = 0UL ;

  _ABVAR_13_time = millis() ;

}

void loop()
{
  if (( ( ( millis() - _ABVAR_13_time ) ) >= ( 40UL ) ))
  {
    getDistance();
    _ABVAR_13_time = millis() ;
  }
  else
  {
    delayMicroseconds( 2090 );
  }
  if (( ( _ABVAR_12_distance ) < ( 250UL ) ))
  {
    if (( ( _ABVAR_14_dCount ) > ( 3 ) ))
    {
      stopMotors();
      blink();
    }
    else
    {
      _ABVAR_14_dCount = ( _ABVAR_14_dCount + 1 ) ;
    }
  }
  else
  {
    _ABVAR_14_dCount = 0 ;
    getSensors3();
    calcDirMS();
    calcSpeed();
    moveMotors();
  }
}

void setupSpeed2()
{
  _ABVAR_15_MAX_SPEED = 160 ;
  vec_tblSpeed2[1 - 1] = 0 ;
  vec_tblSpeed2[2 - 1] = -50 ;
  vec_tblSpeed2[3 - 1] = 0 ;
  vec_tblSpeed2[4 - 1] = -35 ;
  vec_tblSpeed2[5 - 1] = 1 ;
  vec_tblSpeed2[6 - 1] = -100 ;
}

void printSpeed()
{
  Serial.print(", speedLeft=");
  Serial.print(" ");
  Serial.print(_ABVAR_7_speedLeft);
  Serial.print(" ");
  Serial.print(", speedRight=");
  Serial.print(" ");
  Serial.print(_ABVAR_8_speedRight);
  Serial.print(" ");
}

void printSensors()
{
  for (_ABVAR_16_num= 1; _ABVAR_16_num<= ( 5 ); _ABVAR_16_num++ )
  {
    Serial.print(", s=");
    Serial.print(" ");
    Serial.print(vec_sensors[_ABVAR_16_num - 1]);
    Serial.print(" ");
    Serial.print(", b");
    Serial.print(" ");
    Serial.print(vec_sensorsBlack[_ABVAR_16_num - 1]);
    Serial.print(" ");
    Serial.print(", w");
    Serial.print(" ");
    Serial.print(vec_sensorsWhite[_ABVAR_16_num - 1]);
    Serial.print(" ");
    Serial.print(", level");
    Serial.print(" ");
    Serial.print(vec_levels[_ABVAR_16_num - 1]);
    Serial.print(" ");
  }
}

void getSensors()
{
  vec_sensors[1 - 1] = __ardublockAnalogRead(0) ;
  vec_sensors[2 - 1] = __ardublockAnalogRead(1) ;
  vec_sensors[3 - 1] = __ardublockAnalogRead(2) ;
  vec_sensors[4 - 1] = __ardublockAnalogRead(4) ;
  vec_sensors[5 - 1] = __ardublockAnalogRead(5) ;
}

void calcDirMS()
{
  _ABVAR_17_sum = 0 ;
  _ABVAR_18_count = 0 ;
  for (_ABVAR_16_num= 1; _ABVAR_16_num<= ( 5 ); _ABVAR_16_num++ )
  {
    _ABVAR_19_ds = 0 ;
    if (( ( vec_sensors[_ABVAR_16_num - 1] ) < ( vec_levels[_ABVAR_16_num - 1] ) ))
    {
      _ABVAR_19_ds = 1 ;
    }
    _ABVAR_17_sum = ( _ABVAR_17_sum + ( _ABVAR_19_ds * ( ( _ABVAR_16_num - 3 ) * 2 ) ) ) ;
    _ABVAR_18_count = ( _ABVAR_18_count + _ABVAR_19_ds ) ;
  }
  _ABVAR_20_prevDir = _ABVAR_2_dirMS ;
  if (( ( _ABVAR_18_count ) > ( 0 ) ))
  {
    if (( ( _ABVAR_18_count ) == ( 5 ) ))
    {
      _ABVAR_2_dirMS = 0 ;
    }
    else
    {
      _ABVAR_2_dirMS = ( _ABVAR_17_sum / _ABVAR_18_count ) ;
    }
  }
  else
  {
    if (( ( _ABVAR_20_prevDir ) != ( 0 ) ))
    {
      if (( ( _ABVAR_20_prevDir ) > ( 0 ) ))
      {
        _ABVAR_2_dirMS = 6 ;
      }
      else
      {
        _ABVAR_2_dirMS = -6 ;
      }
    }
  }
  if (( ( ( ( _ABVAR_20_prevDir ) > ( 0 ) ) && ( ( _ABVAR_2_dirMS ) < ( 0 ) ) ) || ( ( ( _ABVAR_20_prevDir ) < ( 0 ) ) && ( ( _ABVAR_2_dirMS ) > ( 0 ) ) ) ))
  {
    _ABVAR_2_dirMS = 0 ;
  }
  if (( ( _ABVAR_20_prevDir ) == ( _ABVAR_2_dirMS ) ))
  {
    _ABVAR_3_msCount = ( _ABVAR_3_msCount + 1 ) ;
  }
  else
  {
    _ABVAR_5_oldDirMS = _ABVAR_20_prevDir ;
    _ABVAR_4_oldCount = _ABVAR_3_msCount ;
    _ABVAR_3_msCount = 1 ;
  }
  if (( ( _ABVAR_2_dirMS ) == ( 0 ) ))
  {
    _ABVAR_21_turnDir = 2 ;
  }
}

void setupSpeed()
{
  _ABVAR_15_MAX_SPEED = 160 ;
  _ABVAR_22_STEP = 3 ;
  _ABVAR_23_MAX_ROTATE = 220 ;
  vec_tblProps[1 - 1] = 60 ;
  vec_tblProps[2 - 1] = 30 ;
  vec_tblProps[3 - 1] = 15 ;
  vec_tblProps[4 - 1] = 0 ;
  vec_tblProps[5 - 1] = 0 ;
  vec_tblProps[6 - 1] = -60 ;
  vec_tblDiffs[1 - 1] = 35 ;
  vec_tblDiffs[2 - 1] = 30 ;
  vec_tblDiffs[3 - 1] = 25 ;
  vec_tblDiffs[4 - 1] = 20 ;
  vec_tblDiffs[5 - 1] = 15 ;
  vec_tblDiffs[6 - 1] = 15 ;
  vec_tblTurns[1 - 1] = 4 ;
  vec_tblTurns[2 - 1] = 4 ;
  vec_tblTurns[3 - 1] = 4 ;
  vec_tblTurns[4 - 1] = 4 ;
  vec_tblTurns[5 - 1] = 4 ;
  vec_tblTurns[6 - 1] = 4 ;
}

void calcTurn()
{
  if (( ( ( _ABVAR_24_dir ) <= ( 2 ) ) && ( ( _ABVAR_4_oldCount ) > ( 25 ) ) ))
  {
    _ABVAR_21_turnDir = 2 ;
  }
  if (( ( _ABVAR_24_dir ) > ( _ABVAR_21_turnDir ) ))
  {
    _ABVAR_21_turnDir = _ABVAR_24_dir ;
    if (( ( _ABVAR_4_oldCount ) <= ( vec_tblTurns[_ABVAR_24_dir - 1] ) ))
    {
      _ABVAR_25_speedEx = 50 ;
      __ardublockDigitalWrite(2, HIGH);
      __ardublockDigitalWrite(3, HIGH);
    }
  }
}

void moveMotors()
{
  _ABVAR_26_isStop = LOW ;
  _ABVAR_27_isLeftChange = ( ( ( ( _ABVAR_9_oldSpeedLeft ) < ( 0 ) ) && ( ( _ABVAR_7_speedLeft ) >= ( 0 ) ) ) || ( ( ( _ABVAR_9_oldSpeedLeft ) >= ( 0 ) ) && ( ( _ABVAR_7_speedLeft ) < ( 0 ) ) ) ) ;
  _ABVAR_28_isRightChange = ( ( ( ( _ABVAR_10_oldSpeedRight ) < ( 0 ) ) && ( ( _ABVAR_8_speedRight ) >= ( 0 ) ) ) || ( ( ( _ABVAR_10_oldSpeedRight ) >= ( 0 ) ) && ( ( _ABVAR_8_speedRight ) < ( 0 ) ) ) ) ;
  if (( ( ( abs( _ABVAR_7_speedLeft ) ) < ( _ABVAR_1_MIN_SPEED ) ) || _ABVAR_27_isLeftChange ))
  {
    analogWrite(5 , 0);
    _ABVAR_26_isStop = HIGH ;
  }
  if (( ( ( abs( _ABVAR_8_speedRight ) ) < ( _ABVAR_1_MIN_SPEED ) ) || _ABVAR_28_isRightChange ))
  {
    analogWrite(6 , 0);
    _ABVAR_26_isStop = HIGH ;
  }
  if (_ABVAR_26_isStop)
  {
    delayMicroseconds( 6 );
    _ABVAR_26_isStop = LOW ;
  }
  if (_ABVAR_27_isLeftChange)
  {
    if (( ( _ABVAR_7_speedLeft ) >= ( 0 ) ))
    {
      __ardublockDigitalWrite(4, LOW);
    }
    else
    {
      __ardublockDigitalWrite(4, HIGH);
    }
    _ABVAR_26_isStop = HIGH ;
  }
  if (_ABVAR_28_isRightChange)
  {
    if (( ( _ABVAR_8_speedRight ) >= ( 0 ) ))
    {
      __ardublockDigitalWrite(7, LOW);
    }
    else
    {
      __ardublockDigitalWrite(7, HIGH);
    }
    _ABVAR_26_isStop = HIGH ;
  }
  if (_ABVAR_26_isStop)
  {
    delayMicroseconds( 12 );
  }
  if (( ( abs( _ABVAR_7_speedLeft ) ) >= ( _ABVAR_1_MIN_SPEED ) ))
  {
    analogWrite(5 , abs( _ABVAR_7_speedLeft ));
  }
  if (( ( abs( _ABVAR_8_speedRight ) ) >= ( _ABVAR_1_MIN_SPEED ) ))
  {
    analogWrite(6 , abs( _ABVAR_8_speedRight ));
  }
  _ABVAR_9_oldSpeedLeft = ( _ABVAR_7_speedLeft / 2 ) ;
  _ABVAR_10_oldSpeedRight = ( _ABVAR_8_speedRight / 2 ) ;
}

void calcDiff()
{
  if (( ( _ABVAR_2_dirMS ) != ( _ABVAR_20_prevDir ) ))
  {
    _ABVAR_29_diff = 0 ;
    _ABVAR_30_prop = 0 ;
  }
}

void calcDiff1()
{
  if (( ( _ABVAR_2_dirMS ) != ( _ABVAR_20_prevDir ) ))
  {
    _ABVAR_29_diff = ( ( abs( _ABVAR_20_prevDir ) - _ABVAR_24_dir ) * vec_tblDiffs[_ABVAR_24_dir - 1] ) ;
  }
  else
  {
    _ABVAR_29_diff = 0 ;
  }
}

void testCount()
{
  for (_ABVAR_31_num1= 1; _ABVAR_31_num1<= ( 100 ); _ABVAR_31_num1++ )
  {
    getSensors();
    calcDirMS();
    calcSpeed();
    moveMotors();
    delayMicroseconds( 3380 );
    vec_D1[_ABVAR_31_num1 - 1] = _ABVAR_2_dirMS ;
    vec_D2[_ABVAR_31_num1 - 1] = _ABVAR_30_prop ;
    vec_D3[_ABVAR_31_num1 - 1] = _ABVAR_7_speedLeft ;
    vec_D4[_ABVAR_31_num1 - 1] = _ABVAR_8_speedRight ;
  }
  stopMotors();
  for (_ABVAR_16_num= 1; _ABVAR_16_num<= ( 100 ); _ABVAR_16_num++ )
  {
    Serial.print("num=");
    Serial.print(" ");
    Serial.print(_ABVAR_16_num);
    Serial.print(" ");
    Serial.print(", dir=");
    Serial.print(" ");
    Serial.print(vec_D1[_ABVAR_16_num - 1]);
    Serial.print(" ");
    Serial.print(", prop=");
    Serial.print(" ");
    Serial.print(vec_D2[_ABVAR_16_num - 1]);
    Serial.print(" ");
    Serial.print(", SL=");
    Serial.print(" ");
    Serial.print(vec_D3[_ABVAR_16_num - 1]);
    Serial.print(" ");
    Serial.print(", SR=");
    Serial.print(" ");
    Serial.print(vec_D4[_ABVAR_16_num - 1]);
    Serial.print(" ");
    Serial.println();
  }
}

void motorsTest()
{
  delay( 1000 );
  _ABVAR_7_speedLeft = -170 ;
  _ABVAR_8_speedRight = 170 ;
  moveMotors();
  printMotors();
  delay( 4000 );
  _ABVAR_7_speedLeft = 100 ;
  _ABVAR_8_speedRight = -100 ;
  moveMotors();
  printMotors();
  delay( 4 );
  _ABVAR_7_speedLeft = 0 ;
  _ABVAR_8_speedRight = 0 ;
  moveMotors();
  printMotors();
  delay( 1000 );
  _ABVAR_7_speedLeft = 170 ;
  _ABVAR_8_speedRight = -170 ;
  moveMotors();
  printMotors();
  delay( 4000 );
  _ABVAR_7_speedLeft = 0 ;
  _ABVAR_8_speedRight = 0 ;
  moveMotors();
  printMotors();
  delay( 4000 );
}

void autoLevel()
{
  for (_ABVAR_32_a=1; _ABVAR_32_a<= ( 10 ); ++_ABVAR_32_a )
  {
    __ardublockDigitalWrite(13, HIGH);
    check250();
    __ardublockDigitalWrite(13, LOW);
    check250();
    _ABVAR_6_isAutoLevel = LOW ;
  }
}

void stopMotors()
{
  if (( ( abs( _ABVAR_7_speedLeft ) ) >= ( _ABVAR_1_MIN_SPEED ) ))
  {
    if (( ( _ABVAR_7_speedLeft ) > ( 0 ) ))
    {
      _ABVAR_7_speedLeft = -100 ;
    }
    else
    {
      _ABVAR_7_speedLeft = 100 ;
    }
  }
  if (( ( abs( _ABVAR_8_speedRight ) ) >= ( _ABVAR_1_MIN_SPEED ) ))
  {
    if (( ( _ABVAR_8_speedRight ) > ( 0 ) ))
    {
      _ABVAR_8_speedRight = -100 ;
    }
    else
    {
      _ABVAR_8_speedRight = 100 ;
    }
  }
  moveMotors();
  delay( 20 );
  _ABVAR_7_speedLeft = 0 ;
  _ABVAR_8_speedRight = 0 ;
  moveMotors();
}

void printMotors()
{
  Serial.print(":");
  Serial.println();
  Serial.print(", Ol=");
  Serial.print(" ");
  Serial.print(_ABVAR_9_oldSpeedLeft);
  Serial.print(" ");
  Serial.print(", Or=");
  Serial.print(" ");
  Serial.print(_ABVAR_10_oldSpeedRight);
  Serial.print(" ");
  Serial.print(", isLC=");
  Serial.print(" ");
  Serial.print(_ABVAR_27_isLeftChange);
  Serial.print(" ");
  Serial.print(", isRC=");
  Serial.print(" ");
  Serial.print(_ABVAR_28_isRightChange);
  Serial.print(" ");
  Serial.print(", sl=");
  Serial.print(" ");
  Serial.print(_ABVAR_7_speedLeft);
  Serial.print(" ");
  Serial.print(", sr=");
  Serial.print(" ");
  Serial.print(_ABVAR_8_speedRight);
  Serial.print(" ");
}

void getSensors3()
{
  for (_ABVAR_33_a=1; _ABVAR_33_a<= ( 3 ); ++_ABVAR_33_a )
  {
    _ABVAR_34_adc = __ardublockAnalogRead(0) ;
    if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) <= ( ( vec_sensorsWhite[1 - 1] * 2 ) ) ) ))
    {
      vec_sensors[1 - 1] = ( ( vec_sensors[1 - 1] + _ABVAR_34_adc ) / 2 ) ;
    }
    _ABVAR_34_adc = __ardublockAnalogRead(1) ;
    if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) <= ( ( vec_sensorsWhite[2 - 1] * 2 ) ) ) ))
    {
      vec_sensors[2 - 1] = ( ( vec_sensors[2 - 1] + _ABVAR_34_adc ) / 2 ) ;
    }
    _ABVAR_34_adc = __ardublockAnalogRead(2) ;
    if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) < ( ( vec_sensorsWhite[3 - 1] * 2 ) ) ) ))
    {
      vec_sensors[3 - 1] = ( ( vec_sensors[3 - 1] + _ABVAR_34_adc ) / 2 ) ;
    }
    _ABVAR_34_adc = __ardublockAnalogRead(4) ;
    if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) <= ( ( vec_sensorsWhite[4 - 1] * 2 ) ) ) ))
    {
      vec_sensors[4 - 1] = ( ( vec_sensors[4 - 1] + _ABVAR_34_adc ) / 2 ) ;
    }
    _ABVAR_34_adc = __ardublockAnalogRead(5) ;
    if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) <= ( ( vec_sensorsWhite[5 - 1] * 2 ) ) ) ))
    {
      vec_sensors[5 - 1] = ( ( vec_sensors[5 - 1] + _ABVAR_34_adc ) / 2 ) ;
    }
  }
}

void setupSensors()
{
  for (_ABVAR_16_num= 1; _ABVAR_16_num<= ( 5 ); _ABVAR_16_num++ )
  {
    vec_sensorsBlack[_ABVAR_16_num - 1] = 2000 ;
    vec_sensorsWhite[_ABVAR_16_num - 1] = 0 ;
    vec_levels[_ABVAR_16_num - 1] = 0 ;
  }
}

void calcSpeed2()
{
  if (( ( _ABVAR_2_dirMS ) == ( 0 ) ))
  {
    _ABVAR_7_speedLeft = _ABVAR_15_MAX_SPEED ;
    _ABVAR_8_speedRight = _ABVAR_15_MAX_SPEED ;
    __ardublockDigitalWrite(2, LOW);
    __ardublockDigitalWrite(3, LOW);
  }
  else
  {
    if (( ( _ABVAR_2_dirMS ) > ( 0 ) ))
    {
      __ardublockDigitalWrite(3, HIGH);
      _ABVAR_8_speedRight = vec_tblSpeed2[_ABVAR_2_dirMS - 1] ;
    }
    else
    {
      __ardublockDigitalWrite(2, HIGH);
      _ABVAR_7_speedLeft = vec_tblSpeed2[( 0 - _ABVAR_2_dirMS ) - 1] ;
    }
  }
}

void getDistance()
{
  _ABVAR_35_isNotDistance = HIGH ;
  __ardublockDigitalWrite(8, HIGH);
  delayMicroseconds( 10 );
  __ardublockDigitalWrite(8, LOW);
  _ABVAR_36_distCount = 500 ;
  while ( ( ( ( __ardublockDigitalRead(9) ) == ( LOW ) ) && ( ( _ABVAR_36_distCount ) > ( 0 ) ) ) )
  {
    delayMicroseconds( 1 );
    _ABVAR_36_distCount = ( _ABVAR_36_distCount - 1 ) ;
  }

  if (( ( _ABVAR_36_distCount ) == ( 0 ) ))
  {
    _ABVAR_35_isNotDistance = LOW ;
  }
  _ABVAR_36_distCount = 200 ;
  _ABVAR_12_distance = 5000UL ;
  while ( ( _ABVAR_35_isNotDistance && ( ( _ABVAR_36_distCount ) > ( 0 ) ) ) )
  {
    if (( ( __ardublockDigitalRead(9) ) == ( LOW ) ))
    {
      _ABVAR_35_isNotDistance = LOW ;
      _ABVAR_12_distance = ( ( ( 200 - _ABVAR_36_distCount ) * 681UL ) / 256UL ) ;
    }
    else
    {
      delayMicroseconds( 10 );
    }
    _ABVAR_36_distCount = ( _ABVAR_36_distCount - 1 ) ;
  }

}

void blink()
{
  __ardublockDigitalWrite(2, HIGH);
  __ardublockDigitalWrite(3, HIGH);
  delay( 250 );
  __ardublockDigitalWrite(2, LOW);
  __ardublockDigitalWrite(3, LOW);
  delay( 250 );
}

void check250()
{
  _ABVAR_13_time = millis() ;
  do
  {
    getSensors();
    for (_ABVAR_16_num= 1; _ABVAR_16_num<= ( 5 ); _ABVAR_16_num++ )
    {
      if (( ( vec_sensors[_ABVAR_16_num - 1] ) < ( vec_sensorsBlack[_ABVAR_16_num - 1] ) ))
      {
        vec_sensorsBlack[_ABVAR_16_num - 1] = vec_sensors[_ABVAR_16_num - 1] ;
      }
      if (( ( vec_sensors[_ABVAR_16_num - 1] ) > ( vec_sensorsWhite[_ABVAR_16_num - 1] ) ))
      {
        vec_sensorsWhite[_ABVAR_16_num - 1] = vec_sensors[_ABVAR_16_num - 1] ;
      }
      vec_levels[_ABVAR_16_num - 1] = ( ( ( ( vec_sensorsWhite[_ABVAR_16_num - 1] - vec_sensorsBlack[_ABVAR_16_num - 1] ) * 11 ) / 16 ) + vec_sensorsBlack[_ABVAR_16_num - 1] ) ;
    }
  }
  while(( ( ( millis() - _ABVAR_13_time ) ) <= ( 250UL ) ));
}

void printDirMS()
{
  Serial.print(", dir=");
  Serial.print(" ");
  Serial.print(_ABVAR_2_dirMS);
  Serial.print(" ");
  Serial.print(", msCount");
  Serial.print(" ");
  Serial.print(_ABVAR_3_msCount);
  Serial.print(" ");
  Serial.print(", prev=");
  Serial.print(" ");
  Serial.print(_ABVAR_20_prevDir);
  Serial.print(" ");
  Serial.print(", oldDirMS");
  Serial.print(" ");
  Serial.print(_ABVAR_5_oldDirMS);
  Serial.print(" ");
  Serial.print(", oldCount");
  Serial.print(" ");
  Serial.print(_ABVAR_4_oldCount);
  Serial.print(" ");
  Serial.print(", sum=");
  Serial.print(" ");
  Serial.print(_ABVAR_17_sum);
  Serial.print(" ");
  Serial.print(", count=");
  Serial.print(" ");
  Serial.print(_ABVAR_18_count);
  Serial.print(" ");
}

void printSpeed3()
{
  Serial.print("dir=");
  Serial.print(" ");
  Serial.print(_ABVAR_24_dir);
  Serial.print(" ");
  Serial.print(", prop=");
  Serial.print(" ");
  Serial.print(_ABVAR_30_prop);
  Serial.print(" ");
  Serial.print(", diff=");
  Serial.print(" ");
  Serial.print(_ABVAR_29_diff);
  Serial.print(" ");
  Serial.print(", tdir=");
  Serial.print(" ");
  Serial.print(_ABVAR_21_turnDir);
  Serial.print(" ");
  Serial.print(", tcount=");
  Serial.print(" ");
  Serial.print(_ABVAR_37_turnCount);
  Serial.print(" ");
  Serial.print(", turns=");
  Serial.print(" ");
  Serial.print(vec_tblTurns[_ABVAR_24_dir - 1]);
  Serial.print(" ");
}

void getSensors2()
{
  _ABVAR_34_adc = __ardublockAnalogRead(0) ;
  if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) <= ( 500 ) ) ))
  {
    vec_sensors[1 - 1] = _ABVAR_34_adc ;
  }
  _ABVAR_34_adc = __ardublockAnalogRead(1) ;
  if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) <= ( 500 ) ) ))
  {
    vec_sensors[2 - 1] = _ABVAR_34_adc ;
  }
  _ABVAR_34_adc = __ardublockAnalogRead(2) ;
  if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) < ( 500 ) ) ))
  {
    vec_sensors[3 - 1] = _ABVAR_34_adc ;
  }
  _ABVAR_34_adc = __ardublockAnalogRead(4) ;
  if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) <= ( 500 ) ) ))
  {
    vec_sensors[4 - 1] = _ABVAR_34_adc ;
  }
  _ABVAR_34_adc = __ardublockAnalogRead(5) ;
  if (( _ABVAR_6_isAutoLevel || ( ( _ABVAR_34_adc ) <= ( 500 ) ) ))
  {
    vec_sensors[5 - 1] = _ABVAR_34_adc ;
  }
}

void setupSpeed4()
{
  _ABVAR_15_MAX_SPEED = 170 ;
  _ABVAR_38_MAX_SPEED_D = 100 ;
  _ABVAR_39_MAX_SPEED_DN = 170 ;
  _ABVAR_22_STEP = 40 ;
  vec_tblSpeedLeft[1 - 1] = 35 ;
  vec_tblSpeedLeft[2 - 1] = -45 ;
  vec_tblSpeedLeft[3 - 1] = -65 ;
  vec_tblSpeedLeft[4 - 1] = -85 ;
  vec_tblSpeedLeft[5 - 1] = 0 ;
  vec_tblSpeedLeft[6 - 1] = -160 ;
  vec_tblSpeedRight[1 - 1] = 35 ;
  vec_tblSpeedRight[2 - 1] = -45 ;
  vec_tblSpeedRight[3 - 1] = -65 ;
  vec_tblSpeedRight[4 - 1] = -85 ;
  vec_tblSpeedRight[5 - 1] = 0 ;
  vec_tblSpeedRight[6 - 1] = -160 ;
}

void calcSpeed()
{
  if (( ( _ABVAR_2_dirMS ) == ( 0 ) ))
  {
    __ardublockDigitalWrite(2, LOW);
    __ardublockDigitalWrite(3, LOW);
    if (( ( _ABVAR_2_dirMS ) != ( _ABVAR_20_prevDir ) ))
    {
      if (( ( _ABVAR_20_prevDir ) > ( 0 ) ))
      {
        _ABVAR_8_speedRight = ( _ABVAR_8_speedRight + vec_tblProps[_ABVAR_20_prevDir - 1] ) ;
      }
      else
      {
        _ABVAR_7_speedLeft = ( _ABVAR_7_speedLeft + vec_tblProps[_ABVAR_20_prevDir - 1] ) ;
      }
    }
    if (( ( ( _ABVAR_7_speedLeft - _ABVAR_15_MAX_SPEED ) ) > ( _ABVAR_22_STEP ) ))
    {
      _ABVAR_7_speedLeft = ( _ABVAR_7_speedLeft - _ABVAR_22_STEP ) ;
    }
    else
    {
      if (( ( ( _ABVAR_8_speedRight - _ABVAR_7_speedLeft ) ) > ( _ABVAR_22_STEP ) ))
      {
        _ABVAR_7_speedLeft = ( _ABVAR_7_speedLeft + _ABVAR_22_STEP ) ;
      }
      else
      {
        if (( ( ( _ABVAR_15_MAX_SPEED - _ABVAR_7_speedLeft ) ) > ( _ABVAR_22_STEP ) ))
        {
          _ABVAR_7_speedLeft = ( _ABVAR_7_speedLeft + _ABVAR_22_STEP ) ;
        }
        else
        {
          _ABVAR_7_speedLeft = _ABVAR_15_MAX_SPEED ;
        }
      }
    }
    if (( ( ( _ABVAR_8_speedRight - _ABVAR_15_MAX_SPEED ) ) > ( _ABVAR_22_STEP ) ))
    {
      _ABVAR_8_speedRight = ( _ABVAR_8_speedRight - _ABVAR_22_STEP ) ;
    }
    else
    {
      if (( ( ( _ABVAR_7_speedLeft - _ABVAR_8_speedRight ) ) > ( _ABVAR_22_STEP ) ))
      {
        _ABVAR_8_speedRight = ( _ABVAR_8_speedRight + _ABVAR_22_STEP ) ;
      }
      else
      {
        if (( ( ( _ABVAR_15_MAX_SPEED - _ABVAR_8_speedRight ) ) > ( _ABVAR_22_STEP ) ))
        {
          _ABVAR_8_speedRight = ( _ABVAR_8_speedRight + _ABVAR_22_STEP ) ;
        }
        else
        {
          _ABVAR_8_speedRight = _ABVAR_15_MAX_SPEED ;
        }
      }
    }
  }
  else
  {
    if (( ( _ABVAR_2_dirMS ) > ( 0 ) ))
    {
      __ardublockDigitalWrite(3, HIGH);
      _ABVAR_40_speedIn = _ABVAR_8_speedRight ;
      _ABVAR_25_speedEx = _ABVAR_7_speedLeft ;
      _ABVAR_24_dir = _ABVAR_2_dirMS ;
      calcDir();
      _ABVAR_7_speedLeft = _ABVAR_25_speedEx ;
      _ABVAR_8_speedRight = _ABVAR_40_speedIn ;
    }
    else
    {
      __ardublockDigitalWrite(2, HIGH);
      _ABVAR_25_speedEx = _ABVAR_8_speedRight ;
      _ABVAR_40_speedIn = _ABVAR_7_speedLeft ;
      _ABVAR_24_dir = ( 0 - _ABVAR_2_dirMS ) ;
      calcDir();
      _ABVAR_8_speedRight = _ABVAR_25_speedEx ;
      _ABVAR_7_speedLeft = _ABVAR_40_speedIn ;
    }
  }
}

void setupSpeed1()
{
  _ABVAR_15_MAX_SPEED = 150 ;
  _ABVAR_41_ROTATE = -150 ;
}

void calcSpeed4()
{
  _ABVAR_42_MAX_SPEED_D2 = 140 ;
  if (( ( _ABVAR_2_dirMS ) == ( 0 ) ))
  {
    _ABVAR_7_speedLeft = ( _ABVAR_7_speedLeft + _ABVAR_22_STEP ) ;
    _ABVAR_8_speedRight = ( _ABVAR_8_speedRight + _ABVAR_22_STEP ) ;
    __ardublockDigitalWrite(2, LOW);
    __ardublockDigitalWrite(3, LOW);
  }
  else
  {
    if (( ( abs( _ABVAR_2_dirMS ) ) == ( 6 ) ))
    {
      _ABVAR_15_MAX_SPEED = _ABVAR_38_MAX_SPEED_D ;
    }
    else
    {
      _ABVAR_15_MAX_SPEED = _ABVAR_39_MAX_SPEED_DN ;
    }
    if (( ( _ABVAR_2_dirMS ) > ( 0 ) ))
    {
      __ardublockDigitalWrite(3, HIGH);
      _ABVAR_8_speedRight = vec_tblSpeedRight[_ABVAR_2_dirMS - 1] ;
    }
    else
    {
      __ardublockDigitalWrite(2, HIGH);
      _ABVAR_7_speedLeft = vec_tblSpeedLeft[( 0 - _ABVAR_2_dirMS ) - 1] ;
    }
  }
  if (( ( _ABVAR_7_speedLeft ) > ( _ABVAR_15_MAX_SPEED ) ))
  {
    _ABVAR_7_speedLeft = _ABVAR_15_MAX_SPEED ;
  }
  if (( ( _ABVAR_8_speedRight ) > ( _ABVAR_15_MAX_SPEED ) ))
  {
    _ABVAR_8_speedRight = _ABVAR_15_MAX_SPEED ;
  }
}

void calcProp()
{
  _ABVAR_30_prop = vec_tblProps[_ABVAR_24_dir - 1] ;
}

void calcSpeed1()
{
  if (( ( _ABVAR_2_dirMS ) == ( 0 ) ))
  {
    _ABVAR_7_speedLeft = _ABVAR_15_MAX_SPEED ;
    _ABVAR_8_speedRight = _ABVAR_15_MAX_SPEED ;
    __ardublockDigitalWrite(2, LOW);
    __ardublockDigitalWrite(3, LOW);
  }
  else
  {
    if (( ( _ABVAR_2_dirMS ) > ( 0 ) ))
    {
      __ardublockDigitalWrite(3, HIGH);
      _ABVAR_8_speedRight = _ABVAR_41_ROTATE ;
    }
    else
    {
      __ardublockDigitalWrite(2, HIGH);
      _ABVAR_7_speedLeft = _ABVAR_41_ROTATE ;
    }
  }
}

void calcDir()
{
  if (( ( _ABVAR_24_dir ) > ( abs( _ABVAR_5_oldDirMS ) ) ))
  {
    if (( ( _ABVAR_25_speedEx ) < ( _ABVAR_23_MAX_ROTATE ) ))
    {
      if (( ( ( _ABVAR_23_MAX_ROTATE - _ABVAR_25_speedEx ) ) > ( _ABVAR_22_STEP ) ))
      {
        _ABVAR_25_speedEx = ( _ABVAR_25_speedEx + _ABVAR_22_STEP ) ;
      }
      else
      {
        _ABVAR_25_speedEx = _ABVAR_23_MAX_ROTATE ;
      }
    }
  }
  else
  {
    if (( ( _ABVAR_25_speedEx ) > ( _ABVAR_15_MAX_SPEED ) ))
    {
      _ABVAR_25_speedEx = ( _ABVAR_25_speedEx - ( _ABVAR_22_STEP * 1 ) ) ;
    }
  }
  calcProp();
  calcDiff1();
  calcTurn();
  _ABVAR_40_speedIn = ( ( _ABVAR_25_speedEx * ( _ABVAR_30_prop + ( _ABVAR_29_diff + _ABVAR_43_summ ) ) ) / 128 ) ;
  if (( ( _ABVAR_40_speedIn ) > ( _ABVAR_23_MAX_ROTATE ) ))
  {
    _ABVAR_40_speedIn = _ABVAR_23_MAX_ROTATE ;
  }
  if (( ( _ABVAR_40_speedIn ) < ( ( 0 - _ABVAR_23_MAX_ROTATE ) ) ))
  {
    _ABVAR_40_speedIn = ( 0 - _ABVAR_23_MAX_ROTATE ) ;
  }
}


