public class Cannon extends Tower {
  public Cannon() {
    rad = 200;
    cost = 900;
    x = 701;
    y = 205;
    killList = new PriorityQueue<Bloon>();
    fireRate = 100;
    fired = fireRate;
    projectileSpeed = 8;
    fill(c);
    photo = loadImage("Cannon.png");
    photo.resize(40,40);
    image(photo,x+20,y+20); 
  }
  
  public void attack() {
    if ( killList.peek() != null) {
      Bloon target = killList.poll();
      if (!target.marked && target.health > 0 && fired > fireRate && 
          sqrt(pow(target.x-x,2)+pow(target.y-y,2)) <= rad/2) 
      {
        faceTarget(target);
        target.marked = true;
        Projectile dart = new Projectile(x + 20, y + 20, target, projectileSpeed);
        dart.boom = 60;
        projects.add( dart );
        fired = 0;
      }
    } 
  }
}