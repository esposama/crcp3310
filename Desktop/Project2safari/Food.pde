class Food {

  PVector location;
  int diameter;
  color c;

  Food(PVector location, color c) {
    this.location = location;
    this.c = c;
    diameter = 20;
  }

  void draw() {
    fill(c);
    ellipse(location.x, location.y, diameter, diameter);
  }
}