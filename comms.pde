void serialEvent(Serial p) { 
  String inString = p.readString();
 if(p == ramps){ 
   //buffer ok
   String[] test = match(inString,"ok");
   if(test != null) serial_wait = false;
 }else{
   //bluetooth
   String ina[] = split(inString, "\r");
   btint = Integer.parseInt(ina[0]);
   //probably want to look for changes here and move the Z axis directly
 }
} 

void processBuffer(){
  if(!serial_wait && gcodebuffer.size() > 0 && allowMove){
    String thisLine = gcodebuffer.get(0);
    gcodebuffer.remove(0);
    if (allowRecord) recording.println(thisLine);
    //we look for a 'custom' GCode - Dnnnnn - this delays the machine 
    //by the specified number of milliseconds 
    String[] delayTest = match(thisLine, "D([0-9]{1,5})");
    if(delayTest != null){
      int delay = parseInt(delayTest[1]);
      //println("DELAYING "+delay);
      blockingDelay(delay);
    } else {
      serial_wait = true;
      ramps.write(thisLine);
    }
  }
}

void addToBuffer(String gcode){
  gcodebuffer.add(gcode); 
}

void addDelayToBuffer(int del){
  gcodebuffer.add("D "+del);
}

void clearBuffer(){
  //empty buffer
  while(gcodebuffer.size() > 0){
    gcodebuffer.remove(0);
  }
}

void emergencyStop(){
  println("EMERGENCY STOP");
  clearBuffer();
  allowMove = false;
  allowRecord = false;
  ramps.write("M112\r\n");
  ramps.stop();
}

void connectBluetooth(){
  bluetooth = new Serial(this, "/dev/tty.HC-06-DevB", 9600);
  bluetooth.bufferUntil(10);
  conf_use_bt_controller = true;
  println("Bluetooth controller connected");
}
