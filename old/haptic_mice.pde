import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;
import controlP5.*;
import java.util.*;

int serialPortNumber;
String osName;
int motorL = 6;
int motorR = 5;
int motorV = 3;
int sensorL = 2;
int sensorR = 4;
int timeFeed = 100;
int startTime = 0;
int timeout = 0;
int counterMain = 0;
int counterOther = 0;

Arduino ardu;
ControlP5 cp5;
Textfield fldFreq1;
Textfield fldFreq2;
Textfield fldTime1;
Textfield fldTime2;
Textfield fldTimeout;
Textfield fldInterval;
Textfield fldName;

Button btnOpen;
Button btnRun;
Button btnFill;
Button btnLeft;
Button btnRight;

void setup()
{
  println(Arduino.list());
  size(250,150);
  background(0);
  surface.setTitle("Haptic Mice");
  cp5 = new ControlP5(this);
  fldTimeout = cp5.addTextfield("timeout")
    .setPosition(0,0)
    .setSize(40,20)
    .setText("0");
  fldFreq1 = cp5.addTextfield("freq1")
    .setPosition(110,0)
    .setSize(40,20)
    .setText("0");
  fldTime1 = cp5.addTextfield("time1")
  .setPosition(190,0)
  .setSize(40,20)
  .setText("0");
  fldInterval = cp5.addTextfield("interval")
  .setPosition(150,40)
  .setSize(40,20)
  .setText("0");
  fldFreq2 = cp5.addTextfield("freq2")
    .setPosition(110,80)
    .setSize(40,20)
    .setText("0");
  fldTime2 = cp5.addTextfield("time2")
   .setPosition(190,80)
   .setSize(40,20)
   .setText("0");
   btnFill = cp5.addButton("fill")
  .setPosition(0,100)
  ;
  btnRun = cp5.addButton("run")
    .setPosition(160,130)
    .setSize(80,20)
    ;
  btnLeft = cp5.addButton("left")
    .setPosition(0,130);
  btnRight = cp5.addButton("right")
    .setPosition(80,130);
  btnOpen = cp5.addButton("open")
   .setPosition(0,50);

    ardu = new Arduino(this,Arduino.list()[0],57600);
    ardu.pinMode(2,Arduino.INPUT);
    ardu.pinMode(4,Arduino.INPUT);
    ardu.pinMode(3,Arduino.OUTPUT);
    ardu.pinMode(5,Arduino.OUTPUT);
    ardu.pinMode(6,Arduino.OUTPUT);
    println("==================================");

}

void draw()
{
}

public void controlEvent(ControlEvent event)
{
  if (event.getController().getName() == "run")
  {
    if(int(fldFreq1.getText())==int(fldFreq2.getText())){
      println("Frequencies cannot be same!");
      return;
    }
    println("Vibration1: "+int(fldFreq1.getText())+"hz,"+int(fldTime1.getText())+"s");
    vibrate(int(fldFreq1.getText()),int(fldTime1.getText()));
    println("Interval:"+int(fldInterval.getText())+"s");
    delay(int(fldInterval.getText()));
    println("Vibration2: "+int(fldFreq2.getText())+"hz,"+int(fldTime2.getText())+"s");
    vibrate(int(fldFreq2.getText()),int(fldTime2.getText()));
    if((int(fldFreq1.getText()))>(int(fldFreq2.getText()))){
      println("Testing R");
      doTestL();
    }else if((int(fldFreq1.getText()))<(int(fldFreq2.getText()))){
      println("Testing L");
      doTestR();
    }
    println("==================================");
    
  } else if (event.getController().getName() == "fill")
  {
    println("filling");
    ardu.digitalWrite(motorL,Arduino.HIGH);
    ardu.digitalWrite(motorR,Arduino.HIGH);
    delay(5000);
    ardu.digitalWrite(motorR,Arduino.LOW);
    ardu.digitalWrite(motorL,Arduino.LOW);
    println("==================================");
  } else if (event.getController().getName() == "left")
  {
    feed(motorL);
    println("feeding left");
    println("==================================");
  } else if (event.getController().getName() == "right")
  {
    feed(motorR);
    println("feeding right");
    println("==================================");
  } else if(event.getController().getName() == "open"){
    launch(sketchPath("data"));
  }
}

void feed(int motor)
{
  ardu.digitalWrite(motor,Arduino.HIGH);
  delay(timeFeed);
  ardu.digitalWrite(motor,Arduino.LOW);
}

void vibrate(int ifreq,int iduration)
{
  if(ifreq > 0)
  {
    int off_time,stopTime;
    stopTime = millis()+iduration;
    off_time = (1000/ifreq);
    while(millis()<stopTime)
    {
     ardu.digitalWrite(3,Arduino.HIGH);
     delay(10);
     ardu.digitalWrite(3,Arduino.LOW);
     delay(off_time);
    }
    println("Elapsed vib:"+(millis()-stopTime));
  }
  else {
    delay(iduration);
  }
}

void doTestL(){
  startTime = millis();
  timeout = startTime +(int(fldTimeout.getText()));
  counterMain = 0;
  counterOther = 0;
  String file = str(day()) + '-' + str(month()) + '-' + str(year()) + '_' + str(hour()) + str(minute()) + str(second()) +".txt";
  PrintWriter output = createWriter(file);
  output.println("Freq1:" + fldFreq1.getText()+ "Hz " + fldTime1.getText() + "ms");
  output.println("Freq2:" + fldFreq2.getText()+ "Hz" + fldTime2.getText() + "ms");
  output.println("Interval:" + fldInterval.getText() + "ms");
  output.println("Timeout:" + fldTimeout.getText() + "ms");
  while(millis()<=timeout){
    delay(50);
    if(ardu.digitalRead(4) ==1)
    {
      counterMain++;
    }
    if(counterMain > 5)
    {
      println("Success:"+((millis()-startTime)/1000)+"s");
      output.println("Sucess:"+(millis()-startTime) +"s");
      feed(motorL);
      break;
    } if(ardu.digitalRead(2) ==1){
      counterOther++;
    }if(counterOther > 5)
    {
      output.println("Fail!, took left!");
      break;
    }
  }
  output.flush();
  output.close();
}
void doTestR(){
  startTime = millis();
  timeout = startTime +(int(fldTimeout.getText()));
  counterMain = 0;
  counterOther = 0;
  String file = str(day()) + '-' + str(month()) + '-' + str(year()) + '_' + str(hour()) + str(minute()) + str(second()) +".txt";
  PrintWriter output = createWriter(file);
  output.println("Freq1:" + fldFreq1.getText()+ "Hz " + fldTime1.getText() + "ms");
  output.println("Freq2:" + fldFreq2.getText()+ "Hz" + fldTime2.getText() + "ms");
  output.println("Interval:" + fldInterval.getText() + "ms");
  output.println("Timeout:" + fldTimeout.getText() + "ms");
  while(millis()<=timeout){
    delay(50);
    if(ardu.digitalRead(2) ==1)
    {
      counterMain++;
    }
    if(counterMain > 5)
    {
      println("Success:"+((millis()-startTime)/1000)+"s");
      output.println("Sucess:"+(millis()-startTime) +"s");
      feed(motorR);
      break;
    } if(ardu.digitalRead(4) ==1){
      counterOther++;
    }if(counterOther > 5)
    {
      output.println("Fail!, took right!");
      break;
    }
  }
  output.flush();
  output.close();
}
