/*
  Author: Laerte Sousa Neto
  Email: sousa.lae@gmail.com

  CollisionDetector Object is meant to be used in order to check for
  contact made between Enemies and User character frames.
  
  In order to use this class, you need to pass in a UserFrame and EnemyWave object.
*/
class CollisionDetector
{
   UserFrame user;
   EnemyWave wave;
   EnemyFrame[] enemies;
   
   CollisionDetector(UserFrame userIn, EnemyWave enemyWave)
   {
     user = userIn;
     wave = enemyWave;
   }
   
   boolean wasUserHit()
   {
      boolean wasHit = false;
      for(int i = 0; i < wave.enemies.length; i++)
      {
        if(wasUserHitByEnemy(wave.enemies[i]) && i != wave.emptySpot)
         {
           wasHit = true;
         }
      }
      
      return wasHit;
   }
   
   boolean wasUserHitByEnemy(EnemyFrame enemy)
   {
     boolean wasHit = false;
     
     if((enemy.y >= (user.y - (user.frameHeight-10)) && enemy.y < (user.y)) 
         && (enemy.x >= (user.x-25) && enemy.x < (user.x + (user.frameWidth-20))))
     {
       wasHit = true;
     }            
     
     return wasHit;
   }  
}


/*
  Author: Laerte Sousa Neto
  Email: sousa.lae@gmail.com

  EnemyWave object is used manipulate all enemies on the game, as well keeping them in sync with each other.
  
  It needs the width and height of the screen in order to work. 
*/
class EnemyWave
{
   final String imgURL[] = new String[]{"images/pumpkin1.png", "images/pumpkin2.png", "images/pumpkin3.png", "images/pumpkin4.png", "images/pumpkin5.png"};
   final int enemyWidth = 40;
   
   int screenWidth;
   int screenHeight;
   int numberOfEnemies;
   final int speedIncreaseTimeout = 10000; //milliseconds
   int savedTime;
   
   EnemyFrame[] enemies;
   int emptySpot;
   
   
   EnemyWave(int screenWidthIn, int screenHeightIn)
   {
     screenWidth = screenWidthIn;
     screenHeight = screenHeightIn;
     numberOfEnemies = screenWidth/(enemyWidth);
     emptySpot = (int)random(numberOfEnemies);
     createEnemies();
   } 
   
   void createEnemies()
   {
     enemies = new EnemyFrame[numberOfEnemies];
     int position = 0;
     
     for(int i = 0; i < numberOfEnemies; i++)
     {
       int randomImageIndex = (int)random(imgURL.length);
       enemies[i] = new EnemyFrame(imgURL[randomImageIndex], 2);
       enemies[i].displayAtTheTop(screenWidth, screenHeight);
       enemies[i].x = position;         
 
       position += enemyWidth;      
     }
   }
   
   boolean drop()
   {
     boolean reachedEnd = false;
     boolean speedIncrease = false;
     int passedTime = millis() - savedTime;
     
     for(int i = 0; i < enemies.length; i++)
     {
       reachedEnd = enemies[i].drop(screenHeight);
       if(i != emptySpot)
       {
         enemies[i].display();         
       }
       
       if(passedTime >= speedIncreaseTimeout)
       {
         enemies[i].speed += 0.1;
       }
       
     }
    
     if(passedTime >= speedIncreaseTimeout) {savedTime = millis(); speedIncrease = true; println("increase",enemies[0].speed);} 
     
     if(reachedEnd)
     {
       emptySpot = (int)random(1000)%numberOfEnemies;
     }
     
     return speedIncrease;
   }
}
