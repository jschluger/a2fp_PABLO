import java.util.*;

public class Tower {
  int rad;
  int power;
  int c, x, y;
  PriorityQueue<Bloon> killList;

  public Tower() {
    rad = 150;
    power = 1;
    x = 0;
    y = 0;
    c = color(random(255), random(255), random(255));
    killList = new PriorityQueue<Bloon>();
  }

  public Tower(int r, int p) {
    this();
    rad = r;
    power = p;
  }

  public void display() {
    fill(c);
    rect(x, y, 40, 40);
    //if ( killList.peek() != null) 
    //  BloonsTowerDefense.onScreen.remove( killList.poll() );
  }

  public void displayLocked() {
    fill(50, 50, 50, 10);
    ellipse(x + 20, y + 20, rad, rad);
    
    fill(c);
    rect(x, y, 40, 40);
  }
  
  public void updateQueue() {
      for (Bloon b : BloonsTowerDefense.onScreen) {
         if ( sqrt( pow(b.x - x, 2) + pow(b.y - y, 2)) < rad )
           killList.offer( b );
      }
      
    
  }
}//end class Tower