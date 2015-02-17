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
  println("connecting to "+port);
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



void displayStatus(int x, int y){
 int textSize = 16;
 int bufferCount = gcodebuffer.size();
 textSize(textSize);
 fill(0);
 text("Buffer: "+bufferCount, x, y);
 
 String tool; 
 
 if(currentTool == 0){
   tool = "No Tool";
 } else {
   tool = str(currentTool);
 } 
 
 text("Current Tool: "+tool, x, y+textSize + 5, textSize);
}
