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
    delay(timeFeed);
    ardu.digitalWrite(pump, Arduino.LOW);
    delay(50);
    cycles--;
  }
}

void vibrate20()
{
  int ifreq =20;
  int iduration = fld_time.getValueI();
  println("RUN:freq "+ifreq+",dur "+iduration);
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

void vibrate40()
{
  int ifreq =40;
  int iduration = fld_time.getValueI();
  println("RUN:freq "+ifreq+",dur "+iduration);
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
  surface.setTitle("Stage 2 "+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second()+ "  Iteration:"+numIteration+ " OK:"+numOk+" Fail:"+numFail+" freq:"+freq);
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
    "time:"+ fld_time.getValueI() +
    " open_door:"+ fld_door_time.getValueI()+
    " time_response:"+ fld_response_time.getValueI()+
    " repeats:"+fld_repeats.getValueI() +
    " exp_time:"+fld_time_experiments.getValueI()
  );
  println(params);
  appendTextToFile(flname, "started: "+datetime);
  appendTextToFile(flname, params);
}

void stopExperiment(){
  runLoop=false;
  runExperiment=false;
  abortExperiment=true;
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
  runExperiment=true;
  filename = fld_name.getText()+".txt";
  vibr_dur = fld_time.getValueI();
  waitForNextExperiment=fld_time_experiments.getValueI();
  repeats = fld_repeats.getValueI();
  numIteration=1;
  numOk=0;
  numFail=0;
  okR=0;
  okL=0;
  okInR=0;
  okInL=0;
  feedIt = false;
  touchedPoke= false;
  whichPoke ="none";
  status="null";
  door_time = fld_time.getValueI();
  writeParamsToFile(filename);
  writeSeparator(filename);
  writeTableHeader(filename);  
    while((numIteration<=repeats)&&runExperiment){
      if(!runExperiment){
        println("RUN:Stopping!");
        writeSeparator(filename);
        appendTextToFile(filename,"aborted:"+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
        writeSeparator(filename);
        writeSeparator(filename);
        return;
      }

      
      feedIt=false;
      touchedPoke=false;
      addWindowInfo();
      timeStart=millis();
      timeStop=timeStart+fld_response_time.getValueI()+fld_door_time.getValueI();
      sensingInsideTime=millis()+1000;
      runLoop=true;
      delay(fld_door_time.getValueI());
      openDoor();
      while(runLoop){
      ardu.digitalWrite(pump,Arduino.LOW);
     
        println("RUN:iter:"+numIteration+",freq:"+freq);
        if(millis() >= timeStop){
          if(touchedPoke==false){
            numFail++;
            pokeTime=0;
            insideTime=(millis()-timeStart-door_time);
            status="timed_out";
            println("RUN: timed out!");
          }
          runLoop=false;
        } else if((ardu.digitalRead(pokeL)==Arduino.HIGH)&&(touchedPoke == false)){
          println("RUN: left poke!");
          freq=20;
          addWindowInfo();
          touchedPoke=true;
          pokeTime=millis()-timeStart-door_time;
          whichPoke="left";
          status="ok";
          thread("vibrate20");
          freq=20;
          okL++;
          feedIt=true;
        } else if((ardu.digitalRead(pokeR)==Arduino.HIGH)&&(touchedPoke == false)){
          println("RUN: right poke!");
          freq=40;
          addWindowInfo();
          touchedPoke=true;
          pokeTime=millis()-timeStart-door_time;
          whichPoke="right";
          status="ok";
          thread("vibrate40");
          okR++;
          feedIt=true;
        }else if((ardu.digitalRead(inSensor)==Arduino.HIGH)&&(millis()>=sensingInsideTime)){
          insideTime=millis()-timeStart;
          println("RUN: in!");
          
          if(feedIt){
            if(whichPoke=="left"){
            okInL++;
          }
          if(whichPoke=="right"){
            okInR++;
          }
            numOk++;
            if(freq == 20){
              for(int times=0;times<fld_feed_l.getValueI();times++){
                feed();
                delay(200);
                
              }
            }
            else if(freq==40){
              for(int times=0;times<fld_feed_r.getValueI();times++){
                feed();
                delay(200);
                
              }
            }
          }
          feedIt=false;
          
        }
        delay(10);
      }
      addWindowInfo();
      appendTextToFile(filename,numIteration+","+freq+","+pokeTime+","+whichPoke+","+insideTime+","+status);
      closeDoor();
      ardu.digitalWrite(vibr,Arduino.LOW);
      ardu.servoWrite(door,door_angle);
      delay(waitForNextExperiment);
      numIteration++;
      freq=0;
    }
    if(abortExperiment){
      appendTextToFile(filename,"ABORTED!!");
    }
    writeSeparator(filename);
    appendTextToFile(filename,"inR:"+okR+",inL:"+okL);
    writeSeparator(filename);
    appendTextToFile(filename,"fullR:"+okInR+",fullL:"+okInL);
    writeSeparator(filename);
    appendTextToFile(filename,"finished:" + day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
    appendTextToFile(filename,"Ok:"+numOk+",fail:"+numFail);
    writeSeparator(filename);
    writeSeparator(filename);
    btn_start.setVisible(true);
    btn_stop.setVisible(false);
    println("RUN: end of experiment");
}
