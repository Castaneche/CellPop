//These class draw some stuff on the screen (like text)
abstract class Screen
{
  abstract void update();
  abstract void display();
  abstract int screen();
}
class MenuScreen extends Screen
{
  float offsetText, vTitle, alphaText, vAlpha;
  public MenuScreen()
  {
     offsetText = 20;
     alphaText = 255;
  }
  public void update()
  {
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
    //Background
    rectMode(CENTER);
    noStroke();
    fill(255,255,255,50);
    rect(width/2,height/2, width/1.3, height/8);
    fill(255,255,255,50);
    rect(width/2,height/4,200,110);
    //Text
    textAlign(CENTER,CENTER);
    textSize(50);
    fill(215);
    text("CellPop",width/2,height/4-offsetText-5);
    textSize(30);
    fill(215,215,215,alphaText);
    text("Touch to start !",width/2,height/1.5);
    textSize(15);
    fill(215);
    text("Touchez les cellules lorsque qu'elles sont colorées\nSi vous touchez une cellule noire, elle se verrouille\nSi toutes la planche est remplie vous avez perdu", width/2, height/2);         
    textSize(12);
    text("This game has been develop by Cybermissia.", width/2, height-30);
    rectMode(CORNER);
  }
  public int screen()
  {
    if(mousePressed)
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
  
  public ScoreScreen(int pscore, float ptime)
  {
    score = pscore;
    time = ptime;
    clock = 0; 
    screenToReturn = 3;
  }
  public void update()
  {
    clock++;
  }
  public void display()
  {
    background(10,10,10);
    fill(215);
    text("Score : " + this.score + "\nTime : " + Math.round(this.time/frameRate*100)/100, width/2,height/2);
  }
  public int screen()
  {
    return screenToReturn; 
  }
}

