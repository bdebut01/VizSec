class Attack {
	ArrayList<Incident> incidents;

	String label;
	int severity;
	float x, y;
	float w, h;
	color C_DEFAULT, C_HIGHLIGHT;
	color C_INACTIVE;
	int SPACING_LABELX = 8;

	Attack(String label_, float w_, float h_, int severity_, float x_) {
		label = label_; 
		w = w_; h = h_;
		severity = severity_;
		x = x_;

		//Severity dependent variables
		y = (severity + 1) * h; //this is gross, like super
		C_DEFAULT = color(200 - 10 * severity, 150, 150);
		C_HIGHLIGHT = color(250 - 10 * severity, 150, 150);
		C_INACTIVE = color(200 - 10 * severity, 150, 150, 70);
		
		incidents = new ArrayList<Incident>();
	}

	Attack addIncident(Incident newIncident) {
		incidents.add(newIncident);
		return this;
	}

	//If incidents.size() is 0, draw faded
	Attack render(float w_, float h_) {
		setDims(w_, h_);

		pushStyle();
		
		//Fill Mode
		color fillM;
		if(incidents.size() > 0) //Don't color fully if no attacks detected
    		fillM = inBounds() ? C_HIGHLIGHT : C_DEFAULT;
    	else fillM = C_INACTIVE;

    	fill(fillM);
		stroke(1);
		rect(x, y, w, h);

		fill(0);
		//textAlign();
		text(label, x + SPACING_LABELX, y+(h * .5));
		popStyle();
		//label
		//severity level
		return this;
	}
	
	void setDims(float w_, float h_) {
		w = w_;
		h = h_;
	}

	//Think I want this function to be called when label is clicked.
	//Box will expand to include the attack's incidents and deets
	Attack expand() {
		return this;
	}

	boolean inBounds() {
		return (mouseX < x + w && mouseX > x &&
				mouseY < y + h && mouseY > y);
	}

}