import cc.arduino.*;
import org.firmata.*;


import g4p_controls.*;
import processing.serial.*;

int pump = 5;
int vibr = 3;
int pokeL = 8;
int pokeR= 7;
int servo = 4;
int sensor =2;
int srv_open_angle=90;
int srv_close_angle=40;
int timeFeed=5;

Arduino duino;



public void setup(){
  size(400, 280, JAVA2D);
  createGUI();
  customGUI();

}

public void draw(){
  background(230);
  
}


public void customGUI(){

}

public void run_conditioning(){
  duino = new Arduino(this,duino.list()[drp_port.getSelectedIndex()],57600);
  //duino.pinMode(servo,duino.SERVO);
  //duino.pinMode(vibr
 


}

/*
void fill(int motor)
{
  Arduino duino = new Arduino(this,duino.list()[drp_port.getSelectedIndex()],57600);
  duino.pinMode(servo,duino.SERVO);
  duino.digitalWrite(motor,duinoino.HIGH);
  delay(timeFeed);
  duino.digitalWrite(motor,duinoino.LOW);
  delay(10);
  duino.digitalWrite(motor,duinoino.HIGH);
  delay(timeFeed);
  duino.digitalWrite(motor,duinoino.LOW);
}

void vibrate(int ifreq,int iduration)
{
  if(ifreq > 0)
  {
    int off_time,duration;
    off_time = (1000/ifreq);
    duration = (ifreq*iduration)-1;
    for (int i = 0; i <= duration; i++)
    {
     duino.digitalWrite(3,duinoino.HIGH);
     delay(10);
     duino.digitalWrite(3,duinoino.LOW);
     delay(off_time);
    }
  } else {
    delay(iduration);
  }


*/
