//control values from text boxes

public void Home(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    addToBuffer("G28 X0 Y0 Z0 \r");
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

public void Clear(int theValue) {
  if(frameCount >1){
    initWorkArea();
  }
}

public void record(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    startRecording2();
  }
}

public void end(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    stopRecording2();
  }
}

public void drop_tool(int theValue) {
  if(frameCount >1 && !conf_run_offline){

    changeToolG4(currentTool,false);
    currentTool = 0;
    
  }
}

public void tool_1(int theValue) {
  if(frameCount >1 && !conf_run_offline){

    switchTool(1);
    
  }
}

public void tool_2(int theValue) {
  if(frameCount >1 && !conf_run_offline){
     switchTool(2);
   
  }
}

public void tool_3(int theValue) {
  if(frameCount >1 && !conf_run_offline){
     switchTool(3);
   
  }
}

public void tool_4(int theValue) {
  if(frameCount >1 && !conf_run_offline){
     switchTool(4);
   
  }
}

public void tool_5(int theValue) {
  if(frameCount >1 && !conf_run_offline){
     switchTool(5);
   
  }
}

public void tool_6(int theValue) {
  if(frameCount >1 && !conf_run_offline){
     switchTool(6);
   
  }
}

public void Paint(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    penDip(currentPaint);
  }
}

public void Paint_1(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    penDip(1);
  }
}

public void Paint_2(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    penDip(2);
  }
}

public void Paint_3(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    penDip(3);
  }
}


public void Paint_4(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    penDip(4);
  }
}

public void Paint_5(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    penDip(5);
  }
}

public void Paint_6(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    penDip(6);
  }
}

public void emergency(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    emergencyStop();
  }
}

public void Replay(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    selectInput("Select a file to replay:", "replayRec2File");
  }
}

public void Preview2(int theValue) {
  if(frameCount >1){
    selectInput("Select a file to preview:", "previewFile");
  }
}


public void cBT(int theValue) {
  if(frameCount >1){
    connectBluetooth();
  }
}

public void manualSerialCmd(String theText) {
  // automatically receives results from controller input
  println("Sending: "+theText);
  if(!conf_run_offline) addToBuffer(theText+"\r");
}

