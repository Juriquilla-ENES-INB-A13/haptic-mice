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

public void btn_fill_click1(GButton source, GEvent event) { //_CODE_:btn_fill:651880:
  println("btn_fill - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:btn_fill:651880:

public void btn_start_stop_click1(GButton source, GEvent event) { //_CODE_:btn_startstop:351941:
  println("btn_startstop - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:btn_startstop:351941:

public void btn_open_click(GButton source, GEvent event) { //_CODE_:btn_open:419894:
  println("btn_open - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:btn_open:419894:

public void fld_freq1_click(GTextField source, GEvent event) { //_CODE_:fld_freq1:641981:
  println("fld_freq1 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:fld_freq1:641981:

public void fld_wait_click(GTextField source, GEvent event) { //_CODE_:fld_wait:437514:
  println("fld_wait - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:fld_wait:437514:

public void fld_freq2_click(GTextField source, GEvent event) { //_CODE_:fld_freq2:229347:
  println("fld_freq2 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:fld_freq2:229347:

public void fld_time2_click(GTextField source, GEvent event) { //_CODE_:fld_time2:678785:
  println("fld_time2 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:fld_time2:678785:

public void fld_repeats_click(GTextField source, GEvent event) { //_CODE_:fld_repeats:547788:
  println("fld_repeats - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:fld_repeats:547788:

public void fld_time_bet_expe_clk(GTextField source, GEvent event) { //_CODE_:fld_time_between_experiments:762381:
  println("fld_time_between_experiments - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:fld_time_between_experiments:762381:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  lbl_freq1 = new GLabel(this, 20, 20, 80, 20);
  lbl_freq1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_freq1.setText("freq1:");
  lbl_freq1.setOpaque(false);
  lbl_freq2 = new GLabel(this, 20, 100, 80, 20);
  lbl_freq2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_freq2.setText("freq2:");
  lbl_freq2.setOpaque(false);
  lbl_time1 = new GLabel(this, 200, 20, 80, 20);
  lbl_time1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_time1.setText("time1:");
  lbl_time1.setOpaque(false);
  lbl_time2 = new GLabel(this, 200, 100, 80, 20);
  lbl_time2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_time2.setText("time2:");
  lbl_time2.setOpaque(false);
  lbl_wait = new GLabel(this, 20, 60, 80, 20);
  lbl_wait.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_wait.setText("wait (s):");
  lbl_wait.setOpaque(false);
  lbl_time_betwen_experiments = new GLabel(this, 20, 180, 210, 20);
  lbl_time_betwen_experiments.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_time_betwen_experiments.setText("Time between experiments (s):");
  lbl_time_betwen_experiments.setOpaque(false);
  lbl_repeats = new GLabel(this, 20, 140, 80, 20);
  lbl_repeats.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lbl_repeats.setText("Repeats:");
  lbl_repeats.setOpaque(false);
  btn_fill = new GButton(this, 20, 230, 80, 30);
  btn_fill.setText("Fill");
  btn_fill.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  btn_fill.addEventHandler(this, "btn_fill_click1");
  btn_startstop = new GButton(this, 150, 230, 80, 30);
  btn_startstop.setText("Start");
  btn_startstop.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  btn_startstop.addEventHandler(this, "btn_start_stop_click1");
  btn_open = new GButton(this, 280, 230, 80, 30);
  btn_open.setText("Open...");
  btn_open.addEventHandler(this, "btn_open_click");
  fld_freq1 = new GTextField(this, 100, 20, 80, 20, G4P.SCROLLBARS_NONE);
  fld_freq1.setOpaque(true);
  fld_freq1.addEventHandler(this, "fld_freq1_click");
  fld_time1 = new GTextField(this, 280, 20, 80, 20, G4P.SCROLLBARS_NONE);
  fld_time1.setOpaque(true);
  fld_wait = new GTextField(this, 100, 60, 80, 20, G4P.SCROLLBARS_NONE);
  fld_wait.setOpaque(true);
  fld_wait.addEventHandler(this, "fld_wait_click");
  fld_freq2 = new GTextField(this, 100, 100, 80, 20, G4P.SCROLLBARS_NONE);
  fld_freq2.setOpaque(true);
  fld_freq2.addEventHandler(this, "fld_freq2_click");
  fld_time2 = new GTextField(this, 280, 100, 80, 20, G4P.SCROLLBARS_NONE);
  fld_time2.setOpaque(true);
  fld_time2.addEventHandler(this, "fld_time2_click");
  fld_repeats = new GTextField(this, 100, 140, 80, 20, G4P.SCROLLBARS_NONE);
  fld_repeats.setOpaque(true);
  fld_repeats.addEventHandler(this, "fld_repeats_click");
  fld_time_between_experiments = new GTextField(this, 220, 180, 80, 20, G4P.SCROLLBARS_NONE);
  fld_time_between_experiments.setOpaque(true);
  fld_time_between_experiments.addEventHandler(this, "fld_time_bet_expe_clk");
}

// Variable declarations 
// autogenerated do not edit
GLabel lbl_freq1; 
GLabel lbl_freq2; 
GLabel lbl_time1; 
GLabel lbl_time2; 
GLabel lbl_wait; 
GLabel lbl_time_betwen_experiments; 
GLabel lbl_repeats; 
GButton btn_fill; 
GButton btn_startstop; 
GButton btn_open; 
GTextField fld_freq1; 
GTextField fld_time1; 
GTextField fld_wait; 
GTextField fld_freq2; 
GTextField fld_time2; 
GTextField fld_repeats; 
GTextField fld_time_between_experiments; 
