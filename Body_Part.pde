//for the bodyParts

class bodyPart {
  int j1, j2;
  float w;
  float theta;
  boolean special;
  bodyPart(int _j1, int _j2, float _w, boolean _special) {
    //distinguish which two joints are used to connect
    j1 = _j1;
    j2 = _j2;
    w = _w;
    //decides if circle or rectangle shape
    special = _special;
  }
  void display() {
    noFill();
    stroke(0);
    
    //trigonometry to get angles to work
    
    theta = asin((joints[j1].pos.y - joints[j2].pos.y)/dist(joints[j1].pos.x, joints[j1].pos.y, joints[j2].pos.x, joints[j2].pos.y));
    if (special) {
      if (joints[j1].pos.x < joints[j2].pos.x){
       theta *= -1; 
      }
      pushMatrix();
      translate((joints[j1].pos.x + joints[j2].pos.x)/2, (joints[j1].pos.y + joints[j2].pos.y)/2);
      rotate(theta);
      ellipse(0, 0, dist(joints[j1].pos.x, joints[j1].pos.y, joints[j2].pos.x, joints[j2].pos.y), w);
      popMatrix();
    } else {
      beginShape();
      vertex(joints[j1].pos.x + sin(theta)*w/2, joints[j1].pos.y + cos(theta)*w/2);
      vertex(joints[j1].pos.x - sin(theta)*w/2, joints[j1].pos.y - cos(theta)*w/2);
      vertex(joints[j2].pos.x - sin(theta)*w/2, joints[j2].pos.y - cos(theta)*w/2);
      vertex(joints[j2].pos.x + sin(theta)*w/2, joints[j2].pos.y + cos(theta)*w/2);
      vertex(joints[j1].pos.x + sin(theta)*w/2, joints[j1].pos.y + cos(theta)*w/2);
      endShape();
    }
  }
}