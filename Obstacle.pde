//create obstacles

class Obstacle {
  PVector pos;
  PVector vel;
  float r;
  boolean isBreakable;

  Obstacle (PVector _pos, PVector _vel, float _r, int _isBreakable) {
    pos = _pos;
    vel = _vel;
    r = _r;
    if (_isBreakable == 0) {
      isBreakable = true;
    } else {
      isBreakable = false;
    }
  }

  void display() {
    rectMode(CENTER);
    if (isBreakable) {
      fill(150);
    } else {
      fill(0);
    }
    ellipse(pos.x, pos.y, r, r);
    pos = pos.add(vel);
  }
}

void spawnObstacle() {
  spawnTimer++;
  //to spawn an obstacle - based on time
  if (spawnTimer > difficulty) {
    float r = floor(random(0, 2));
    if (r == 0) {
      obstacles.add(new Obstacle(new PVector(1040.0, random(200, 400)), new PVector(-5, 0), random(50, 80), floor(random(0, 2))));
    }
    spawnTimer = 0;
  }
  
  
  //remove obstacles
  for (int j = obstacles.size()-1; j > 0; j--) {
    if (obstacles.size() > 0) {
      Obstacle myObstacle = obstacles.get(j);
      if (myObstacle.pos.x + myObstacle.r/2 < 0 && myObstacle.vel.x < 0) {
        obstacles.remove(j);
      }
    }
  }
}