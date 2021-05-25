void vibrate(){ //<>//
  int startTime=millis();
  int iduration=fldVibrDur.getValueI();
  int stopTime=startTime+iduration;
  int off_time,pulseWidth;
  println("RUN: Vibr:"+freq);
  if(freq > 0){
    if(freq >=20 && freq<35){
      pulseWidth=25;
    } else{
      pulseWidth=10;
    }
    int  cycles;
    off_time = (1000/freq)-pulseWidth;
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
  }else {
    delay(iduration);
  }
}

void timedFeed()
{
  int delayedFeed=fld_wait_to_feed.getValueI();
  println("RUN: delayed feed: "+fld_wait_to_feed.getValueI());
  delay(delayedFeed);
  for(int i = 0;i<timesFeed;i++){
    feedL();
    ardu.digitalWrite(pumpL,Arduino.LOW);
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
  feedTimesL=0;
  feedTimesR=0;
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
        println("InL:"+InL);
        waitingPoke=false;
      }else if((ardu.digitalRead(pokeR)==Arduino.HIGH)&&waitingPoke){
        appendTextToFile(filename,iteration+","+(millis()-timeStart)+",pokeR");
        InR++;
        println("InR:"+InR);
        waitingPoke=false;
      }
      delay(50);
    }
    appendTextToFile(filename,"InL:"+InL+" InR:"+InR+" Iter:"+iteration+" feedTimesL:"+feedTimesL+" feedTimesR:"+feedTimesR);
    openDataFolder();
  }
  writeSeparator(filename);
  writeSeparator(filename);
  btn_start.setVisible(true);
  btn_stop.setVisible(false);
  runExperiment=false;
  println("RUN: end of experiment");
}

      

   
