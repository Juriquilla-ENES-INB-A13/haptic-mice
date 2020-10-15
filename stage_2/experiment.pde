 

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
    " time1:"+ fld_time1.getValueF() +
    " wait time:"+fld_wait_time.getValueF() +
    " freq2:" + fld_freq2.getValueI() +
    " time2:"+ fld_time2.getValueF()+
    " open door:"+ fld_door_time.getValueF()+
    " time response:"+ fld_response_time.getValueF()+
    " repeats:"+fld_repeats.getValueI() +
    " exp_time:"+fld_time_experiments.getValueF() +
    " close door:"+fld_close_door.getValueF() 
  );
  println(params);
  appendTextToFile(flname, "started: "+datetime);
  appendTextToFile(flname, params);
}

void doExperiment(String flname, int times) {
   {
    boolean feedIt;
    boolean touchedPoke;
    String filename = fld_name.getText()+".txt";
    int freq1 = fld_freq1.getValueI();
    int time1 = int(fld_time1.getValueF()*1000);
    int delay_wait = int(fld_wait_time.getValueF()*1000);
    int freq2 = fld_freq2.getValueI();
    int time2 = int(fld_time2.getValueF()*1000);
    numIteration=0;
    numOk=0;
    numFail=0;
    writeParamsToFile(filename);
    writeSeparator(filename);
    writeTableHeader(filename);  
    for (int i=1; i<=times; i++) {
      setExperimentTitle();
      numIteration=i;
      StringBuilder chain = new StringBuilder(Integer.toString(i));
      vibrate(freq1,time1);
      delay(delay_wait);
      vibrate(freq2,time2);
      delay(fld_door_time.getValueI()*1000);
      openDoor();
      int timeStart=millis();
      int timeStop=timeStart+int(fld_response_time.getValueF()*1000);
      runLoop=true;
      feedIt=false;
      touchedPoke=false;
      while(runLoop){
        setExperimentTitle();
        if(millis() >= timeStop){
          chain.append(",none,0");
          numFail++;
          delay(fld_close_door.getValueI()*1000);
          closeDoor();
          runLoop=false;
        } else if((ardu.digitalRead(pokeL)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(",left,"+float((millis()-timeStart)/1000));
          if(fld_freq2.getValueI()>fld_freq1.getValueI()){
            feedIt=true;
          }
          touchedPoke=true;
        } else if((ardu.digitalRead(pokeR)==Arduino.HIGH)&&(touchedPoke == false)){
          chain.append(",right,"+float((millis()-timeStart)/1000));
          if(fld_freq1.getValueI()>fld_freq2.getValueI()){
            feedIt=true;
          }
          touchedPoke=true;
        }else if((ardu.digitalRead(inSensor)==Arduino.HIGH)&& feedIt){
          numOk++;
          closeDoor();
          feed();
          runLoop=false;
        }
      }
      chain.append(","+float((millis()-timeStart)/1000));
      appendTextToFile(filename,chain.toString());
      delay(int(fld_time_experiments.getValueF()*1000));
    }
    writeSeparator(filename);
    appendTextToFile(filename,"finished:" + day()+"-"+month()+"-"+year()+" "+hour()+":"+minute()+":"+second());
    writeSeparator(filename);
    writeSeparator(filename);

  }
}
