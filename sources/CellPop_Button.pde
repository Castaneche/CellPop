class Button
{
  float x,y,w,h;
  color col;
  float r,g,b;
  String text;
  float textS;
  final float v = 5;
  boolean active;
  public Button(float px, float py, float pw, float ph, String ptext, float ptextS, color pcol)
  {
    if(percentMode) {
      x = (px/100)*width;
      y = (py/100)*height;
      w = (pw/100)*width;
      h = (ph/100)*height;
    }
    else {
      x = px;
      y = py;
      w = pw;
      h = ph;
    } 
    text = ptext;
    textS = ptextS;
    
    r = red(pcol);
    g = green(pcol);
    b = blue(pcol);
    col = color(r,g,b,255);
   }
  public void update()
  {
    col = color(r,g,b,255);
  }
  public void display()
  {
      noStroke();
      fill(col);
      rect(x,y,w,h);
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
      if(mousePressed)
      {
           col = color(r,g,b,215);
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