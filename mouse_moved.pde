void mouseDragged() {
  //if the mouse pointer is in the white square
  if (mouseX >= 10 && mouseX <=760 && mouseY>=10 && mouseY<=760){  
   inGrid = true; 
   }else{
     inGrid = false;
   }  
   
  if(!floating && inGrid){
    //draw to screen
    noSmooth();
    noStroke();
    fill(0,0,0);
    ellipse(mouseX,mouseY,5,5);
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

  print(real_x_pos);
  print("    ");
  println(real_y_pos);
   
//  float pressure = tablet.getPressure();
//  real_z_pos = 100;
//  if (pressure > 0.2){
//     real_z_pos = real_z_pos + (pressure * 80);
//  }
//println(str(real_z_pos));
   
  if(floating){
    real_z_pos = 120;  
  } else {
    real_z_pos = 180;
  }
  
  
  lastX = int(real_x_pos);
  lastY = int(real_y_pos);
  lastTX = millis();

  moveMachine(real_x_pos,real_y_pos,real_z_pos);
 
 }
  
 
void mouseReleased() {
  if(!conf_run_offline && !changingTool){
    addToBuffer("M280 P0 S100\r");
  } 
}



