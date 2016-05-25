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
}
