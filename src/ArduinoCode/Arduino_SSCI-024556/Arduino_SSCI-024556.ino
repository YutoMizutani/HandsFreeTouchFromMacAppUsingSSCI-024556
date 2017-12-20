/*================================================================

Arduino_SSCI-024556.ino

Copyright (C) 2017 Yuto Mizutani.
This software is released under the MIT License.

=================================================================*/



/*=================================================================*/
boolean isOn = true;
/*=================================================================*/
void power(int num, boolean isOn) {
  Serial.print("touch(");
  Serial.print(num);
  Serial.print(", ");
  Serial.print(isOn ? "HIGH" : "LOW");
  Serial.println(")");
  
  digitalWrite(num, isOn ? HIGH : LOW);
}

void pinModeAllOutput() {
  int UnoPinNum = 13;
  for(int i=0; i <= UnoPinNum; i++) {
    pinMode(i, OUTPUT);
  }
}

int convertNum(String str) {
  return str.toInt();
}
/*-----------------------------------------------------------------*/
void touch(int num) {
  power(num, true);
  delay(100);
  power(num, false);
  delay(100);
}
/*=================================================================*/
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  //pinModeAllOutput();
  pinMode(1, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(13, OUTPUT);
  Serial.println("Start!");
}
/*-----------------------------------------------------------------*/
void loop() {
  // put your main code here, to run repeatedly:  
  
  if (Serial.available()) {
    //Command is '\r' or '\n'
    String str = Serial.readStringUntil('\r');
    String strx = str + '\r';
    int len = strx.length() + 1;
    char buf[len];
    strx.toCharArray(buf, len);
    
    int num = convertNum(buf);
    Serial.println(num);
    touch(num);
  }
  
  Serial.flush();
}
/*=================================================================*/


