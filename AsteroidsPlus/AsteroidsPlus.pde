/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

import sprites.*;
import sprites.utils.*;
import sprites.maths.*;
import java.util.*;
import java.util.concurrent.*;

GameLevel gameLevel;
PImage background;

KeyboardController kbController;
SoundPlayer soundPlayer;
StopWatch stopWatch = new StopWatch();
int remainingLives;
float globalVolume = .2;

boolean startButtonRegistered = false;
boolean stop = false;
boolean pressP, pressZ;


void setup() 
{
  size(1000, 700);

  // BG Image must be same size as window. 
  background = loadImage("milkyWayBackground.jpg");

  kbController = new KeyboardController(this);
  soundPlayer = new SoundPlayer(this, globalVolume);  

  // register the function (pre) that will be called
  // by Processing before the draw() function. 
  registerMethod("pre", this);

  remainingLives = 3;

  gameLevel = new StartLevel(this);
  gameLevel.start();
}

// Executed before each next frame is drawn. 
void pre() 
{
  gameLevel.update();
  //S4P.updateSprites(stopWatch.getElapsedTime());
  S4P.updateSprites(0.04);
  nextLevelStateMachine();
}

// Determine the next GameLevel to play
void nextLevelStateMachine()
{
  GameState state = gameLevel.getGameState();

  if (gameLevel instanceof StartLevel) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new AsteroidsLevel1(this);
      gameLevel.start();
    }
  } else if (gameLevel instanceof AsteroidsLevel1) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new AsteroidsLevel2(this);
      //gameLevel = new WinLevel(this);
      //gameLevel = new LoseLevel(this);
      gameLevel.start();
      background = loadImage("background2.jpg");
    } else if (state == GameState.Lost) {
      gameLevel.stop();
      gameLevel = new LoseLevel(this);
      gameLevel.start();
    }
  } else if (gameLevel instanceof AsteroidsLevel2) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new AsteroidsLevel3(this);
      gameLevel.start();
      background = loadImage("background3.jpg");
    } else if (state == GameState.Lost) {
      gameLevel.stop();
      gameLevel = new LoseLevel(this);
      gameLevel.start();
    }
  } else if (gameLevel instanceof AsteroidsLevel3) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new AsteroidsLevel4(this);
      gameLevel.start();
      background = loadImage("background4.jpg");
    } else if (state == GameState.Lost) {
      gameLevel.stop();
      gameLevel = new LoseLevel(this);
      gameLevel.start();
    }
  }else if (gameLevel instanceof AsteroidsLevel4) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new WinLevel(this);
      gameLevel.start();
      background = loadImage("background5.jpg");
    } else if (state == GameState.Lost) {
      gameLevel.stop();
      gameLevel = new LoseLevel(this);
      gameLevel.start();
    }
  }else if (gameLevel instanceof WinLevel) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new StartLevel(this);
      gameLevel.start();
    }
  } else if (gameLevel instanceof LoseLevel) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new StartLevel(this);
      gameLevel.start();
    }
  }
  
}

// Activated by Processing when a key is pressed
void keyPressed() 
{
  gameLevel.keyPressed();
  if (key == 'p' || key == 'P') {
    pressP = true;
    stop = !stop;
    if (stop) {
      fill(237, 28, 36);
      textSize(75);
      String msg = "PAUSED";
      String msg2 = "Unpause and hold \"z\" to display a secret message!";
      text(msg, 350, 350);
      fill (185, 76, 225);
      textSize(15);
      text(msg2, 10, 690);
      noLoop();
    }
    else {
      loop();
    }
  }
  if ((key == 'z' || key == 'Z')){
        pressZ = true;
        //String msg3 = "Thank you for playing our Game!";
        //fill(255, 210, 0);
        //textSize(75);
        //text(msg3, 350, 350);
  }
}

void keyReleased()
{
  if ((key == 'z' || key == 'Z')){
        pressZ = false;
        //String msg3 = "Thank you for playing our Game!";
        //fill(255, 210, 0);
        //textSize(75);
        //text(msg3, 350, 350);
  }
}

// Activated by Processing when the mouse button is pressed in the canvas
void mousePressed()
{
  gameLevel.mousePressed();
}

void draw() 
{
  // Background image must be same size as window. 
  background(background);
  S4P.drawSprites();
  gameLevel.drawOnScreen();
  
  if (pressP == true && pressZ == true){
    String msg3 = "Thank you for playing our Game :)";
    fill(229, 78, 208);
    textSize(50);
    text(msg3, 100, 350);
  }
  
}
