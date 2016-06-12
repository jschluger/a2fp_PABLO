public class SuperMonkey extends Tower {
   
  public SuperMonkey() {
    rad = 600;
    cost = 2;
    x = 651;
    y = 205;
    killList = new PriorityQueue<Bloon>();
    fireRate = 6;
    fired = fireRate;
    projectileSpeed = 50;
    fill(c);
    photo = loadImage("Super_Monkey.png");
    photo.resize(40,40);
    image(photo,x+20,y+20); 
     
  }
  
}