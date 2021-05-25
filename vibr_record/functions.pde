void openDataFolder() {
  println("Opening folder:"+dataPath(""));
  if (System.getProperty("os.name").toLowerCase().contains("windows")) {
    launch("explorer.exe"+" "+dataPath(""));
  } else {
    launch(dataPath(""));
  }
}

void createFile(File f) {
  File parentDir = f.getParentFile();
  try {
    parentDir.mkdirs(); 
    f.createNewFile();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void record(){
  if(run==false){
    return;
  }
  String filename=new String(day()+month()+year()+hour()+minute()+second()+".csv");
  File f = new File(dataPath(filename));
  if (!f.exists()) {
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    while(run){
      if(port.available()>0){
        String inBuffer = port.readString();   
        if (inBuffer != null)
        {
          println(inBuffer);
          out.println(inBuffer);
        }
      }
    }
    out.close();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}
