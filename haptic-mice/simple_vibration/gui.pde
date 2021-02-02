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

public void vibr_click1(GButton source, GEvent event) { //_CODE_:btn_vibrate:960415:
  vibrate(fld_freq.getValueI(),fld_vibr_duration.getValueI());
  
} //_CODE_:btn_vibrate:960415:

public void setPort_click(GButton source, GEvent event) { //_CODE_:btn_setPort:379419:
  setArduino();
} //_CODE_:btn_setPort:379419:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Haptic Mice - Stage 1");
  lbl_frequency = new GLabel(this, -70, 50, 200, 20);
  lbl_frequency.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_frequency.setText("Frequency (Hz):");
  lbl_frequency.setOpaque(false);
  lbl_vibr_duration = new GLabel(this, -70, 90, 200, 20);
  lbl_vibr_duration.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_vibr_duration.setText("Vibration duration (ms)");
  lbl_vibr_duration.setOpaque(false);
  fld_freq = new GTextField(this, 130, 50, 110, 20, G4P.SCROLLBARS_NONE);
  fld_freq.setOpaque(true);
  fld_vibr_duration = new GTextField(this, 130, 90, 110, 20, G4P.SCROLLBARS_NONE);
  fld_vibr_duration.setOpaque(true);
  btn_vibrate = new GButton(this, 310, 70, 80, 30);
  btn_vibrate.setText("vibrate");
  btn_vibrate.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  btn_vibrate.addEventHandler(this, "vibr_click1");
  lbl_port = new GLabel(this, 0, 10, 80, 20);
  lbl_port.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lbl_port.setText("port:");
  lbl_port.setOpaque(false);
  lst_port = new GDropList(this, 80, 10, 110, 80, 3, 10);
  lst_port.setItems(Arduino.list(), 0);
  btn_setPort = new GButton(this, 200, 10, 80, 20);
  btn_setPort.setText("Open Port");
  btn_setPort.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  btn_setPort.addEventHandler(this, "setPort_click");
  lbl_connected = new GLabel(this, 280, 10, 186, 20);
  lbl_connected.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_connected.setText("disconnected");
  lbl_connected.setOpaque(false);
}

// Variable declarations 
// autogenerated do not edit
GLabel lbl_frequency; 
GLabel lbl_vibr_duration; 
GTextField fld_freq; 
GTextField fld_vibr_duration; 
GButton btn_vibrate; 
GLabel lbl_port; 
GDropList lst_port; 
GButton btn_setPort; 
GLabel lbl_connected; 
