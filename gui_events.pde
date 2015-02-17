//control values from text boxes

public void Home(int theValue) {
  if(frameCount >1 && !conf_run_offline){
    addToBuffer("G28 X0 Y0 \r");
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
  if(frameCount >1 && !conf_run_offline){
    initWorkArea();
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

public void drop_tool(int theValue) {
  if(frameCount >1 && !conf_run_offline){

    changeTool(currentTool,false);
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

public void Drawing(int theValue) {
  if(frameCount >1){
    setFloating();
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

public void manualSerialCmd(String theText) {
  // automatically receives results from controller input
  println("Sending: "+theText);
  if(!conf_run_offline) addToBuffer(theText+"\r");
}

