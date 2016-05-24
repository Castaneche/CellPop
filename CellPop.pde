Game game;

void setup()
{
  size(displayWidth,displayHeight); 
  orientation(PORTRAIT);
  frameRate(60);
  smooth();
  strokeWeight(3);
  
  game = new Game();
}
void draw()
{
  game.run();
}
void mouseReleased()
{
  if(game.screen instanceof GameScreen) //If it's the GameScreen
  {
    //Cast the class to use the special function 'handleMouseReleased'
    GameScreen gs = GameScreen.class.cast(game.screen); 
    gs.handleMouseReleased();
  }
  /*if(game.screen instanceof ScoreScreen)
  {
    ScoreScreen sc = ScoreScreen.class.cast(game.screen);
    if(sc.clock/frameRate >= 3)
    {
      sc.screenToReturn = 0;
    } 
  }*/
}
