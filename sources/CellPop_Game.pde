class Game
{
  ScreenMachine sm;
  
  public Game()
  {
    sm = new ScreenMachine();
    sm.changeScreen(new IntroScreen());
  }
  void run()
  {
    update();
    display();
  }
  void update()
  {
    this.sm.update();
  }
  void display()
  {
    this.sm.display(); 
    //Display FPS
    textAlign(RIGHT,TOP);
    textSize(12);
    fill(255,255,255,175);
    text("fps : " + (int)frameRate,width,0);
    textAlign(CENTER,CENTER);
  }
}