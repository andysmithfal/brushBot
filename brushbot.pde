// brushBot 
// 2015 Dave Turtle / Andy Smith
// Falmouth University

import controlP5.*;
ControlP5 cp5;

import codeanticode.tablet.*;

Tablet tablet;

//float penPressure = 0;

PrintWriter output;

import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port

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

float real_z_pos;

color onColor = color(204, 153, 0);


void setup(){
  
    //frameRate(40);
  
  background(255,0,0);
  size(1280, 800);
  
  //tablet = new Tablet(this); 
  
  //String portName = Serial.list()[0];
  myPort = new Serial(this, "/dev/tty.usbmodem1431", 115200);
  
  //put in a delay to let the marlin software reset
  
    myDelay(2000);
    
    //send g code to home machine
    
  myPort.write("M280 P0 S0 \r");
  myPort.write("G28 X0 Y0 \r");  
  myPort.write("G21 \r"); 
  myPort.write("G90 \r"); 
  myPort.write("G1 X0 Y0 F40000"); 
    
  
  PFont font = createFont("arial",20);
  
  
  cp5 = new ControlP5(this);
     
     textFont(font);
     
     // create a new button
      cp5.addButton("record")
     .setValue(0)
     .setPosition(780,10)
     .setSize(50,19)
     ;
     
      cp5.addButton("end")
     .setValue(0)
     .setPosition(780,60)
     .setSize(50,19)
     ;
     
       cp5.addButton("Home")
     .setValue(0)
     .setPosition(780,110)
     .setSize(50,19)
     ;
     
         cp5.addButton("Start")
     .setValue(0)
     .setPosition(780,160)
     .setSize(50,19)
     ;
     
      cp5.addButton("Stop")
     .setValue(0)
     .setPosition(780,210)
     .setSize(50,19)
     ;
     
      cp5.addButton("Paint_1")
     .setValue(0)
     .setPosition(780,260)
     .setSize(50,19)
     ;

     
     // Create a new file in the sketch directory
  
  String str_sec = str(second());
  String str_min  = str(minute());
  String str_hr = str(hour());
  String str_day = str(day());
  String str_mth = str(month());
  String str_yr = str(year());
  
  output = createWriter(str_day + "-" + str_mth + "-" + str_yr + "_" + str_hr + "-"+ str_min+ "-" + str_sec + ".txt"); 
}

void draw() {
  rect(10,10,750,750);
  //frameRate(1);

  //println(frameRate);
   // Instead of mousePressed, one can use the Tablet.isMovement() method, which
  // returns true when changes not only in position but also in pressure or tilt
  // are detected in the tablet. 
 
}
void myDelay(int ms)
{
   try
  {    
    Thread.sleep(ms);
  }
  catch(Exception e){}
}
 
 
