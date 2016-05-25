class Button
{
  float x,y,w,h;
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
    active = false;
    offset = poffset;
  }
  public void update()
  {
    
    if(offset < 0)
      offset += v;
    else if(offset > 0)
      offset -= v;
    
    if(mousePressed && offset == 0)
    {
      if(mouseX >= x
      && mouseX <= x+w
      && mouseY >= y
      && mouseY <= y+h)
      {
         active = true;
      }
    }
    else
      active = false;
  }
  public void display()
  {
      noStroke();
      fill(215);
      rect(x-offset,y,w+offset*2,h);
      fill(0);
      textAlign(CENTER,CENTER);
      textSize(textS);
      text(text,x+w/2,y+h/2);
  }
  public boolean isActive()
  {
    return active;
  } 
}
