void startRecording(){
  // Create a new file in the sketch directory
  String str_sec = str(second());
  String str_min  = str(minute());
  String str_hr = str(hour());
  String str_day = str(day());
  String str_mth = str(month());
  String str_yr = str(year());
  
  String date = str_yr + str_mth + str_day + "_" + str_hr + str_min + str_sec;
  
  recording = createWriter("recordings/"+ date + ".gcode"); 
  
  allowRecord = true;
}

void stopRecording(){
  allowRecord = false;
  recording.flush(); // Writes the remaining data to the file
  recording.close(); // Finishes the file
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
