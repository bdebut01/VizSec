class Chart {
	float x, y; 
	float w, h;

	ArrayList<Bar> bars;

	int TICK_HEIGHT = 10;
	int DEFAULT_BARHEIGHT = 10;
	int FACTOR_H = 3;
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
			bars.get(i).render(attacks.get(i));
		}
	}

	void setupBars() {
		float BAR_SPACE = iWidth/5;
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
		int barHeight;

		Bar(float x_, float y_, float w_, float h_) {
			x = x_; y = y_;
			w = w_; h = h_;
		}

		void render(Attack attk) {
			if(attk.incidents.size() > 0) {
				pushStyle(); 
				rectMode(CORNERS);
				fill(attk.fillM);
				barHeight = DEFAULT_BARHEIGHT + attk.incidents.size() *
								FACTOR_H;

				rect(x,y,x+w,h-barHeight); //20 here is what to subtract by to bar height
				popStyle();
			}
			hover(attk);
		}

		void hover(Attack attk) {
			String label = attk.label;
			if(inBounds()) {
				attk.fillM = attk.C_HIGHLIGHT; //!! this only goes one direction
				renderText(mouseX, mouseY, attk);
			}
			else if(attk.fillM == attk.C_HIGHLIGHT) {	
				renderText(x, h-barHeight, attk);
			}
		}

		//Hover box with Ming's details
		void renderText(float xx, float yy, Attack attk) {
			pushStyle();
			fill(0);
			rect(xx, yy, 80, 40);
			fill(255);
			text(attk.label, xx, yy + 15);
			popStyle();	
		}

		boolean inBounds() {
			return (mouseX < x + w && mouseX > x &&
					mouseY > h - barHeight && mouseY < y);
		}
	}
}