class GameState
{
  int level;
  int numberOfEnemies;
  int savedTime;
  boolean isRunning = false;
  boolean showStartMenu = true;
  boolean userLost = false;
  
  UserFrame user;
  EnemyWave wave;
  CollisionDetector collisionDetector;
  GameAlert alert;
  
  GameState()
  {
    level = 1;
    numberOfEnemies = 10;
    isRunning = false;
    showStartMenu = true;
    userLost = false;
    
    user = new UserFrame();
    user.displayAtTheBottom(screenWidth, screenHeight);
    wave = new EnemyWave(screenWidth, screenHeight);
    collisionDetector = new CollisionDetector(user, wave);  
    alert = new GameAlert(screenWidth, screenHeight);
  }
  
  void restart()
  {
    wave = new EnemyWave(screenWidth, screenHeight);
    collisionDetector = new CollisionDetector(user, wave);
  }
  
  void refresh()
  {
    user.display(); 
    boolean levelUp = wave.drop();
    
    if(levelUp) 
    {
      level++;
      savedTime = millis();
    };
    
    if(millis() - savedTime < 4000)
    {
      alert.displayLevelUp(level);
    }
    
    if(collisionDetector.wasUserHit() && !gameState.userLost)
    {
      userLost = true;
      level = 0;
      isRunning = false;
      showStartMenu = true;   
    }
  }
  
}
