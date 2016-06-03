ArrayList<Bloon> offScreen, onScreen;
ArrayList<Tower> towers;
int stage;
boolean locked;
Tower t;
int xOffset, yOffset;

void setup(){
  offScreen = new ArrayList<Bloon>();
  onScreen = new ArrayList<Bloon>();
  towers = new ArrayList<Tower>();
  locked = false;
  t = new Tower();
  for (int i = 0; i < 15; i++)
    offScreen.add( new Bloon() );
  size(600, 600);
  //load map
  for (int i = 0; i < towers.size(); i++) {
    towers.get(i).display();
  }
  t.display();
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
  if (locked) {
    t.x = mouseX-xOffset; 
    t.y = mouseY-yOffset;
  }
  for (int i = 0; i < towers.size(); i++) {
    towers.get(i).display();
  }
  t.display();
}

void mouseClicked() {
  if (mouseX < 50 && mouseY < 50) {
    locked = true;
  }
}

void mousePressed() {
  if (locked) {
    t.x = mouseX-xOffset; 
    t.y = mouseY-yOffset;
  }
}


void mouseReleased() {
  if (locked) {
    towers.add(t);
    t = new Tower();
  }
  locked = false;
  
}