import processing.serial.*;
import g4p_controls.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.lang.*;

Serial port;
int val;
boolean run=false;

public void setup(){
  size(300, 170, JAVA2D);
  createGUI();
  customGUI();
  
  
}

public void draw(){
  background(230);
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}
