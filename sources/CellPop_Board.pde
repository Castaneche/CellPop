class Board
{
  CellsManager cm;
  float clock, tps, tpsLimit;
  String level;
  float firstLimit, secondLimit; //Two limits for the spawn time
  
  public Board(String plevel)
  {
    level = plevel;
    if(level == "easy")
    {
      cm = new CellsManager(3,4);
    }
    else if(level == "medium")
    {
      cm = new CellsManager(5,3.5);
    }
    else if(level == "hard")
    {
      cm = new CellsManager(7,3);
    }
    else if(level == "insane")
    {  
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