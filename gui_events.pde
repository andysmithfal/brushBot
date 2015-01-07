
 //control values from text boxes

 public void Home(int theValue) {
  if(frameCount >1){
  myPort.write("G28 X0 Y0 \r");
}
} 

 public void Start(int theValue) {
  if(frameCount >1){
  allowMove = true;
}
} 

 public void Stop(int theValue) {
  if(frameCount >1){
  allowMove = false;
}
}

 public void record(int theValue) {
  if(frameCount >1){
  allowRecord = true;
}
}

 public void pause(int theValue) {
  if(frameCount >1){
  allowRecord = false;
}
}

 public void end(int theValue) {
  if(frameCount >1){
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  //exit(); // Stops the program
}
}

 public void Paint_1(int theValue) {
  if(frameCount >1){
    
    myPort.write("M280 P0 S0 \r"); //lift brush
    myDelay(500);
    myPort.write("G1 X70 Y220 F40000 \r"); //go to paint pot position
    myDelay(500);
    myPort.write("M280 P0 S180 \r"); //lower brush
    myDelay(1000);
    myPort.write("M280 P0 S100 \r"); //lift brush a bit
     myDelay(1000);
    myPort.write("G1 X40 Y220 F500 \r"); //wipe slowly to one side
    myDelay(2000);
    myPort.write("M280 P0 S0 \r"); //lift brush all the way
    myDelay(500);
    myPort.write("G1 X20 Y221 F40000 \r"); //reset the feed rate
    
}
}


