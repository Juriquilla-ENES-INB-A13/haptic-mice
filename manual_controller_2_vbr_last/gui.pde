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

public void fill_click(GButton source, GEvent event) { //_CODE_:btn_fill:241519:
  fill();
} //_CODE_:btn_fill:241519:

public void start_click1(GButton source, GEvent event) { //_CODE_:btn_start:428180:
  if(checkFields()&& !runExperiment){
    btn_start.setVisible(false);
    btn_stop.setVisible(true);
    thread("startExperiment");
  }
} //_CODE_:btn_start:428180:

public void open_click(GButton source, GEvent event) { //_CODE_:btn_open:719474:
  openDataFolder();
} //_CODE_:btn_open:719474:

public void setPort_click(GButton source, GEvent event) { //_CODE_:btn_setPort:396596:
  setArduino();
} //_CODE_:btn_setPort:396596:

public void feed_click(GButton source, GEvent event) { //_CODE_:btn_feed:628575:
thread("feed");
appendTextToFile(filename,(millis()-timeStart)+",feed");
} //_CODE_:btn_feed:628575:

public void stop_click(GButton source, GEvent event) { //_CODE_:btn_stop:242696:
  stopExperiment();
  btn_start.setVisible(true);
    btn_stop.setVisible(false);
} //_CODE_:btn_stop:242696:

public void btnOpenDoor_click(GButton source, GEvent event) { //_CODE_:btnOpenDoor:840315:
  thread("openDoor");
} //_CODE_:btnOpenDoor:840315:

public void btnCloseDoor_click(GButton source, GEvent event) { //_CODE_:btnCloseDoor:683991:
  thread("closeDoor");
} //_CODE_:btnCloseDoor:683991:

public void btnVibrationLow_click(GButton source, GEvent event) { //_CODE_:btnVibrationLow:343186:
appendTextToFile(filename,(millis()-timeStart)+",vibrH");
  thread("vibrateLower");
  waitingPoke=true;
  iteration++;
} //_CODE_:btnVibrationLow:343186:

public void btnVibrateHigh_click(GButton source, GEvent event) { //_CODE_:btnVibrateHigh:776184
appendTextToFile(filename,(millis()-timeStart)+",vibrL");
thread("vibrateHigher");
waitingPoke=true;
iteration++;
} //_CODE_:btnVibrateHigh:776184:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Haptic Mice - Manual Stage Vibration");
  lbl_experiment_name = new GLabel(this, 40, 300, 140, 20);
  lbl_experiment_name.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_experiment_name.setText("Experiment name:");
  lbl_experiment_name.setOpaque(false);
  fld_name = new GTextField(this, 180, 300, 90, 20, G4P.SCROLLBARS_NONE);
  fld_name.setOpaque(true);
  btn_fill = new GButton(this, 340, 200, 80, 30);
  btn_fill.setText("Fill");
  btn_fill.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  btn_fill.addEventHandler(this, "fill_click");
  btn_start = new GButton(this, 40, 360, 80, 30);
  btn_start.setText("Start");
  btn_start.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  btn_start.addEventHandler(this, "start_click1");
  btn_open = new GButton(this, 380, 360, 140, 30);
  btn_open.setText("Open data folder");
  btn_open.addEventHandler(this, "open_click");
  lst_port = new GDropList(this, 180, 20, 110, 80, 3, 10);
  lst_port.setItems(Arduino.list(), 0);
  lbl_port = new GLabel(this, 100, 20, 80, 20);
  lbl_port.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_port.setText("port:");
  lbl_port.setOpaque(false);
  btn_setPort = new GButton(this, 300, 20, 80, 20);
  btn_setPort.setText("Open");
  btn_setPort.addEventHandler(this, "setPort_click");
  lbl_connected = new GLabel(this, 410, 20, 160, 20);
  lbl_connected.setText("disconnected");
  lbl_connected.setOpaque(false);
  btn_feed = new GButton(this, 480, 200, 80, 30);
  btn_feed.setText("Feed");
  btn_feed.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  btn_feed.addEventHandler(this, "feed_click");
  btn_stop = new GButton(this, 180, 360, 80, 30);
  btn_stop.setText("stop!");
  btn_stop.setLocalColorScheme(GCScheme.RED_SCHEME);
  btn_stop.addEventHandler(this, "stop_click");
  fld_feed_l = new GTextField(this, 380, 160, 50, 20, G4P.SCROLLBARS_NONE);
  fld_feed_l.setText("1");
  fld_feed_l.setOpaque(true);
  lbl_feed_l = new GLabel(this, 340, 160, 40, 20);
  lbl_feed_l.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_feed_l.setText("L:");
  lbl_feed_l.setOpaque(false);
  lbl_feed_r = new GLabel(this, 470, 160, 40, 20);
  lbl_feed_r.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_feed_r.setText("R:");
  lbl_feed_r.setOpaque(false);
  fld_feed_r = new GTextField(this, 510, 160, 50, 20, G4P.SCROLLBARS_NONE);
  fld_feed_r.setText("1");
  fld_feed_r.setOpaque(true);
  fld_wait_to_feed = new GTextField(this, 480, 110, 50, 20, G4P.SCROLLBARS_NONE);
  fld_wait_to_feed.setOpaque(true);
  lbl_delay_feed = new GLabel(this, 340, 110, 140, 20);
  lbl_delay_feed.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_delay_feed.setText("delay to feed (ms)");
  lbl_delay_feed.setOpaque(false);
  lbl_pump_pulse = new GLabel(this, 340, 70, 110, 20);
  lbl_pump_pulse.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_pump_pulse.setText("Pump pulse (ms)");
  lbl_pump_pulse.setOpaque(false);
  fld_pump_pulse = new GTextField(this, 450, 70, 60, 20, G4P.SCROLLBARS_NONE);
  fld_pump_pulse.setOpaque(true);
  lblVibrDur = new GLabel(this, 40, 50, 160, 20);
  lblVibrDur.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblVibrDur.setText("Vibration duration (ms)");
  lblVibrDur.setOpaque(false);
  fldVibrDur = new GTextField(this, 200, 50, 60, 20, G4P.SCROLLBARS_NONE);
  fldVibrDur.setOpaque(true);
  btnOpenDoor = new GButton(this, 340, 240, 80, 30);
  btnOpenDoor.setText("Open door");
  btnOpenDoor.addEventHandler(this, "btnOpenDoor_click");
  btnCloseDoor = new GButton(this, 480, 240, 80, 30);
  btnCloseDoor.setText("Close door");
  btnCloseDoor.addEventHandler(this, "btnCloseDoor_click");
  btnVibrationLow = new GButton(this, 340, 280, 80, 30);
  btnVibrationLow.setText("Vibr .-");
  btnVibrationLow.addEventHandler(this, "btnVibrationLow_click");
  btnVibrateHigh = new GButton(this, 480, 280, 80, 30);
  btnVibrateHigh.setText("Vibr. +");
  btnVibrateHigh.addEventHandler(this, "btnVibrateHigh_click");
}

// Variable declarations 
// autogenerated do not edit
GLabel lbl_experiment_name; 
GTextField fld_name; 
GButton btn_fill; 
GButton btn_start; 
GButton btn_open; 
GDropList lst_port; 
GLabel lbl_port; 
GButton btn_setPort; 
GLabel lbl_connected; 
GButton btn_feed; 
GButton btn_stop; 
GTextField fld_feed_l; 
GLabel lbl_feed_l; 
GLabel lbl_feed_r; 
GTextField fld_feed_r; 
GTextField fld_wait_to_feed; 
GLabel lbl_delay_feed; 
GLabel lbl_pump_pulse; 
GTextField fld_pump_pulse; 
GLabel lblVibrDur; 
GTextField fldVibrDur; 
GButton btnOpenDoor; 
GButton btnCloseDoor; 
GButton btnVibrationLow; 
GButton btnVibrateHigh; 
