class Attack {
	ArrayList<Incident> incidents;

	String label;
	int severity;
	float x, y;
	float w, h;
	color C_DEFAULT, C_HIGHLIGHT;
	color C_INACTIVE;
	int SPACING_LABELX = 8;
	boolean isActive;
	boolean isClicked;
	color fillM;

	//Instead of a private clip, cause that pissed of Processing,
	//the severity integer dictates which tone from the array to intonate.
	//Therefore you'll see references to snd[severity]

	float ANIMATE_START;

	Attack(String label_, float w_, float h_, int severity_, float x_) {
		label = label_; 
		w = w_; h = h_;
		severity = severity_;
		x = x_;

		isActive = false;
		isClicked = false;
		ANIMATE_START = -1;

		//Severity dependent variables
		y = (severity + 1) * h; //this is gross, like super
		C_DEFAULT = colorFinder(severity_, 0);
		C_HIGHLIGHT = colorFinder(severity_, 2); //make 3rd state for highlight
		C_INACTIVE = colorFinder(severity_, 1);
		
		incidents = new ArrayList<Incident>();
	}

	Attack addIncident(Incident newIncident) {
		incidents.add(newIncident);
		isActive = true;

		//Trigger sound
		boolean trash = isSmart ? triggerSmart() : triggerStupid();

		return this;
	}

	boolean triggerStupid() {
		println("Dumb!");
		return false;
	}

	boolean triggerSmart() {
		println("Smart trigger!");
		return false;
	}

	//If incidents.size() is 0, draw faded
	Attack render(float w_, float h_) {
		setDims(w_, h_);

		pushStyle();
		
		//Fill Mode
		if(incidents.size() > 0) //Don't color fully if no attacks detected
    		fillM = inBounds() ? C_HIGHLIGHT : C_DEFAULT;
    	else fillM = C_INACTIVE;

    	fill(fillM);
		stroke(1);
		rect(x, y, w, h);

		fill(0);
		text(label, x + SPACING_LABELX, y+(h * .5));
		popStyle();

		if(isClicked) {
			expand();
		}	
		return this;
	}
	
	void setDims(float w_, float h_) {
		w = w_;
		h = h_;
	}

	//Think I want this function to be called when label is clicked.
	//Box will expand to include the attack's incidents and deets
	Attack expand() {
		isClicked = true;
		return this;
	}

	Attack retract() {
		isClicked = false;
		return this;
	}

	boolean inBounds() {
		return (mouseX < x + w && mouseX > x &&
				mouseY < y + h && mouseY > y);
	}


	color colorFinder(int sev, int mode) {
		color answer = color(0, 0, 0);
		if(mode == 0) { //default
			switch (sev) {
				case 0: answer = color(228,26,28); break;
				case 1: answer = color(55,126,184); break;
				case 2: answer = color(77,175,74); break;
				case 3: answer = color(152,78,163); break;
				case 4: answer = color(255,127,0); break;
				case 5: answer = color(255,255,51); break;
				case 6: answer = color(166,86,40); break;
				case 7: answer = color(247,129,191); break;
			}
		} else if(mode == 1) { //inactive
			switch (sev) {
				case 0: answer = color(228,26,28,50); break;
				case 1: answer = color(55,126,184,50); break;
				case 2: answer = color(77,175,74,50); break;
				case 3: answer = color(152,78,163,50); break;
				case 4: answer = color(255,127,0,50); break;
				case 5: answer = color(255,255,51,50); break;
				case 6: answer = color(166,86,40,50); break;
				case 7: answer = color(247,129,191,50); break;
			}
		} else {
			switch (sev) { //highlight
				case 0: answer = color(248,26,28); break;
				case 1: answer = color(55,126,204); break;
				case 2: answer = color(77,195,74); break;
				case 3: answer = color(162,78,173); break;
				case 4: answer = color(255,147,0); break;
				case 5: answer = color(255,255,71); break;
				case 6: answer = color(186,86,40); break;
				case 7: answer = color(255,139,191); break;
			}
		}
		return answer;
	}
}