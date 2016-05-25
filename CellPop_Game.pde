class Game
{
  Screen screen;
  int score;
  float time;
  
  public Game()
  {
    screen = new MenuScreen(); 
  }
  void run()
  {
    update();
    if(screen.screen() == 0)
    {
      if(!(screen instanceof MenuScreen))
        screen = new MenuScreen();
    }
    else if(screen.screen() == 1)
    {
      if(!(screen instanceof LoadingScreen))
        screen = new LoadingScreen();
    }
    else if(screen.screen() == 2)
    {
      if(!(screen instanceof GameScreen))
        screen = new GameScreen();
      
      GameScreen gs = GameScreen.class.cast(screen);
      this.score = gs.score;
      this.time = gs.time;
    } 
    else if(screen.screen() == 3)
    {
      if(!(screen instanceof ScoreScreen))
        screen = new ScoreScreen(this.score, this.time);
    } 
    else if(screen.screen() == 11)
    {
      if(!(screen instanceof TutoScreen))
        screen = new TutoScreen();
    }
    display();
  }
  void update()
  {
    screen.update();
  }
  void display()
  {
    screen.display(); 
    //Display FPS
    textAlign(RIGHT,TOP);
    textSize(15);
    fill(255,255,255,175);
    text("fps : " + (int)frameRate,width,0);
    textAlign(CENTER,CENTER);
  }
}

