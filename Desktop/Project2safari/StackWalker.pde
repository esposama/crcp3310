class StackWalker {

  final int MAX_VELOCITY = 2;
  final float NOISE_DELTA = .03;
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
    tendency = new PVector(1.4, 0);
    xOffset = 0.0;
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
    if (location.y  > height-200) location.y = 0;
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
