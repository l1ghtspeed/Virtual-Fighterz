//class for joint objects

class joint {
  //declare and initiate vectors
  PVector pos = new PVector(0, 0);
  float x, y;
  color c;
  color oldC;
  int counter;
  float r;
  boolean calibrated = false;

  //class constructor
  joint (float _r) {
    r = _r;
  }

  //function to display joint
  void display() {
    stroke(c);
    strokeWeight(2);
    fill(c);
    ellipse(pos.x, pos.y, r, r);
    noFill();
  }
}