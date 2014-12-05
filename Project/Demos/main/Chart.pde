class Chart {
	float x, y; 
	float w, h;

	ArrayList<Bar> bars;

	int TICK_HEIGHT = 10;
	int DEFAULT_BARHEIGHT = 10;
	int FACTOR_H = 3;

	int TEXTBOX_HEIGHT = 120;
	int TEXTBOX_WIDTH = 100;
	int TEXT_SPACING = 5;
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
		for(int i = 0; i < NUM_ATTACK_TYPES; i++) {
			bars.get(i).hover (attacks.get(i));
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

		//y-axis
	}

	class Bar {
		float x, y; 
		float w, h;
		float barHeight;

		Bar(float x_, float y_, float w_, float h_) {
			x = x_; y = y_;
			w = w_; h = h_;
		}

		void render(Attack attk) {
			int num_incidents = attk.incidents.size();
			if(num_incidents > 0) {
				pushStyle(); 
				rectMode(CORNERS);
				fill(attk.fillM);
				barHeight = DEFAULT_BARHEIGHT + attk.incidents.size() *
								FACTOR_H;

				rect(x,y,x+w,h-barHeight);
				fill(0);
				textAlign(CENTER);
				text(num_incidents, x+w/2, h-barHeight-2);
				popStyle();

			} else  {
				//num of incidents label
				pushStyle();
				fill(0);
				textAlign(CENTER);
				text(num_incidents, x+iWidth/2-iWidth/5, y - 2);
				popStyle();
			}
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
			fill(255,255,255,85);
			stroke(1);
			rect(xx, yy, TEXTBOX_WIDTH, TEXTBOX_HEIGHT);
			fill(0);
			//just the most recent incident
		    Incident ii = attk.incidents.get(attk.incidents.size()-1);
			String label2 = "Type: " + attk.label 			+ '\n' +
							"IP: " 	 + ii.ip 	  			+ '\n' + 
							"Time stamp: " + ii.time_stamp  + '\n' +
							"Status: " + ii.req_status;
			textSize(10);
			text(label2, xx+TEXT_SPACING, yy+TEXT_SPACING, 
				 TEXTBOX_WIDTH - TEXT_SPACING, TEXTBOX_HEIGHT - TEXT_SPACING);
			popStyle();	
		}

		boolean inBounds() {
			return (mouseX < x + w && mouseX > x &&
					mouseY > h - barHeight && mouseY < y);
		}
	}
}