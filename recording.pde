void startRecording2(){
  allowRecord2 = true;
  recording2 = new JSONArray();
  record2index = 0; 
  JSONObject event = new JSONObject();
  event.setString("event", "info");
  event.setInt("offset_x", pixelGrid_x);
  event.setInt("offset_y", pixelGrid_y);
  event.setInt("canvas_size", pixelGrid_size);
  event.setInt("version", 2);
  recording2.setJSONObject(record2index, event);
  record2index++;
  //init the recording here with current tool?
  println("Recording started");
} 

void stopRecording2(){
  allowRecord2 = false;
  
  //finish the file with some homing moves 
  record2z(0.0);
  record2dwell(2000);
  record2event("home");
  
  //name the file
  String str_sec = nf(second(),2);
  String str_min  = nf(minute(),2);
  String str_hr = nf(hour(),2);
  String str_day = nf(day(),2);
  String str_mth = nf(month(),2);
  String str_yr = str(year());
  
  String date = str_yr + str_mth + str_day + "_" + str_hr + str_min + str_sec;
  
  json = new JSONObject();
  json.setJSONArray("brushbot-recording",recording2);
  saveJSONObject(json, "recordings2/"+date+".json");
  println("Saved file "+date+".json");
  
  //flush arrays here?
}

void record2xy(Float x, Float y){
 if(allowRecord2 && lastRec2X != x && lastRec2Y != y){
    JSONObject event = new JSONObject();
    event.setString("event", "xymove");
    event.setFloat("x", x);
    event.setFloat("y", y);
    recording2.setJSONObject(record2index, event);
    record2index++;
    lastRec2X = x; 
    lastRec2Y = y;
  }
}

void record2z(Float z){
 if(allowRecord2 && lastRec2Z != z){
    JSONObject event = new JSONObject();
    event.setString("event", "zmove");
    event.setFloat("z", z);
    recording2.setJSONObject(record2index, event);
    record2index++;
    lastRec2Z = z;
  }  
}

void record2paint(int pot){
 if(allowRecord2){
    JSONObject event = new JSONObject();
    event.setString("event", "paint");
    event.setInt("pot", pot);
    recording2.setJSONObject(record2index, event);
    record2index++;
  }  
}

void record2tool(int tool){
 if(allowRecord2){
    JSONObject event = new JSONObject();
    event.setString("event", "toolchange");
    event.setInt("tool", tool);
    recording2.setJSONObject(record2index, event);
    record2index++;
  }  
}

void record2event(String ev){
  JSONObject event = new JSONObject();
  event.setString("event", ev);
  recording2.setJSONObject(record2index, event);
  record2index++;    
}

void record2dwell(int dwell){
  JSONObject event = new JSONObject();
  event.setString("event", "dwell");
  event.setInt("pause", dwell);
  recording2.setJSONObject(record2index, event);
  record2index++;
}

void loadRec2File(File selection){
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Opening " + selection.getAbsolutePath());
    //addFileToBuffer(selection.getAbsolutePath());  
    json = loadJSONObject(selection.getAbsolutePath());
    JSONArray loadedRecording = json.getJSONArray("brushbot-recording");
    println("Loaded!");
    println("Found " + loadedRecording.size() + " entries.");
    
    int currentSize = 100;
    for(int i = 0; i < loadedRecording.size(); i++){
      JSONObject event = loadedRecording.getJSONObject(i);
      String eventType = event.getString("event");
      if(eventType.equals("zmove")){
        currentSize = int(event.getFloat("z"));
      }
      if(eventType.equals("xymove")){
        int x = int(event.getFloat("x"));
        int y = int(event.getFloat("y"));
        
        float mouse_x_pos = tablet.getPenX() - pixelGrid_x;
        float mouse_y_pos = pixelGrid_size - (tablet.getPenY() - pixelGrid_y);
        
        float x_length = x_max_val - x_min_val;
        float y_length = y_max_val - y_min_val;
        float x_pix_val = x_length / pixelGrid_size;
        float y_pix_val = y_length / pixelGrid_size;      
        float x_screen = (x+pixelGrid_x / x_pix_val) - x_min_val;
        float y_screen = ((y+pixelGrid_y) / y_pix_val) - y_min_val;
        
        println(x + " " + y + " > > " + int(x_screen) + " " + int(y_screen));
        //draw to screen
          noSmooth();
          noStroke();
          fill(0,0,0);
          ellipse(int(x_screen),int(y_screen),5,5);
          
      }      
      //println(eventType);
    }
     
  }  
}

void replayRec2File(File selection){
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Opening " + selection.getAbsolutePath());
    //addFileToBuffer(selection.getAbsolutePath());  
    json = loadJSONObject(selection.getAbsolutePath());
    JSONArray loadedRecording = json.getJSONArray("brushbot-recording");
    println("Loaded!");
    println("Found " + loadedRecording.size() + " entries.");
    
    for(int i = 0; i < loadedRecording.size(); i++){
      JSONObject event = loadedRecording.getJSONObject(i);
      String eventType = event.getString("event");
      if(eventType.equals("zmove")){
        float z = event.getFloat("z");
        moveZ(z);        
      }
      if(eventType.equals("xymove")){
        float x = event.getFloat("x");
        float y = event.getFloat("y");
        
        moveXY(x, y, x_min_val, x_max_val, y_min_val, y_max_val);
          
      }    
      if(eventType.equals("paint")){
        int pot = event.getInt("pot");
        
        penDip(pot);
        addToBuffer("G4 P100 \r");
          
      }    
      
      if(eventType.equals("toolchange")){
        int tool = event.getInt("tool");
        switchTool(tool);        
      }          
    }
     
  }  
}

void previewFile(File selection){
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Opening " + selection.getAbsolutePath());
    json = loadJSONObject(selection.getAbsolutePath());
    JSONArray loadedRecording = json.getJSONArray("brushbot-recording");
    println("Loaded!");
    println("Found " + loadedRecording.size() + " entries.");
    
    int currentSize = 100;
    for(int i = 0; i < loadedRecording.size(); i++){
      JSONObject event = loadedRecording.getJSONObject(i);
      String eventType = event.getString("event");
      if(eventType.equals("zmove")){
        currentSize = int(event.getFloat("z"));
      }
      if(eventType.equals("xymove")){
        int x = int(event.getFloat("x"));
        int y = int(event.getFloat("y"));
        
        float mouse_x_pos = tablet.getPenX() - pixelGrid_x;
        float mouse_y_pos = pixelGrid_size - (tablet.getPenY() - pixelGrid_y);
        
        float x_length = x_max_val - x_min_val;
        float y_length = y_max_val - y_min_val;
        float x_pix_val = x_length / pixelGrid_size;
        float y_pix_val = y_length / pixelGrid_size;      
        float x_screen = (x+pixelGrid_x / x_pix_val) - x_min_val;
        float y_screen = ((y+pixelGrid_y) / y_pix_val) - y_min_val;
        
        println(x + " " + y + " > > " + int(x_screen) + " " + int(y_screen));
        //draw to screen
          noSmooth();
          noStroke();
          fill(0,0,0);
          ellipse(int(x_screen),int(y_screen),5,5);
          
      }      
      //println(eventType);
    }
     
  }  
}



void replayFile(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("Buffering file " + selection.getAbsolutePath());
    addFileToBuffer(selection.getAbsolutePath());   
  }
}
 
void addFileToBuffer(String file){
  String[] lines = loadStrings(file);
  for(int i = 0; i < lines.length; i++){
    if(lines[i].length() < 1) continue;
    String[] comment = match(lines[i].substring(0,1), ";");
    if(comment != null){
      continue;
    };
    addToBuffer(lines[i]+"\r\n");
  }
}
