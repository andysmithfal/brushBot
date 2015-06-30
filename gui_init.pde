void initGUI(){
  cp5 = new ControlP5(this);
  //fonts 
  PFont font = createFont("arial",20);
  PFont font_fs = createFont("Courier-Bold",20,false);
  
  textFont(font);
     
  //define buttons
  //column 1
   cp5.addButton("Start")
   .setValue(0)
   .setPosition(780,(1*50)-40)
   .setSize(50,20)
   ;
   
   cp5.addButton("Stop")
   .setValue(0)
   .setPosition(780,(2*50)-40)
   .setSize(50,20)
   ;  
  
   cp5.addButton("record")
   .setValue(0)
   .setPosition(780,(3*50)-40)
   .setSize(50,20)
   ;
   
   cp5.addButton("end")
   .setValue(0)
   .setPosition(780,(4*50)-40)
   .setSize(50,20)
   ;
   
   cp5.addButton("Replay")
   .setValue(0)
   .setPosition(780,(5*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Replay")
   ;
   
   cp5.addButton("Home")
   .setValue(0)
   .setPosition(780,(6*50)-40)
   .setSize(50,20)
   ;
     
   cp5.addButton("Clear")
   .setValue(0)
   .setPosition(780,(7*50)-40)
   .setSize(50,20)
   .setCaptionLabel("CLEAR SCR")
   ;

   //column 2
   cp5.addButton("tool_1")
   .setValue(0)
   .setPosition(850,(1*50)-40)
   .setSize(50,20)
   .setCaptionLabel("TOOL 1")
   ;
   
   cp5.addButton("tool_2")
   .setValue(0)
   .setPosition(850,(2*50)-40)
   .setSize(50,20)
   .setCaptionLabel("TOOL 2")
   ;
   
   cp5.addButton("tool_3")
   .setValue(0)
   .setPosition(850,(3*50)-40)
   .setSize(50,20)
   .setCaptionLabel("TOOL 3")
   ;
   
   cp5.addButton("tool_4")
   .setValue(0)
   .setPosition(850,(4*50)-40)
   .setSize(50,20)
   .setCaptionLabel("TOOL 4")
   ;
  
   cp5.addButton("tool_5")
   .setValue(0)
   .setPosition(850,(5*50)-40)
   .setSize(50,20)
   .setCaptionLabel("TOOL 5")
   ;
   
   cp5.addButton("tool_6")
   .setValue(0)
   .setPosition(850,(6*50)-40)
   .setSize(50,20)
   .setCaptionLabel("TOOL 6")
   ;
   
   cp5.addButton("drop_tool")
   .setValue(0)
   .setPosition(850,(7*50)-40)
   .setSize(50,20)
   .setCaptionLabel("DROP TOOL")
   ;
   
   //column 3 
   cp5.addButton("Paint_1")
   .setValue(0)
   .setPosition(920,(1*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Paint 1")
   ;
   
   cp5.addButton("Paint_2")
   .setValue(0)
   .setPosition(920,(2*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Paint 2")
   ;
   
   cp5.addButton("Paint_3")
   .setValue(0)
   .setPosition(920,(3*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Paint 3")
   ;
   
   cp5.addButton("Paint_4")
   .setValue(0)
   .setPosition(920,(4*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Paint 4")
   ;
   
   cp5.addButton("Paint_5")
   .setValue(0)
   .setPosition(920,(5*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Paint 5")
   ;
   
   
   cp5.addButton("Paint_6")
   .setValue(0)
   .setPosition(920,(6*50)-40)
   .setSize(50,20)
   .setCaptionLabel("WASH")
   ;
   
   //column 4
   cp5.addButton("emergency")
   .setValue(0)
   .setPosition(990,(1*50)-40)
   .setSize(100,100)
   .setCaptionLabel("            EMERGENCY\n                 STOP")
   .setColorForeground(0xffaa0000)
   .setColorBackground(0xffff0000)
   .setColorActive(0xff660000)
   ;
   
   cp5.addButton("Preview2")
   .setValue(0)
   .setPosition(990,(4*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Preview 2")
   ;
   
   
   cp5.addButton("cBT")
   .setValue(0)
   .setPosition(990,(5*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Bluetooth")
   ;
   

   cp5.addTextfield("manualSerialCmd")
   .setPosition(780,500)
   .setSize(200,40)
   .setFont(font_fs)
   .setAutoClear(false)
   ;
   
   consoleTextArea = cp5.addTextarea("txt")
                  .setPosition(780, 600)
                  .setSize(450, 100)
                  .setFont(createFont("", 10))
                  .setLineHeight(14)
                  .setColor(color(255,255,255))
                  .setColorBackground(color(0, 100))
                  .setColorForeground(color(255, 100));
  ;

  console = cp5.addConsole(consoleTextArea);
}
