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
  //addToBuffer("G4 P750\r");
  //wipe 
  //addToBuffer("G1 X"+xoffset+" Y115 F500\r");
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

void xyInput(){
  //if the mouse pointer is in the white square
  if (mouseX >= 10 && mouseX <=760 && mouseY>=10 && mouseY<=760){  
   inGrid = true; 
   }else{
     inGrid = false;
   }  
   

  //ignore mouse move events in quick succession
  if(millis() < lastTX+50){
    //println("Skipping");
    return;
  }
   
  //calaculate the mouse pixel position 0 - pixelGrid_size in x and y
  
  int mouse_x_pos = mouseX - pixelGrid_x;
  int mouse_y_pos = pixelGrid_size - (mouseY - pixelGrid_y);
  
  //using the mm extents of the working area gained from the text box values
  //work out the real worl position of the mouse pointer
  
  float x_length = x_max_val - x_min_val;
  
  float y_length = y_max_val - y_min_val;
  
  
  //to convert pixel position to real world value
  
  float x_pix_val = x_length / pixelGrid_size;
  float y_pix_val = y_length / pixelGrid_size;
    
  float real_x_pos = (mouse_x_pos * x_pix_val) + x_min_val;
  float real_y_pos = (mouse_y_pos * y_pix_val) + y_min_val;

  //skip duplicate gcode
  if(int(real_x_pos) == lastX && int(real_y_pos) == lastY) return;

//  print(real_x_pos);
//  print("    ");
//  println(real_y_pos);
//   
  if(mousePressed){
    float pressure = tablet.getPressure();
    real_z_pos = 80;
    if (pressure > 0.1){
       real_z_pos = real_z_pos + (pressure * 90);
         if(inGrid){
            //draw to screen
            noSmooth();
            noStroke();
            fill(0,0,0);
            ellipse(mouseX,mouseY,5,5);
          }
    }
    if(real_z_pos > 180) real_z_pos = 180;
    println(str(pressure)+"  >>  "+str(real_z_pos));
  } else {
    real_z_pos = 100; 
  }
  
//  if(floating){
//    real_z_pos = 120;  
//  } else {
//    real_z_pos = 180;
//  }
  
  
  lastX = int(real_x_pos);
  lastY = int(real_y_pos);
  lastTX = millis();

  moveMachine(real_x_pos,real_y_pos,real_z_pos);
}

void moveMachine(float x, float y, float z){
  if(conf_run_offline) return; //do nothing if we're running offline
   if (allowMove == true && inGrid == true){   
    addToBuffer("G1 X" + nf(x,3,2) + " Y" + nf(y,3,2) + "\r");
    addToBuffer("M280 P0 S" + nf(z,3,2) +"\r");    
    
//    if (allowMove == true && allowRecord == true && inGrid == true){
//    output.println("G1 X" + str(x) + " Y" + str(y) + "\r");
//    output.println("M280 P0 S" + nf(z,3,2) +"\r");
//    }
 }
}
