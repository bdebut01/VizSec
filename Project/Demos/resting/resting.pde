import ddf.minim.*; //Minim library
int NUM_SOUNDS = 8;
float TONE_DURATION = .8; //in seconds
int BUTTON_RADIUS = 20;
int SPACING = 15;

//Color palette
color C_BG = #F2E6B6; 
color C_TEXT = #292929;
color C_HIGHLIGHT = #8F9E8B; 
color C_BUTTON  = #5B7876;



String[] attacks = { "http error", "nmap", "XSS",
                     "/etc/", "admin", "wp-admin",
                     "phpMyAdmin", "Shellcode"};

Minim minim; //base minim object
AudioSample snd[]; //AudioSamples are "triggered" sounds


ArrayList<Button> bs;

void setup() {
  smooth();
	size(320, 420);
  
	minim = new Minim(this);
	snd = new AudioSample[NUM_SOUNDS];

	bs = new ArrayList<Button>();
	int x = width/8;
	int y = height/5;

	for (int i = 0; i < NUM_SOUNDS; i++) {
		int extension = 340;
		//println ((extension + i*20) + ".wav");
		snd[i] = minim.loadSample((extension - i*20) + ".wav");

		//Buttons
		bs.add(new Button(x, y, BUTTON_RADIUS, attacks[7 - i], i));
    y += BUTTON_RADIUS + SPACING;
	}

}

void draw() {
  background(C_BG);
  drawTitle();
	for(int i = 0; i < NUM_SOUNDS; i++) {
		bs.get(i).drawButton();
	}
}


void drawTitle() {
  pushStyle();
  int x = width/4;
  int y = height/8;
  textSize(24);
  fill(C_TEXT);
  text("Listening for...", x, y);
  popStyle();
}

void aud_stopAll() {
	for(int i = 0; i < NUM_SOUNDS; i++) {
		snd[i].close();
	}
}


void mousePressed() {
  for(int i = 0; i < NUM_SOUNDS; i++) {
    if(bs.get(i).inBounds()) {
      bs.get(i).triggerSound();
    }
  }
}

void delay(float time_delay)
{
  int now = millis();
  while(millis() - now <= (time_delay * 1000));
}


