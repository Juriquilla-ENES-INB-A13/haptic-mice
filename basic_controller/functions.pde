//common functions

void setArduino(){
  if(ardu != null){
    ardu.dispose();
    println("INFO:arduino disconnected!");
  }
  println("INFO:connecting to port:"+Serial.list()[lst_port.getSelectedIndex()]);
  ardu = new Arduino(this, Arduino.list()[lst_port.getSelectedIndex()], 57600);
  ardu.pinMode(vibr, Arduino.OUTPUT);
  ardu.pinMode(pump, Arduino.OUTPUT);
  ardu.pinMode(pokeL, Arduino.INPUT);
  ardu.pinMode(pokeR, Arduino.INPUT);
  ardu.pinMode(door, Arduino.SERVO);
  ardu.pinMode(inSensor, Arduino.INPUT);
  ardu.pinMode(10,Arduino.OUTPUT);
  ardu.servoWrite(door,closeAngle);
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

//Motor functions
void fill()
{
  println("RUN:Filling!");
  ardu.digitalWrite(pump, Arduino.HIGH);
  delay(3000);
  ardu.digitalWrite(pump, Arduino.LOW);
  println("RUN:Done!");
}

void feed()
{
  ardu.digitalWrite(pump, Arduino.HIGH);
  delay(timeFeed);
  ardu.digitalWrite(pump, Arduino.LOW);
  delay(10);
  ardu.digitalWrite(pump, Arduino.HIGH);
  delay(timeFeed);
  ardu.digitalWrite(pump, Arduino.LOW);
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
      delay(25);
      ardu.digitalWrite(vibr, Arduino.LOW);
      delay(off_time);
      println(i);
    }
  } else {
    delay(iduration);
  }
}

void closeDoor(){
  ardu.pinMode(door,Arduino.SERVO);
  for(int i = openAngle;i>closeAngle;i--){
    ardu.servoWrite(door,i);
    delay(doorDelay);
  }
}

void openDoor(){
  ardu.servoWrite(door,openAngle);
}

void addWindowInfo(){
  surface.setTitle("Basic controller- "+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second()+ "  Iteration:"+numIteration);
}
//Experiment specific functions


boolean checkFields() {
  boolean test;
  if ((fld_freq.getValueI() != 0) || (fld_vibr_duration.getValueI() != 0) || (fld_response_time.getValueI() != 0) || (fld_repeats.getValueI()!=0) || (fld_time_experiments.getValueI() != 0)) {
    test=true;
  } else {
    println("ERROR: No empty fields allowed! ");
    test=false;
  }
  return test;
}

void doExperiment() 
   {
    numIteration=0;
    int times = fld_repeats.getValueI();  
    for (int i=1; i<=times; i++) {
      addWindowInfo();
      numIteration=i;
      vibrate(fld_freq.getValueI(),fld_vibr_duration.getValueI());
      delay(fld_time_experiments.getValueI());
    }
    
  btn_startstop.setVisible(true);
  btn_stop.setVisible(false);
}
