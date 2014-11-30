class Attack {
	ArrayList<Incident> incidents;

	String label;
	int severity;
	int x, y;
	int w, h;

	Attack(String label_, int w_, int h_, int severity_) {
		label = label_; 
		w = w_; h = h_;
		severity = severity_;
	}

	Attack addIncident(Incident newIncident) {
		incidents.add(newIncident);
		return this;
	}

	Attack render() {
		rect(x, y, w, h);
		//label
		//severity level
		return this;
	}
	

	//Think I want this function to be called when label is clicked.
	//Box will expand to include the attack's incidents and deets
	Attack expand() {
		return this;
	}

}