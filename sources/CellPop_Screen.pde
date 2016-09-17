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
class IntroScreen extends Screen
{
  Intro intro = new Intro("icon_CellPop.png");
  public IntroScreen()
  {
     
  }
  public void update(ScreenMachine sm)
  {
    intro.update();
    if(intro.t / frameRate > 5 || mousePressed) sm.changeScreen(new MenuScreen());
  }
  public void display()
  {
    background(10);
    intro.display();
  }
}
class MenuScreen extends Screen
{
  float offsetText, vTitle, alphaText, vAlpha;
  Button startButton = new Button(20,35,60,10,"START", adjustTextSize(40),-10,RED);
  Button tutoButton = new Button(20,47.5,60,10,"TUTORIAL", adjustTextSize(40), 10,GREEN);
  Button scoreButton = new Button(20,60,60,10,"HIGHSCORES", adjustTextSize(40), -10, LIGHTBLUE);
  Button quitButton = new Button(20,72.5,60,10,"QUIT",adjustTextSize(40), 10, WHITE);
  
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
    
    if(startButton.isReleased())
      sm.changeScreen(new LevelScreen());
    if(tutoButton.isReleased())
      sm.changeScreen(new TutoScreen());
    if(scoreButton.isReleased())
      sm.changeScreen(new HighScoreScreen());
    if(quitButton.isReleased())
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
    textSize(adjustTextSize(60));
    fill(215);
    text("CellPop",width/2,height/4-offsetText-5);        
<<<<<<< HEAD
    textSize(adjustTextSize(15));
    text("This game has been develop by Cybermissia. version : 0.22", width/2, height-30);
=======
    textSize(15);
    text("This game has been develop by Cybermissia. version : 0.21", width/2, height-30);
>>>>>>> 151b7c0ab4a5f6decd1be8b5a2765b9cfc42cab4
    rectMode(CORNER);
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
  
  Button backButton = new Button(25,60,50,10,"Menu",adjustTextSize(40), -10,WHITE);
  
  public ScoreScreen(int pscore, float ptime)
  {
    score = pscore;
    time = (float)Math.round((ptime/60)*100)/100;
  }
  public void update(ScreenMachine sm)
  {
    backButton.update();
    
    if(backButton.isReleased())
      sm.changeScreen(new MenuScreen());
  }
  public void display()
  {
    background(10,10,10);
    fill(215);
    textSize(adjustTextSize(40));
    text("Score : " + this.score + "\nTime : " + time + " sec", width/2,height/2);
    
    backButton.display();
  }
}
class LevelScreen extends Screen
{
  float offsetText, vTitle;
  Button easyButton = new Button(20,35,60,10,"EASY",adjustTextSize(40),-10,YELLOW);
  Button mediumButton = new Button(20,47.5,60,10,"MEDIUM",adjustTextSize(40),10,ORANGE);
  Button hardButton = new Button(20,60,60,10,"HARD",adjustTextSize(40),-10,LIGHTRED);
  Button insaneButton = new Button(20,72.5,60,10,"INSANE",adjustTextSize(40),10,RED);
  Button backButton = new Button(20,85,60,10,"BACK",adjustTextSize(40),-10,WHITE);
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
    
    if(backButton.isReleased())
      sm.changeScreen(new MenuScreen());
    if(easyButton.isReleased())
    {
      level = "easy";
      sm.changeScreen(new GameScreen(level));
    }
    if(mediumButton.isReleased())
    {
      level = "medium";
      sm.changeScreen(new GameScreen(level));
    }
    if(hardButton.isReleased())
    {
      level = "hard";
      sm.changeScreen(new GameScreen(level));
    } 
    if(insaneButton.isReleased())
    {
      level = "insane";
      sm.changeScreen(new GameScreen(level));
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
    textSize(adjustTextSize(60));
    fill(WHITE);
    text("Level",width/2,height/4-offsetText);     
  }
}
class TutoScreen extends Screen
{
  float offsetText, vTitle;
  Button backButton = new Button(20,72.5,60,10,"BACK",adjustTextSize(40),-10,WHITE);
  public TutoScreen()
  {
    offsetText = 20;
  }
  public void update(ScreenMachine sm)
  {
    backButton.update();
    
    if(backButton.isReleased())
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
    textSize(adjustTextSize(60));
    fill(GREEN);
    text("Tutorial",width/2,height/4-offsetText);    
    textSize(20);
    fill(WHITE);
    text("Touch the cells when they are colored\n"
     + "If you touch a black cell, she gets locked\n"
     + "There is a limit of error in each level :\nEasy : 1\nMedium : 2\nHard : 3\nInsane : 4\n"
     + "If the board is full you have lost.", width/2, height/2); 
  }
}
class HighScoreScreen extends Screen
{
  float offsetText, vTitle;
  Button backButton = new Button(20,72.5,60,10,"BACK",adjustTextSize(40),-10,WHITE);
  ArrayList<String[]> highscores;
  public HighScoreScreen()
  {
    highscores = read("score.txt");
    offsetText = 20;
  }
  public void update(ScreenMachine sm)
  {
    backButton.update();
    
    if(backButton.isReleased())
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
    textSize(adjustTextSize(60));
    fill(LIGHTBLUE);
    text("HighScores",width/2,height/4-offsetText);  
    String highscoreText = "";
    for(int i = 0; i < highscores.size(); i++)
    {
      highscoreText += highscores.get(i)[0] + " : " + highscores.get(i)[1] + " | " + highscores.get(i)[2] + "\n";
    }
    textSize(adjustTextSize(30));
    fill(215);
    text(highscoreText, width/2, height/1.8);  
  }
}
