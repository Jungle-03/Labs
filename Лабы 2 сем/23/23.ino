const int buttonPins[] = {2, 3, 4, 5};    // Пины кнопок
const int piezoPins[] = {9, 10, 11, 12};  // Пины пьезо

const int recordButtonPin = 5;     // Пин кнопки записи
const int playbackButtonPin = 6;   // Пин кнопки воспроизведения
const int recordingLedPin = 7;     // Пин светодиода записи

int recordedMelody[100];           // Массив для хранения записанной мелодии
int melodyLength = 0;              // Длина записанной мелодии
bool isRecording = false;          // Флаг состояния записи

void setup() {
  Serial.begin(9600);  // Инициализация Serial для взаимодействия с монитором
  for (int i = 0; i < 4; i++) {
    pinMode(buttonPins[i], INPUT_PULLUP);
    pinMode(piezoPins[i], OUTPUT);
  }

  pinMode(recordButtonPin, INPUT_PULLUP);
  pinMode(playbackButtonPin, INPUT_PULLUP);
  pinMode(recordingLedPin, OUTPUT);
}

void loop() {
  handleRecording();
  handlePlayback();

  for (int i = 0; i < 4; i++) {
    if (digitalRead(buttonPins[i]) == LOW) {
      playTone(i);
    }
  }
}

void handleRecording() {
  if (digitalRead(recordButtonPin) == LOW) {
    if (!isRecording) {
      startRecording();
    } else {
      stopRecording();
    }
    delay(500);  // Дополнительная задержка для избежания дребезга кнопки
  }
}

void startRecording() {
  isRecording = true;
  melodyLength = 0;
  digitalWrite(recordingLedPin, HIGH);
  Serial.println("Recording started");
}

void stopRecording() {
  isRecording = false;
  digitalWrite(recordingLedPin, LOW);
  Serial.println("Recording stopped");
}

void handlePlayback() {
  if (digitalRead(playbackButtonPin) == LOW) {
    if (melodyLength > 0) {
      playMelody();
    }
    delay(500);  // Дополнительная задержка для избежания дребезга кнопки
  }
}

void playMelody() {
  for (int i = 0; i < melodyLength; i++) {
    tone(piezoPins[i % 4], recordedMelody[i]);
    delay(500);  // Можно изменить задержку между нотами
    noTone(piezoPins[i % 4]);
  }
}

void playTone(int index) {
  int frequencies[] = {262, 294, 330, 349};  // Частоты для каждого пьезо

  if (isRecording) {
    recordedMelody[melodyLength] = frequencies[index];
    melodyLength++;
  }

  tone(piezoPins[index], frequencies[index]);
  delay(500);  // Можно изменить длительность звучания по вашему вкусу
  noTone(piezoPins[index]);
}
