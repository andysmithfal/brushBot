// brushBot 
// 2015 Dave Turtle / Andy Smith
// Falmouth University

// ensure you have a config file with essential settings:   
// rename config.pde.example to config.pde

import controlP5.*;
ControlP5 cp5;

import codeanticode.tablet.*;

Tablet tablet;

//float penPressure = 0;

PrintWriter output;

import processing.serial.*;

Serial ramps;  // Create object from Serial class
int val;        // Data received from the serial port

int feedrate = 40000;

int x_min_val = 50;
int x_max_val = 200;
int y_min_val = 50;
int y_max_val = 200;


int pixelGrid_x = 10;
int pixelGrid_y = 10;
int pixelGrid_size = 750;

int lastTX = 0;

boolean inGrid = false;
boolean allowMove = false;
boolean allowRecord = false;
boolean floating = true;

float real_z_pos;
color onColor = color(204, 153, 0);


void setup(){
  
    //frameRate(40);
  
  
  size(conf_screen_x, conf_screen_y);
  
  //define gfx tablet object
    //tablet = new Tablet(this); 
  
  //connect to serial and init machine
  if(!conf_run_offline){
    ramps = new Serial(this, conf_serial_port, 115200);
    //put in a delay to let the marlin software reset
    blockingDelay(2000);
    //send g code to init
      
    ramps.write("M280 P0 S0 \r"); //set z-axis to 0 degrees (pen up)
    ramps.write("G28 X0 Y0 \r");  //home machine
    ramps.write("G21 \r"); //set units to mm
    ramps.write("G90 \r"); //absolute positioning
    ramps.write("G1 X0 Y0 F"+str(feedrate)+"\r"); //set feedrate
  }  

  //init the gui  
  //fonts 
  //String[] fontList = PFont.list();
  //println(fontList);
  PFont font = createFont("arial",20);
  PFont font_fs = createFont("Courier-Bold",20,false);
  cp5 = new ControlP5(this);
  textFont(font);
     
  //define buttons
  //column 1
   cp5.addButton("record")
   .setValue(0)
   .setPosition(780,(1*50)-40)
   .setSize(50,20)
   ;
   
   cp5.addButton("end")
   .setValue(0)
   .setPosition(780,(2*50)-40)
   .setSize(50,20)
   ;
   
   cp5.addButton("Home")
   .setValue(0)
   .setPosition(780,(3*50)-40)
   .setSize(50,20)
   ;
   
   cp5.addButton("Start")
   .setValue(0)
   .setPosition(780,(4*50)-40)
   .setSize(50,20)
   ;
   
   cp5.addButton("Stop")
   .setValue(0)
   .setPosition(780,(5*50)-40)
   .setSize(50,20)
   ;
   
   cp5.addButton("Drawing")
   .setValue(0)
   .setPosition(780,(6*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Floating")
   ;
   
   cp5.addButton("Paint_1")
   .setValue(0)
   .setPosition(780,(7*50)-40)
   .setSize(50,20)
   .setCaptionLabel("Paint Pot 1")
   ;



   cp5.addTextfield("manualSerialCmd")
   .setPosition(780,700)
   .setSize(200,40)
   .setFont(font_fs)
   .setAutoClear(false)
   ;

     
  // Create a new file in the sketch directory
  
  String str_sec = str(second());
  String str_min  = str(minute());
  String str_hr = str(hour());
  String str_day = str(day());
  String str_mth = str(month());
  String str_yr = str(year());
  
  output = createWriter(str_day + "-" + str_mth + "-" + str_yr + "_" + str_hr + "-"+ str_min+ "-" + str_sec + ".txt"); 
  
  
  initWorkArea();
}

void draw() {
  
  //println(frameRate);
  //TODO: try this -
   // Instead of mousePressed, one can use the Tablet.isMovement() method, which
  // returns true when changes not only in position but also in pressure or tilt
  // are detected in the tablet. 
 
}


 
