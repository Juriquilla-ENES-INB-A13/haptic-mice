import g4p_controls.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.lang.*;
import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

//connections
int vibr = 3;
int vibr2 = 2;

//Other variables
int timeFeed = 2;
int closeAngle = 40;
int openAngle = 85;
int doorDelay = 15;
int numOk = 0;
int numFail = 0;
int numIteration = 0;
int sensingInsideTime;
boolean runLoop =false;

//objects
Arduino ardu;

public void setup() {
  size(450,180, JAVA2D);
  createGUI();
  customGUI();
}

public void draw() {
 
  background(230);
}

public void customGUI() {
  fld_freq.setNumericType(G4P.INTEGER);
  fld_vibr_duration.setNumericType(G4P.INTEGER);

}
void keyPressed(){
  if(key == ENTER){
    vibrate(fld_freq.getValueI(),fld_vibr_duration.getValueI());
  }
}
