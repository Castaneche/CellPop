class Board
{
  CellsManager cm;
  float clock, tps, tpsLimit;
  int level;
  float firstLimit, secondLimit; //Two limits for the spawn time
  
  public Board(int plevel)
  {
    level = plevel;
    if(level == 0)
      cm = new CellsManager(3);
    else if(level == 1)
      cm = new CellsManager(5);
    else
      cm = new CellsManager(7);
    
    tpsLimit = 2;
  }
  void update()
  {
    clock++;
    if(clock/frameRate >= 0.5)
    {
      changeSpeed();
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
  void changeSpeed()
  {
    if(level == 0)
      tpsLimit = random(0.75,1.25);
    else if(level == 1)
      tpsLimit = random(0.3,0.75);
    else
      tpsLimit = random(0.15,0.3);
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
