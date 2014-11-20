import ddf.minim.*; //Minim library
int NUM_SOUNDS = 8;

Minim minim; //base minim object
AudioSample snd[]; //AudioSamples are "triggered" sounds

ArrayList<Button> buttons;

void setup() {
	size(600, 400);

	minim = new Minim(this);
	snd = new AudioSample[NUM_SOUNDS];

	buttons = new ArrayList<Button>();
	int x = 0;
	int y = 0;

	for (int i = 0; i < NUM_SOUNDS; i++) {
		int extension = 200;
		snd[i] = minim.loadSample((extension + i*20) + ".wav");

		//Buttons
		buttons.add(x, y, btnWid, btnHei, 2, str(extension + i*20))
		x += width/4
		x %= width

		if (i == 3) y += (btnHei + 20);
	}
	

}

void draw() {
	background(255);
	for(int i = 0; i < NUM_SOUNDS; i++) {
		b[].draw();
	}
}


void aud_stopAll() {
	for(int i = 0; i < NUM_SOUNDS; i++) {
		snd[i].close();
	}
}


void mousePressed() {
  b.update_state(mouseX, mouseY);
}

class Button {
  float x, y; // Center of rectangle
  float w, h; // Width and height of rectangle
  float r; // Radius of edges
  String s1;
  boolean state; // true == s1, false == s2
  
  Button(float xi, float yi, float wi, float hi, float ri, String s) {
    x = xi; y = yi; 
    w = wi; h = hi; 
    r = ri;
    state = true;
    s1 = s;
  }
  
  float getX0() { return x - getW()/2; }
  float getY0() { return y - getH()/2; }
  float getW() { return w * (state ? 1 : 2/3.0); }
  float getH() { return h * (state ? 1 : 2/3.0); }
  
  void draw() {
    fill(state ? 0 : 100, state ? 0 : 150, state ? 0 : 200);
    rect(getX0(), getY0(), getW(), getH(), r);
    textAlign(CENTER,CENTER);
    fill(state ? 255 : 0);
    text(state ? s1 : s2, x, y);
  }
  
  void update_state(int mx, int my) {
    state = (abs(mx - x) < 0.5*w && abs(my - y) < 0.5*h) ? ! state : state;
  }
  
}


