// Need G4P library
import g4p_controls.*;
import processing.serial.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.

  String osName = System.getProperty("os.name").toLowerCase(); 


public void setup(){
  size(620, 400, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  
}

public void draw(){
  background(230);
  lbl_time.setText(hour()+":"+minute()+":"+second());
  lbl_date.setText(day()+"-"+month()+"-"+year());
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}
