class SetWalker {

  final int MAX_VELOCITY = 2;
  final float NOISE_DELTA = .04;
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
    tendency = new PVector(1.4, 0);
    xOffset = 0.0;
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
    if (location.y  > height-200) location.y = 0;
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