class Board
{
  CellsManager cm;
  float clock, tps, tpsLimit;
  String level;
  float firstLimit, secondLimit; //Two limits for the spawn time
  int maxError;
  
  public Board(String plevel)
  {
    level = plevel;
    if(level == "easy")
    {
      maxError = 1;
      cm = new CellsManager(3,4);
    }
    else if(level == "medium")
    {
      maxError = 2;
      cm = new CellsManager(5,3.5);
    }
    else if(level == "hard")
    {
      maxError = 3;
      cm = new CellsManager(7,3);
    }
    else if(level == "insane")
    {
      maxError = 4;
      cm = new CellsManager(8,2);
    }
    tpsLimit = 2;
  }
  void update()
  {
    clock++;
    if(clock/frameRate >= 1)
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
    if(level == "easy")
      tpsLimit = random(0.65,1.00);
    else if(level == "medium")
      tpsLimit = random(0.25,0.65);
    else if(level == "hard")
      tpsLimit = random(0.15,0.25);
    else if(level == "insane")
      tpsLimit = 0.1;
  }
  boolean isFull()
  {
    int compteurCells = 0;
    int compteurLocked = 0;
    for(int i = 0 ; i < cm.cells.size() ; i++)
    {
      if(cm.cells.get(i).active())
        continue;
      else if(cm.cells.get(i).locked)
        compteurLocked++;
      else
        compteurCells++;
    }
    if(compteurCells == 0 || compteurLocked >= maxError)
      return true;
    else
      return false;
  }
}