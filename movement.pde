void penDip1(){
    addToBuffer("M280 P0 S0 \r"); //lift brush
    blockingDelay(500);
    addToBuffer("G1 X70 Y220 F"+feedrate+" \r"); //go to paint pot position
    blockingDelay(500);
    addToBuffer("M280 P0 S180 \r"); //lower brush
    blockingDelay(1000);
    addToBuffer("G2 X70 Y220 I5 J0 F2000\r"); //do a circle
    blockingDelay(3000);
    addToBuffer("M280 P0 S100 \r"); //lift brush a bit
    blockingDelay(1000);
    addToBuffer("G1 X40 Y220 F500 \r"); //wipe slowly to one side
    blockingDelay(2000);
    addToBuffer("M280 P0 S0 \r"); //lift brush all the way
    blockingDelay(500);
    addToBuffer("G1 X20 Y221 F"+feedrate+" \r"); //reset the feed rate
}

                //tool num,     true = pick up    false = put down
                
void switchTool(int tool){
   if(currentTool == 0){
     changeTool(tool,true);
     currentTool = tool;
   } else {
     changeTool(currentTool,false);
     changeTool(tool,true);
     currentTool = tool;
   } 
}

void changeTool(int tool, boolean direction){
  int x_offset = 10+(tool*35);
  
  int speed = 4000;
  addToBuffer("G1 X0 Y40 \r");
  addToBuffer("G1 X"+x_offset+" Y40\r");
  if(direction == true){
    //pick up tool
    addToBuffer("M280 P0 S170 \r");
    addToBuffer("D"+(250+350*tool));
    addToBuffer("G1 X"+x_offset+" Y10 F"+speed+" \r");
    addToBuffer("D"+(900*tool));
    addToBuffer("M280 P0 S0 \r");
  } else {
    //put down tool
    addToBuffer("M280 P0 S0 \r");
    addToBuffer("D"+(250+(350*tool)));
    addToBuffer("G1 X"+x_offset+" Y10  F"+speed+" \r");
    addToBuffer("D"+(900*tool));
    addToBuffer("M280 P0 S180 \r");    
  }
  addToBuffer("D"+(750+(350*tool)));
  addToBuffer("G1 X"+x_offset+" Y40 \r");
  addToBuffer("G1 X"+x_min_val+" Y"+y_min_val+" F"+feedrate+"\r");
  addToBuffer("D"+(750+(350*tool)));

} 

void moveMachine(float x, float y, float z){
  if(conf_run_offline) return; //do nothing if we're running offline
   if (allowMove == true && inGrid == true){   
    addToBuffer("G1 X" + nf(x,3,2) + " Y" + nf(y,3,2) + "\r");
    addToBuffer("M280 P0 S" + nf(z,3,2) +"\r");    
    
    if (allowMove == true && allowRecord == true && inGrid == true){
    output.println("G1 X" + str(x) + " Y" + str(y) + "\r");
    output.println("M280 P0 S" + nf(z,3,2) +"\r");
    }
 }
}
