//control values from text boxes

public void Home(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    ramps.write("G28 X0 Y0 \r");
  }
} 

public void Start(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    allowMove = true;
  }
} 

public void Stop(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    allowMove = false;
  }
}

public void record(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    allowRecord = true;
  }
}

public void pause(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    allowRecord = false;
  }
}

public void end(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    //exit(); // Stops the program
  }
}

public void Drawing(int theValue) {
  if(frameCount >1){
    setFloating();
  }
}

public void Paint_1(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    penDip1();
  }
}

public void manualSerialCmd(String theText) {
  // automatically receives results from controller input
  println("Sending: "+theText);
  if(!conf_run_offline) ramps.write(theText+"\r");
}

