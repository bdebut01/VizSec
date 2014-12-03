class Chart {
	float x, y; 
	float w, h;

	ArrayList<Bar> bars;

	int TICK_HEIGHT = 10;
	float iWidth; //ie intervalWidthX 

	Chart(float x_, float y_, float w_, float h_) {
		x = x_; y = y_;
		h = h_; w = w_;
		bars = new ArrayList<Bar>();

		iWidth = w / NUM_ATTACK_TYPES;
		
		setupBars();
	}

	void render() {
		axis();
		for(int i = 0; i < NUM_ATTACK_TYPES; i++) {
			bars.get(i).render();
		}
	}

	void setupBars() {
		float BAR_SPACE = iWidth/8;
		for(int i = 0; i < NUM_ATTACK_TYPES; i++) {
			bars.add(new Bar(x+iWidth*i + BAR_SPACE, y+h,
							 iWidth - BAR_SPACE*2, y+h));
		}
	}

	void axis() {
		line(x, y+h, x+w, y+h);	//x
		line(x, y+h, x, y);		//y

		//intervals
		//x-axis
		for(int i = 1; i < NUM_ATTACK_TYPES+1; i++) {
			line(x+iWidth*i, y+h, x+iWidth*i, y+h+TICK_HEIGHT);
		}
	}

	class Bar {
		float x, y; 
		float w, h;
		int sev;

		Bar(float x_, float y_, float w_, float h_, int sev) {
			x = x_; y = y_;
			w = w_; h = h_;
		}

		void render() {
			pushStyle();
			rectMode(CORNERS);
			rect(x,y,x+w,h-20); //20 here is what to subtract by to bar height
			popStyle();
		}
	}
}