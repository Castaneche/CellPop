//These class draw some stuff on the screen (like text)
abstract class Screen
{
  abstract void update();
  abstract void display();
  abstract int screen();
}
class MenuScreen extends Screen
{
  float fps;
  float offsetText, vTitle, alphaText, vAlpha;
  Button startButton = new Button(width/2-250/2,height/2.75-60/2,250,60,"START", 30);
  Button tutoButton = new Button(width/2-250/2,height/2.25-60/2,250,60,"TUTORIAL", 30);
  public MenuScreen()
  {
     offsetText = 20;
     alphaText = 255;
  }
  public void update()
  {
    startButton.update();
    tutoButton.update();
    
    alphaText += vAlpha;
    offsetText += vTitle;
    if(offsetText >= 20)
    {
      vTitle=-0.5; 
    }
    else if(offsetText <= -20)
    {
      vTitle=0.5;
    }
    if(alphaText >= 255)
      vAlpha = -3;
    else if(alphaText <= 0)
      vAlpha = 3;
  }
  public void display()
  {
    background(10,10,10);
    startButton.display();
    tutoButton.display();
    //Background
    rectMode(CENTER);
    noStroke();
    //Text
    textAlign(CENTER,CENTER);
    textSize(60);
    fill(215);
    text("CellPop",width/2,height/4-offsetText-5);
    if(tutoButton.isActive())
    {
      textSize(20);
      fill(215);
      text("Touch the cells when they are colored\nIf you touch a black cell, she gets locked\nIf the board is full you have lost.", width/2, height/1.75);       
    }  
    textSize(15);
    text("This game has been develop by Cybermissia. version : 0.1", width/2, height-30);
    rectMode(CORNER);
  }
  public int screen()
  {
    if(startButton.isActive())
      return 1; 
    return 0;
  }
}
class LoadingScreen extends Screen
{
  float countdown;
  public LoadingScreen()
  {
    countdown = 180; 
  }
  public void update()
  {
    countdown--;  
  }
  public void display()
  {
    background(10,10,10);
    fill(215);
    textSize(50);
    text("The game start in", width/2, height/4);
    text(Math.round(countdown/frameRate),width/2,height/2);
  }
  public int screen()
  {
    if(countdown/frameRate <= 0)
      return 2;
    return 1;
  }
}
class GameScreen extends Screen
{
  Board board;
  int score; //Look in CellsManager for the score
  float time;
  
  public GameScreen()
  {
    score = 0;
    time = 0;
    board = new Board();
  }
  public void update()
  {
    this.time++;
    this.score = board.cm.getScore();
    if(!board.isFull())
        board.update();
  }
  public void display()
  {
    background(10,10,10);
    board.display();
  }
  public int screen()
  {
    if(board.isFull())
      return 3;  
    return 2;
  }
  public void handleMouseReleased()
  {
    board.cm.mouseR(); 
  }
}
class ScoreScreen extends Screen
{
  //For the displaying
  int score;
  float time;
  //For the input
  float clock;
  int screenToReturn;
  
  Button backButton = new Button(width/2-250/2,height/1.5-60/2,250,60,"Menu",30);
  
  public ScoreScreen(int pscore, float ptime)
  {
    score = pscore;
    time = ptime;
    clock = 0; 
    screenToReturn = 3;
  }
  public void update()
  {
    if(clock/frameRate >= 3)
      backButton.update();
    clock++;
  }
  public void display()
  {
    background(10,10,10);
    fill(215);
    textSize(40);
    text("Score : " + this.score + "\nTime : " + (double)Math.round((this.time/60)*100)/100 + " sec", width/2,height/2);
    
    if(clock/frameRate >= 3)
      backButton.display();
  }
  public int screen()
  {
    if(backButton.isActive())
      return 0;
    return 3; 
  }
}

