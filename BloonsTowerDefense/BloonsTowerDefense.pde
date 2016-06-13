import java.util.PriorityQueue;

static ArrayList<Bloon> offScreen, onScreen;
ArrayList<Tower> towers;
ArrayList<Projectile> projects;
boolean roundOver;
int round;
final int NUM_ROUNDS = 50;

static int health, money;
boolean locked;
static boolean validLoc; //validLoc for valid location;
Tower[] choices;
int choice; //which tower you are buying
int ID = -1; //ID of tower in ArrayList towers
int xOffset, yOffset;
PImage map;
int errorTime;
boolean pressed;

boolean gameSpeed; //flase = 60fps, true = 120fps

void setup(){
  gameSpeed = false;
  roundOver = true;
  round = 0;
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
  size(800, 600);
  errorTime = -1;
  pressed = false;

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
  if (!gameOver()) {
    displayText();
    loadOnScreen();
    displayBloons();
    displayTowers();
    placeTowers();
    displayProjectiles();
    displayErrors();
  }

} // end draw()

public void loadOffScreen() {
  for (int i = 0; i < round * 25; i++)
    if (round < 3) {
      if (random(100) < 95)
        offScreen.add( new Bloon(1) );
      else 
        offScreen.add( new Bloon(2) );
    }
    else if (round < 10) {
      if (random(100) < 75)
        offScreen.add( new Bloon(1) );
      else if (random(100) < 15)
        offScreen.add( new Bloon(2) );
      else
        offScreen.add( new Bloon(3) );
    }
    else if (round < 20) {
      if (random(100) < 50)
        offScreen.add( new Bloon(1) );
      else if (random(100) < 30)
        offScreen.add( new Bloon(2) );
      else if (random(100) < 10)
        offScreen.add( new Bloon(3) );
      else
        offScreen.add( new Bloon(4) );
    }
    else if (round < 30) {
      if (random(100) < 35)
        offScreen.add( new Bloon(1) );
      else if (random(100) < 30)
        offScreen.add( new Bloon(2) );
      else if (random(100) < 20)
        offScreen.add( new Bloon(3) );
      else
        offScreen.add( new Bloon(4) );
    }
    else if (round < 40) {
      if (random(100) < 15)
        offScreen.add( new Bloon(1) );
      else if (random(100) < 30)
        offScreen.add( new Bloon(2) );
      else if (random(100) < 40)
        offScreen.add( new Bloon(3) );
      else
        offScreen.add( new Bloon(4) );
    }
    else {
      if (random(100) < 10)
        offScreen.add( new Bloon(1) );
      else if (random(100) < 15)
        offScreen.add( new Bloon(2) );
      else if (random(100) < 35)
        offScreen.add( new Bloon(3) );
      else
        offScreen.add( new Bloon(4) );
    }
}

public void loadOnScreen() {
  if (roundOver) {
    text("CLICK HERE TO \nSTART NEXT ROUND", 630, 520);
  
    if (pressed) {
      roundOver = false;
      round += 1;
      loadOffScreen();
      //adding the bloons one at a time to the screen
      pressed = false;
    }
  }
  if (! offScreen.isEmpty() && frameCount % (60 - round) == 0) {
        onScreen.add( offScreen.remove(0) );
      }
}

public void displayBloons() {
  if (onScreen.size() == 0 && offScreen.size() == 0) roundOver = true;
  
  for (int i = 0; i < onScreen.size(); i++) {
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
  
  //round
  if (!roundOver)
    text( round, 686, 123);
  
  //roundOver
  if (roundOver && round < NUM_ROUNDS)
    text( "Next: " + (round + 1), 686, 123);

  //fast forward button
  if ( gameSpeed ) 
    text("Click to slow down", 630, 480);
  else 
    text("Click to speed up", 630, 480);

}

public void displayErrors() {
  if (errorTime >= 0) 
    { 
      fill(0);
      text("Not Enough Money!", 628, 350);
  errorTime--;
  }
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
  if (roundOver) {
     if (mouseX > 630 && mouseY > 511
     && mouseX < 750 && mouseY < 540) {
        pressed = true; 
     }
  }

  selectTower();
    
  if (mouseX > 630 && mouseY > 470
      && mouseX < 730 && mouseY < 480) {
      if (gameSpeed)
	  frameRate(60);
      else 
	  frameRate(120);
      gameSpeed = !gameSpeed;
  }
}

public void selectTower() {
  boolean selected = false;
  for (int i = 0; i < towers.size(); i++) {
    float dist = dist(mouseX,mouseY,towers.get(i).x + 20, towers.get(i).y + 20);
    if (dist < 30) {
      selected = true;
      ID = i;
      break;
    }
  }
  if (selected != true) {
    ID = -1; //nothing selected
  }  
}

public boolean gameOver() {
  if (round > NUM_ROUNDS) {
    text("You have won!!!", 628, 500);
    return true;
  }
  else if (health < 0) {
    text("GAME OVER", 628, 500);
    return true;
  }
  else return false;
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
