static ArrayList<Bloon> offScreen, onScreen;
ArrayList<Tower> towers;
int stage;
boolean locked;
static boolean validLoc; //validLoc for valid location;
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
  
  // @col
  //load pixels (for validLoc)
  loadPixels();
  // @colEnd
  
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
    if (onScreen.get(i).stage == 14) {
      onScreen.remove(i);
      i--;
    }
  }
  if (locked) {
    if (checkLoc()) { 
      validLoc = true;
    }
    else {
      validLoc = false;
    }
    t.x = mouseX - 20; 
    t.y = mouseY - 20;
  }
  for (int i = 0; i < towers.size(); i++) {
    towers.get(i).display();
    towers.get(i).updateQueue();
  }
  if (locked) t.displayLocked();
  else t.display();
  
  // coordinate debug
  ellipse( mouseX, mouseY, 2, 2 );
  fill(color(0,0,0));
  text( "x: " + mouseX + " y: " + mouseY, mouseX + 2, mouseY );
  
}

  public boolean checkLoc() {
    boolean nearTowers = true; //checks if there are turrets on the spot
    for (int i = 0; i < towers.size(); i++) {
      if (Math.sqrt((Math.pow(towers.get(i).x - t.x,2)) + (Math.pow(towers.get(i).y - t.y,2))) < 40) {
        nearTowers = false;
        break;
      }
    }
    
    return (nearTowers) && (
    
          (mouseX < 85 && mouseY < 245) ||
          (mouseX < 300 && mouseY < 95) ||
          (mouseX > 276 && mouseY > 95 && mouseX < 308 && mouseY < 121) ||
          (mouseX > 298 && mouseY > 105 && mouseX < 502 && mouseY < 199) ||
          (mouseX > 298 && mouseY > 105 && mouseX < 351 && mouseY < 417)|| 
          (mouseX > 152 && mouseY > 165 && mouseX < 233 && mouseY < 405)||
          (mouseX > 0 && mouseY > 318 && mouseX < 233 && mouseY < 405)||
          (mouseX > 0 && mouseY > 318 && mouseX < 35 && mouseY < height)||
          (mouseX > 0 && mouseY > 569 && mouseX < 590 && mouseY < height)||
          (mouseX > 95 && mouseY > 468 && mouseX < 495 && mouseY < 500)||
          (mouseX > 298 && mouseY > 405 && mouseX < 495 && mouseY < 500)
          
          );
  }  


void mouseClicked() {
  if (!locked && mouseX < 50 && mouseY < 50) {
    locked = true;
  }
  
}

void mousePressed() {
  if (locked) {
    if (validLoc) {
      towers.add(t);
    }
    t = new Tower();
  }
  locked = false;

}