//These class draw some stuff on the screen (like text or button)
// 0 = MainMenu
// 1 = LoadingScreen
// 2 = Game
// 3 = Score
// 10 = Level
// 11 = Tuto

abstract class Screen
{
  abstract void update(ScreenMachine sm);
  abstract void display();
}
class MenuScreen extends Screen
{
  float offsetText, vTitle, alphaText, vAlpha;
  Button startButton = new Button(width/2-250/2,height/2.75-60/2,250,60,"START", 30,-100);
  Button tutoButton = new Button(width/2-250/2,height/2.75-60/2+80,250,60,"TUTORIAL", 30, 100);
  Button scoreButton = new Button(width/2-250/2,height/2.75-60/2+160,250,60,"HIGHSCORES", 30, -100);
  Button quitButton = new Button(width/2-250/2,height/2.75-60/2+240,250,60,"QUIT", 30, 100);
  
  public MenuScreen()
  {
     offsetText = 20;
     alphaText = 255;
  }
  public void update(ScreenMachine sm)
  {
    startButton.update();
    tutoButton.update();
    scoreButton.update();
    quitButton.update();
    
    if(startButton.isActive())
      sm.changeScreen(new LevelScreen());
    if(tutoButton.isActive())
      sm.changeScreen(new TutoScreen());
    if(scoreButton.isActive())
      sm.changeScreen(new HighScoreScreen());
    if(quitButton.isActive())
      exit();
    
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
    scoreButton.display();
    quitButton.display();
    //Background
    rectMode(CENTER);
    noStroke();
    //Text
    textAlign(CENTER,CENTER);
    textSize(60);
    fill(215);
    text("CellPop",width/2,height/4-offsetText-5);        
    textSize(15);
    text("This game has been develop by Cybermissia. version : 0.18", width/2, height-30);
    rectMode(CORNER);
  }
}
class LoadingScreen extends Screen
{
  float countdown;
  String level;
  public LoadingScreen(String plevel)
  {
    level = plevel;
    countdown = 180; 
  }
  public void update(ScreenMachine sm)
  {
    if(countdown/frameRate <= 0)
      sm.changeScreen(new GameScreen(level));
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
}
class GameScreen extends Screen
{
  Board board;
  int score; //Look in CellsManager for the score
  float time;
  String level;
  
  public GameScreen(String plevel)
  {
    score = 0;
    time = 0;
    level = plevel;
    board = new Board(level);
    
  }
  public void update(ScreenMachine sm)
  { 
    this.time++;
    this.score = board.cm.getScore();
    
    if(!board.isFull())
      board.update();
    else
    {
      updateFile(level, score, (float)Math.round((this.time/60)*100)/100);
      sm.changeScreen(new ScoreScreen(this.score,this.time));
    }
  }
  public void display()
  {
    background(10,10,10);
    board.display();
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
  
  Button backButton = new Button(width/2-250/2,height/1.5-60/2,250,60,"Menu",30, -100);
  
  public ScoreScreen(int pscore, float ptime)
  {
    score = pscore;
    time = (float)Math.round((ptime/60)*100)/100;
  }
  public void update(ScreenMachine sm)
  {
    backButton.update();
    
    if(backButton.isActive())
      sm.changeScreen(new MenuScreen());
  }
  public void display()
  {
    background(10,10,10);
    fill(215);
    textSize(40);
    text("Score : " + this.score + "\nTime : " + time + " sec", width/2,height/2);
    
    backButton.display();
  }
}
class LevelScreen extends Screen
{
  float offsetText, vTitle;
  Button easyButton = new Button(width/2-250/2,height/2.75-60/2,250,60,"EASY",30,-100);
  Button mediumButton = new Button(width/2-250/2,height/2.75-60/2+80,250,60,"MEDIUM",30,100);
  Button hardButton = new Button(width/2-250/2,height/2.75-60/2+160,250,60,"HARD",30,-100);
  Button insaneButton = new Button(width/2-250/2,height/2.75-60/2+240,250,60,"INSANE",30,100);
  Button backButton = new Button(width/2-250/2,height/2.75-60/2+320,250,60,"BACK",30,-100);
  String level; //Default value
  public LevelScreen()
  {
    offsetText = 20;
  }
  public void update(ScreenMachine sm)
  {
    easyButton.update();
    mediumButton.update();
    hardButton.update();
    insaneButton.update();
    backButton.update();
    
    if(backButton.isActive())
      sm.changeScreen(new MenuScreen());
    if(easyButton.isActive())
    {
      level = "easy";
      sm.changeScreen(new LoadingScreen(level));
    }
    if(mediumButton.isActive())
    {
      level = "medium";
      sm.changeScreen(new LoadingScreen(level));
    }
    if(hardButton.isActive())
    {
      level = "hard";
      sm.changeScreen(new LoadingScreen(level));
    } 
    if(insaneButton.isActive())
    {
      level = "insane";
      sm.changeScreen(new LoadingScreen(level));
    }
    offsetText += vTitle;
    if(offsetText >= 20)
      vTitle=-0.5; 
    else if(offsetText <= -20)
      vTitle=0.5;
  }
  public void display()
  {
    background(10,10,10);
    easyButton.display();
    mediumButton.display();
    hardButton.display();
    insaneButton.display();
    backButton.display();
    textAlign(CENTER,CENTER);
    textSize(60);
    fill(215);
    text("Level",width/2,height/4-offsetText);     
  }
}
class TutoScreen extends Screen
{
  float offsetText, vTitle;
  Button backButton = new Button(width/2-250/2,height/1.5-60/2,250,60,"BACK",30,-100);
  public TutoScreen()
  {
    offsetText = 20;
  }
  public void update(ScreenMachine sm)
  {
    backButton.update();
    
    if(backButton.isActive())
      sm.changeScreen(new MenuScreen());
    
    offsetText += vTitle;
    if(offsetText >= 20)
      vTitle=-0.5; 
    else if(offsetText <= -20)
      vTitle=0.5;
  }
  public void display()
  {
    background(10,10,10);
    backButton.display();
    textAlign(CENTER,CENTER);
    textSize(60);
    fill(215);
    text("Tutorial",width/2,height/4-offsetText);    
    textSize(20);
    fill(215);
    text("Touch the cells when they are colored\nIf you touch a black cell, she gets locked\nIf the board is full you have lost.", width/2, height/2); 
  }
}
class HighScoreScreen extends Screen
{
  float offsetText, vTitle;
  Button backButton = new Button(width/2-250/2,height/1.5-60/2,250,60,"BACK",30,-100);
  ArrayList<String[]> highscores;
  public HighScoreScreen()
  {
    highscores = read("score.txt");
    offsetText = 20;
  }
  public void update(ScreenMachine sm)
  {
    backButton.update();
    
    if(backButton.isActive())
      sm.changeScreen(new MenuScreen());
    
    offsetText += vTitle;
    if(offsetText >= 20)
      vTitle=-0.5; 
    else if(offsetText <= -20)
      vTitle=0.5;
  }
  public void display()
  {
    background(10,10,10);
    backButton.display();
    textAlign(CENTER,CENTER);
    textSize(60);
    fill(215);
    text("HighScores",width/2,height/4-offsetText);  
    for(int i = 0; i < highscores.size(); i++)
    {
      textSize(30);
      fill(215);
      text(highscores.get(i)[0] + " : " + highscores.get(i)[1] + " | " + highscores.get(i)[2], width/2, height/2.5+i*40);
    }    
  }
}
