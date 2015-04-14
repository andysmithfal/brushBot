// brushBot 
// 2015 Dave Turtle / Andy Smith
// Falmouth University

// ensure you have a config file with essential settings:   
// rename config.pde.example to config.pde

//GUI
import controlP5.*;
ControlP5 cp5;
DropdownList toolDropdown;
Println console;
Textarea consoleTextArea;

//tablet
import codeanticode.tablet.*;
Tablet tablet;
float penPressure = 0;

//recording
PrintWriter recording;
PrintWriter jsonrecording;
boolean allowRecord = false;

JSONObject json;
JSONArray recording2;
int record2index = 0;
boolean allowRecord2 = false;
float lastRec2X; 
float lastRec2Y;
float lastRec2Z;

//serial
import processing.serial.*;
Serial ramps;  // Create object from Serial class
int val;        // Data received from the serial port

int feedrate = 30000;

int x_min_val = 40;
int x_max_val = 220;
int y_min_val = 120;
int y_max_val = 300;


int pixelGrid_x = 10;
int pixelGrid_y = 10;
int pixelGrid_size = 750;

int lastTX = 0;
int lastX = 0;
int lastY = 0;
int lastZ = 0;
int currentTool = 0;
int currentPaint = 1;

boolean inGrid = false;
boolean allowMove = false;
boolean floating = true;
boolean changingTool = false;

ArrayList<String> gcodebuffer = new ArrayList<String>();
boolean serial_wait = false;

float real_z_pos;
color onColor = color(204, 153, 0);


void setup(){ 
  size(conf_screen_x, conf_screen_y);
  
  //define gfx tablet object
    tablet = new Tablet(this); 
  
  //connect to serial and init machine
  if(!conf_run_offline){
    ramps = new Serial(this, findSerial(ramps.list()), 115200);
    ramps.bufferUntil(10); 
    //put in a delay to let the marlin software reset
    blockingDelay(2000);
    //send g code to init
    addToBuffer("M280 P0 S10 \r"); //set z-axis to 10 degrees (pen up)
    addToBuffer("G28 X0 Y0 \r");  //home machine
    addToBuffer("G21 \r"); //set units to mm
    addToBuffer("G90 \r"); //absolute positioning
    addToBuffer("G1 X0 Y0 F"+str(feedrate)+"\r"); //set feedrate
    addToBuffer("G1 X0 Y25 \r"); //set feedrate
  }  
  
  initGUI();
  initWorkArea();
}

void draw() {
  noStroke();
  fill(0xed,0xa2,0x23);
  rect(770,0,(conf_screen_x-770),conf_screen_y);
  
  if( tablet.isMovement() ){
    xyInput();
  }
  processBuffer();
  displayStatus(990, 500);
}

void stop() {
 //TODO: code run on exit - drop tool, stop recording etc 
}
