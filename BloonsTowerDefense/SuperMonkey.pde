public class SuperMonkey extends Tower {
   
  public SuperMonkey() {
    rad = 300;
    cost = 2000;
    x = 751;
    y = 205;
    killList = new PriorityQueue<Bloon>();
    fireRate = 10;
    fired = fireRate;
    projectileSpeed = 45;
    fill(c);
    photo = loadImage("Super_Monkey.png");
    photo.resize(40,40);
    image(photo,x+20,y+20); 
     
  }
  
}