class Board
{
  CellsManager cm;
  final float factor = 0.01;
  float clock, tps, tpsLimit;
  
  public Board()
  {
    cm = new CellsManager();
    tpsLimit = 2;
  }
  void update()
  {
    clock++;
    if(clock/frameRate >= 0.5 && tpsLimit >= 0.1)
    {
      increaseSpeed();
      clock = 0;
    }
    
    tps++;
    if(tps/frameRate >= tpsLimit)
    {
      cm.activateACell();
      tps = 0; 
    }
    
    cm.updateCells();
  }
  void display()
  {
    cm.displayCells();
  }
  void increaseSpeed()
  {
    tpsLimit -= factor;
  }
  boolean isFull()
  {
    int compteur  = 0;
    for(int i = 0 ; i < cm.cells.size() ; i++)
    {
      if(cm.cells.get(i).active() || cm.cells.get(i).locked)
        continue;
      else
        compteur++;
    }
    if(compteur == 0)
      return true;
    else
      return false;
  }
}
