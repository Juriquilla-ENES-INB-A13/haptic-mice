import g4p_controls.*;

import cc.arduino.*;
import org.firmata.*;

import processing.serial.*;

int vibr=3;
boolean run=false;

Arduino ardu;



void setup(){
  size(300,170);
  createGUI();
  fldFreq.setNumericType(G4P.INTEGER);
  fldFreq.setText("80");
}

public void draw(){
}

public void runTest(){
  while(run){
    vibrate();
    delay(2000);
  }
}
  
