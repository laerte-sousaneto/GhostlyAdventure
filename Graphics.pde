class GameAlert
{
  final int screenWidth;
  final int screenHeight;
  
  String message;
  
  
  GameAlert(int screenWidth, int screenHeight)
  {
     this.screenWidth = screenWidth;
     this.screenHeight = screenHeight;
  }
 
  void displayLevelUp(int level)
  {
    this.message = "Level " + level;
    
    display();
  }
  
  void display()
  {
    textSize(80);
    fill(0);
    text(message, screenWidth/2 - 190 ,screenHeight/2 - 100);    
  } 
}

class ButtonGUI
{  
  int btnWidth;
  int btnHeight;
  int x;
  int y;
  
  int textX;
  int textY;
  int textSize;
  
  String text;
  PImage image;
  
  final int defaultColor = 0;
  final int hoverColor = 150;
  
  int backgroundColor = defaultColor;  
  
  ButtonGUI(String text,String imgURL, int x, int y, int btnWidth, int btnHeight)
  {
    this.x = x;
    this.y = y;
    this.btnWidth = btnWidth;
    this.btnHeight = btnHeight;
    
    this.text = text;
    this.textSize = 25;
    this.textX = x + (btnWidth/2)-this.textSize;
    this.textY = y + (btnHeight/2)+this.textSize/3;
    
    image = loadImage(imgURL);
    
  }
  
  boolean overButton()
  {
    if (mouseX >= x && mouseX <= x+btnWidth && 
      mouseY >= y && mouseY <= y+btnHeight) 
    {
      this.backgroundColor = this.hoverColor;
      return true;
    } 
    else 
    {
      this.backgroundColor = this.defaultColor;
      return false;
    }    
  }
  
  void display()
  {
    overButton();
    stroke(255);
    fill(backgroundColor);
    rect(x,y, btnWidth, btnHeight);
    fill(255);
    textSize(textSize);
    text(this.text, textX, textY);
    image(image, x+5, y+5, 40,40);    
  }
}

class Background
{
  String title = "Ghostly Adventure";
  
  PImage moonImg;
  PImage mainBackground;
  int oceanAnimationColor;
  float yoff = 0.6;
  
  Background()
  {
    moonImg = loadImage("images/background.jpg");
    mainBackground = loadImage("images/main_background.jpg");
    oceanAnimationColor = (int)random(255);
  } 
  void startAnimation()
  {  
    oceanAnimationColor+=2;
    
    background(0);
    image(moonImg, 20.0, 20.0);
    
    // We are going to draw a polygon out of the wave points
    beginShape(); 
    
    float xoff = 0;       // Option #1: 2D Noise
    // float xoff = yoff; // Option #2: 1D Noise
    fill(oceanAnimationColor, 0, 0);
    // Iterate over horizontal pixels
    for (float x = 0; x <= width; x += 10) 
    {
      // Calculate a y value according to noise, map to 
      float y = map(noise(xoff, yoff), 0, 1, 200, height*1.6); // Option #1: 2D Noise
      // float y = map(noise(xoff), 0, 1, 200,300);    // Option #2: 1D Noise
      
      // Set the vertex
      vertex(x, y); 
      // Increment x dimension for noise
      xoff += 0.05;
    }
    // increment y dimension for noise
    yoff += 0.01;
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
  }
  
  void loadMainScreen()
  {
    image(mainBackground,0,0,800,800);
    textSize(70);
    fill(200,50,0);
    text(title, 100,150);
  }
}
