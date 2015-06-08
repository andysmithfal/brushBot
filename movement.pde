void penDip(int pot){
  int xoffset = (50*pot)-50;
  //pen fully up
  addToBuffer("G4 P1 \r");
  addToBuffer("M280 P0 S10\r");
  addToBuffer("G4 P500\r");
  //go to the pot
  addToBuffer("G1 X"+xoffset+" Y95\r");
  //down
  addToBuffer("G4 P1 \r");
  addToBuffer("M280 P0 S180\r");
  addToBuffer("G4 P750\r");
  //round
  for(int i = 0; i < 6; i++){
    addToBuffer("G2 X"+xoffset+" Y95 I5 J0 F"+feedrate+"\r");
  }
  //up a bit
  addToBuffer("G4 P1 \r");
  addToBuffer("M280 P0 S105\r");
  //addToBuffer("G4 P750\r");
  //wipe 
  //addToBuffer("G1 X"+xoffset+" Y115 F500\r");
  //up all the way
  addToBuffer("G4 P1 \r");
  addToBuffer("M280 P0 S10\r");
  addToBuffer("G4 P750\r"); 
  //finish 
  addToBuffer("G1 X"+xoffset+" Y120 F"+feedrate+"\r"); 
  
  if(allowRecord2){
      JSONObject event = new JSONObject();
      event.setString("event", "pendip");
      event.setFloat("pot", pot);
      recording2.setJSONObject(record2index, event);
      record2index++;
    }
}
           
void switchTool(int tool){
   if(currentTool == 0){
     changeToolG4(tool,true);
     currentTool = tool;
   } else {
     changeToolG4(currentTool,false);
     changeToolG4(tool,true);
     currentTool = tool;
   } 
}

void changeToolG4(int tool, boolean direction){
  int x_offset = 45+(tool*35); 
  float x_offset_f = 45+(tool*34.8);
  
  int speed = 4000;
  addToBuffer("G1 X0 Y40 \r");
  addToBuffer("G1 X"+nf(x_offset_f,3,2)+" Y40\r");
  if(direction == true){
    //pick up tool
    addToBuffer("G4 P1 \r");
    addToBuffer("M280 P0 S135 \r");
    addToBuffer("G4 P"+(250+350*tool)+" \r");
    
    addToBuffer("G4 P1 \r");
    addToBuffer("G1 X"+nf(x_offset_f,3,2)+" Y5 F"+speed+" \r");
    addToBuffer("G4 P"+(900*tool)+" \r");
    addToBuffer("G4 P1 \r");
    addToBuffer("M280 P0 S10 \r");
  } else {
    //put down tool
    addToBuffer("G4 P1 \r");
    addToBuffer("M280 P0 S10 \r");
    addToBuffer("G4 P"+(250+350*tool)+" \r");
    addToBuffer("G4 P1 \r");
    addToBuffer("G1 X"+nf(x_offset_f,3,2)+" Y5  F"+speed+" \r");
    addToBuffer("G4 P"+(900*tool)+" \r");    
    addToBuffer("G4 P1 \r");
    addToBuffer("M280 P0 S135 \r");
  }
  addToBuffer("G4 P"+(1000+750+(350*tool))+" \r");
  addToBuffer("G1 X"+nf(x_offset_f,3,2)+" Y40 \r");
  addToBuffer("G1 X"+x_min_val+" Y"+y_min_val+" F"+feedrate+"\r");
  //addToBuffer("D"+(750+(350*tool)));

} 

void xyzInput(){
  float penX = tablet.getPenX();
  float penY = tablet.getPenY();

  //if the mouse pointer is in the white square
  if (mouseX >= 10 && mouseX <=760 && mouseY>=10 && mouseY<=760){  
   inGrid = true; 
   }else{
     inGrid = false;
   }  
  
  //do nothing if we're not in the grid
  if(!inGrid) return;
  //do nothing if we're not allowing movement 
  if(!allowMove) return;  
  //ignore mouse move events in quick succession
  if(millis() < lastTX+30) return;
   
  //remove the border offset from the mouse position and flip
  //the Y axis (gcode datum is bottom-left)
  float mouse_x_pos = penX - pixelGrid_x;
  float mouse_y_pos = pixelGrid_size - (penY - pixelGrid_y);

  //skip duplicate gcode
  //if(int(mouse_x_pos) == lastX && int(mouse_y_pos) == lastY) return;

  //calc z 
  
  float pressure = tablet.getPressure();
  if(mousePressed && pressure == 0) pressure = 1.0;
  

  
  real_z_pos = brush_hover_height;
  if (pressure > 0.1){
     real_z_pos = real_z_pos + (pressure * (180-brush_hover_height));
          //draw to screen
          noSmooth();
          noStroke();
          fill(0,0,0);
          ellipse(mouseX,mouseY,int(pressure*10),int(pressure*10));
    if(real_z_pos > 180) real_z_pos = 180;    
      moveZ(real_z_pos);
      lastZ = int(real_z_pos);
  } else {
   if(lastZ == brush_hover_height){
    //do nothing 
   } else {
    moveZ(brush_hover_height);
    lastZ = brush_hover_height;
   } 
  }
  
  //println(str(pressure)+"  >>  "+str(real_z_pos));
  
  

  
  lastX = int(mouse_x_pos);
  lastY = int(mouse_y_pos);
  lastTX = millis();

  moveXY(mouse_x_pos, mouse_y_pos, x_min_val, x_max_val, y_min_val, y_max_val);

  if(pressure > 0){
    record2xy(penX, penY);
    record2z(pressure);
  }
}

void moveXY(float x, float y, int x_min_val, int x_max_val, int y_min_val, int y_max_val){
  if(conf_run_offline) return; //do nothing if we're running offline

  //using the mm extents of the working area 
  //work out the real worl position of the mouse pointer

  float x_length = x_max_val - x_min_val;
  float y_length = y_max_val - y_min_val;

  //to convert pixel position to real world value

  float x_pix_val = x_length / pixelGrid_size;
  float y_pix_val = y_length / pixelGrid_size;

  float real_x_pos = (x * x_pix_val) + x_min_val;
  float real_y_pos = (y * y_pix_val) + y_min_val;

  addToBuffer("G1 X" + nf(real_x_pos,3,2) + " Y" + nf(real_y_pos,3,2) + "\r");
}

void moveZ(float z){
  if(conf_run_offline) return; //do nothing if we're running offline
   if (allowMove == true){   
    addToBuffer("M280 P0 S" + nf(z,3,2) +"\r");

   }
}

// not sure why this is here, don't think it's used
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
