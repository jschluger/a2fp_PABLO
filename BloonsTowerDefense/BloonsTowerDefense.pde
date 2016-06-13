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
int notChoice;
int ID = -1; //ID of tower in ArrayList towers
int xOffset, yOffset;
PImage map;
int errorTime;
int loadTime;
boolean pressed;
boolean lvlHigh;
boolean spdHigh;

boolean gameSpeed; //false = 60fps, true = 120fps

void setup(){
  gameSpeed = false;
  roundOver = true;
  round = 0;
  health = 50;
  money = 500;
  offScreen = new ArrayList<Bloon>();
  onScreen = new ArrayList<Bloon>();
  towers = new ArrayList<Tower>();
  projects = new ArrayList<Projectile>();
  locked = false;
  choices = new Tower[4];
  choices[0] = new Monkey();
  choices[1] = new BoomerangThrower(); 
  choices[2] = new Cannon();
  choices[3] = new SuperMonkey();
  choice = -1;
  notChoice = -1;
  size(800, 600);
  errorTime = -1;
  loadTime = round * 50;
  pressed = false;
  lvlHigh = false;
  spdHigh = false;

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
    highlight();
    displayText();
    loadOffScreen();
    loadOnScreen();
    displayBloons();
    displayTowers();
    placeTowers();
    displayProjectiles();
    displayErrors();
  }
  displayBloons();
  displayText();

} // end draw()

public void loadOffScreen() {
  if (loadTime++ < round * 50){
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
}

public void loadOnScreen() {
  if (roundOver) {
    text("CLICK HERE TO \nSTART NEXT ROUND", 630, 520);
  
    if (pressed) {
      roundOver = false;
      money += 100 + round*10;
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
  fill(0);
  //health
  text( health, 686, 83);
  
  //money
  text( money, 686, 48);
  
  //round
  if (!roundOver)
    text( round, 686, 123);
  
  //roundOver
  if (roundOver && round < NUM_ROUNDS)
    text("Next: " + (round + 1), 686, 123);

  //fast forward button
  if ( gameSpeed ) 
    text("Click to slow down", 630, 480);
  else 
    text("Click to speed up", 630, 480);

  if (locked) {
    if (60 / choices[choice].fireRate < 1) {
      text("Cost: " + choices[choice].cost + "\nFire Rate: " + "SLOW",600,275 );
    }
    else {
      text("Cost: " + choices[choice].cost + "\nFire Rate: " + 60 / choices[choice].fireRate + " projectile / second",600,275 );
    }
  }
  if (ID > -1) 
    text("SELL", 630, 430);
}

public void displayErrors() {
  if (errorTime >= 0) 
    { 
      fill(0);
      text("Not Enough Money!", 628, 350);
      if (60 / choices[notChoice].fireRate < 1) {
        text("Cost: " + choices[notChoice].cost + "\nFire Rate: " + "SLOW" ,600,275 );
      }
      else {
        text("Cost: " + choices[notChoice].cost + "\nFire Rate: " + 60 / choices[notChoice].fireRate + " projectile / second",600,275 );
    }
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

void update() {
  spdHigh = overRect(621,462,125,24);
  lvlHigh = overRect(621,505,137,35);
}

void highlight() {
  update();
  if (spdHigh) {
    fill(color(255,0,0),100);
    rect(621,462,125,24);
  }
  if (ID > -1 && overRect(621,415,41,20)) {
    fill(color(255,0,0),100);
    rect(621,415,41,20);
  }
  if (lvlHigh && roundOver) {
    fill(color(255,0,0),100);
    rect(621,505,137,35);
  }
}
  
boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mouseClicked() {
  if (!locked && mouseX > 600 && mouseY > 205
      && mouseX < 642 && mouseY < 248
      ) {
    if (money >= choices[0].cost) {
      locked = true;
      choice = 0;
    }
    else {
      errorTime = 200;
      notChoice = 0;
    }
  }
   else if (!locked && mouseX > 651 && mouseY > 205
           && mouseX < 691 && mouseY < 248
           ) {
    if (money >= choices[1].cost) {
      locked = true;
      choice = 1;
    }
    else {
      errorTime = 200;
      notChoice = 1;
    }
  }
    else if (!locked && mouseX > 701 && mouseY > 205
           && mouseX < 741 && mouseY < 248
           ) {
    if (money >= choices[2].cost) {
      locked = true;
      choice = 2;
    }
    else {
      errorTime = 200;
      notChoice = 2;
      }
    }
    else if (!locked && mouseX > 751 && mouseY > 205
           && mouseX < 791 && mouseY < 248
           ) {
    if (money >= choices[3].cost) {
      locked = true;
      choice = 3;
    }
    else {
      errorTime = 200;
      notChoice = 3;
      }
    }
           
    if (ID > -1) {
      if (mouseX > 621 && mouseY > 415
      && mouseX < 662 && mouseY < 435) {
        money += towers.remove(ID).cost * .8;
    }
  }

  selectTower();
    
  if (mouseX > 621 && mouseY > 462
      && mouseX < 746 && mouseY < 486) {
      if (gameSpeed)
	  frameRate(60);
      else 
	  frameRate(120);
      gameSpeed = !gameSpeed;
  }
  
  if (gameOver()) {
   if ( overRect(608, 368, 175, 40) ) 
       setup();
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
  String mes = "";
  boolean yes = false;
  
  if (round > NUM_ROUNDS) {
    mes = "You have won!!!";
    yes = true;
  }
  else if (health <= 0) {
    mes = "Game Over :(";
    yes = true;
  }
  if (yes) {
    fill(0);
    textSize(40);
    text(mes, 167, 279);
    text("RESTART", 608, 400); 
    textSize(12);
    if ( overRect(608, 368, 175, 40) )
      fill(color(0,255,0),100);
    else 
      fill(color(255,0,0),100);
      
    rect(608,368,175,40);
  }
  return yes;
}

void mousePressed() {
  if (roundOver) {
     if (mouseX > 621 && mouseY > 505
     && mouseX < 758 && mouseY < 540) {
        pressed = true;
        round += 1;
        loadTime = 0;
     }
  }
  if (locked) {
    if (validLoc) {
	    towers.add(choices[choice]);
      money -= choices[choice].cost;
    }
    if (choice == 0)
      choices[0] = new Monkey();
    if (choice == 1)
      choices[1] = new BoomerangThrower();
    if (choice == 2)
      choices[2] = new Cannon();
    if (choice == 3)
      choices[3] = new SuperMonkey();
    choice = -1;   
  }
  locked = false;
}