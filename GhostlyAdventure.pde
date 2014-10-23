/*
  Author: Laerte Sousa Neto
  Email: sousa.lae@gmail.com

  This is the main file for the application.
  It contains all setups, and processes needed
  for the game to work.
*/

GameState gameState; //Handles current state of game.
ButtonGUI startBtn; // Creates Button like GUI
Background background; // Handles background animation

//Screen size for the game
final int screenWidth = 800; 
final int screenHeight = 800;

//User keyboard input
boolean keyHeld = false;
int currentKeyPressed = 0; //Last keystroke ID

//Different key stroke IDs
final int leftKeyIndex = 37;
final int rightKeyIndex = 39;
final int enterKeyIndex = 10;
   
//Initial setup and initialization of the game.
void setup()
{
  size(screenWidth, screenHeight);
  background(0);
  smooth();
  frameRate(100);

  gameState = new GameState();
  background = new Background();
  startBtn = new ButtonGUI("Start (Press Enter)","images/mask.png",screenWidth/2-100,screenHeight/2-50,300,50);
}

void draw()
{
  
  //Check Status of the application and perform operations as intructed
  if(gameState.isRunning)  //Operation while actual game is running
  {
    background.startAnimation(); // Starts a background animation
    gameState.refresh(); //Refresh enemy and user positions
    
    //Check for last key pressed
    if(currentKeyPressed == leftKeyIndex) //if last key pressed was left arrow key
    {
      if(gameState.user.x > 0) gameState.user.x -= gameState.user.speed;
    }
    else if(currentKeyPressed == rightKeyIndex) //if last key pressed was right arrow key
    {
      if(gameState.user.x < (screenWidth - gameState.user.frameWidth)) gameState.user.x += gameState.user.speed;
    }
  }
  else if(gameState.showStartMenu && !gameState.userLost) //Initial screen when game is launched
  {
    background.loadMainScreen();
    startBtn.display(); 
    if(currentKeyPressed == enterKeyIndex) gameState.startGame();
  }
  else if(gameState.userLost) //Lost/Restart screen
  {
    startBtn.text = "Restart (Press Enter)";
    startBtn.textX = (startBtn.btnWidth/2) + startBtn.x - 100;
    startBtn.display(); 
    if(currentKeyPressed == enterKeyIndex) gameState.startGame();
  }
}


//Keyboard Event handlers
void keyPressed()
{
   currentKeyPressed = keyCode; //Grab key pressed ID
}

void keyReleased()
{
   currentKeyPressed = 0;  //Reset current key pressed to none
}

void mousePressed()
{  
  //Peform operation if user click over Button
  if(startBtn.overButton())
  { 
    if(gameState.userLost)
    {
       gameState.startGame();
    }
    else
    {
      gameState.startGame();
    }     
  }
}
