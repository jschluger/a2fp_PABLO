public class Projectile {
  
  PImage photo;
  int x,y,tarx,tary;
  
  Projectile(int x, int y, Bloon tar) { // x,y = tower, tarx,tary = target coor
    photo = loadImage("dart.png");
    this.x = x;
    this.y = y;
    this.tarx = tar.x;
    this.tary = tar.y;
  }
  
  void display() {
    image(photo,x,y);
  }
}