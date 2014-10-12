GameState gameState;
ButtonGUI startBtn;
Background background;

final int screenWidth = 800;
final int screenHeight = 800;

void setup()
{
  size(screenWidth, screenHeight);
  background(0);
  smooth();
  frameRate(100);

  gameState = new GameState();
  background = new Background();
  startBtn = new ButtonGUI("Start","images/mask.png",screenWidth/2-100,screenHeight/2-50,200,50);
}

void draw()
{
  if(gameState.isRunning)
  {
    background.startAnimation();
    gameState.refresh();
  }
  else if(gameState.showStartMenu && !gameState.userLost)
  {
    background.loadMainScreen();
    startBtn.display(); 
  }
  else if(gameState.userLost)
  {
    startBtn.text = "Restart";
    startBtn.textX = (startBtn.btnWidth/2) + startBtn.x - 40;
    startBtn.display(); 
  }
}

void keyPressed()
{
   final int leftKeyIndex = 37;
   final int rightKeyIndex = 39;
   
   switch(keyCode)
   {
     case leftKeyIndex:
       if(gameState.user.x > 0) gameState.user.x -= gameState.user.speed;
       break;
     case rightKeyIndex:
       if(gameState.user.x < (screenWidth - gameState.user.frameWidth)) gameState.user.x += gameState.user.speed;
       break;     
   }
}

void mousePressed()
{  
  if(startBtn.overButton())
  { 
    if(gameState.userLost)
    {
       gameState.restart();
       gameState.userLost = false;
       gameState.isRunning = true;
       gameState.showStartMenu = false;
    }
    else
    {
      gameState.showStartMenu = false;
      gameState.isRunning = true;  
    }     
  }
}
