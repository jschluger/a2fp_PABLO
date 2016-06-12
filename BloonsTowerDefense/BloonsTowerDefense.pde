static ArrayList<Bloon> offScreen, onScreen;
ArrayList<Tower> towers;
ArrayList<Projectile> projects;

static int health, money;
int stage;
boolean locked;
static boolean validLoc; //validLoc for valid location;
Tower[] choices;
int choice; //which tower you are buying
int ID = -1; //ID of tower in ArrayList towers
int xOffset, yOffset;
PImage map;
int errorTime;

void setup(){
  health = 150;
  money = 500;
  offScreen = new ArrayList<Bloon>();
  onScreen = new ArrayList<Bloon>();
  towers = new ArrayList<Tower>();
  projects = new ArrayList<Projectile>();
  locked = false;
  choices = new Tower[2];
  choices[0] = new Monkey();
  choices[1] = new SuperMonkey();
  choice = -1;
  for (int i = 0; i < 50; i++)
    offScreen.add( new Bloon( (int)(Math.random()* 4) + 1) );
  size(800, 600);
  errorTime = -1;

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
  for (Tower t : choices) t.display();
}// end setup()


void draw() {
  background(map);
  loadOnScreen();
  displayBloons();
  displayTowers();
  placeTowers();
  displayProjectiles();
  displayText();
  displayErrors();

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
    choices[choice].x = mouseX - 20; 
    choices[choice].y = mouseY - 20;
  }
  
  for (int i = 0; i < choices.length; i++) {
    if (i == choice) choices[i].displayLocked();
    else choices[i].display();
  }
}

public void displayTowers() {
  for (int i = 0; i < towers.size(); i++) {
    if (i == ID) towers.get(ID).displaySelected();
    towers.get(i).display();
    towers.get(i).updateQueue();
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

public void displayErrors() {
  if (errorTime >= 0) 
    text("Not Enough Money!", 628, 500);
  errorTime--;
}
public boolean checkLoc() {
  boolean nearTowers = true; //checks if there are turrets on the spot
  for (int i = 0; i < towers.size(); i++) {
    if (dist(towers.get(i).x, towers.get(i).y, choices[choice].x,  choices[choice].y) < 40) {
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
    if (money >= choices[0].cost) {
      locked = true;
      choice = 0;
    }
    else errorTime = 200;
  }
  else if (!locked && mouseX > 651 && mouseY > 205
           && mouseX < 691 && mouseY < 248
           ) {
    if (money >= choices[1].cost) {
      locked = true;
      choice = 1;
    }
    else errorTime = 200;
  }
  else {
    selectTower();
  }
}

public void selectTower() {
  float shortest = Integer.MAX_VALUE;
  boolean selected = false;
  for (int i = 0; i < towers.size(); i++) {
    float dist = dist(mouseX,mouseY,towers.get(i).x + 20, towers.get(i).y + 20);
    if (dist < 30 && dist <= shortest) {
      shortest = dist;
      selected = true;
      ID = i;
    }
  }
  if (selected != true) {
    ID = -1; //nothing selected
  }  
}


void mousePressed() {
  if (locked) {
    if (validLoc) {
	    towers.add(choices[choice]);
      money -= choices[choice].cost;
    }
    if (choice == 0)
      choices[0] = new Monkey();
    if (choice == 1)
      choices[1] = new SuperMonkey();
    choice = -1;   
  }
  locked = false;
}
