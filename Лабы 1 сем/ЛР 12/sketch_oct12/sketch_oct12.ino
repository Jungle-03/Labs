#include <LiquidCrystal.h>

LiquidCrystal lcd(13, 12, 11, 10, 9, 8);

void setup() {
  lcd.begin(16, 2); 
  lcd.print("Radzivil");
  delay(1000);
}

void loop() {
  lcd.clear(); 

  // Переместите слово вправо
  for (int i = 0; i < 16; i++) {
    lcd.setCursor(i, 0);
    lcd.print("Radzivil");
    delay(200);
  }

  lcd.clear(); 

  
  for (int i = 15; i >= 0; i--) {
    lcd.setCursor(i, 0);
    lcd.print("Radzivil");
    delay(200);
  }
}
