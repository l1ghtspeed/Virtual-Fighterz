//simple menu

void menu() {
  textSize(60);
  text("Virtual FighterZ", width/2, 100);
  oneP.update();
  twoP.update();
}

//button class
class Button {
  float xPos, yPos, w, h;
  boolean clicked = false;
  String word;
  int bTimer;

  Button (float _xPos, float _yPos, float _w, float _h, String _word) {
    xPos = _xPos;
    yPos = _yPos;
    w = _w;
    h = _h;
    word = _word;
  }

  void update() {
    strokeWeight(2);
    stroke(50);
    rectMode(CENTER);
    if (joints[0].pos.x > (xPos - w/2) && joints[0].pos.x < (xPos + w/2) && joints[0].pos.y > (yPos - h/2) && joints[0].pos.y < (yPos + h/2)) {
      fill(#26C485, bTimer);
      rect(xPos, yPos, w, h, 10);
      bTimer++;
      if (bTimer >= 255){
       bTimer = 0;
       gameState = 2;
      }
    } else {
      fill(#6BA292);
      rect(xPos, yPos, w, h, 10);
      bTimer = 0;
    }
    fill(#FC7521);
    textSize(h/2);
    text(word, xPos, yPos + 7);
  }
}

void gameOver(){
  textAlign(CENTER);
  fill(0);
  textSize(50);
  text("GAME OVER!", width/2, 220);
  textSize(20);
  text("Your Score was: " + score, width/2, 270);
}