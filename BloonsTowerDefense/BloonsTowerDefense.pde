ArrayList<Bloon> offScreen, onScreen;
int stage;
boolean locked;
Tower t;
int xOffset, yOffset;

void setup(){
  offScreen = new ArrayList<Bloon>();
  onScreen = new ArrayList<Bloon>();
  t = new Tower();
  locked = false;
  for (int i = 0; i < 15; i++)
    offScreen.add( new Bloon() );
  size(600, 600);
  //load map
    
}

void draw() {
  //adding the bloons one at a time to the screen
  if (! offScreen.isEmpty() && frameCount % 60 == 0) {
    onScreen.add( offScreen.remove(0) );
  }
  background(0);
  for (Bloon b : onScreen){
    b.display();
    b.move();
  }

  t.display();
}

void mousePressed() {
  if(!locked) { 
    locked = true; 
  } else {
    locked = false;
  }
  xOffset = mouseX-t.x; 
  yOffset = mouseY-t.y; 

}

void mouseDragged() {
  if(locked) {
    t.x = mouseX-xOffset; 
    t.y = mouseY-yOffset; 
  }
}

void mouseReleased() {
  locked = false;
}