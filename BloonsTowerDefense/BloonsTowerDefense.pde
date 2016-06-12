static ArrayList<Bloon> offScreen, onScreen;
ArrayList<Tower> towers;
ArrayList<Projectile> projects;

int health, money;
int stage;
boolean locked;
static boolean validLoc; //validLoc for valid location;
Tower t;
int ID = -1; //ID of tower in ArrayList towers
int xOffset, yOffset;
PImage map;

void setup(){
  health = 150;
  money = 500;
  offScreen = new ArrayList<Bloon>();
  onScreen = new ArrayList<Bloon>();
  towers = new ArrayList<Tower>();
  projects = new ArrayList<Projectile>();
  locked = false;
  t = new Monkey();
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
}// end setup()

void draw() {
  background(map);
  loadOnScreen();
  displayBloons();
  placeTowers();
  displayTowers();
  displayProjectiles();
  displayText();

} // end draw()


public void loadOnScreen() {
 //adding the bloons one at a time to the screen
  if (! offScreen.isEmpty() && frameCount % 10 == 0) {
    onScreen.add( offScreen.remove(0) );
  } 
}

public void displayBloons() {
  for (int i = 0; i < onScreen.size(); i++){
    if (onScreen.get(i).stage == 14) {
      health -= onScreen.remove(i).health;
      i--;
    }
    else if (onScreen.get(i).health <= 0) {
      onScreen.remove(i);
      money += 5;
      i--;
    }
    else {
      onScreen.get(i).display();
      onScreen.get(i).move(); 
    }
  }
}

public void placeTowers() {
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
  
  if (locked) t.displayLocked();
  else t.display();
}

public void displayTowers() {
 for (int i = 0; i < towers.size(); i++) {
    towers.get(i).display();
    towers.get(i).updateQueue();
    
    //SELECTED
  if (ID >= 0) towers.get(ID).displaySelected();
  } 
}

public void displayProjectiles() {
  for (int i = 0; i < projects.size(); i++) {
    if ( projects.get(i).checkHit() ) {
      projects.remove(i--);
    }
    else projects.get(i).display(); 
  }
}

public void displayText() {
  // coordinate debug
  ellipse( mouseX, mouseY, 2, 2 );
  fill(color(0,0,0));
  text( "x: " + mouseX + " y: " + mouseY, mouseX + 2, mouseY );
  
  //health
  text( health, 686, 83);
  
  //money
  text( money, 686, 48);
}

public boolean checkLoc() {
  boolean nearTowers = true; //checks if there are turrets on the spot
  for (int i = 0; i < towers.size(); i++) {
    if (sqrt((pow(towers.get(i).x - t.x,2)) + (pow(towers.get(i).y - t.y,2))) < 40) {
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
                          (mouseX > 298 && mouseY > 405 && mouseX < 495 && mouseY < 500) || 
                          (mouseX > 358 && mouseY > 0 && mouseX < 588 && mouseY < 35) || 
                          (mouseX > 570 && mouseY > 0 && mouseX < 588 && mouseY < height) || 
                          (mouseX > 410 && mouseY > 265 && mouseX < 588 && mouseY < 340) 
                          );
}  


void mouseClicked() {
  if (!locked && mouseX > 600 && mouseY > 205
              && mouseX < 642 && mouseY < 248
              ) {
    locked = true;
  }
  float shortest = Integer.MAX_VALUE;
  boolean selected = false;
  for (int i = 0; i < towers.size(); i++) {
    float dist = dist(mouseX,mouseY,towers.get(i).x,towers.get(i).y);
    if (dist < 20 && dist < shortest) {
      shortest = dist;
      selected = true;
      ID = i;
    }
  }
  if (selected != true) {
    ID = -1; //nothing selected
  }
  else {
    towers.get(ID).selected = true;
  }
}

void mousePressed() {
  if (locked) {
    if (validLoc) {
	    towers.add(t);
      money -= t.cost;
    }
    t = new Monkey();
    
  }
  locked = false;
}