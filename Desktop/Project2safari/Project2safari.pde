//Amanda Esposito Project #2 Safari 
//In this project I used 4 different kinds of data structures and 4 different walkers. Each walker descibed a different data structure. 
//Each walker would collect balls and sorta them based off the kind of data structure. The screen is divided into 4 different section that 
//would be either add or delete. When each walker enter these different zones based off the data structure they represented would act differently. 
//I learned how to impletement each structure and what each data structure meant in this project. 


Walker walker;
SetWalker setWalker;
QueueWalker queueWalker;
StackWalker stackWalker;   

ArrayList<Food> foods = new ArrayList<Food>();
final int NUMBER_OF_FOODS = 200;
final int NUMBER_OF_COLORS = 10;
color[] colors = new color[NUMBER_OF_COLORS];


void setup() {
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
    color c = colors[(int)random(0, NUMBER_OF_COLORS)];
    foods.add(new Food(l, c));
  }
} 

void draw() {
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