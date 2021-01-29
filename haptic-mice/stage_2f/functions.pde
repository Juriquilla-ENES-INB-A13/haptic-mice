//common functions

void setArduino(){
  if(ardu != null){
    ardu.dispose();
    printInfo("INFO:arduino disconnected!");
  }
  printInfo("INFO:connecting to port:"+Arduino.list()[lst_port.getSelectedIndex()]);
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
  printInfo("INFO:success!");
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

void printInfo(String textLog){
  println(textLog);
  //taLog.appendText(textLog);
  //appendTextToFile("log.txt",textLog);
}


//Motor functions
void fill()
{
  printInfo("RUN:Filling!");
  ardu.digitalWrite(pump, Arduino.HIGH);
  delay(3000);
  ardu.digitalWrite(pump, Arduino.LOW);
  printInfo("RUN:Done!");
}

void feed()
{
  printInfo("RUN: feed");
  int cycles=cycleFeed;
  while(cycles>=0){
    ardu.digitalWrite(pump, Arduino.HIGH);
    delay(fld_pump_pulse.getValueI());
    ardu.digitalWrite(pump, Arduino.LOW);
    delay(10);
    cycles--;
  }
}

void vibrate(int ifreq, int iduration)
{
  printInfo("RUN:freq "+ifreq+",dur "+iduration);
  if (ifreq > 0)
  {
    int off_time, cycles;
    off_time = (1000/ifreq)-25;
    cycles = (iduration/(off_time+25))-1;
    for (int i = 0; i <= cycles; i++)
    {
      ardu.digitalWrite(vibr, Arduino.HIGH);
      delay(25);
      ardu.digitalWrite(vibr, Arduino.LOW);
      delay(off_time);
    }
  } else {
    delay(iduration);
  }
}

void openDataFolder() {
  printInfo("INFO:Opening folder:"+dataPath(""));
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
  door_angle=closeAngle;
  while(door_angle<openAngle){
    ardu.servoWrite(door,door_angle);
    door_angle++;
    delay(doorDelay);
  }
}

void addWindowInfo(){
  surface.setTitle("Stage 2f "+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second()+ "  Iteration:"+numIteration+ " OK:"+numOk+" Fail:"+numFail+" freq:"+freq);
}


//Experiment specific functions

boolean checkFields() {

  if ((fld_time.getValueI() != 0)||
  (fld_response_time.getValueI() != 0) || 
  (fld_repeats.getValueI()!=0) || 
  (fld_time_experiments.getValueI() != 0) || 
  (fld_name.getText() != "")) {
    return true;
  } else {
    printInfo("ERROR: No empty fields allowed! ");
    return false;
  }
}

void writeParamsToFile(String flname)
{
  printInfo("FILE: "+flname);
  String datetime = new String(day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
  printInfo(datetime);
  String params = new String(
    "time:"+ fld_time.getValueI() +
    " open_door:"+ fld_door_time.getValueI()+
    "inside time:"+ fld_inside_time.getValueI()+
    " time_response:"+ fld_response_time.getValueI()+
    " repeats:"+fld_repeats.getValueI() +
    " exp_time:"+fld_time_experiments.getValueI()
  );
  printInfo(params);
  appendTextToFile(flname, "started: "+datetime);
  appendTextToFile(flname, params);
}

void stopExperiment(){
  runLoop=false;
  runExperiment=false;
  abortExperiment=true;
}


int[] makeList(){
  int totalNum = fld_repeats.getValueI();
  int experimentsLeft=(int(fld_repeats.getValueI()*(sldProportion.getValueF()/100)));
  int countChanged = 0;
  int[] list = new int[totalNum];
  for(int i=0;i<list.length;i++){
    list[i]=40;
  }
  while(experimentsLeft>0){
    for(int i=0;i<list.length;i++){
      delay(int(random(0,30)));
      if((list[i]==40)&&(experimentsLeft>0)){
        if(int(random(0,2))==1){
          list[i]=20;
          experimentsLeft--;
        }
      }
    }
  }
  println(list);
  return list;
}

void randomizeFreq()
{
  if(int(random(2))==1){
    freq=20;
  }else{
    freq=40;
  }
}

void startExperiment() {
  int[] frequencies = makeList();
  runExperiment=true;
  filename = fld_name.getText()+".txt";
  vibr_dur = fld_time.getValueI();
  waitForNextExperiment=fld_time_experiments.getValueI();
  repeats = fld_repeats.getValueI();
  numIteration=0;
  numOk=0;
  numFail=0;
  pokeFullL=0;
  pokeFullR=0;
  pokeTouchR=0;
  pokeTouchL=0;
  door_time = fld_time.getValueI();
  writeParamsToFile(filename);
  writeSeparator(filename);
  writeTableHeader(filename);  
    for(;numIteration<frequencies.length;numIteration++){
      if(!runExperiment){
        printInfo("RUN:Stopping!");
        writeSeparator(filename);
        appendTextToFile(filename,"aborted:"+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
        writeSeparator(filename);
        writeSeparator(filename);
        return;
      }
      boolean feedIt;
      boolean touchedPoke;
      String whichPoke="none";
      String status="null";
      feedIt=false;
      touchedPoke=false;
      addWindowInfo();
      freq=frequencies[numIteration];
      vibrate(freq,vibr_dur);
      addWindowInfo();
      timeStart=millis();
      timeStop=timeStart+fld_response_time.getValueI()+door_time;
      sensingInsideTime=fld_inside_time.getValueI();
      sensingInsideTime*=2;
      sensingInsideTime+=millis();
      if(fld_door_time.getValueI()>=0){
        delay(fld_door_time.getValueI());
      }
      openDoor();
      runLoop=true;
      printInfo("RUN:iter:"+numIteration+",freq:"+freq);

      while(runLoop){
        if(millis() >= timeStop){
          numFail++;
          closeDoor();
          pokeTime=0;
          runLoop=false;
          insideTime=(millis()-timeStart-door_time);
          status="timed_out";
          printInfo("RUN: timed out!");
          waitForNextExperiment=fldFailDoorTime.getValueI();
        } else if((ardu.digitalRead(pokeL)==Arduino.HIGH)&&(touchedPoke == false)){
          printInfo("RUN: left poke!");
          touchedPoke=true;
          pokeTime=millis()-timeStart;
          whichPoke="left";
          pokeTouchL++;
          if (freq==20){
            feedIt=true;
            status="ok";
            waitForNextExperiment=fld_time_experiments.getValueI();
          }else if(freq==40){
            status="failed";
            timeStop+=fldFailDoorTime.getValueI();
            waitForNextExperiment=fldFailDoorTime.getValueI();
          }
        } else if((ardu.digitalRead(pokeR)==Arduino.HIGH)&&(touchedPoke == false)){
          printInfo("RUN: right poke!");
          touchedPoke=true;
          pokeTime=millis()-timeStart-door_time;
          whichPoke="right";
          pokeTouchR++;
          if(freq==40){
            feedIt=true;
            status="ok";
            waitForNextExperiment=fld_time_experiments.getValueI();
          }else if(freq==20){
            status="failed";
            timeStop+=fldFailDoorTime.getValueI();
            waitForNextExperiment=fldFailDoorTime.getValueI();
          }
        }else if((ardu.digitalRead(inSensor)==Arduino.HIGH)&&(millis()>=sensingInsideTime)){
          insideTime=millis()-timeStart-door_time;
          printInfo("RUN: in!");
          if(feedIt){
            if(whichPoke=="right"){
              pokeFullR++;
            } else if(whichPoke=="left"){
              pokeFullL++;
            }
            numOk++;
            feed();  
          }else{
            numFail++;
          }
          closeDoor();
          runLoop=false;
        }
        delay(10);
      }
      addWindowInfo();
      appendTextToFile(filename,numIteration+","+freq+","+pokeTime+","+whichPoke+","+insideTime+","+status);
      printInfo("Waiting:"+waitForNextExperiment);
      delay(waitForNextExperiment);
      
    }
    if(abortExperiment){
      appendTextToFile(filename,"ABORTED!!");
    }
    writeSeparator(filename);
    appendTextToFile(filename,"finished:" + day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
    appendTextToFile(filename,"touchedL:"+pokeTouchL+"touchedR:"+pokeTouchR);
    appendTextToFile(filename,"FullL:"+pokeFullL+",FullR:"+pokeFullR);
    appendTextToFile(filename,"Ok:"+numOk+",fail:"+numFail);
    writeSeparator(filename);
    writeSeparator(filename);
    btn_start.setVisible(true);
    btn_stop.setVisible(false);
    printInfo("RUN: end of experiment");
}
