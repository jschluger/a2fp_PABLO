public class Tower {
  int rad;
  int power;
  int c, x, y;

  public Tower() {
    rad = 50;
    power = 1;
    x = mouseX;
    y = mouseY;
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

}//end class Tower