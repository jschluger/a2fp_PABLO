public class Projectile {
  
  PImage photo;
  float x,y;
  Bloon target;
  
  Projectile(int x, int y, Bloon tar) { // x,y = tower, tarx,tary = target coor
    photo = loadImage("dart.png");
    photo.resize(20,20);
    this.x = x;
    this.y = y;
    target = tar;
  }
  
  void display() {
    fill(0);
    ellipse(x,y,5,10);
    move();
    //image(photo,x,y);
  }
  
  public void move() {
    float vectorLen = sqrt( pow(x - target.x, 2) + pow(y - target.y, 2) );
    x += (target.x - x ) * 4 / vectorLen;
    y += (target.y - y ) * 4 / vectorLen;
    
  }
    
  public boolean checkHit() {
    if ( abs(x - target.x ) < 4 &&
         abs(x - target.x ) < 4){
	    target.setHealth( target.health - 1 );
	    return true;
    }
    else return false;
      
  }
    
    
}