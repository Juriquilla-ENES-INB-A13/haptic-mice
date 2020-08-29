
import g4p_controls.*;



public void setup(){
  size(350, 320, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  
}

public void draw(){
  background(230);
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
  fld_freq.setNumericType(G4P.INTEGER);
  fld_repeats.setNumericType(G4P.INTEGER);
  fld_vibr_duration.setNumericType(G4P.DECIMAL);
  fld_response_time.setNumericType(G4P.DECIMAL);
  fld_time_experiments.setNumericType(G4P.DECIMAL);


}
