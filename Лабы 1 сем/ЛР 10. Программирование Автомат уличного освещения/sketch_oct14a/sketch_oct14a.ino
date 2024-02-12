int LED=13;
int LDR=15;
int Poti=14 ;
int cnt=0;

int qwe = 0;

const int potPin = A0; 
int potValue = 0;
int ldrValue = 0;


void setup()
{
pinMode (LED, OUTPUT);
 Serial.begin(9600);

}
void loop()
{


// Считываем значение с потенциометра
  potValue = analogRead(Poti);
  ldrValue = analogRead(LDR);

  // Выводим значение на монитор последовательного порта
  Serial.print("Значение потенциометра: ");
  Serial.print(potValue);
  Serial.print(" ");
  Serial.println(ldrValue);

  // Задержка для стабилизации вывода









if (analogRead (LDR)> analogRead (Poti)) cnt=0;
if (analogRead (LDR)< analogRead (Poti)) cnt++;


if (cnt>300){


digitalWrite (LED, HIGH);

do
{
  
delay (100) ;
}
while (analogRead (LDR) <analogRead (Poti)) ; 
cnt=0;
digitalWrite (LED, LOW);

}
delay (10) ;

}