class SetWalker {

  final int MAX_VELOCITY = 1;
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
	stroke(10); 
	line(0, 690, 1600, 690);
	line(250, 690, 250,  2560); 
	line(500, 690, 500,  2560); 
	noStroke();
    ellipse(location.x, location.y, WIDTH, WIDTH);
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
		f.location.x = random(250, 500);
        f.location.y = random(height - 200, height);
		colors.add(f.c); 
		}
  }
} 