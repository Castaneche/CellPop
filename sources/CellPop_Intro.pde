class Intro {
  float t; //time
  float a = 255; //alpha
  PImage logo;
  Intro(String path)
  {
    logo = loadImage(path);
  }
  public void update() {
    t++;
    a = a - t/20;
  }
  public void display() {
    image(logo, width/2 - width/4, height/2 - height/3, width/2, height/3);
    textAlign(CENTER);
    textSize(adjustTextSize(65));
    fill(255);
    text("CellPop", width/2, height/2 + 60);
    textSize(adjustTextSize(35));
    text("by Cybermissia", width/2, height/2 + 120);
    
    //Fade effect
    fill(10,10,10,a);
    rect(0,0,width,height);
  }
}