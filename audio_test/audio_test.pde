import ddf.minim.*; //Minim library
int NUM_SOUNDS = 8;
float TONE_DURATION = .8; //in seconds

Minim minim; //base minim object
AudioSample snd[]; //AudioSamples are "triggered" sounds


ArrayList<Button> bs;

void setup() {
	size(600, 400);

	minim = new Minim(this);
	snd = new AudioSample[NUM_SOUNDS];

	bs = new ArrayList<Button>();
	int x = 20;
	int y = 20;

	for (int i = 0; i < NUM_SOUNDS; i++) {
		int extension = 200;
		//println ((extension + i*20) + ".wav");
		snd[i] = minim.loadSample((extension + i*20) + ".wav");

		//Buttons
		bs.add(new Button(x, y, width/10, height/10, 2, str(extension + i*20), i));
		x += width/4 + 10;
		x %= width + 40;

		if (i == 3) y = height/5;
	}

}

void draw() {
	background(255);
	for(int i = 0; i < NUM_SOUNDS; i++) {
		bs.get(i).drawButton();
	}
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

class Button {
  float x, y; // Center of rectangle
  float w, h; // Width and height of rectangle
  float r; // Radius of edges
  String s1;
  int id;
  color DEFAULTc;
  color HIGHLIGHTc;
  
  Button(float xi, float yi, float wi, float hi, float ri, String s,
          int id_) {
    x = xi; y = yi; 
    w = wi; h = hi; 
    r = ri;
    s1 = s;
    id = id_;
    DEFAULTc = color(100, 150, 100);
    HIGHLIGHTc = color(155, 200, 90);
  }
  

  Button drawButton() {
    pushStyle();

    //Fill Mode
    color fillM = inBounds() ? HIGHLIGHTc : DEFAULTc;
    fill(fillM);

    //Button
    strokeWeight(2);
    rectMode(CORNER);
    rect(x, y, w, h, r);
    
    //Text
    textAlign(LEFT,BOTTOM);
    fill(0);
    text(s1, x, y);

    popStyle();
    return this;
  }

  boolean inBounds() {
    return (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y+h));
  }
  
  void triggerSound() {
    snd[id].trigger();
    delay(TONE_DURATION);
    snd[id].stop();
  }
  
}


