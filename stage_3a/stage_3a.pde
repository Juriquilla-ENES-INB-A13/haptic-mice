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
int closeAngle = 40;
int openAngle = 85;
int doorDelay = 15;
int numOk = 0;
int numFail = 0;
int numIteration = 0;
int freq1;
int freq2;
boolean runLoop;
boolean stopExperiment;

//objects
Arduino ardu;

public void setup(){

  size(630, 480, JAVA2D);
  createGUI();
  customGUI();

  
}

public void draw(){
  background(230);
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
 fld_freq1.setNumericType(G4P.INTEGER); 
 fld_time1.setNumericType(G4P.INTEGER); 
 fld_wait_time.setNumericType(G4P.INTEGER); 
 fld_freq2.setNumericType(G4P.INTEGER); 
 fld_time2.setNumericType(G4P.INTEGER); 
 fld_door_time.setNumericType(G4P.INTEGER);
 fld_response_time.setNumericType(G4P.INTEGER);
 fld_repeats.setNumericType(G4P.INTEGER); 
 fld_time_experiments.setNumericType(G4P.INTEGER); 
 fld_close_door.setNumericType(G4P.INTEGER); 
}
