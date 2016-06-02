public class Bloon {
  int health;
  float x, y, dx, dy;
  
  public Bloon() {
    health = 1;
    x = 0;
    y = height / 2;
    dx = 2;
    dy = 0;
  }
  
  public Bloon(int hlth, float X, float Y) {
    health = hlth;
    x = X;
    y = Y;
  }
    
  public void display() {
    ellipse(x, y, 15, 15);
  }

  public void move() {
    x += dx;
    y += dy;
  }
  
}//end class Bloon
