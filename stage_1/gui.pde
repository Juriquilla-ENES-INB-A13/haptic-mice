/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void fill_click(GButton source, GEvent event) { //_CODE_:btn_fill:689985:
  fill(pump);
} //_CODE_:btn_fill:689985:

public void startstop_click(GButton source, GEvent event) { //_CODE_:btn_startstop:979319:
if (checkFields()){
  btn_startstop.setText("Running!");
  btn_startstop.setLocalColorScheme(GCScheme.RED_SCHEME);
  doExperiment(fld_name.getText(),fld_repeats.getValueI());
  btn_startstop.setText("Start");
  btn_startstop.setLocalColorScheme(GCScheme.GREEN_SCHEME);  
}


} //_CODE_:btn_startstop:979319:

public void open_click(GButton source, GEvent event) { //_CODE_:btn_open:975310:
openDataFolder();
} //_CODE_:btn_open:975310:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Haptic Mice - Stage 1");
  lbl_frequency = new GLabel(this, 10, 10, 200, 20);
  lbl_frequency.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_frequency.setText("Frequency (Hz):");
  lbl_frequency.setOpaque(false);
  lbl_vibr_duration = new GLabel(this, 10, 50, 200, 20);
  lbl_vibr_duration.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_vibr_duration.setText("Vibration duration (s)");
  lbl_vibr_duration.setOpaque(false);
  lbl_time_response = new GLabel(this, 10, 130, 200, 20);
  lbl_time_response.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_time_response.setText("Time to response(s)");
  lbl_time_response.setOpaque(false);
  lbl_repeat = new GLabel(this, 10, 170, 200, 20);
  lbl_repeat.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_repeat.setText("Repeats (times);");
  lbl_repeat.setOpaque(false);
  lbl_wait_experiments = new GLabel(this, 10, 210, 200, 20);
  lbl_wait_experiments.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_wait_experiments.setText("Time between experiments (s):");
  lbl_wait_experiments.setOpaque(false);
  lbl_exp_name = new GLabel(this, 10, 250, 200, 20);
  lbl_exp_name.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_exp_name.setText("Experiment name:");
  lbl_exp_name.setOpaque(false);
  fld_freq = new GTextField(this, 210, 10, 110, 20, G4P.SCROLLBARS_NONE);
  fld_freq.setOpaque(true);
  fld_vibr_duration = new GTextField(this, 210, 50, 110, 20, G4P.SCROLLBARS_NONE);
  fld_vibr_duration.setOpaque(true);
  fld_response_time = new GTextField(this, 210, 130, 110, 20, G4P.SCROLLBARS_NONE);
  fld_response_time.setOpaque(true);
  fld_repeats = new GTextField(this, 210, 170, 110, 20, G4P.SCROLLBARS_NONE);
  fld_repeats.setOpaque(true);
  fld_time_experiments = new GTextField(this, 210, 210, 110, 20, G4P.SCROLLBARS_NONE);
  fld_time_experiments.setOpaque(true);
  fld_name = new GTextField(this, 210, 250, 110, 20, G4P.SCROLLBARS_NONE);
  fld_name.setOpaque(true);
  btn_fill = new GButton(this, 10, 280, 80, 30);
  btn_fill.setText("Fill");
  btn_fill.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  btn_fill.addEventHandler(this, "fill_click");
  btn_startstop = new GButton(this, 130, 280, 80, 30);
  btn_startstop.setText("Start");
  btn_startstop.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  btn_startstop.addEventHandler(this, "startstop_click");
  btn_open = new GButton(this, 240, 280, 80, 30);
  btn_open.setText("Open...");
  btn_open.addEventHandler(this, "open_click");
  lbl_door_time = new GLabel(this, 50, 90, 160, 20);
  lbl_door_time.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_door_time.setText("Time to open door (s)");
  lbl_door_time.setOpaque(false);
  fld_door_time = new GTextField(this, 210, 90, 110, 20, G4P.SCROLLBARS_NONE);
  fld_door_time.setOpaque(true);
}

// Variable declarations 
// autogenerated do not edit
GLabel lbl_frequency; 
GLabel lbl_vibr_duration; 
GLabel lbl_time_response; 
GLabel lbl_repeat; 
GLabel lbl_wait_experiments; 
GLabel lbl_exp_name; 
GTextField fld_freq; 
GTextField fld_vibr_duration; 
GTextField fld_response_time; 
GTextField fld_repeats; 
GTextField fld_time_experiments; 
GTextField fld_name; 
GButton btn_fill; 
GButton btn_startstop; 
GButton btn_open; 
GLabel lbl_door_time; 
GTextField fld_door_time; 
