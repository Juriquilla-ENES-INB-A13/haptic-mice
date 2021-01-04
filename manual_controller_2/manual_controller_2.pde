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
boolean runLoop;
boolean runExperiment=false;
boolean abortExperiment=false;
int sensingInsideTime;
int port = 0;
int timeFeed = 5;
int cycleFeed = 0;
int closeAngle = 45;
int openAngle = 75;
int doorDelay = 15;
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
int okInR;
int okInL;
int okR;
int okL;
int insideWait;
int timesFeed;
int iteration;
String filename;
boolean feedIt;
boolean touchedPoke;
boolean feeding=false;
String whichPoke="none";
String status="null";
boolean closedDoor=false;
boolean doorWorking=false;
int openDoorDelay=1000;

//objects
Arduino ardu;

public void setup(){
  size(630, 410, JAVA2D);
  println(Arduino.list());
  createGUI();
  customGUI();
}

public void draw(){
  background(230);
  addWindowInfo();
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
  fld_response_time.setText("3000");
  fld_name.setText("test");
 fld_response_time.setNumericType(G4P.INTEGER);
 fld_feed_r.setNumericType(G4P.INTEGER);
 fld_feed_l.setNumericType(G4P.INTEGER);
 fld_wait_to_feed.setNumericType(G4P.INTEGER);
 fld_wait_to_feed.setText("0");
 fld_pump_pulse.setNumericType(G4P.INTEGER);
 fld_pump_pulse.setText(Integer.toString(timeFeed));
 fld_inside_time.setNumericType(G4P.INTEGER);
 fld_inside_time.setText("500");
 fldVibDur.setNumericType(G4P.INTEGER);
 fldVibDur.setText("1000");
 btn_stop.setVisible(false);
}
