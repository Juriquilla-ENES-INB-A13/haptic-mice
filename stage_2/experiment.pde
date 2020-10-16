//Experiment specific functions


boolean checkFields() {
  boolean test;
  if ((fld_freq1.getValueI() != 0) ||
  (fld_time1.getValueI() != 0)||
  (fld_wait_time.getValueI() != 0) ||
  (fld_freq2.getValueI()!=0)||
  (fld_time2.getValueI()!=0)||
  (fld_response_time.getValueI() != 0) || 
  (fld_repeats.getValueI()!=0) || 
  (fld_time_experiments.getValueI() != 0) || 
  (fld_name.getText() != "")||
  (fld_close_door.getValueI() != 0)) {
    test=true;
  } else {
    println("ERROR: No empty fields allowed! ");
    test=false;
  }
  return test;
}

void writeParamsToFile(String flname)
{
  println("FILE:"+flname);
  String datetime = new String(day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
  println(datetime);
  String params = new String(
    "freq1:" + fld_freq1.getValueI() +
    " time1:"+ fld_time1.getValueI() +
    " wait_time:"+fld_wait_time.getValueI() +
    " freq2:" + fld_freq2.getValueI() +
    " time2:"+ fld_time2.getValueI()+
    " open_door:"+ fld_door_time.getValueI()+
    " time_response:"+ fld_response_time.getValueI()+
    " repeats:"+fld_repeats.getValueI() +
    " exp_time:"+fld_time_experiments.getValueI() +
    " close_door:"+fld_close_door.getValueI() 
  );
  println(params);
  appendTextToFile(flname, "started: "+datetime);
  appendTextToFile(flname, params);
}

void doExperimentR() {
   {
    
    numIteration=0;
    numOk=0;
    numFail=0;
    int times = fld_repeats.getValueI();
    boolean feedIt;
    boolean touchedPoke;
    String filename = fld_name.getText()+".txt";
    appendTextToFile(filename,"testing:right");
    writeParamsToFile(filename);
    writeSeparator(filename);
    writeTableHeader(filename);  
    for (int i=1; i<=times; i++) {
      if(stopExperiment){
        println("RUN:aborting!");
        writeSeparator(filename);
        appendTextToFile(filename,"aborted:"+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
        writeSeparator(filename);
        writeSeparator(filename);
        return;
      }
      addWindowInfo();
      numIteration=i;
      StringBuilder chain = new StringBuilder(Integer.toString(i));
      vibrate(fld_freq1.getValueI(),fld_time1.getValueI());
      delay(fld_wait_time.getValueI());
      vibrate(fld_freq2.getValueI(),fld_time2.getValueI());
      delay(fld_door_time.getValueI());
      openDoor();
      int timeStart=millis();
      int timeStop=timeStart+fld_response_time.getValueI();
      runLoop=true;
      feedIt=false;
      touchedPoke=false;
      while(runLoop){
        println("RUN:iter:"+i+",pokes:"+ardu.digitalRead(pokeL) +","+ ardu.digitalRead(pokeR));
        if(millis() >= timeStop){
          chain.append(","+(millis()-timeStart)+",0,0,timeout");
          numFail++;
          delay(fld_close_door.getValueI());
          closeDoor();
          runLoop=false;
        } else if((ardu.digitalRead(pokeL)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(","+float(millis()-timeStart)+",1,0,fail");
          feedIt=true;
          touchedPoke=true;
        } else if((ardu.digitalRead(pokeR)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(","+float(millis()-timeStart)+",0,1,ok");
          feedIt=true;
          touchedPoke=true;
        }else if(ardu.digitalRead(inSensor)==Arduino.HIGH){
          if(feedIt){
            numOk++;
            closeDoor();
            feed();
            runLoop=false;
          }
        }
      }
      appendTextToFile(filename,chain.toString());
      delay(fld_time_experiments.getValueI());
    }
    writeSeparator(filename);
    appendTextToFile(filename,"finished:" + day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
    appendTextToFile(filename,"Ok:"+numOk+",fail:"+numFail);
    writeSeparator(filename);
    writeSeparator(filename);
    
  }
  btn_start.setVisible(true);
  btn_stop.setVisible(false);
}

void doExperimentL() {
   {
    numIteration=0;
    numOk=0;
    numFail=0;
    int times = fld_repeats.getValueI();
    boolean feedIt;
    boolean touchedPoke;
    String filename = fld_name.getText()+".txt";
    appendTextToFile(filename,"testing:left");
    writeParamsToFile(filename);
    writeSeparator(filename);
    writeTableHeader(filename);  
    for (int i=1; i<=times; i++) {
      if(stopExperiment){
        println("RUN:aborting!");
        writeSeparator(filename);
        appendTextToFile(filename,"aborted:"+day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
        writeSeparator(filename);
        writeSeparator(filename);
        return;
      }
      addWindowInfo();
      numIteration=i;
      StringBuilder chain = new StringBuilder(Integer.toString(i));
      vibrate(fld_freq1.getValueI(),fld_time1.getValueI());
      delay(fld_wait_time.getValueI());
      vibrate(fld_freq2.getValueI(),fld_time2.getValueI());
      delay(fld_door_time.getValueI());
      openDoor();
      int timeStart=millis();
      int timeStop=timeStart+fld_response_time.getValueI();
      runLoop=true;
      feedIt=false;
      touchedPoke=false;
      while(runLoop){
        println("RUN:iter:"+i+",pokes:"+ardu.digitalRead(pokeL) +","+ ardu.digitalRead(pokeR));
        if(millis() >= timeStop){
          chain.append(","+(millis()-timeStart)+",0,0,timeout");
          numFail++;
          delay(fld_close_door.getValueI());
          closeDoor();
          runLoop=false;
        } else if((ardu.digitalRead(pokeL)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(","+float(millis()-timeStart)+",1,0,ok");
          feedIt=true;
          touchedPoke=true;
        } else if((ardu.digitalRead(pokeR)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(","+float(millis()-timeStart)+",0,1,fail");
          feedIt=true;
          touchedPoke=true;
        }else if(ardu.digitalRead(inSensor)==Arduino.HIGH){
          if(feedIt){
            numOk++;
            closeDoor();
            feed();
            runLoop=false;
          }
        }
      }
      appendTextToFile(filename,chain.toString());
      delay(fld_time_experiments.getValueI());
    }
    writeSeparator(filename);
    appendTextToFile(filename,"finished:" + day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
    appendTextToFile(filename,"Ok:"+numOk+",fail:"+numFail);
    writeSeparator(filename);
    writeSeparator(filename);
    
  }
  btn_start.setVisible(true);
  btn_stop.setVisible(false);
}
