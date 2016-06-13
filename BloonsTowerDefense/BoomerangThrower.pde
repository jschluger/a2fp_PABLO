public class BoomerangThrower extends Tower {
   
  public BoomerangThrower() {
    rad = 150;
    cost = 900;
    x = 651;
    y = 205;
    killList = new PriorityQueue<Bloon>();
    fireRate = 20;
    fired = fireRate;
    projectileSpeed = -1;
    fill(c);
    photo = loadImage("Boomerang_Thrower.png");
    photo.resize(40,40);
    image(photo,x+20,y+20); 
     
  }
  
}