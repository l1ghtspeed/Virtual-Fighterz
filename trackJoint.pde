//joint tracking using averaging color detection method

void trackJoint() {
  for (int i = 0; i < pixelCount; i++) {
    for (int j = 0; j < joints.length; j++) {
      if (red(video.pixels[i]) > red(joints[j].c)-sensitivity && red(video.pixels[i]) < red(joints[j].c)+sensitivity 
        && green(video.pixels[i]) > green(joints[j].c)-sensitivity && green(video.pixels[i]) < green(joints[j].c)+sensitivity
        && blue(video.pixels[i]) > blue(joints[j].c)-sensitivity && blue(video.pixels[i]) < blue(joints[j].c)+sensitivity) 
      {
        joints[j].counter++;
        joints[j].x += i%dX;
        joints[j].y += i/dX;
      }
    }
  }
  for (int j = 0; j < joints.length; j++) {
    if (joints[j].counter >= 0) {
      if (dist(joints[j].pos.x, joints[j].pos.y, floor(joints[j].x/joints[j].counter), floor(joints[j].y/joints[j].counter)) > 5 
        && joints[j].x > 0 && joints[j].y > 0) {  
        joints[j].pos.x = abs(floor(joints[j].x/joints[j].counter) - width);
        joints[j].pos.y = floor(joints[j].y/joints[j].counter);
      }   
      joints[j].counter = 0;
      joints[j].x = 0;
      joints[j].y = 0;
    }
  }
}