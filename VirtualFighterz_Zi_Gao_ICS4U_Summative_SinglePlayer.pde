//import required libraries
import processing.video.*;

//create capture object
Capture video;

//for configuration purposes
int gameState = 0;
boolean startCalibration = false;
int redAmount, greenAmount, blueAmount;
int calibrationNumber;
int n;

//create buttons
Button oneP;
Button twoP;

//for the game
float health = 15;
float score = 0;

//color tracking sensitivity
int sensitivity = 30;

//dimensions of video and total pixel count
int dX = 640; 
int dY = 480;
int pixelCount;

//create arrays of joint and bodypart objects
joint[] joints = new joint[4];
bodyPart[] bodyParts = new bodyPart[3];

//obstacles
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
int spawnTimer;
int difficulty = 90;

void setup() {
  size(640, 480); 
  frameRate(60);
 
  oneP = new Button(width/2, 220, 200, 60, "1P");
  twoP = new Button(width/2, 320, 200, 60, "2P"); 
  //joint 0 - left wrist
  joints[0] = new joint(40);
  //joint 1 - left elbow
  joints[1] = new joint(10);
  //joint 2 - leftShoulder/Neck
  joints[2] = new joint(10);
  //joint 3 - waist
  joints[3] = new joint(10);
  //joint 4 - head
  joints[4] = new joint(10);

  //bodyPart 0 - leftForearm
  bodyParts[0] = new bodyPart(0, 1, 20, false);
  //bodyPart 1 - leftUpperarm
  bodyParts[1] = new bodyPart(1, 2, 30, false);
  //bodyPart 2 - upperBody
  bodyParts[2] = new bodyPart(3, 2, 100, true);
  //bodyPart 3 - head
  bodyParts[3] = new bodyPart(2, 4, 60, true);
 
  //video object
  video = new Capture(this, dX, dY, 30);
  video.start();
  pixelCount = dX*dY;
}

void draw() {
  background(255);
  if (gameState == 0) {
    //calibration
    image(video, 0, 0, width, height);
    calibrate();
  } else if (gameState == 1) {
    //main menu
    menu();
    trackJoint();
    joints[0].display();
  } else if (gameState == 2) {
    //one player mode
    rectMode(CORNER);
    textAlign(CORNER);
    trackJoint();
    for (int i = 0; i < bodyParts.length; i++) {
      bodyParts[i].display();
    }    
    for (int i = 0; i < joints.length; i++) {
      joints[i].display();
    }
    spawnObstacle();
    for (int i = 0; i < obstacles.size(); i++) {
      Obstacle myObstacle = obstacles.get(i);
      myObstacle.display();
    }
    collisionDetection();
    textSize(20);
    fill(100, 255, 100);
    text("HEALTH", 20, 20);
    stroke(0);
    rectMode(CORNER);
    rect(20, 30, health*20, 30);
    text("Score: " + score, 500, 50);
    score++;
    if (health <= 0){
     gameState = 3; 
    }
  } else if (gameState == 3){
    //gameOver screen
    gameOver(); 
  }
}

void calibrate() {
  rectMode(CENTER);
  stroke(5);
  fill(255, 200);
  rect(width/2, height/2, 400, 150);
  textAlign(CENTER);
  fill(0);
  textSize(35); 
  if (!joints[calibrationNumber].calibrated) {
    if (startCalibration) {
      n++;
      if (n > 600) {
        //start calibrating
        redAmount += red(video.pixels[0]);
        greenAmount += green(video.pixels[0]);
        blueAmount += blue(video.pixels[0]);
        text("Calibrating...", width/2, height/2);
      } else {
        text("Calibrating in: " + floor((700-n)/100), width/2, height/2);
      }
      if (n > 800) {
        //finish calibrating
        joints[calibrationNumber].calibrated = true;
        joints[calibrationNumber].c = color(redAmount/200, greenAmount/200, blueAmount/200);
        joints[calibrationNumber].oldC = color(redAmount/200, greenAmount/200, blueAmount/200);
        redAmount = 0;
        blueAmount = 0;
        greenAmount = 0;
        n = 0;
      }
    } else if (!startCalibration) {
      text("Press Space to Start", width/2, 220);
      switch(calibrationNumber) {
      case 0: 
        text("Calibrating Wrist!", width/2, 270);
        break;
      case 1: 
        text("Calibrating Elbow!", width/2, 270);
        break;
      case 2:
        text("Calibrating Neck!", width/2, 270);
        break;
      case 3: 
        text("Calibrating Waist!", width/2, 270);
        break;
      case 4:
        text("Calibrating Head!", width/2, 270);
        break;
      }
      if (keyPressed && key == ' ') {
        startCalibration = true;
        keyPressed = false;
      }
    }
  } else {
    calibrationNumber++; 
    startCalibration = false;
    if (calibrationNumber >= joints.length) {
      gameState = 1;
    }
  }
}

void captureEvent(Capture video) {
  //get pixels
  video.read();
  video.loadPixels();
}