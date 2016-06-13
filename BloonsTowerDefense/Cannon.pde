public class Cannon extends Tower {
  public Cannon() {
    rad = 200;
    cost = 900;
    x = 751;
    y = 205;
    killList = new PriorityQueue<Bloon>();
    fireRate = 20;
    fired = fireRate;
    projectileSpeed = -1;
    fill(c);
    photo = loadImage("Cannon.png");
    photo.resize(40,40);
    image(photo,x+20,y+20); 
  }
}