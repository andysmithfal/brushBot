void penDip(int pot){
  int xoffset = (50*pot)-50;
  //to the pot
  addToBuffer("G1 X"+xoffset+" Y95\r");
  //down
  addToBuffer("G4 P1 \r");
  addToBuffer("M280 P0 S180\r");
  addToBuffer("G4 P750\r");
  //round
  for(int i = 0; i < 6; i++){
    addToBuffer("G2 X"+xoffset+" Y95 I5 J0 F40000\r");
  }
  //up a bit
  addToBuffer("G4 P1 \r");
  addToBuffer("M280 P0 S105\r");
  addToBuffer("G4 P750\r");
  //wipe 
  addToBuffer("G1 X"+xoffset+" Y115 F500\r");
  //up all the way
  addToBuffer("G4 P1 \r");
  addToBuffer("M280 P0 S0\r");
  addToBuffer("G4 P750\r"); 
  //finish 
  addToBuffer("G1 X"+xoffset+" Y120 F40000\r"); 
  
}
           
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
    addToBuffer("M280 P0 S165 \r");
    addToBuffer("D"+(250+350*tool));
    addToBuffer("G1 X"+x_offset+" Y9 F"+speed+" \r");
    addToBuffer("D"+(900*tool));
    addToBuffer("M280 P0 S0 \r");
  } else {
    //put down tool
    addToBuffer("M280 P0 S0 \r");
    addToBuffer("D"+(250+(350*tool)));
    addToBuffer("G1 X"+x_offset+" Y9  F"+speed+" \r");
    addToBuffer("D"+(900*tool));
    addToBuffer("M280 P0 S170 \r");    
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
