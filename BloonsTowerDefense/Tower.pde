import java.util.*;

public abstract class Tower {
  int rad;
  int power;
  int c, x, y;
  PriorityQueue<Bloon> killList;
  int fireRate;
  int fired;
  boolean placed;
  float angle;
  PImage photo;
  boolean selected = false;
 

  public void display() {
    fired++;
    if (selected) {
      displaySelected();
    }
    faceAngle();
    attack();  
}
  
  public void attack() {
   if ( killList.peek() != null) {
      Bloon target = killList.poll();
      if (!target.marked && target.health > 0 && fired > fireRate && 
          sqrt(pow(target.x-x,2)+pow(target.y-y,2)) <= rad/2) 
      {
        faceTarget(target);
        target.marked = true;
        Projectile dart = new Projectile(x + 20, y + 20, target, 10);
        projects.add( dart );
        fired = 0;
      }
    } 
  }

  public void displayLocked() {
    //@col
    // if valid location
    if (BloonsTowerDefense.validLoc) { //green
	    fill(color(0,255,0),100);
    }
    else { //red
	    fill(color(255,0,0),100);
    }
    //@colEnd
    ellipse(x + 20, y + 20, rad, rad);
    
    image(photo,x+20,y+20);
    placed = true;
  }
  
  void displaySelected() {
    fill(color(0,255,0),100);
    ellipse(x + 20, y + 20, rad, rad);
  }
  

  public void updateQueue() {
    for (Bloon b : BloonsTowerDefense.onScreen) {
	    if ( sqrt( pow(b.x - x, 2) + pow(b.y - y, 2)) < rad/2  && ! b.marked ) {
        killList.add( b );
	    }
    }
  }
  
  void faceTarget(Bloon tar) {
    if (x - tar.x == 0) {
      pushMatrix();
      translate(x+20,y+20);
      if (y - tar.y < 0) {
        angle = radians(90);
        rotate(angle);
      }
      else {
        angle = radians(270);
        rotate(angle);
      }
      image(photo,-20,-20);
      popMatrix();
    }
    else {
      pushMatrix();
      translate(x+20,y+20);
      angle = PI + atan2(tar.x,tar.y);
      rotate(angle);
      image(photo,-20,-20);
      popMatrix();
    }
  }
  
  void faceAngle() {
      pushMatrix();
      translate(x+20,y+20);
      rotate(-angle);
      image(photo,-20,-20);
      popMatrix();
  }
  
}//end class Tower