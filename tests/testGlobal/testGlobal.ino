
const char * text1 = "The brain is 80% of the fluid. Often brake";

struct {
  char * text;
  int  len;
} myVar1 = {(char *)text1, 0};

void setup() {
}

void loop() {
  myVar1.len = strlen(myVar1.text);
}
