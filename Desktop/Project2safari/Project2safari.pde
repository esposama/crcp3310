Walker walker;
SetWalker setWalker; 

ArrayList<Food> foods = new ArrayList<Food>();
final int NUMBER_OF_FOODS = 100;
final int NUMBER_OF_COLORS = 10;
color[] colors = new color[NUMBER_OF_COLORS];

void setup() {
  background(0);
  //size(1000, 700);
  walker = new Walker(new PVector(width/2-50, height/2-50));
  setWalker = new SetWalker(new PVector(width/2-50, height/2-50));
  for (int i = 0; i < NUMBER_OF_COLORS; ++i) {
    colors[i] = color(random(0, 200), 200, random(0, 200));
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
  for (int i = foods.size () - 1; i >= 0; i-- ) {
    Food f = foods.get(i);
    f.draw();
	if (walker.isTouching(f)) {
      walker.eat(f);
      foods.remove(f);
    }
	if (setWalker.isTouching(f)) {
      setWalker.eat(f);
      foods.remove(f);
    }
	} 
} 