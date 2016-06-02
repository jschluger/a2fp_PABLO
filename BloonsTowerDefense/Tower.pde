public class Tower {
  int rad;
  int power;
  int c;

  public Tower() {
    rad = 50;
    power = 1;
    c = color(random(255), random(255), random(255));
  }

  public Tower(int r, int p) {
    this();
    rad = r;
    power = p;
  }

}//end class Tower
