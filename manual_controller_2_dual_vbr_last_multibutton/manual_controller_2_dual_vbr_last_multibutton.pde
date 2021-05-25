/*
Manual control for double pumps, multiple button frequencies
*/


import g4p_controls.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.lang.*;
import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

//connections & variables
int vibr = 3;
int pumpL = 5;
int pumpR = 6;
int pokeL = 8;
int pokeR = 7;
int door = 4;
int inSensor = 2;
int freqList[] = new int[]{20, //Freq1
                              26, //Freq2
                              32, //Freq3
                              38, //Freq4
                              44, //Freq5
                              50, //Freq6
                              56, //Freq7
                              62, //Freq8
                              68, //Freq9
                              74, //Freq10
                              80};//Freq11 

boolean doorOpen;
boolean runLoop;
boolean runExperiment=false;
boolean abortExperiment=false;
int sensingInsideTime;
int port = 0;
int timeFeed = 5;
int cycleFeed = 10;
int closeAngle = 6;
int openAngle = 52;
int doorDelay = 12;
int numOk = 0;
int numFail = 0;
int numIteration = 0;
int freq = 0;
int vibr_dur;
int door_time;
int timeStart;
int timeStop;
int door_angle;
int waitForNextExperiment;
int repeats;
int pokeTime;
int insideTime;
int InR;
int InL;
int InW;
int insideWait;
int timesFeed;
int iteration;
int maxFreq = 80;
int minFreq = 20;
int feedTimesL=0;
int feedTimesR=0;
String filename;
boolean feedIt;
boolean touchedPoke;
boolean feeding=false;
boolean waitingPoke=false;
String whichPoke="none";
String status="null";


//objects
Arduino ardu;

public void setup(){
  size(630, 610, JAVA2D);
  println(Arduino.list());
  createGUI();
  customGUI();
}

public void draw(){
  background(230);
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
  


 fld_feed_r.setNumericType(G4P.INTEGER);
 fld_feed_l.setNumericType(G4P.INTEGER);
 fld_wait_to_feed.setNumericType(G4P.INTEGER);
 fld_wait_to_feed.setText("0");
 fld_pump_pulse.setNumericType(G4P.INTEGER);
 fld_pump_pulse.setText(Integer.toString(timeFeed));

 fldVibrDur.setNumericType(G4P.INTEGER);
 fldVibrDur.setText("1000");
 btn_stop.setVisible(false);
   btnCloseDoor.setVisible(false);
  btnOpenDoor.setVisible(false);

  btn_start.setVisible(false);
  btn_feedL.setVisible(false);
  btn_fillL.setVisible(false);
  btnFeedR.setVisible(false);
  btnFillR.setVisible(false);
  btn_1.setText(freqList[0]+"Hz");
  btn_2.setText(freqList[1]+"Hz");
  btn_3.setText(freqList[2]+"Hz");
  btn_4.setText(freqList[3]+"Hz");
  btn_5.setText(freqList[4]+"Hz");
  btn_6.setText(freqList[5]+"Hz");
  btn_7.setText(freqList[6]+"Hz");
  btn_8.setText(freqList[7]+"Hz");
  btn_9.setText(freqList[8]+"Hz");
  btn_10.setText(freqList[9]+"Hz");
  btn_11.setText(freqList[10]+"Hz");
  
  btn_1.setVisible(false);
  btn_2.setVisible(false);
  btn_3.setVisible(false);
  btn_4.setVisible(false);
  btn_5.setVisible(false);
  btn_6.setVisible(false);
  btn_7.setVisible(false);
  btn_8.setVisible(false);
  btn_9.setVisible(false);
  btn_10.setVisible(false);
  btn_11.setVisible(false);
  
}
