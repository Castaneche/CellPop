//Global variable
boolean percentMode = true;

Game game;

void setup()
{
  size(580,800); 
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
  if(game.sm.getCurrentScreen() instanceof GameScreen) //If it's the GameScreen
  {
    //Cast the class to use the special function 'handleMouseReleased'
    GameScreen gs = GameScreen.class.cast(game.sm.getCurrentScreen()); 
    gs.handleMouseReleased();
  }
}