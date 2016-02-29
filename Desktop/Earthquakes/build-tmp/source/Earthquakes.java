import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Earthquakes extends PApplet {

// import java.util.HashMap; 
// import java.util.ArrayList; 
// import java.io.File; 
// import java.io.BufferedReader; 
// import java.io.PrintWriter; 
// import java.io.InputStream; 
// import java.io.OutputStream; 
// import java.io.IOException; 
// import java.util.regex.Pattern;
// import java.util.regex.Matcher;
// import java.util.Scanner;
// import java.io.LineNumberReader;
// import java.io.FileReader; 
// import java.util.Map;


JSONArray json; 
ArrayList< HashMap< String, String > > earthquakeTables; 
PImage map; 

public void loadData() { 
  json = loadJSONArray("http://earthquake-report.com/feeds/recent-eq?json");
}

public void setup() { 
  //json = loadJSONArray("http://earthquake-report.com/feeds/recent-eq?json");
  thread("loadData"); 
  earthquakeTables = new ArrayList< HashMap < String, String > > (); 
  map = loadImage("world.jpg"); 
  for (int i = 0; i < json.size(); i++) { 
    HashMap<String, String> earthquakeTable = new HashMap<String, String>();
    JSONObject item = json.getJSONObject(i); 
    
    String titleValue = item.getString("title"); 
    String magnitudeValue = item.getString("magnitude"); 
    String locationValue = item.getString("location"); 
    String depthValue = item.getString("depth"); 
    String latitudeValue = item.getString("latitude"); 
    String longitudeValue = item.getString("longitude"); 
    String dateTimeValue = item.getString("date_time"); 
   
    earthquakeTable.put("title", titleValue); 
    earthquakeTable.put("magnitude", magnitudeValue); 
    earthquakeTable.put("location", locationValue); 
    earthquakeTable.put("depth", depthValue); 
    earthquakeTable.put("latitude", latitudeValue); 
    earthquakeTable.put("longitude", longitudeValue); 
    earthquakeTable.put("date_time", dateTimeValue); 
    
    earthquakeTables.add(earthquakeTable); 
  }
  for(HashMap< String, String> earthquakeTable: earthquakeTables){ 
    for(String data: earthquakeTable.values()) { 
      println(data);  
    } 
    println();
  } 
}
public void draw() { 
  background(40, 90, 220); 
  pushMatrix();
  scale(.4f, .4f);
  image(map, 0, 0); 
  popMatrix();
  
  for(HashMap< String, String> earthquakeTable: earthquakeTables){ 
    float depthValue = PApplet.parseFloat(earthquakeTable.get("depth")); 
    float a = map(depthValue, 0, 60, 100, 200); 
    fill(255, 255, 255, a); 
    float magnitudeValue = PApplet.parseFloat(earthquakeTable.get("magnitude"));
    strokeWeight(pow(magnitudeValue, 2.5f)); 
    stroke(0, 0, 0, a); 
    float latitudeValue = PApplet.parseFloat(earthquakeTable.get("latitude")); 
    float longitudeValue = PApplet.parseFloat(earthquakeTable.get("longitude")); 
    float x = map(longitudeValue, -180, 155, 0, width); 
    float y = map(latitudeValue, -70, 100, 0, height - 200); 
    ellipse(x, y, 50, 50); 

    
  } 
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Earthquakes" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
