
//collision detection

void collisionDetection() {
  if (obstacles.size() > 0) {
    for (int i = obstacles.size()-1; i > 0; i--) {
      Obstacle myObstacle = obstacles.get(i);
      if (dist(myObstacle.pos.x, myObstacle.pos.y, joints[0].pos.x, joints[0].pos.y) < (joints[0].r/2 + myObstacle.r/2)
        && myObstacle.isBreakable) {
        obstacles.remove(i);
      } else {
        for (int j = 0; j < bodyParts.length; j++) {
          if (abs(dist(joints[bodyParts[j].j1].pos.x, joints[bodyParts[j].j1].pos.y, myObstacle.pos.x, myObstacle.pos.x)) + 
            abs(dist(joints[bodyParts[j].j2].pos.x, joints[bodyParts[j].j2].pos.y, myObstacle.pos.x, myObstacle.pos.y)) -
            abs(dist(joints[bodyParts[j].j1].pos.x, joints[bodyParts[j].j1].pos.y, joints[bodyParts[j].j2].pos.x, joints[bodyParts[j].j2].pos.y)) < (myObstacle.r/2)) {
            health-=(j+1);
            obstacles.remove(i);
          }
        }
      }
    }
  }
}