/*
Arduino example for interfacing with the HMC5883L
by: Jordan McConnell SparkFun Electronics
created on: 6/30/11
*/
#include <Wire.h> //I2C Arduino Library
#define gy271_write 0x3C
#define gy271_read 0x3d

int cnt=0;
int x,y,z; 
long xx,yy,zz;

void setup(){
  //Initialize Serial and I2C communications
  Serial.begin(9600);
  Wire.begin();  
  //Put the HMC5883 IC into the correct operating mode
  Wire.beginTransmission(gy271_write); //open communication with HMC5883
  Wire.write(0x02); //select mode register
  Wire.write(0x00); //continuous measurement mode
  Wire.endTransmission();
}

void loop(){
  //Tell the HMC5883 where to begin reading data
  Wire.beginTransmission(gy271_write);
  Wire.write(0x03); //select register 3, X MSB register
  Wire.endTransmission();

  //Read data from each axis, 2 registers per axis
  Wire.requestFrom(gy271_read, 6);
  if(6<=Wire.available()){
    x = Wire.read()<<8; //X msb
    x |= Wire.read(); //X lsb
    z = Wire.read()<<8; //Z msb
    z |= Wire.read(); //Z lsb
    y = Wire.read()<<8; //Y msb
    y |= Wire.read(); //Y lsb
  }
  
  //Print out values of each axis
  Serial.print("x: ");
  Serial.print(x);
  Serial.print("  y: ");
  Serial.print(y);
  Serial.print("  z: ");
  Serial.println(z);
  /*
//Serial.print(z);Serial.write(32);
//repeatable within 1 deg, but off by 90 deg?
if(avgxyz())
if(zz>4800){  //near level 5200 max down, in MA
  //Serial.print(xx);Serial.write(32);Serial.println(yy);
  float heading=atan2(yy,xx);
  heading*=(180/M_PI); 
  //declination here degrees
  if(heading<0)heading+=360;
  if(heading>360)heading-=360;  //for + declination only   
  //upside down on board so...
  heading=360-heading;
  Serial.println(heading);
  }
*/
  delay(150);  //50 or 150 more acc 3s
}
/*
boolean avgxyz(){
const int N=20;  //matches delay 20*50=1s
boolean b;
cnt++;
if(cnt%N==1)xx=yy=zz=0;
xx+=x;
yy+=y;
zz+=z;
if(b=!(cnt%N)){
  xx=xx*10/N;yy=yy*10/N;zz=zz*10/N; }
return(b);
}
*/
