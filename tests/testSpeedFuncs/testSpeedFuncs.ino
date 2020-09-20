///////////////////////////
//
//  Сравнение умножения на 10 и сумма сдвигов на 3 и на 1
//
template <typename T> inline Print & operator << (Print &s, T n) { s.print(n); return s; }

const int m10(const int n) {
    return n / 59;
}

const int s31(const int n) {
    return (n * 343)>>11;
}

const unsigned long TestIt(const int (* f)(const int), int & res) {
    res = 0;
    unsigned long start = millis();
    for (int k = 0; k <= 1000; k++)
        for (int a = 0; a <= 1000; a++) res += f(a);
    return millis() - start;
}

void setup() {
    Serial.begin(9600);

    int res = 0;

    Serial << "*10 = " << TestIt(m10, res) << '\n';
    Serial << "<< 3 + << 1 = " << TestIt(s31, res) << '\n';

    res ++;
}

void loop() {}

