void moveMachine(float x, float y,float z){
  if(conf_run_offline) return; //do nothing if we're running offline
  println("moving machine");
  //println(str(int(z)));
   if (allowMove == true && inGrid == true){   
    ramps.write("G1 X" + nf(x,3,2) + " Y" + nf(y,3,2) + "\r");
    ramps.write("M280 P0 S" + nf(z,3,2) +"\r");    
    
    if (allowMove == true && allowRecord == true && inGrid == true){
    output.println("G1 X" + str(x) + " Y" + str(y) + "\r");
    output.println("M280 P0 S" + nf(z,3,2) +"\r");
    }

 }
 //blockingDelay(5);
}

String findSerial(String[] ports){
  String port = "no port!";
  for(String thisPort : ports){
    String[] m = match(thisPort.toLowerCase(), "usb");
    String[] c = match(thisPort.toLowerCase(), "com([0-9]{1,2})");
    if(m != null || c != null){
     port = thisPort;
     break;
    }
  }
  return port;
}

void blockingDelay(int ms){
  try{    
    Thread.sleep(ms);
  }
  catch(Exception e){}
}


void setFloating(){
  floating = !floating;
  String label = floating ? "Floating" : "Drawing";
  cp5.get(Button.class,"Drawing").setCaptionLabel(label);
}

void initWorkArea(){
 background(0xed,0xa2,0x23);
 stroke(1);
 fill(255,255,255);
 rect(10,10,750,750); 
}

void penDip1(){
    ramps.write("M280 P0 S0 \r"); //lift brush
    blockingDelay(500);
    ramps.write("G1 X70 Y220 F"+feedrate+" \r"); //go to paint pot position
    blockingDelay(500);
    ramps.write("M280 P0 S180 \r"); //lower brush
    blockingDelay(1000);
    ramps.write("G2 X70 Y220 I5 J0 F2000\r"); //do a circle
    blockingDelay(3000);
    ramps.write("M280 P0 S100 \r"); //lift brush a bit
    blockingDelay(1000);
    ramps.write("G1 X40 Y220 F500 \r"); //wipe slowly to one side
    blockingDelay(2000);
    ramps.write("M280 P0 S0 \r"); //lift brush all the way
    blockingDelay(500);
    ramps.write("G1 X20 Y221 F"+feedrate+" \r"); //reset the feed rate
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
  ramps.write("G1 X0 Y40 \r");
  ramps.write("G1 X"+x_offset+" Y40\r");
  if(direction == true){
    //pick up tool
    ramps.write("M280 P0 S180 \r");
    blockingDelay(250+(350*tool));
    ramps.write("G1 X"+x_offset+" Y8 F"+speed+" \r");
    blockingDelay(750*tool);
    ramps.write("M280 P0 S0 \r");
  } else {
    //put down tool
    ramps.write("M280 P0 S0 \r");
    blockingDelay(250+(350*tool));
    ramps.write("G1 X"+x_offset+" Y8  F"+speed+" \r");
    blockingDelay(750*tool);
    ramps.write("M280 P0 S180 \r");    
  }
  blockingDelay(750+(350*tool));
  ramps.write("G1 X"+x_offset+" Y40 \r");
  ramps.write("G1 X"+x_min_val+" Y"+y_min_val+" F"+feedrate+"\r");
  blockingDelay(750+(350*tool));

}
