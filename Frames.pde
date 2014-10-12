class UserFrame extends CharacterFrame
{
    UserFrame()
    {
      super("images/ghost.png");
      super.speed = 20;
    }
}

class EnemyFrame extends CharacterFrame
{
  EnemyFrame()
  {
    super("images/moon.png");
    super.speed = 1;
  }
 
  EnemyFrame(String ImageURl, int initialSpeed)
  {
    super(ImageURl);
    super.speed = initialSpeed;
  } 
  
  boolean drop(int screenHeight)
  {
    boolean reachedEnd = false;
    
    super.y += super.speed;
    if(y >= screenHeight)
    {
      super.y = 0;
      reachedEnd = true;
    }
    
    return reachedEnd;
  }
}

class CharacterFrame
{
  final String IMG_URL; 
  final PImage frameImg;
  final int frameWidth;
  final int frameHeight;
  int x;
  int y;
  float speed;
  
  CharacterFrame(String imageURL)
  {
    IMG_URL = imageURL;
    frameImg = loadImage(IMG_URL);
    frameWidth = 50;
    frameHeight = 50;
    x = 0;
    y = 0;
    speed = 10;
  }
  
  void move(int newX, int newY)
  {
    x = newX;
    y = newY;
  }
  
  void displayAtTheTop(int screenWidth, int screenHeight)
  {
    y = 0;
    x = screenWidth/2;
  }
  
  void displayAtTheBottom(int screenWidth, int screenHeight)
  {
    y = screenHeight - frameHeight;
    x = screenWidth/2;
  }
 
  void display()
  {
    image(frameImg, x, y, 40, 40);
  } 
}
