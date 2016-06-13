public class Bloon implements Comparable {
  int health;
  int x, y;
  float speed;
  int stage;
  boolean marked;
  PImage bloon;
  
  public Bloon() {
    setHealth(1);
    bloon = loadImage("red.png");
    x = 0;
    y = 270;
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
    if (health == 1) {
      bloon = loadImage("red.png");
    }
    else if (health == 2) {
      bloon = loadImage("blue.png");
    }
    else if (health == 3) {
      bloon = loadImage("green.png");
    }
    else {
      bloon = loadImage("pink.png");
    }
    speed = hp;
    marked = false;
  }
    
  public void display() {
    bloon.resize(20,25);
    image(bloon,x,y);
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
	    if (y > 430) stage++; 
    }
    else if ( stage == 4 ) {
	    x -= speed;
	    if (x < 57) stage++; 
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
	    if ( y < 227) stage++; 
    }
    else if ( stage == 10 ) {
	    x += speed;
	    if (x > 525) stage++; 
    }
    else if ( stage == 11 ) {
	    y -= speed;
	    if (y < 62) stage++; 
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