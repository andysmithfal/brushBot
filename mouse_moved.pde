void mouseMoved() {
  xyInput();
}

void mouseDragged() {
  xyInput(); 
}
  
 
void mouseReleased() {
  if(!conf_run_offline && !changingTool){
    //addToBuffer("M280 P0 S100\r");
  } 
}



