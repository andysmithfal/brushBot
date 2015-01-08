void keyPressed() {
  //ignore keypresses if text boxes are focused
  if(cp5.get(Textfield.class,"manualSerialCmd").isFocus()) return;
  switch(key) {
   case 'd': 
    setFloating();
    break; 
  }
}
