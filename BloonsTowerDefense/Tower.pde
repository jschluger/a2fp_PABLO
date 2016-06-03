public class Tower {
  int rad;
  int power;
  int c, x, y;

  public Tower() {
    rad = 150;
    power = 1;
    x = 0;
    y = 0;
    c = color(random(255), random(255), random(255));
  }

  public Tower(int r, int p) {
    this();
    rad = r;
    power = p;
  }

  public void display() {
    fill(c);
    rect(x, y, 40, 40);
  }

  public void displayLocked() {
    fill(50, 50, 50, 10);
    ellipse(x + 20, y + 20, rad, rad);
    
    fill(c);
    rect(x, y, 40, 40);
    
  }
}//end class Tower