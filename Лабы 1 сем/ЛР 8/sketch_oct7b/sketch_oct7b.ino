const int redPin = 12;
const int yellowPin =11;
const int greenPin = 10;
const int interval = 1000;  // Интервал между сменой цветов в нормальном режиме (в миллисекундах)

enum TrafficLightMode {
  MODE_OFF,
  MODE_NORMAL,
  MODE_SLEEP,
  MODE_RED,
  MODE_GREEN
};

TrafficLightMode currentMode = MODE_OFF;
unsigned long previousMillis = 0;
int colorIndex = 0;
int colors[] = {redPin, yellowPin, greenPin};
int numColors = sizeof(colors) / sizeof(colors[0]);

void setup() {
  Serial.begin(9600);
  pinMode(redPin, OUTPUT);
  pinMode(yellowPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
}

void loop() {
  if (Serial.available() > 0) {
    char mode = Serial.read();
    switch (mode) {
      case 'N':
        setMode(MODE_NORMAL);
        break;
      case 'S':
        setMode(MODE_SLEEP);
        break;
      case 'R':
        setMode(MODE_RED);
        break;
      case 'G':
        setMode(MODE_GREEN);
        break;
        
    }
  }

  switch (currentMode) {
    case MODE_NORMAL:
      normalMode();
      break;
    case MODE_SLEEP:
      sleepMode();
      break;
    case MODE_RED:
      redMode();
      break;
    case MODE_GREEN:
      greenMode();
      break;
    default:
      turnOff();
      break;
  }
}

void setMode(TrafficLightMode mode) {
  currentMode = mode;
  colorIndex = 0;
}

void normalMode() {
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;
    turnOff();
    digitalWrite(colors[colorIndex], HIGH);
    colorIndex = (colorIndex + 1) % numColors;
    
  }
  
}

void sleepMode() {
  turnOff();
  while (currentMode == MODE_SLEEP) {
    blinkYellow();
    if (Serial.available() > 0) {
      break;
    }
  }
}

void redMode() {
  turnOff();
  digitalWrite(redPin, HIGH);
}

void greenMode() {
  turnOff();
  digitalWrite(greenPin, HIGH);
}

void turnOff() {
  digitalWrite(redPin, LOW);
  digitalWrite(yellowPin, LOW);
  digitalWrite(greenPin, LOW);
}

void blinkYellow() {
  digitalWrite(yellowPin, HIGH);
  delay(500);
  digitalWrite(yellowPin, LOW);
  delay(500);
}