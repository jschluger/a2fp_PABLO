static ArrayList<Bloon> offScreen, onScreen;
ArrayList<Tower> towers;
int stage;
boolean locked;
// @col
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
  //@col
  //color debug (color in original map)
    color col = pixels[mouseX * 600 + mouseY];
    float green = green(col);
    int averageGreenCol = averageGreenCol();
  //@colEnd
  
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
    //@col
    if (checkLoc()) {//(green > 145 && green < 150) {
      validLoc = true;
    }
    else {//if (green < 145 && green > 137){
      validLoc = false;
    }
    //@colEnd
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
  
  //@col
  // color debug
  text( "color :" + col, mouseX + 2, mouseY - 20);
  // greenness
  text( "green: " + green, mouseX + 2, mouseY - 40);
  // average greenness
  text( "avggreen:" + averageGreenCol, mouseX + 2, mouseY - 60);
  //@colEnd
}

  public boolean checkLoc() {
    return(mouseX < 85 && mouseY < 245) ||
          (mouseX < 300 && mouseY < 95) ||
          (mouseX > 276 && mouseY > 95 && mouseX < 308 && mouseY < 121) ||
          (mouseX > 298 && mouseY > 105 && mouseX < 502 && mouseY < 199) ||
          (mouseX > 298 && mouseY > 105 && mouseX < 351 && mouseY < 417)|| 
          (mouseX > 152 && mouseY > 165 && mouseX < 233 && mouseY < 405)||
          (mouseX > 0 && mouseY > 318 && mouseX < 233 && mouseY < 405)||
          (mouseX > 0 && mouseY > 318 && mouseX < 35 && mouseY < height)||
          (mouseX > 0 && mouseY > 569 && mouseX < 590 && mouseY < height)||
          (mouseX > 95 && mouseY > 468 && mouseX < 495 && mouseY < 500)||
          (mouseX > 298 && mouseY > 405 && mouseX < 495 && mouseY < 500)||
          
          false;

  }  


void mouseClicked() {
  if (!locked && mouseX < 50 && mouseY < 50) {
    locked = true;
  }
  
}

void mousePressed() {
  if (locked) {
    towers.add(t);
    t = new Tower();
  }
  locked = false;

}

//@col
color averageGreenCol() {
  color ret=0;
  int[][] around = new int[20][20]; //less memory consumption than 40*40
  for (int i = 0; i < around.length;i++) {
    for (int p = 0; p < around[0].length;p++) {
      int xcor = mouseX + 10 - i;
      int ycor = mouseY + 10 - i;
      if (xcor > 600) {
        xcor = 600;
      }
      if (xcor < 0) {
        xcor = 0;
      }
      if (ycor > 600) {
        ycor = 600;
      }
      if (ycor < 0) {
        ycor = 0;
      }
      ret += pixels[xcor + ycor * 600];
    }
  }
  
  
  return ret/400;
}
//@colEnd