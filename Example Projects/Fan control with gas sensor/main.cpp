#include <Arduino.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>


#define MQPIN 32
#define PWMPIN 18

#define WIFI_SSID "WIFI SSID"
#define WIFI_PASSWORD "WIFI PASSWORD"

// Firebase Informations
#define API_KEY "API KEY"
#define DATABASE_URL "DATABASE URL"

// Firebase Authentication and Database references
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// Global variables
String userUID = "YOUR USER ID";  // User UID
String projectID = "niveraapp-c5658"; // Firebase Project ID
String documentPath = "users/" + userUID + "/sensors/";


// Other Variables
unsigned long sendDataPrevMillis = 0;
bool signupOK = false;

String fanMA = "0";
String gSt;
int gasValue;

String fanSpeed = "0";
int fanPercent;



void setup() {
  Serial.begin(115200);

  // WiFi Setup
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("WiFi Connectes: ");
  Serial.println(WiFi.localIP());

  // Firebase settings
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  auth.user.email = "YOUR MAIL (YOU NEED TO REGISTER WITH NIVERA APPLICATION)";
  auth.user.password = "YOUR APPLICATION ACCOUNT PASSWORD";

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  pinMode(MQPIN, INPUT);
  pinMode(PWMPIN, OUTPUT);
}

// Update DATA Function
void updateSensorValue(String sensorID, String sensorValue) {
  FirebaseJson content;
  content.set("fields/sensorValue/stringValue", sensorValue);

  if (Firebase.Firestore.patchDocument(&fbdo, projectID.c_str(), "", (documentPath + sensorID).c_str(), content.raw(), "sensorValue")) {
    Serial.println("UPDATE SUCCESSFUL.");
  } else {
    Serial.print("UPDATE ERROR: ");
    Serial.println(fbdo.errorReason());
  }
}

// Read DATA Function
String readSensorValue(String sensorID) {
  if (Firebase.Firestore.getDocument(&fbdo, projectID.c_str(), "", (documentPath + sensorID).c_str())) {
    Serial.println("READ SUCCESSFUL.");
    //Serial.print("DATA Type: ");
    //Serial.println(fbdo.dataType());
    //Serial.println(fbdo.payload());

    // JSON Process
    FirebaseJson json;
    json.setJsonData(fbdo.payload());
    FirebaseJsonData jsonData;
    if (json.get(jsonData, "fields/sensorValue/stringValue")) {
      Serial.print("sensorValue: ");
      Serial.println(jsonData.stringValue);
      return jsonData.stringValue;
    } else {
      Serial.println("sensorValue couldnt read.");
      return "";
    }
  } else {
    Serial.print("READ ERROR: ");
    Serial.println(fbdo.errorReason());
    return "";
  }
}



void loop() {

  delay(1000);


  // READING GAS
  gasValue = analogRead(MQPIN);
  gSt = String(gasValue);
  Serial.println("MQ Sensor Value: " + gSt);

  // FAN PERCENT ARRANGEMENT
  if(fanMA == "0"){
    fanSpeed = "0";
    analogWrite(PWMPIN, fanSpeed.toInt());
    delay(100);
    digitalWrite(PWMPIN, LOW);
    if(gasValue>=1050) {
      fanSpeed=255;
      analogWrite(PWMPIN, fanSpeed.toInt());
      delay(100);
      digitalWrite(PWMPIN, HIGH);
      Serial.println("MAX");
    }else if(gasValue>=680 &&  gasValue<1050) {
      fanSpeed = map(gasValue, 680, 1049, 125, 255);
      analogWrite(PWMPIN, fanSpeed.toInt());
    }else if(gasValue<680){
      fanSpeed="0";
      analogWrite(PWMPIN, fanSpeed.toInt());
      delay(100);
      digitalWrite(PWMPIN, LOW);
      Serial.println("CLOSED");
    }
    fanPercent = map(fanSpeed.toInt(), 0, 255, 0, 100);
  }else if(fanMA == "1"){
    analogWrite(PWMPIN, fanSpeed.toInt());
  }

  Serial.println("PWM Value: " + String(fanSpeed));


  // Firebase Operations
  if(Firebase.ready() && (millis() - sendDataPrevMillis > 6200 || sendDataPrevMillis == 0)){
    sendDataPrevMillis = millis();

    updateSensorValue("TYPE YOUR SENSOR ID", gSt);

    fanMA = readSensorValue("SENSOR ID");
    

    if (fanMA == "1")
    {
      fanPercent = readSensorValue("TYPE YOUR SENSOR ID").toInt();
      Serial.println("Fan Percent: " + fanPercent);
      fanSpeed = map(fanPercent, 0, 100, 0, 255);
    }

    if(fanMA == "0"){
      fanSpeed = map(fanPercent, 0, 100, 0, 255);
      updateSensorValue("TYPE YOUR SENSOR ID", String(fanPercent));
      
    }
    


    }

  delay(100);
}