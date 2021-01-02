//common functions
void setArduino(){
  if(ardu != null){
    ardu.dispose();
    println("INFO:arduino disconnected!");
  }
  println("INFO:connecting to port:"+Arduino.list()[lst_port.getSelectedIndex()]);
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
  println("INFO:success!");
  lbl_connected.setText("connected!");
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
  println("RUN: feed");
  int cycles=cycleFeed;
  while(cycles>=0){
    ardu.digitalWrite(pump, Arduino.HIGH);
    delay(fld_pump_pulse.getValueI());
    ardu.digitalWrite(pump, Arduino.LOW);
    delay(50);
    cycles--;
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
  ardu.pinMode(door,Arduino.SERVO);
  while(door_angle>closeAngle){
    ardu.servoWrite(door,door_angle);
    door_angle--;
    delay(doorDelay);
  }
}

void openDoor(){
  door_angle = openAngle;
  ardu.servoWrite(door,door_angle);
}

void addWindowInfo(){
  surface.setTitle("Manual Stage "+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second()+ "  Iteration:"+numIteration+ " OK:"+numOk+" Fail:"+numFail);
}


//Experiment specific functions

boolean checkFields() {

  if ((fld_response_time.getValueI() != 0) || 
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
   
    " time_response:"+ fld_response_time.getValueI()
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
