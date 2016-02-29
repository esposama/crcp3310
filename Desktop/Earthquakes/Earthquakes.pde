// Amanda Esposito Project 3 Earthquakes
// My program takes data from JSON format and displays its location by the lattitude and longitude. 
//The dept value is displayed by darkness of the circle and the magnitude value is the stroke weight of the circle. 

JSONArray json; 
ArrayList< HashMap< String, String > > earthquakeTables; 
PImage map; 

void setup() { 
  json = loadJSONArray("http://earthquake-report.com/feeds/recent-eq?json");
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
void draw() { 
  background(40, 90, 220); 
  pushMatrix();
  scale(.4, .4);
  image(map, 0, 0); 
  popMatrix();
  
  for(HashMap< String, String> earthquakeTable: earthquakeTables){ 
    float depthValue = float(earthquakeTable.get("depth")); 
    float a = map(depthValue, 0, 60, 100, 200); 
    fill(255, 255, 255, a); 
    float magnitudeValue = float(earthquakeTable.get("magnitude"));
    strokeWeight(pow(magnitudeValue, 2.5)); 
    stroke(0, 0, 0, a); 
    float latitudeValue = float(earthquakeTable.get("latitude")); 
    float longitudeValue = float(earthquakeTable.get("longitude")); 
    float x = map(longitudeValue, -180, 155, 0, width); 
    float y = map(latitudeValue, -70, 100, 0, height - 200); 
    ellipse(x, y, 50, 50); 

    
  } 
}