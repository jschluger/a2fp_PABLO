public class Monkey extends Tower {
   
  public Monkey() {
    rad = 700;
    cost = 250;
    x = 601;
    y = 205;
    killList = new PriorityQueue<Bloon>();
    fireRate = 60;
    fired = fireRate;
    fill(c);
    photo = loadImage("Dart_Monkey.png");
    photo.resize(40,40);
    image(photo,x+20,y+20); 
     
   }
  
}