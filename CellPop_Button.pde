class Button
{
  float x,y,w,h;
  String text;
  int textS;
  boolean active;
  public Button(float px, float py, float pw, float ph, String ptext, int ptextS)
  {
    x = px;
    y = py;
    w = pw;
    h = ph;
    text = ptext;
    textS = ptextS;
    active = false;
  }
  public void update()
  {
    if(mousePressed)
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
    rect(x,y,w,h);
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
