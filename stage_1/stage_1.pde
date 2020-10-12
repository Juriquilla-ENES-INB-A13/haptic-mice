import g4p_controls.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.lang.*;
import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

//connections
int vibr = 3;
int pump = 5;
int pokeL = 8;
int pokeR = 7;
int door = 4;
int inSensor = 2;
int port = 0;

//Other variables
int timeFeed = 5;
int closeAngle = 40;
int openAngle = 85;
int doorDelay = 15;
int numOk = 0;
int numFail = 0;
int numIteration = 0;
boolean runLoop;

//objects
Arduino ardu;

public void setup() {
  ardu = new Arduino(this, Arduino.list()[port], 57600);
  ardu.pinMode(vibr, Arduino.OUTPUT);
  ardu.pinMode(pump, Arduino.OUTPUT);
  ardu.pinMode(vibr, Arduino.OUTPUT);
  ardu.pinMode(pokeL, Arduino.INPUT);
  ardu.pinMode(pokeR, Arduino.INPUT);
  ardu.pinMode(door, Arduino.SERVO);
  ardu.pinMode(inSensor, Arduino.INPUT);
  size(630, 430, JAVA2D);
  createGUI();
  customGUI();
  ardu.servoWrite(door,closeAngle);
}

public void draw() {
  setExperimentTitle();

  background(230);
}

public void customGUI() {
  fld_freq.setNumericType(G4P.INTEGER);
  fld_repeats.setNumericType(G4P.INTEGER);
  fld_vibr_duration.setNumericType(G4P.INTEGER);
  fld_response_time.setNumericType(G4P.DECIMAL);
  fld_time_experiments.setNumericType(G4P.DECIMAL);
  fld_door_time.setNumericType(G4P.INTEGER);
  fld_close_door.setNumericType(G4P.INTEGER);

}

//common functions
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
void fill(int motor)
{
  println("Filling!");
  ardu.digitalWrite(motor, Arduino.HIGH);
  delay(3000);
  ardu.digitalWrite(motor, Arduino.LOW);
  println("Done!");
}
void feed(int motor)
{
  ardu.digitalWrite(motor, Arduino.HIGH);
  delay(timeFeed);
  ardu.digitalWrite(motor, Arduino.LOW);
  delay(10);
  ardu.digitalWrite(motor, Arduino.HIGH);
  delay(timeFeed);
  ardu.digitalWrite(motor, Arduino.LOW);
}

void vibrate()
{
  int ifreq=fld_freq.getValueI();
  int iduration=fld_vibr_duration.getValueI()*1000;
  if (ifreq > 0)
  {
    int off_time, duration;
    off_time = (1000/ifreq)-25;
    duration = (ifreq*iduration)-1;
    for (int i = 0; i <= duration; i++)
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


boolean checkFields() {
  boolean test;
  if ((fld_freq.getValueI() != 0) || (fld_vibr_duration.getValueI() != 0) || (fld_response_time.getValueI() != 0) || (fld_repeats.getValueI()!=0) || (fld_time_experiments.getValueI() != 0) || (fld_name.getText() != "")||(fld_close_door.getValueI() != 0)) {
    test=true;
  } else {
    println("ERROR: No empty fields allowed! ");
    test=false;
  }
  return test;
}
void openDataFolder() {
  println("Opening folder:"+dataPath(""));
  if (System.getProperty("os.name").toLowerCase().contains("windows")) {
    launch("explorer.exe"+" "+dataPath(""));
  } else {
    launch(dataPath(""));
  }
}
void writeParamsToFile(String flname)
{
  println("FILE:"+flname);
  String datetime = new String(day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
  println(datetime);
  String params = new String("freq:" + fld_freq.getValueI()+" time:"+fld_vibr_duration.getValueF()+" response_time:"+fld_response_time.getValueF()+" repeats:"+fld_repeats.getValueI()+" exp_time:"+fld_time_experiments.getValueF());
  println(params);
  appendTextToFile(flname, "started: "+datetime);
  appendTextToFile(flname, params);
}
void writeTableHeader(String flname)
{
  appendTextToFile(flname, "repeat,ellapsed_time,pokeL,pokeR");
}
void writeSeparator(String flname)
{
  appendTextToFile(flname, "");
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

void setExperimentTitle(){
  surface.setTitle("Stage 1 "+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second()+ "  Iteration:"+numIteration+ " OK:"+numOk+" Fail:"+numFail);
}

void doExperiment() {
   {
    numIteration=0;
    numOk=0;
    numFail=0;
    int times = fld_repeats.getValueI();
    boolean feedIt;
    boolean touchedPoke;
    String filename = fld_name.getText()+".txt";
    writeParamsToFile(filename);
    writeSeparator(filename);
    writeTableHeader(filename);  
    for (int i=1; i<=times; i++) {
      setExperimentTitle();
      numIteration=i;
      StringBuilder chain = new StringBuilder(Integer.toString(i));
      vibrate();
      delay(fld_door_time.getValueI()*1000);
      openDoor();
      int timeStart=millis();
      int timeStop=timeStart+int(fld_response_time.getValueF()*1000);
      runLoop=true;
      feedIt=false;
      touchedPoke=false;
      while(runLoop){
        setExperimentTitle();
        println(ardu.digitalRead(pokeL) + ardu.digitalRead(pokeR));
        if(millis() >= timeStop){
          chain.append(","+float((millis()-timeStart)/1000)+",0,0");
          numFail++;
          delay(fld_close_door.getValueI()*1000);

          closeDoor();
          runLoop=false;
        } else if((ardu.digitalRead(pokeL)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(","+float((millis()-timeStart)/1000)+",1,0");
          feedIt=true;
          touchedPoke=true;
        } else if((ardu.digitalRead(pokeR)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(","+float((millis()-timeStart)/1000)+",0,1");
          feedIt=true;
          touchedPoke=true;
        }else if(ardu.digitalRead(inSensor)==Arduino.HIGH){
          if(feedIt){
            numOk++;
            closeDoor();
            feed(pump);
            runLoop=false;
          }
        }
      }
      appendTextToFile(filename,chain.toString());
      delay(int(fld_time_experiments.getValueF()*1000));
    }
    writeSeparator(filename);
    appendTextToFile(filename,"finished:" + day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
    writeSeparator(filename);
    writeSeparator(filename);

  }
}
