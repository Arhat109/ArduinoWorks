
void setup() {
  Serial.begin(9600);                         //класс Serial, название begin (9600)
}

void my_setup()
{
  Serial.println("bai bai Andrei");           //писать каждыем (1000) мл. ("Hello Andrey!")
  delay(1000);
}

char * my_string2()
{
  return "Andrey, go to bed!";
}

void loop() {
  my_setup();
  Serial.println("Hello, Andrey!");           //писать каждыем (1000) мл. ("Hello Andrey!")
  delay(1000);

  Serial.println( my_string2() );           //писать каждыем (1000) мл. ("Hello Andrey!")
  delay(1000);
}
