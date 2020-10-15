//Experiment specific functions


boolean checkFields() {
  boolean test;
  if ((fld_freq.getValueI() != 0) || (fld_vibr_duration.getValueI() != 0) || (fld_response_time.getValueI() != 0) || (fld_repeats.getValueI()!=0) || (fld_time_experiments.getValueI() != 0) || (fld_name.getText() != "")||(fld_close_door.getValueI() != 0)) {
    test=true;
  } else {
    println("ERROR: No empty fields allowed! ");
    test=false;
  }
  return test;
}

void doExperiment() {
   {
    numIteration=0;
    numOk=0;
    numFail=0;
    int times = fld_repeats.getValueI();
    boolean feedIt;
    boolean touchedPoke;
    String filename = fld_name.getText()+".txt";
    writeParamsToFile(filename);
    writeSeparator(filename);
    writeTableHeader(filename);  
    for (int i=1; i<=times; i++) {
      addWindowInfo();
      numIteration=i;
      StringBuilder chain = new StringBuilder(Integer.toString(i));
      vibrate(fld_freq.getValueI(),fld_vibr_duration.getValueI());
      delay(fld_door_time.getValueI()*1000);
      openDoor();
      int timeStart=millis();
      int timeStop=timeStart+int(fld_response_time.getValueF()*1000);
      runLoop=true;
      feedIt=false;
      touchedPoke=false;
      while(runLoop){
        println(ardu.digitalRead(pokeL) + ardu.digitalRead(pokeR));
        if(millis() >= timeStop){
          chain.append(","+float((millis()-timeStart)/1000)+",0,0");
          numFail++;
          delay(fld_close_door.getValueI()*1000);
          closeDoor();
          runLoop=false;
        } else if((ardu.digitalRead(pokeL)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(","+float((millis()-timeStart)/1000)+",1,0");
          feedIt=true;
          touchedPoke=true;
        } else if((ardu.digitalRead(pokeR)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(","+float((millis()-timeStart)/1000)+",0,1");
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
      delay(int(fld_time_experiments.getValueF()*1000));
    }
    writeSeparator(filename);
    appendTextToFile(filename,"finished:" + day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
    appendTextToFile(filename,"Ok:"+numOk+",fail:"+numFail);
    writeSeparator(filename);
    writeSeparator(filename);
  }
  btn_startstop.setVisible(true);
  btn_stop.setVisible(false);
}
