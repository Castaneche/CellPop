//=======================================================================
// CLASS
//=======================================================================
class Cell
{
  float x,y,w,h;
  float factor; //increases color's value of the cell
  color col;
  float alpha,r,g,b;
  boolean locked;
  float clock; //the cell is locked if you wait too long
  float timeLimit; 
  public Cell(float p_x, float p_y, float p_w, float p_h, float ptimeLimit)
  {
    x = p_x; 
    y = p_y;
    w = p_w;
    h = p_h;
    timeLimit = ptimeLimit;
  }
  void update()
  {
    if(alpha <= 255)
    {
      alpha+=factor;
    }
    else if(alpha >= 255 && !locked)
    {
      clock++;
    }
    
    if(clock/frameRate >= timeLimit)
      activateError();
    
    col = color(r,g,b,alpha);  
}
  void activate()
  {
    factor = 1.5;
    r = random(50,255);
    g = random(50,255);
    b = random(50,255);
    col = color(r,g,b,alpha);
  }
  boolean active()
  {
    if(col != color(0,0,0,alpha) && !locked)
    {
      return true; 
    }
    else
      return false;
  }
  void activateError() //set a red color
  {
    r = 255;
    g = b = 0;
    alpha = 255;
    factor = 0;
    locked = true;
  }
  void deactivate()
  {
    r = g = b = 0;
    alpha = 0; 
    factor = 0;
  }
  void display()
  {
    fill(col);
    stroke(255,255,255,150);
    rect(x,y,w,h); 
  }
}
class CellsManager
{
  ArrayList<Cell> cells = new ArrayList();
  final int offset = 1; 
  int score;
  
  public CellsManager(int nbCellsX,float timeLimit)
  {
    cells.clear();
    
    int cellSize = width/nbCellsX;
    println(cellSize);
    int nbCellsH = height/cellSize;
    int adjust = height%cellSize/2; //adjust the screen
    
    for(int i = 0; i < nbCellsX; i++)
    {
      for(int j = 0 ; j < nbCellsH ; j++)
      {
        cells.add(new Cell(i*cellSize+offset,j*cellSize+offset+adjust,cellSize-offset*2,cellSize-offset*2,timeLimit));
      } 
    }
  }
  void mouseR()
  {
    for(int i = 0; i < cells.size(); i++)
    {
      if(mouseX > cells.get(i).x
        && mouseY > cells.get(i).y
        && mouseX < cells.get(i).x + cells.get(i).w
        && mouseY < cells.get(i).y + cells.get(i).h)
      {
        if(cells.get(i).active())
        {
          score++;
          cells.get(i).deactivate();
        }
        else
        {
          cells.get(i).activateError(); 
        }
      }  
    } 
  }
  void activateACell()
  {
    int indexCell;
    do{
      indexCell = (int)random(cells.size());
    } while(cells.get(indexCell).active() || cells.get(indexCell).locked);
    cells.get(indexCell).activate();
  }
  void updateCells()
  {
    for(int i = 0; i < cells.size(); i++)
    {
      cells.get(i).update();
    } 
  }
  void displayCells()
  {
    for(int i = 0; i < cells.size(); i++)
    {
      cells.get(i).display();
    } 
  }
  int getScore()
  {
    return score; 
  }
}