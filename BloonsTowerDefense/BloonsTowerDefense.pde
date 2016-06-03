ArrayList<Bloon> offScreen, onScreen;
ArrayList<Tower> towers;
int stage;
boolean locked;
Tower t;
int xOffset, yOffset;
PImage map;

void setup(){
  offScreen = new ArrayList<Bloon>();
  onScreen = new ArrayList<Bloon>();
  towers = new ArrayList<Tower>();
  locked = false;
  t = new Tower();
  for (int i = 0; i < 15; i++)
    offScreen.add( new Bloon( (int)(Math.random()* 3) + 1) );
  size(800, 600);

  //load map
  map = loadImage("map.png");
  map.resize(width, height);
  background(map);
  
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
  background(map);
  for (int i = 0; i < onScreen.size(); i++){
    onScreen.get(i).display();
    onScreen.get(i).move();
    if (onScreen.get(i).stage == 14) onScreen.remove(i);
  }
  if (locked) {
    t.x = mouseX - 20; 
    t.y = mouseY - 20;
  }
  for (int i = 0; i < towers.size(); i++) {
    towers.get(i).display();
  }
  t.display();
}

void mouseClicked() {
  if (!locked && mouseX < 50 && mouseY < 50) {
    locked = true;
  }
  else if (locked = true) {
    towers.add(t);
    t = new Tower();
    locked = false;
  }
}
