//common functions
void setArduino(){
  if(ardu != null){
    ardu.dispose();
    println("INFO:arduino disconnected!");
  }
  println("INFO:connecting to port:"+Arduino.list()[lst_port.getSelectedIndex()]);
  ardu = new Arduino(this, Arduino.list()[lst_port.getSelectedIndex()], 57600);
  ardu.pinMode(vibr, Arduino.OUTPUT);
  ardu.pinMode(pumpL, Arduino.OUTPUT);
  ardu.pinMode(pumpR, Arduino.OUTPUT);
  ardu.pinMode(pokeL, Arduino.INPUT);
  ardu.pinMode(pokeR, Arduino.INPUT);
  ardu.pinMode(door, Arduino.SERVO);
  ardu.pinMode(inSensor, Arduino.INPUT);
  ardu.pinMode(10,Arduino.OUTPUT);
  ardu.servoWrite(door,closeAngle);
  doorOpen=false;
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
  lbl_connected.setText("connected!");
  btnCloseDoor.setVisible(true);
  btnOpenDoor.setVisible(true);
  btn_start.setVisible(true);
  btn_feedL.setVisible(true);
  btn_fillL.setVisible(true);
  btnFeedR.setVisible(true);
  btnFillR.setVisible(true);
  
  btn_1.setVisible(true);
  btn_2.setVisible(true);
  btn_3.setVisible(true);
  btn_4.setVisible(true);
  btn_5.setVisible(true);
  btn_6.setVisible(true);
  btn_7.setVisible(true);
  btn_8.setVisible(true);
  btn_9.setVisible(true);
  btn_10.setVisible(true);
  btn_11.setVisible(true);
  
}

void appendTextToFile(String filename, String text) {
  File f = new File(dataPath(filename));
  if (!f.exists()) {
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(text);
    out.close();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

void createFile(File f) {
  File parentDir = f.getParentFile();
  try {
    parentDir.mkdirs(); 
    f.createNewFile();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

//Motor functions
void fillL()
{
  println("RUN:Filling!");
  ardu.analogWrite(pumpL, 255);
  delay(3000);
  ardu.analogWrite(pumpL, 0);
  println("RUN:Done!");
}
void fillR() //<>//
{
  println("RUN:Filling!");
  ardu.analogWrite(pumpR, 255);
  delay(3000);
  ardu.analogWrite(pumpR, 0);
  println("RUN:Done!");
}

void feedL()
{
  println("RUN: feedL");
  int power;
  if(sldPower.getValueF()>0){
    power=int(sldPower.getValueF()*2.55);
  }else{
    power=0;
  }
  ardu.analogWrite(pumpL,power);
  delay(fld_pump_pulse.getValueI());
  ardu.analogWrite(pumpL, 0);
  delay(50);
  if(runExperiment){
    appendTextToFile(filename,iteration+","+(millis()-timeStart)+",feedL");
    feedTimesL++;
  }
}

void feedR()
{
  println("RUN: feedR");
  int power;
  if(sldPower.getValueF()>0){
    power=int(sldPower.getValueF()*2.55);
  }else{
    power=0;
  }
  ardu.analogWrite(pumpR,power);
  delay(fld_pump_pulse.getValueI());
  ardu.analogWrite(pumpR, 0);
  delay(50);
  if(runExperiment){
    appendTextToFile(filename,iteration+","+(millis()-timeStart)+",feedR");
    feedTimesR++;
  }
}

void openDataFolder() {
  println("Opening folder:"+dataPath(""));
  if (System.getProperty("os.name").toLowerCase().contains("windows")) {
    launch("explorer.exe"+" "+dataPath(""));
  } else {
    launch(dataPath(""));
  }
}

void writeTableHeader(String flname)
{
  appendTextToFile(flname, "repeat,freq,poke_time,touched_poke,inside_time,status");
}

void writeSeparator(String flname)
{
  appendTextToFile(flname, "");
}

void closeDoor(){
  if(!doorOpen){
    println("Door already closed");
    return;
  }
  ardu.pinMode(door,Arduino.SERVO);
  while(door_angle>closeAngle){
    ardu.servoWrite(door,door_angle);
    door_angle--;
    println(door_angle);
    delay(doorDelay);
  }
  doorOpen=false;
}

void openDoor(){
  if(doorOpen){
    println("Door already open");
    return;
  }
  door_angle = openAngle;
  ardu.pinMode(door,Arduino.SERVO);
  for(door_angle=closeAngle;door_angle<openAngle;door_angle++){
    ardu.servoWrite(door,door_angle);
    println(door_angle);
    delay(doorDelay);
  }
  doorOpen=true;
}

void addWindowInfo(){
  surface.setTitle("Dual Manual Stage "+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second()+ "  Iteration:"+iteration+ " OK:"+numOk+" Fail:"+numFail);
}


//Experiment specific functions

boolean checkFields() {

  if ((fldVibrDur.getValueI() != 0) || 
  (fld_name.getText() != "")) {
    return true;
  } else {
    println("ERROR: No empty fields allowed! ");
    return false;
  }
}

void writeParamsToFile(String flname)
{
  println("FILE: "+flname);
  String datetime = new String(day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
  println(datetime);
  String params = new String(
   

  );
  println(params);
  appendTextToFile(flname, "started: "+datetime);
  appendTextToFile(flname, params);
}

void stopExperiment(){
  runLoop=false;
  runExperiment=false;
}

void randomizeFreq()
{
  if(int(random(2))==1){
    freq=20;
  }else{
    freq=40;
  }
}
