class Button
{
  float x,y,w,h;
  color col;
  String text;
  int textS;
  float offset;
  final float v = 5;
  boolean active;
  public Button(float px, float py, float pw, float ph, String ptext, int ptextS, float poffset)
  {
    x = px;
    y = py;
    w = pw;
    h = ph;
    text = ptext;
    textS = ptextS;
    offset = poffset;
    col = color(215);
  }
  public void update()
  {
    col = color(215);
    
    if(offset < 0)
      offset += v;
    else if(offset > 0)
      offset -= v;
    
    
  }
  public void display()
  {
      noStroke();
      fill(col);
      rect(x-offset,y,w+offset*2,h);
      fill(0);
      textAlign(CENTER,CENTER);
      textSize(textS);
      text(text,x+w/2,y+h/2);
  }
  public boolean isReleased()
  {
    if(mouseX >= x
    && mouseX <= x+w
    && mouseY >= y
    && mouseY <= y+h)
    {
      if(mousePressed && offset == 0)
      {
           col = color(150);
           active = true;

      }
      else if(!mousePressed && active)
      {
        return true;
      }
      else
      {
        active = false; 
      }
    }
    else
    {
      active = false; 
    }
    return false; 
  }
}