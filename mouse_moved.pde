void mouseDragged() {
  //ignore mouse move events in quick succession
  if(millis() < lastTX+5){
    //println("Skipping");
    return;
  }
  lastTX = millis();
  
  //println("mouse moved at "+millis()+" last was "+lastTX);
  //if the mouse pointer is in the white square
  if (mouseX >= 10 && mouseX <=760 && mouseY>=10 && mouseY<=760){  
   inGrid = true; 
   }else{
     inGrid = false;
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
  
  moveMachine(real_x_pos,real_y_pos,real_z_pos);
 
 }
  
 
void mouseReleased() {
  if(!conf_run_offline){
    ramps.write("M280 P0 S100\r");
  } 
}



