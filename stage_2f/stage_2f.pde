import g4p_controls.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.Arrays;
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

//variables
boolean runLoop;
boolean runExperiment=false;
boolean abortExperiment=false;
int sensingInsideTime;
int port = 0;
int timeFeed = 4;
int cycleFeed = 1;
int closeAngle = 27;
int openAngle = 75;
int doorDelay = 10;
int numOk = 0;
int numFail = 0;
int numIteration = 0;
int freq;
int vibr_dur;
int door_time;
int timeStart;
int timeStop;
int door_angle;
int waitForNextExperiment;
int repeats;
int pokeTime;
int insideTime;
String filename;
int pokeFullL;
int pokeFullR;
int pokeTouchR;
int pokeTouchL;

//objects
Arduino ardu;

public void setup(){
  size(950, 410, JAVA2D);
  createGUI();
  customGUI();
  appendTextToFile("log.txt","=======================================================");
  appendTextToFile("log.txt",day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
}

public void draw(){
  background(230);
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
 fld_time.setNumericType(G4P.INTEGER); 
 fld_door_time.setNumericType(G4P.INTEGER);
 fld_response_time.setNumericType(G4P.INTEGER);
 fld_repeats.setNumericType(G4P.INTEGER); 
 fld_time_experiments.setNumericType(G4P.INTEGER);
 fld_inside_time.setNumericType(G4P.INTEGER);
 fld_inside_time.setText("500");
 fld_pump_pulse.setNumericType(G4P.INTEGER);
 fld_pump_pulse.setText(Integer.toString(timeFeed));
 fldFailDoorTime.setNumericType(G4P.INTEGER);
 fld_time.setText("2000");
 fld_door_time.setText("200");
 fld_response_time.setText("3000");
 fld_repeats.setText("20");
 
 fld_time_experiments.setText("2000");
 
 
 
 sldProportion.setValue(80);
 btn_stop.setVisible(false);
}
