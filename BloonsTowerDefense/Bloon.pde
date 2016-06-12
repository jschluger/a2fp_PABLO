public class Bloon implements Comparable{
  int health;
  int c;
  int x, y;
  float speed;
  int stage;
  boolean marked;
  
  public Bloon() {
    setHealth(1);
    x = 0;
    y = height / 2 - 15;
    speed = 1;
    stage = 0;
    marked = false;
  }
  
  public Bloon(int hp) {
    this();
    setHealth(hp);
  }

  public void setHealth(int hp) { 
      health = hp;
      if (health == 1)
        c = color(255,0,0);
      else if (health == 2)
        c = color(0,0,255);
      else if (health == 3)
        c = color(0,255,0);
      else 
        c = color(255,0,221);
      speed = hp;
      marked = false;
  }
    
  public void display() {
    fill(c);
    ellipse(x, y, 15, 15);
  }

  public void move() {
     
    if ( stage == 0 ) {
	    x += speed;
	    if (x > 115) stage++; 
    }
    else if ( stage == 1 ) {
	    y -= speed;
	    if (y < 120) stage++; 
    }
    else if ( stage == 2 ) {
	    x += speed;
	    if (x > 256) stage++; 
    }
    else if ( stage == 3 ) {
	    y += speed;
	    if (y > 437) stage++; 
    }
    else if ( stage == 4 ) {
	    x -= speed;
	    if (x < 75) stage++; 
    }
    else if ( stage == 5 ) {
	    y += speed;
	    if (y > height - 65) stage++; 
    }
    else if ( stage == 6 ) {
	    x += speed;
	    if (x > 525) stage++; 
    }
    else if ( stage == 7 ) {
	    y -= speed;
	    if (y < 375) stage++; 
    }
    else if ( stage == 8 ) {
	    x -= speed;
	    if (x < 375) stage++; 
    }
    else if ( stage == 9 ) {
	    y -= speed;
	    if ( y <  244) stage++; 
    }
    else if ( stage == 10 ) {
	    x += speed;
	    if (x > 525) stage++; 
    }
    else if ( stage == 11 ) {
	    y -= speed;
	    if (y < 85) stage++; 
    }
    else if ( stage == 12 ) {
	    x -= speed;
	    if (x < 315) stage++; 
    }
    else if ( stage == 13 ) {
	    y -= speed;
	    if (y < 0) stage++; 
    }
    //stage 14 == dead
     
  }
  
    public int compareTo(Object b) {
	if (((Bloon) b).health > health) {
	    return 1;
	}
	else if (((Bloon) b).health == health) {
	    return 0;
	}
	else {
	    return -1;
	}
    }
  
}//end class Bloon