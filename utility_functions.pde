void moveMachine(float x, float y,float z){
  if(conf_run_offline) return; //do nothing if we're running offline
  
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
