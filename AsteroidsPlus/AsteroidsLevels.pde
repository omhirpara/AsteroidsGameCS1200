/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

int accuracy;
int accuracyMult;
int score;
void resetScore() {
  score = 0;
  accuracy = 0;
  accuracyMult = 0;
  missileNum = 0;
  missilesCollisionNum = 0;
  remainingLives = 3;
}

class AsteroidsLevel1 extends AsteroidsGameLevel 
{
  float missileSpeed = 200;
  StopWatch powerupSW;
  int periodBetweenPU = 10;
  StopWatch addAsteroidsSW;
  int periodBetweenAdds = 5;
  float asteroidSpeed;

  AsteroidsLevel1(PApplet applet)
  {
    super(applet);

    powerupSW = new StopWatch();
    addAsteroidsSW = new StopWatch();
    asteroidSpeed = 3;
  }

  void start()
  {
    super.start();
    resetScore();

    ship = new Ship(game, width/2, height/2);

    // Example of setting the ship's sprite to a custom image. 
    //ship = new Ship(game, "ships2.png", width/2, height/2);
    //ship.setScale(.5);

    asteroids.add(new BigAsteroid(game, 200, 500, 0, 0.02, 22, PI*.5));
    asteroids.add(new BigAsteroid(game, 500, 200, 1, -0.01, 22, PI*1));

    gameState = GameState.Running;
  }

  void update() 
  {
    super.update();

    if (powerupSW.getRunTime() - 10 > periodBetweenPU) {
      powerupSW.reset();

      int centerX = game.width/2;
      int centerY = game.height/2;
      powerUps.add(new ShieldPowerup(game, centerX, centerY, 100, ship));
      powerUps.add(new RapidFirePowerup(game, centerX, centerY, 100, ship));
    }

    // TEAMS: Example of adding additional asteroids for Infinite Level
    /*
    if (addAsteroidsSW.getRunTime() > periodBetweenAdds) {
     addAsteroidsSW.reset();
     
     asteroidSpeed += 20;
     int newX = ((int)ship.getX() + game.width/2) % game.width;
     int newy = ((int)ship.getY() + game.height/2) % game.height;
     asteroids.add(new BigAsteroid(game, newX, newy, 0, 0.02, asteroidSpeed, random(0, 6.5)));
     }
     */
  }

  void drawOnScreen() 
  {
    String msg;
    
    fill(255);
    textSize(20);
    msg = "Score: " + score;
    text(msg, 10, 20);
    msg = "Lives: " + remainingLives;
    text(msg, 10, 40);
    text("Missiles Fired: " + missileNum, 10, 60);
    text("Missiles Hit: " + missilesCollisionNum, 10, 80);
    if (missileNum > 0) {
      accuracy = ((int)(10000*(((double)missilesCollisionNum)/missileNum)));
      text("Accuracy: " + (accuracy/100.0) + "%", 10, 100);
    }
    else {
      text("Accuracy: 0.0%", 10, 100);
    }
    if (accuracy / 100.0 == 100){
      accuracyMult = 5;
    }
    else if (accuracy / 100.0 > 80){
      accuracyMult = 4;
    }
    else if (accuracy / 100.0 > 60){
      accuracyMult = 3;
    }
    else if (accuracy / 100.0 > 40){
      accuracyMult = 2;
    }
    else if (accuracy / 100.0 > 0){
      accuracyMult = 1;
    }
    else {
      accuracyMult = 0;
    }
    text("Point Multiplier: " + accuracyMult + "x", 10, 120);
    ship.drawOnScreen(); // Draws Energy Bar
  }

  void keyPressed() 
  {
    if ( key == ' ') {
      if (ship.isActive()) 
      {
        if(ship.rapidfireOn()) /////////////////////////////////////////////////////////////////////added if/else
        {
          rapidfireMissile(missileSpeed + 50); 
        }
        else
        {
          launchMissile(missileSpeed);
        }
      }
    }
  }

  void mousePressed()
  {
  }

  private void launchMissile(float speed) 
  {
    if (ship.energy >= .2) {
      int shipx = (int)ship.getX();
      int shipy = (int)ship.getY();
      
      Missile missile = new Missile(game, shipx, shipy);
      missile.setRot(ship.getRot() - 1.5708);
      missile.setSpeed(speed);
      missiles.add(missile);

      ship.energy -= ship.deplete;
    }
  }
  
  //RAPIDFIRE POWERUP IMPLEMENTATION 
  private void rapidfireMissile(float speed) 
  {
    if (ship.energy >= .05) {
      int shipx = (int)ship.getX();
      int shipy = (int)ship.getY();
      
      Missile missile = new Missile(game, shipx, shipy);
      missile.setRot(ship.getRot() - 1.5708);
      missile.setSpeed(speed);
      missiles.add(missile);

      ship.energy -= ship.deplete;
    }
  }
}

/*****************************************************/

class AsteroidsLevel2 extends AsteroidsGameLevel 
{
  float missileSpeed = 200;
  StopWatch powerupSW;
  int periodBetweenPU = 10;

  AsteroidsLevel2(PApplet applet)
  {
    super(applet);

    powerupSW = new StopWatch();
  }

  void start()
  {
    super.start();

    ship = new Ship(game, width/2, height/2);
    asteroids.add(new BigAsteroid(game, 200, 500, 0, 0.02, 22, PI*.5));
    asteroids.add(new BigAsteroid(game, 500, 200, 1, -0.01, 22, PI*1));
    asteroids.add(new BigAsteroid(game, 100, 300, 2, 0.01, 22, PI*1.7));

    gameState = GameState.Running;
  }

  void update() 
  {
    super.update();

    if (powerupSW.getRunTime() - 10 > periodBetweenPU) {
      powerupSW.reset();
      powerUps.add(new ShieldPowerup(game, game.width/2, game.height/2, 100, ship));
      powerUps.add(new RapidFirePowerup(game, game.width/2, game.height/2, 100, ship));
    }
  }

  void drawOnScreen() 
  {
    String msg;

    fill(255);
    textSize(20);
    msg = "Score: " + score;
    text(msg, 10, 20);
    msg = "Lives: " + remainingLives;
    text(msg, 10, 40);
    text("Missiles Fired: " + missileNum, 10, 60);
    text("Missiles Hit: " + missilesCollisionNum, 10, 80);
    if (missileNum > 0) {
      accuracy = ((int)(10000*(((double)missilesCollisionNum)/missileNum)));
      text("Accuracy: " + (accuracy/100.0) + "%", 10, 100);
    }
    else {
      text("Accuracy: 0.0%", 10, 100);
    }
    if (accuracy / 100.0 == 100){
      accuracyMult = 5;
    }
    else if (accuracy / 100.0 > 80){
      accuracyMult = 4;
    }
    else if (accuracy / 100.0 > 60){
      accuracyMult = 3;
    }
    else if (accuracy / 100.0 > 40){
      accuracyMult = 2;
    }
    else if (accuracy / 100.0 > 0){
      accuracyMult = 1;
    }
    else {
      accuracyMult = 0;
    }
    text("Point Multiplier: " + accuracyMult + "x", 10, 120);
    ship.drawOnScreen(); // Draws Energy Bar
  }

  void keyPressed() 
  {
    if ( key == ' ') {
      if (ship.isActive()) 
      {
        if(ship.rapidfireOn()) 
        {
          rapidfireMissile(missileSpeed + 50); 
        }
        else
        {
          launchMissile(missileSpeed);
        }
      }
    }
  }

  void mousePressed()
  {
  }

  private void launchMissile(float speed) 
  {
    if (ship.energy >= .2) {
      int shipx = (int)ship.getX();
      int shipy = (int)ship.getY();
      Missile missile = new Missile(game, shipx, shipy);
      missile.setRot(ship.getRot() - 1.5708);
      missile.setSpeed(speed);
      missiles.add(missile);

      ship.energy -= ship.deplete;
    }
  }
  
  //RAPIDFIRE POWERUP IMPLEMENTATION
  private void rapidfireMissile(float speed) 
  {
    if (ship.energy >= .05) {
      int shipx = (int)ship.getX();
      int shipy = (int)ship.getY();
      
      Missile missile = new Missile(game, shipx, shipy);
      missile.setRot(ship.getRot() - 1.5708);
      missile.setSpeed(speed);
      missiles.add(missile);

      ship.energy -= ship.deplete;
    }
  }
}

class AsteroidsLevel3 extends AsteroidsGameLevel 
{
  float missileSpeed = 200;
  StopWatch powerupSW;
  int periodBetweenPU = 10;

  AsteroidsLevel3(PApplet applet)
  {
    super(applet);

    powerupSW = new StopWatch();
  }

  void start()
  {
    super.start();

    ship = new Ship(game, width/2, height/2);
    asteroids.add(new BigAsteroid(game, 200, 500, 0, 0.02, 22, PI*.5));
    asteroids.add(new BigAsteroid(game, 500, 200, 1, -0.01, 22, PI*1));
    asteroids.add(new BigAsteroid(game, 100, 300, 2, 0.01, 22, PI*1.7));
    asteroids.add(new BigAsteroid(game, 500, 600, 0, -0.02, 22, PI*1.3));

    gameState = GameState.Running;
  }

  void update() 
  {
    super.update();

    if (powerupSW.getRunTime() - 10 > periodBetweenPU) {
      powerupSW.reset();
      powerUps.add(new ShieldPowerup(game, game.width/2, game.height/2, 100, ship));
      powerUps.add(new RapidFirePowerup(game, game.width/2, game.height/2, 100, ship));
    }
  }

  void drawOnScreen() 
  {
    String msg;

    fill(255);
    textSize(20);
    msg = "Score: " + score;
    text(msg, 10, 20);
    msg = "Lives: " + remainingLives;
    text(msg, 10, 40);
    text("Missiles Fired: " + missileNum, 10, 60);
    text("Missiles Hit: " + missilesCollisionNum, 10, 80);
    if (missileNum > 0) {
      accuracy = ((int)(10000*(((double)missilesCollisionNum)/missileNum)));
      text("Accuracy: " + (accuracy/100.0) + "%", 10, 100);
    }
    else {
      text("Accuracy: 0.0%", 10, 100);
    }
    if (accuracy / 100.0 == 100){
      accuracyMult = 5;
    }
    else if (accuracy / 100.0 > 80){
      accuracyMult = 4;
    }
    else if (accuracy / 100.0 > 60){
      accuracyMult = 3;
    }
    else if (accuracy / 100.0 > 40){
      accuracyMult = 2;
    }
    else if (accuracy / 100.0 > 0){
      accuracyMult = 1;
    }
    else {
      accuracyMult = 0;
    }
    
    text("Point Multiplier: " + accuracyMult + "x", 10, 120);
    ship.drawOnScreen(); // Draws Energy Bar
  }

  void keyPressed() 
  {
    if ( key == ' ') {
      if (ship.isActive()) 
      {
        if(ship.rapidfireOn())
        {
          rapidfireMissile(missileSpeed + 50); 
        }
        else
        {
          launchMissile(missileSpeed);
        }
      }
    }
  }

  void mousePressed()
  {
  }

  private void launchMissile(float speed) 
  {
    if (ship.energy >= .2) {
      int shipx = (int)ship.getX();
      int shipy = (int)ship.getY();
      Missile missile = new Missile(game, shipx, shipy);
      missile.setRot(ship.getRot() - 1.5708);
      missile.setSpeed(speed);
      missiles.add(missile);

      ship.energy -= ship.deplete;
    }
  }
  //RAPIDFIRE POWERUP IMPLEMENTATION
  private void rapidfireMissile(float speed) 
  {
    if (ship.energy >= .05) {
      int shipx = (int)ship.getX();
      int shipy = (int)ship.getY();
      
      Missile missile = new Missile(game, shipx, shipy);
      missile.setRot(ship.getRot() - 1.5708);
      missile.setSpeed(speed);
      missiles.add(missile);

      ship.energy -= ship.deplete;
    }
  }
}
class AsteroidsLevel4 extends AsteroidsGameLevel 
{
  float missileSpeed = 400;
  StopWatch powerupSW;
  int periodBetweenPU = 10;

  AsteroidsLevel4(PApplet applet)
  {
    super(applet);

    powerupSW = new StopWatch();
  }

  void start()
  {
    super.start();

    ship = new Ship(game, width/2, height/2);
    asteroids.add(new BigAsteroid(game, 200, 500, 0, 0.02, 22, PI*.5));
    asteroids.add(new BigAsteroid(game, 500, 200, 1, -0.01, 22, PI*1));
    asteroids.add(new BigAsteroid(game, 100, 300, 2, 0.01, 22, PI*1.7));
    asteroids.add(new BigAsteroid(game, 500, 600, 0, -0.02, 22, PI*1.3));
    asteroids.add(new BigAsteroid(game, 450, 400, 0, -0.04, 22, PI*.7));
    asteroids.add(new BigAsteroid(game, 250, 600, 0, -0.03, 22, PI*1.1));

    gameState = GameState.Running;
  }

  void update() 
  {
    super.update();

    if (powerupSW.getRunTime() - 10 > periodBetweenPU) {
      powerupSW.reset();
      powerUps.add(new ShieldPowerup(game, game.width/2, game.height/2, 100, ship));
      powerUps.add(new RapidFirePowerup(game, game.width/2, game.height/2, 100, ship));
    }
  }

  void drawOnScreen() 
  {
    String msg;

    fill(255);
    textSize(20);
    msg = "Score: " + score; // write user score
    text(msg, 10, 20);
    msg = "Lives: " + remainingLives; // write user's remaining lives
    text(msg, 10, 40);
    text("Missiles Fired: " + missileNum, 10, 60); // display total missiles fired 
    text("Missiles Hit: " + missilesCollisionNum, 10, 80); // display total missiles that hit asteroids
    if (missileNum > 0) {
      accuracy = ((int)(10000*(((double)missilesCollisionNum)/missileNum))); // display user's accuracy
      text("Accuracy: " + (accuracy/100.0) + "%", 10, 100);
    }
    else {
      text("Accuracy: 0.0%", 10, 100);
    }
    if (accuracy / 100.0 == 100){
      accuracyMult = 5;
    }
    else if (accuracy / 100.0 > 80){
      accuracyMult = 4;
    }
    else if (accuracy / 100.0 > 60){
      accuracyMult = 3;
    }
    else if (accuracy / 100.0 > 40){
      accuracyMult = 2;
    }
    else if (accuracy / 100.0 > 0){
      accuracyMult = 1;
    }
    else {
      accuracyMult = 0;
    }
    text("Point Multiplier: " + accuracyMult + "x", 10, 120);
    ship.drawOnScreen(); // Draws Energy Bar
  }

  void keyPressed() 
  {
    if ( key == ' ') {
      if (ship.isActive()) 
      {
        if(ship.rapidfireOn()) /////////////////////////////////////////////////////////////////////added if/else
        {
          rapidfireMissile(missileSpeed + 50); 
        }
        else
        {
          launchMissile(missileSpeed);
        }
      }
    }
  }

  void mousePressed()
  {
  }

  private void launchMissile(float speed) 
  {
    if (ship.energy >= .2) {
      int shipx = (int)ship.getX();
      int shipy = (int)ship.getY();
      Missile missile = new Missile(game, shipx, shipy);
      missile.setRot(ship.getRot() - 1.5708);
      missile.setSpeed(speed);
      missiles.add(missile);

      ship.energy -= ship.deplete;
    }
  }
  //RAPIDFIRE POWERUP IMPLEMENTATION /////////////////////////////////////////////////////////////////////added
  private void rapidfireMissile(float speed) 
  {
    if (ship.energy >= .05) {
      int shipx = (int)ship.getX();
      int shipy = (int)ship.getY();
      
      Missile missile = new Missile(game, shipx, shipy);
      missile.setRot(ship.getRot() - 1.5708);
      missile.setSpeed(speed);
      missiles.add(missile);

      ship.energy -= ship.deplete;
    }
  }
}
