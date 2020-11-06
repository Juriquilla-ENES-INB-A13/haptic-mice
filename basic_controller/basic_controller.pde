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
int sensingInsideTime;
boolean runLoop =false;

//objects
Arduino ardu;

public void setup() {
  size(630, 350, JAVA2D);
  createGUI();
  customGUI();
}

public void draw() {
  addWindowInfo();
  background(230);
}

public void customGUI() {
  fld_freq.setNumericType(G4P.INTEGER);
  fld_repeats.setNumericType(G4P.INTEGER);
  fld_vibr_duration.setNumericType(G4P.INTEGER);
  fld_response_time.setNumericType(G4P.INTEGER);
  fld_time_experiments.setNumericType(G4P.INTEGER);
  btn_stop.setVisible(false);
}
