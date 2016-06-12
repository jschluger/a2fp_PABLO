public class Projectile {
  
  PImage photo;
  float x,y;
  float speed;
  Bloon target;
  float angle;
  
  Projectile(int x, int y, Bloon tar, float spd) { // x,y = tower, tarx,tary = target coor
    photo = loadImage("dart.png");
    photo.resize(15,15);
    this.x = x;
    this.y = y;
    speed = spd;
    target = tar;
    faceTarget();
  }
  
  void display() {
    fill(0);
    image(photo, x, y);
    //ellipse(x,y,5,10);
    faceTarget();
    faceAngle();
    move();
    //image(photo,x,y);
  }
  
  public void move() {
    faceTarget();
    faceAngle();
    float vectorLen = sqrt( pow(x - target.x, 2) + pow(y - target.y, 2) );
    x += (target.x - x ) * speed / vectorLen;
    y += (target.y - y ) * speed / vectorLen;
  }
    
  public boolean checkHit() {
    if ( abs(x - target.x ) < speed &&
         abs(x - target.x ) < speed){
	    target.setHealth( target.health - 1 );
	    BloonsTowerDefense.money += 5;
      return true;
    }
    else return false;
      
  }
  
  void faceTarget() {
    if (x - target.x == 0) {
      pushMatrix();
      translate(x+20,y+20);
      if (y - target.y < 0) {
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
      angle = PI + atan2(target.x,target.y);
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
    
    
}