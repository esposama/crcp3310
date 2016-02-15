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

public class Project2safari extends PApplet {

Walker walker;
SetWalker setWalker;
QueueWalker queueWalker;
StackWalker stackWalker;   

ArrayList<Food> foods = new ArrayList<Food>();
final int NUMBER_OF_FOODS = 200;
final int NUMBER_OF_COLORS = 10;
int[] colors = new int[NUMBER_OF_COLORS];


public void setup() {
  background(0);
  //size(1000, 700);
  walker = new Walker(new PVector(width/2-50, height/2-50));
  setWalker = new SetWalker(new PVector(width/2-50, height/2-50));
  queueWalker = new QueueWalker(new PVector(width/2-50, height/2-50));
  stackWalker = new StackWalker(new PVector(width/2-50, height/2-50));
  for (int i = 0; i < NUMBER_OF_COLORS; ++i) {
    colors[i] = color(random(0, 200), 100, random(0, 200));
  }
  for (int i = 0; i < NUMBER_OF_FOODS; ++i) {
    PVector l = new PVector(random(0, width), random(0, height-200));
    int c = colors[(int)random(0, NUMBER_OF_COLORS)];
    foods.add(new Food(l, c));
  }
} 

public void draw() {
  background(200);
  walker.walk();
  walker.draw();
  setWalker.walk(); 
  setWalker.draw();
  queueWalker.walk();
  queueWalker.draw();
  stackWalker.walk(); 
  stackWalker.draw(); 
  for (int i = foods.size () - 1; i >= 0; i-- ) {
    Food f = foods.get(i);
    f.draw();
	if (walker.isTouching(f)) {
		if ((walker.location.x > 0) && (walker.location.x < width/4) || (walker.location.x > width/2 && walker.location.x < ((width/4)*3))) {
			walker.eat(f); 
			foods.remove(f); 
		}
	 else { 
		walker.deleteFood(f); 
				foods.remove(f); 

    }
}
	if (setWalker.isTouching(f)) {
		if ((setWalker.location.x > 0) && (setWalker.location.x < width/4) || (setWalker.location.x > width/2 && setWalker.location.x < ((width/4)*3))) {
			setWalker.eat(f); 
			foods.remove(f); 
		}
	 else { 
		setWalker.deleteFood(f);
				foods.remove(f); 
 
    }
}
	if (queueWalker.isTouching(f)) {
		if ((queueWalker.location.x > 0) && (queueWalker.location.x < width/4) || (queueWalker.location.x > width/2 && queueWalker.location.x < ((width/4)*3))) {
			queueWalker.eat(f); 
			foods.remove(f); 
		}
	else { 
		queueWalker.deleteFood(f);
		foods.remove(f); 
    }
}
if (stackWalker.isTouching(f)) {
		if ((stackWalker.location.x > 0) && (stackWalker.location.x < width/4) || (stackWalker.location.x > width/2 && stackWalker.location.x < ((width/4)*3))) {
			stackWalker.eat(f); 
			foods.remove(f); 
		}
	 else { 
		stackWalker.deleteFood(f); 
				foods.remove(f); 

    }
  } 
}
} 
class Walker {

  final int MAX_VELOCITY = 2;
  final float NOISE_DELTA = .01f;
  final int WIDTH = 100;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector tendency;
  float xOffset;

  ArrayList<Food> data = new ArrayList<Food>();
 ArrayList<Integer> colors = new ArrayList<Integer>(); 

  public Walker(PVector initialLocation) {
    this.location = initialLocation;
    velocity = new PVector(1, 0);
    acceleration = new PVector(1, 0);
    tendency = new PVector(1.4f, 0);
    xOffset = 0.0f;
  }

  public void draw() {
	fill(0);
    ellipse(location.x,location.y,WIDTH,WIDTH);

    textSize(12);
	fill(255);
    textAlign(CENTER);
    text("Bag Walker", location.x, location.y);
    for (Food f : data) {
      fill(f.c);
      ellipse(f.location.x, f.location.y, 20, 20);
    }
  }

  public void walk() {
    acceleration = PVector.fromAngle(noise(xOffset) * TWO_PI);
    velocity.add(acceleration);
    location.add(velocity);
    velocity.add(tendency);
    velocity.limit(MAX_VELOCITY);
    xOffset += NOISE_DELTA;
    if (location.y < 0) location.y = height-200;
    if (location.y  > height-200) location.y = 0;
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
  }

  public boolean isTouching(Food f) {
    return dist(location.x, location.y, f.location.x, f.location.y) < (WIDTH / 2 + f.diameter / 2);
  }

  public void eat(Food f) {
    data.add(f);
    f.location.x = random(0, width/4);
    f.location.y = random(height - 200, height);
  }

    public void deleteFood(Food f){
    data.remove(f); 
  	for (int i = 0; i < data.size(); i++) {
 		if(data.get(i).c == f.c) 
 		data.remove(i);  
 		break; 
 	} for (int i = 0; i < colors.size(); i++) { 
    	colors.remove(f.c); 
    }
  } 
}
class Food {

  PVector location;
  int diameter;
  int c;

  Food(PVector location, int c) {
    this.location = location;
    this.c = c;
    diameter = 20;
  }

  public void draw() {
    fill(c);
    ellipse(location.x, location.y, diameter, diameter);
  }
}
class SetWalker {

  final int MAX_VELOCITY = 2;
  final float NOISE_DELTA = .04f;
  final int WIDTH = 100;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector tendency;
  float xOffset;

  ArrayList<Food> data = new ArrayList<Food>();
  ArrayList<Integer> colors = new ArrayList<Integer>(); 

  public SetWalker(PVector initialLocation) {
    this.location = initialLocation;
    velocity = new PVector(1, 0);
    acceleration = new PVector(1, 0);
    tendency = new PVector(1.4f, 0);
    xOffset = 0.0f;
  }

  public void draw() {
	fill(0);
    ellipse(location.x,location.y,WIDTH,WIDTH);

    textSize(12);
	fill(255);
    textAlign(CENTER);
    text("Set Walker", location.x, location.y);
	stroke(20); 
	fill(0); 
	line(0, 690, 1600, 690);
	line(width/4, 0, width/4,  2560); 
	line(width/2, 0, width/2,  2560); 
	line(((width/4)*3), 0, ((width/4)*3), 2560);
	fill(0); 
	textSize(24);
    text("Add", 150 , 100);
    text("Bag", 150, 750); 
    text("Delete", 500 , 100);
    text("Set", 500, 750); 
    text("Add", 850 , 100);
    text("Queue", 850, 750); 
    text("Delete", 1200 , 100);
    text("Stack", 1200 , 750);
  
    for (Food f : data) {
      fill(f.c);
      ellipse(f.location.x, f.location.y, 20, 20);
    }
  }

  public void walk() {
    acceleration = PVector.fromAngle(noise(xOffset) * TWO_PI);
    velocity.add(acceleration);
    location.add(velocity);
    velocity.add(tendency);
    velocity.limit(MAX_VELOCITY);
    xOffset += NOISE_DELTA;
    if (location.y < 0) location.y = height-200;
    if (location.y  > height-200) location.y = 0;
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
  }

  public boolean isTouching(Food f) {
    return dist(location.x, location.y, f.location.x, f.location.y) < (WIDTH / 2 + f.diameter / 2);
  }

  public void eat(Food f) {
	// if the color is already present do nothing
	//if not set contains food color then add 
	boolean containsColor = false; 
	for (int i = 0; i < colors.size(); i++){ 
		if (colors.get(i) == f.c) {
		containsColor = true; 
		}
	}
		if (!containsColor) { 
		data.add(f);
		f.location.x = random(width/4, width/2);
        f.location.y = random(height - 200, height);
		colors.add(f.c); 
		}
  }
   public void deleteFood(Food f){
   	data.remove(f); 
   	for (int i = 0; i < data.size(); i++) { 
  	if (data.get(i).c == f.c) {  
 		data.remove(i);  
 		break; 
    }
   } 
  } 
} 
class StackWalker {

  final int MAX_VELOCITY = 2;
  final float NOISE_DELTA = .03f;
  final int WIDTH = 100;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector tendency;
  float xOffset;

  ArrayList<Food> data = new ArrayList<Food>();
  ArrayList<Integer> colors = new ArrayList<Integer>(); 


  public StackWalker(PVector initialLocation) {
    this.location = initialLocation;
    velocity = new PVector(1, 0);
    acceleration = new PVector(1, 0);
    tendency = new PVector(1.4f, 0);
    xOffset = 0.0f;
  }

  public void draw() {
	    fill(0);
    ellipse(location.x,location.y,WIDTH,WIDTH);

    textSize(12);
	fill(255);
    textAlign(CENTER);
    text("Stack Walker", location.x, location.y);
    for (Food f : data) {
      fill(f.c);
      ellipse(f.location.x, f.location.y, 20, 20);
    }
  }

  public void walk() {
    acceleration = PVector.fromAngle(noise(xOffset) * TWO_PI);
    velocity.add(acceleration);
    location.add(velocity);
    velocity.add(tendency);
    velocity.limit(MAX_VELOCITY);
    xOffset += NOISE_DELTA;
    if (location.y < 0) location.y = height-200;
    if (location.y  > height-200) location.y = 0;
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
  }

  public boolean isTouching(Food f) {
    return dist(location.x, location.y, f.location.x, f.location.y) < (WIDTH / 2 + f.diameter / 2);
  }

  public void eat(Food f) {

    data.add(f);
	for(int i = 0; i < data.size(); i++) { 
		data.get(i).location.x = (width/4)*3+ 20*i;
	}
    f.location.y = height - 200;
  }

  public void deleteFood(Food f){
  	if (!data.isEmpty()){ 
 		if(data.get(data.size()-1).c == f.c){
 		data.remove(data.size()-1);  
    } 
  }
} 
}  
class QueueWalker {

  final int MAX_VELOCITY = 2;
  final float NOISE_DELTA = .02f;
  final int WIDTH = 100;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector tendency;
  float xOffset;

  ArrayList<Food> data = new ArrayList<Food>();
  ArrayList<Integer> colors = new ArrayList<Integer>(); 


  public QueueWalker(PVector initialLocation) {
    this.location = initialLocation;
    velocity = new PVector(1, 0);
    acceleration = new PVector(1, 0);
    tendency = new PVector(1.4f, 0);
    xOffset = 0.0f;
  }

  public void draw() {
	fill(0);
    ellipse(location.x,location.y,WIDTH,WIDTH);

    textSize(12);
	fill(255);
    textAlign(CENTER);
    text("Queue Walker", location.x, location.y);
    for (Food f : data) {
      fill(f.c);
      ellipse(f.location.x, f.location.y, 20, 20);
    }
  }

  public void walk() {
    acceleration = PVector.fromAngle(noise(xOffset) * TWO_PI);
    velocity.add(acceleration);
    location.add(velocity);
    velocity.add(tendency);
    velocity.limit(MAX_VELOCITY);
    xOffset += NOISE_DELTA;
    if (location.y < 0) location.y = height-200;
    if (location.y  > height-200) location.y = 0;
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
  }

  public boolean isTouching(Food f) {
    return dist(location.x, location.y, f.location.x, f.location.y) < (WIDTH / 2 + f.diameter / 2);
  }

  public void eat(Food f) {
    data.add(f);
	for(int i = 0; i < data.size(); i++) { 
		data.get(i).location.x = (width/2) + 20*i;
	}
    f.location.y = height - 200;
} 
 public void deleteFood(Food f){
  	if (!data.isEmpty()){ 
 		if(data.get(0).c == f.c) 
 		data.remove(0); 
    	} 
	} 
 } 
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Project2safari" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
