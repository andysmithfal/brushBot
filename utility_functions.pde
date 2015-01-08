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
