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
int timeFeed = 5;

//objects
Arduino ardu;

public void setup(){
  ardu = new Arduino(this, Arduino.list()[port], 57600);
  ardu.pinMode(vibr,Arduino.OUTPUT);
  ardu.pinMode(pump,Arduino.PWM);
  ardu.pinMode(vibr,Arduino.OUTPUT);
  ardu.pinMode(pokeL,Arduino.INPUT);
  ardu.pinMode(pokeR,Arduino.INPUT);
  ardu.pinMode(door,Arduino.SERVO);
  ardu.pinMode(inSensor,Arduino.INPUT);
  size(330, 290, JAVA2D);
  createGUI();
  customGUI();
  
}

public void draw(){
  surface.setTitle("Stage 1 "+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
  background(230);
}

public void customGUI(){
  fld_freq.setNumericType(G4P.INTEGER);
  fld_repeats.setNumericType(G4P.INTEGER);
  fld_vibr_duration.setNumericType(G4P.DECIMAL);
  fld_response_time.setNumericType(G4P.DECIMAL);
  fld_time_experiments.setNumericType(G4P.DECIMAL);
}

void appendTextToFile(String filename, String text){
  File f = new File(dataPath(filename));
  if(!f.exists()){
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(text);
    out.close();
  }catch (IOException e){
      e.printStackTrace();
  }
}

void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
  }catch(Exception e){
    e.printStackTrace();
  }
}   

void fill(int motor)
{
  println("Filling!");
  ardu.digitalWrite(motor,Arduino.HIGH);
  delay(3000);
  ardu.digitalWrite(motor,Arduino.LOW);
  println("Done!");
}

void feed(int motor)
{
  ardu.digitalWrite(motor,Arduino.HIGH);
  delay(timeFeed);
  ardu.digitalWrite(motor,Arduino.LOW);
  delay(10);
  ardu.digitalWrite(motor,Arduino.HIGH);
  delay(timeFeed);
  ardu.digitalWrite(motor,Arduino.LOW);
}

void vibrate(int ifreq,int iduration)
{
  if(ifreq > 0)
  {
    int off_time,duration;
    off_time = (1000/ifreq);
    duration = (ifreq*iduration)-1;
    for (int i = 0; i <= duration; i++)
    {
     ardu.digitalWrite(3,Arduino.HIGH);
     delay(10);
     ardu.digitalWrite(3,Arduino.LOW);
     delay(off_time);
    }
  } else {
    delay(iduration);
  }
}

void doExperiment(){
  StringBuilder chain = new StringBuilder("");
  chain.append(fld_freq.getValueI());
  chain.append(",");
  chain.append(fld_vibr_duration.getValueF());
  chain.append(",");
  chain.append(fld_response_time.getValueF());
  chain.append(",");
  chain.append(fld_repeats.getValueI());
  println(chain);
  
}

boolean checkFields(){
  boolean test;
  if ((fld_freq.getValueI() != 0) || (fld_vibr_duration.getValueI() != 0) || (fld_response_time.getValueI() != 0) || (fld_repeats.getValueI()!=0) || (fld_time_experiments.getValueI() != 0) || (fld_name.getText() != "")){
    test=true;
  } else {
    println("ERROR: No empty fields allowed! ");
    test=false;
  }
  return test;
}
