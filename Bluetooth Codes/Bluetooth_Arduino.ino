#include<Servo.h>
Servo s1,s2,s3,s4,s5,s6;
String dataIn;
float servo1Pos=0,servo2Pos=0,servo3Pos=0,servo4Pos=0,servo5Pos=0,servo6Pos=0;
float servo1[10],servo2[10],servo3[10],servo4[10],servo5[10],servo6[10];
int index=0;
void runservo() {
  while (dataIn != "RESET") {   // Run the steps over and over again until "RESET" button is pressed
    for (int i = 0; i <= index - 1; i++) {  // Run through all steps(index)
      if (Serial1.available() > 0) {      // Check for incomding data
        dataIn = Serial1.readStringUntil('\n');
        if ( dataIn == "PAUSE") {           // If button "PAUSE" is pressed
          while (dataIn != "RUN") {         
            if (Serial1.available() > 0) {
              dataIn = Serial1.readStringUntil('\n');
              if ( dataIn == "RESET") {     
                break;
              }
            }
          }
        }
      }
      Serial.println(servo1[i]);
      Serial.println(servo2[i]);
      Serial.println(servo3[i]);
      Serial.println(servo4[i]);
      Serial.println(servo5[i]);
      Serial.println(servo6[i]);
          s1.write(servo1[i]);
        s2.write(servo2[i]);
      s3.write(servo3[i]);
           s4.write(servo4[i]);
      s5.write(servo5[i]);
s6.write(servo6[i]);
      delay(2000);
    }
  }
}
void setup()
{
  Serial.begin(9600);
  Serial1.begin(9600);
  Serial.println();
  s1.attach(3);
  s1.write(servo1Pos+90);
  s2.attach(4);
  s2.write(servo2Pos+100);
  s3.attach(10);
  s3.write(170-servo3Pos);
  s4.attach(6);
  s4.write(servo4Pos);
  s5.attach(7);
  s5.write(servo5Pos+90);
  s6.attach(8);
  s6.write(servo6Pos);
  Serial.print("F");
    Serial.print(" ");
    Serial.print(servo1Pos);
    Serial.print(" ");
    Serial.print(servo2Pos);
    Serial.print(" ");
    Serial.print(servo3Pos);
    Serial.print(" ");
    Serial.print(servo4Pos);
    Serial.print(" ");
    Serial.println(servo5Pos);
    
}

void loop()
{
  if(Serial1.available())
  {
    dataIn = Serial1.readStringUntil('\n');
    if(dataIn.startsWith("g")){
      String c=dataIn.substring(1,2);
      if(c=="1"){
        servo6Pos=90;
      s6.write(90);
      }
      else{
        servo6Pos=0;
      s6.write(0);
      }
    }
    if(dataIn.startsWith("SAVE")){
      servo1[index]=90+servo1Pos;
      servo2[index]=100+servo2Pos;
      servo3[index]=170-servo3Pos;
      servo4[index]=servo4Pos;
      servo5[index]=90+servo5Pos;
      servo6[index]=servo6Pos;
      Serial.println(servo1[index]);
      Serial.println(servo2[index]);
      Serial.println(servo3[index]);
      Serial.println(servo4[index]);
      Serial.println(servo5[index]);
      Serial.println(servo6[index]);
      Serial.println(index);
      index++;      
    }
    if(dataIn.startsWith("F")){
      Serial.println(dataIn);
    }
    if(dataIn.startsWith("I")){
      Serial.println(dataIn);
    }
    
    if(dataIn.startsWith("RESET")){
      memset(servo1,0,sizeof(servo1));
      memset(servo2,0,sizeof(servo2));
      memset(servo3,0,sizeof(servo3));
      memset(servo4,0,sizeof(servo4));
      memset(servo5,0,sizeof(servo5));
      memset(servo6,0,sizeof(servo6));
      index=0;
    }
     if (dataIn.startsWith("RUN")) {
      runservo();
    }
  }
  if(Serial.available()){
    dataIn=Serial.readStringUntil('\n');
     if (dataIn.startsWith("a")) {
      String dataInS = dataIn.substring(1, dataIn.length()-1);
      servo1Pos = dataInS.toFloat();
      s1.write(servo1Pos+90);
}
    if(dataIn.startsWith("b")){
      String dataInS = dataIn.substring(1, dataIn.length()-1);
      servo2Pos = dataInS.toFloat();
      s2.write(servo2Pos+100);
    }
    if(dataIn.startsWith("c")){
      String dataInS = dataIn.substring(1, dataIn.length()-1);
      servo3Pos = dataInS.toFloat();
      s3.write(170-servo3Pos);
    }
    if(dataIn.startsWith("d")){
      String dataInS = dataIn.substring(1, dataIn.length()-1);
      servo4Pos = dataInS.toFloat();
      s4.write(servo4Pos);
    }
    if(dataIn.startsWith("e")){
      String dataInS = dataIn.substring(1, dataIn.length()-1);
      servo5Pos = dataInS.toFloat();
      s5.write(servo5Pos+90);
    }
    if(dataIn.startsWith("F")){
      Serial1.print(dataIn);
      Serial1.println(" ");
    }
        if(dataIn.startsWith("I")){
      Serial1.print(dataIn);
      Serial1.println(" ");
  }
  }
}
