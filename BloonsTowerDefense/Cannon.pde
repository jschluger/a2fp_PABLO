public class Cannon extends Tower {
  public Cannon() {
    rad = 200;
    cost = 900;
    x = 701;
    y = 205;
    killList = new PriorityQueue<Bloon>();
    fireRate = 50;
    fired = fireRate;
    projectileSpeed = 8;
    fill(c);
    photo = loadImage("Cannon.png");
    photo.resize(40,40);
    image(photo,x+20,y+20); 
  }
}