void vibrateLower() //<>//
{
  int startTime = millis();
  int pulseWidth=17;
  int ifreq= minFreq;
  int iduration = fldVibrDur.getValueI();
  int stopTime = startTime + iduration;
  println("RUN:freq "+ifreq+",dur "+iduration);
  if (ifreq > 0)
  {
    int off_time, cycles;
    off_time = (1000/ifreq)-pulseWidth;
    cycles = (iduration/(off_time+pulseWidth))-1;
    for (int i = 0; i <= cycles; i++)
    {
      ardu.digitalWrite(vibr, Arduino.HIGH);
      delay(pulseWidth);
      ardu.digitalWrite(vibr, Arduino.LOW);
      delay(off_time);
      if(millis()>=stopTime){
      break;
      }
    }
  } else {
    delay(iduration);
  }
}

void vibrateHigher()
{
  int startTime=millis();
  int ifreq=maxFreq;
  int iduration = fldVibrDur.getValueI();
  int stopTime=startTime+iduration;
  println("RUN:freq "+ifreq+",dur "+iduration);
  if (ifreq > 0)
  {
    int off_time, cycles;
    off_time = (1000/ifreq)-10;
    cycles = (iduration/(off_time+10))-1;
    for (int i = 0; i <= cycles; i++)
    {
      ardu.digitalWrite(vibr, Arduino.HIGH);
      delay(10);
      ardu.digitalWrite(vibr, Arduino.LOW);
      delay(off_time);
      if(millis()>=stopTime){
        break;
      }
    }
  } else {
    delay(iduration);
  }
}

void timedFeed()
{
  int delayedFeed=fld_wait_to_feed.getValueI();
  println("RUN: delayed feed: "+fld_wait_to_feed.getValueI());
  delay(delayedFeed);
  for(int i = 0;i<timesFeed;i++){
    feed();
    ardu.digitalWrite(pump,Arduino.LOW);
    delay(50);
    
  }
}

void startExperiment() {
  if(runExperiment){
    println("Another experiment running!");
    return;
  }
  filename = fld_name.getText()+".txt";
  InR=0;
  InL=0;
  feedTimes=0;
  iteration=0;
  writeParamsToFile(filename);
  writeSeparator(filename);
  runExperiment=true;
  btn_start.setVisible(false);
  btn_stop.setVisible(true);
  if(runExperiment){
    timeStart=millis();
    appendTextToFile(filename,fld_name.getText()+""+day()+month()+year()+":"+hour()+minute()+second());
    while(runExperiment){
      if((ardu.digitalRead(pokeL)==Arduino.HIGH)&&waitingPoke){
        appendTextToFile(filename,iteration+","+(millis()-timeStart)+",pokeL");
        InL++;
        waitingPoke=false;
      }else if((ardu.digitalRead(pokeR)==Arduino.HIGH)&&waitingPoke){
        appendTextToFile(filename,iteration+","+(millis()-timeStart)+",pokeR");
        InR++;
        waitingPoke=false;
      }
      delay(50);
    }
    appendTextToFile(filename,"InL:"+InL+" InR:"+InR+" Iter:"+iteration+" feeds:"+feedTimes);
  }
  writeSeparator(filename);
  writeSeparator(filename);
  btn_start.setVisible(true);
  btn_stop.setVisible(false);
  runExperiment=false;
  println("RUN: end of experiment");
}

      

   
