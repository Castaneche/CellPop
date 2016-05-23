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
    display();
  }
  void update()
  {
    screen.update();
  }
  void display()
  {
    screen.display(); 
  }
}

