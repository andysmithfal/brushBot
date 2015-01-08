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
    ramps.write("M280 P0 S0 \r"); //lift brush
    blockingDelay(500);
    ramps.write("G1 X70 Y220 F"+feedrate+" \r"); //go to paint pot position
    blockingDelay(500);
    ramps.write("M280 P0 S180 \r"); //lower brush
    blockingDelay(1000);
    ramps.write("M280 P0 S100 \r"); //lift brush a bit
    blockingDelay(1000);
    ramps.write("G1 X40 Y220 F500 \r"); //wipe slowly to one side
    blockingDelay(2000);
    ramps.write("M280 P0 S0 \r"); //lift brush all the way
    blockingDelay(500);
    ramps.write("G1 X20 Y221 F"+feedrate+" \r"); //reset the feed rate
  }
}

public void manualSerialCmd(String theText) {
  // automatically receives results from controller input
  println("Sending: "+theText);
  if(!conf_run_offline) ramps.write(theText+"\r");
}

