//common functions
void setArduino(){
  if(ardu != null){
    ardu.dispose();
    println("INFO:arduino disconnected!");
  }
  
  ardu = new Arduino(this, Arduino.list()[portList.getSelectedIndex()], 57600);
  ardu.pinMode(vibr, Arduino.OUTPUT);
  ardu.pinMode(10,Arduino.OUTPUT);
  //This make arduino signal an ok connection
  delay(1000);
  ardu.digitalWrite(10,Arduino.HIGH);
  delay(100);
  ardu.digitalWrite(10,Arduino.LOW);
  delay(100);
  ardu.digitalWrite(10,Arduino.HIGH);
  delay(100);
  ardu.digitalWrite(10,Arduino.LOW);
  println("INFO:success!");
  
  
}

void vibrate()
{
  int timeStop=millis()+2000;
  int ifreq=fldFreq.getValueI();
  int off_time;
  off_time = (1000/ifreq)-10;
  
  if (ifreq > 0)
  {
    while(millis()<timeStop){
      ardu.digitalWrite(vibr, Arduino.HIGH);
      delay(10);
      ardu.digitalWrite(vibr, Arduino.LOW);
      delay(off_time);
    }
  }
}
