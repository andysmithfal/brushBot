void keyPressed() {
  //ignore keypresses if text boxes are focused
  if(cp5.get(Textfield.class,"manualSerialCmd").isFocus()) return;
  switch(key) {
   case 'd': 
    setFloating();
    break;
   case 'i': 
    currentPaint++;
    if(currentPaint > 5) currentPaint = 1;
    break;
   case 'o': 
    currentPaint--;
    if(currentPaint < 1) currentPaint = 5;
    break;
   case 'p': 
    penDip(currentPaint);
    break;
   case 'w': 
    penDip(6);
    break; 
  }
}
