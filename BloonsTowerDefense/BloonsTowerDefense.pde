ArrayList<Bloon> offScreen, onScreen;

void setup(){
    offScreen = new ArrayList<Bloon>();
    onScreen = new ArrayList<Bloon>();
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

}