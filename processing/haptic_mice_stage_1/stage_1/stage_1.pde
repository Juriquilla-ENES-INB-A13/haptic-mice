
import g4p_controls.*;
import java.io.BufferedWriter;
import java.io.FileWriter;


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

/**
 * Creates a new file including all subfolders
 */
void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
  }catch(Exception e){
    e.printStackTrace();
  }
}    
