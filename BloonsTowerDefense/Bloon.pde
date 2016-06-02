public class Bloon {
  int health;
  int c;
  float x, y, dx, dy;
  
  public Bloon() {
    setHealth(1);
    x = 0;
    y = height / 2;
    dx = 2;
    dy = 0;
  }
  
  public Bloon(int hp, float X, float Y) {
    this();
    setHealth(hp);
    x = X;
    y = Y;
  }

  public void setHealth(int hp) {
    health = hp;
    if (health == 1)
      c = color(255,0,0);
    else if (health == 2)
      c = color(0,0,255);
    else
      c = color(0,255,0);
  }
    
  public void display() {
    ellipse(x, y, 15, 15);
  }

  public void move() {
    x += dx;
    y += dy;
  }
  
}//end class Bloon
