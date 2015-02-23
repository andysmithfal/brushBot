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
