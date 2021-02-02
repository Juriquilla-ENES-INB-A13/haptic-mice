//common functions
void setArduino(){
  if(ardu != null){
    ardu.dispose();
    println("INFO:arduino disconnected!");
  }
  println("INFO:connecting to port:"+Serial.list()[lst_port.getSelectedIndex()]);
  ardu = new Arduino(this, Arduino.list()[lst_port.getSelectedIndex()], 57600);
  ardu.pinMode(vibr, Arduino.OUTPUT);
  ardu.pinMode(vibr2,Arduino.OUTPUT);
  //This make arduino signal an ok connection
  delay(1000);
  ardu.digitalWrite(10,Arduino.HIGH);
  delay(100);
  ardu.digitalWrite(10,Arduino.LOW);
  delay(100);
  ardu.digitalWrite(10,Arduino.HIGH);
  delay(100);
  ardu.digitalWrite(10,Arduino.LOW);
  println("INFO:succes!");
  lbl_connected.setText("connected!");
}

void unsetArduino(){
  ardu.dispose();
  println("arduino disconnected!");
}




void vibrate(int ifreq, int iduration)
{
  if (ifreq > 0)
  {
    int off_time, cycles;
    off_time = (1000/ifreq)-25;
    println("off:"+off_time);
    cycles = (iduration/(off_time+25))-1;
    println("cyc:"+cycles);
    for (int i = 0; i <= cycles; i++)
    {
      ardu.digitalWrite(vibr, Arduino.HIGH);
      ardu.digitalWrite(vibr2,Arduino.HIGH);
      delay(25);
      ardu.digitalWrite(vibr, Arduino.LOW);
      ardu.digitalWrite(vibr, Arduino.LOW);
      delay(off_time);
      println(i);
    }
  } else {
    delay(iduration);
  }
}
