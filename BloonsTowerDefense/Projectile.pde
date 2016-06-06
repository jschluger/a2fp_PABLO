public class Projectile {
  
  PImage image;
  int x,y,tarx,tary;
  
  Projectile(int x, int y, Bloon tar) { // x,y = tower, tarx,tary = target coor
    size(10,10);
    image = loadImage("dart.png");
    this.x = x;
    this.y = y;
    this.tarx = tar.x;
    this.tary = tar.y;
  }
  
  void draw() {
    image(image,x,y);
  }
}