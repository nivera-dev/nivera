#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 32

#define OLED_RESET -1

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

const int buttonPin1 = 34;
const int buttonPin2 = 35;
const int ledPin = 25;
const int buzzerPin = 4;

int buttonPressCount = 0;

void setup() {
  Serial.begin(9600);

  if (!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
    Serial.println(F("SSD1306 allocation failed"));
    for (;;) ;
  }

  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(WHITE);
  display.setCursor(0, 0);
  display.println("Basma Sayaci");

  pinMode(buttonPin1, INPUT_PULLUP);
  pinMode(buttonPin2, INPUT_PULLUP);
  pinMode(ledPin, OUTPUT);
  pinMode(buzzerPin, OUTPUT);
}

void loop() {
  static bool buttonWasPressed1 = false;
  static bool buttonWasPressed2 = false;

  int reading1 = digitalRead(buttonPin1);
  int reading2 = digitalRead(buttonPin2);

  // Button 1 basma algılama
  if (reading1 == LOW && !buttonWasPressed1) {
    buttonWasPressed1 = true;
    delay(200);
    buttonPressCount++;

    display.clearDisplay();
    display.setCursor(0, 10);
    display.print("Basma Sayaci:");
    display.print(buttonPressCount);
    display.display();

    digitalWrite(ledPin, HIGH);

  } else if (reading1 == HIGH) {
    buttonWasPressed1 = false;
    digitalWrite(ledPin, LOW);
  }

  // Button 2 basma algılama
  if (reading2 == LOW && !buttonWasPressed2) {
    buttonWasPressed2 = true;
    delay(200);
    buttonPressCount = 0;

    display.clearDisplay();
    display.setCursor(0, 10);
    display.print("Basma Sayaci:");
    display.print(buttonPressCount);
    display.display();

    
    noTone(buzzerPin); // Buzzer off
  } else if (reading2 == HIGH) {
    buttonWasPressed2 = false;
     tone(buzzerPin, 1000);
  }
}
