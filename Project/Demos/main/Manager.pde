class Manager {
	float x, y; 
	float w, h;
	float tab_height;

	//ArrayList<Attack> attacks; //global attacks list

	Chart viz;
	int CHART_SPACE_LEFTX = 25;
	int CHART_SPACE_RIGHTX = 25;
	int CHART_EXTRA = 0;

	Flag flag;
	float flagStart;
	boolean isFlag;
	float FLAG_DURATION = 10;
	int index_Expanded;

	Manager(float x_, float y_, float w_, float h_) {
		x = x_; y = y_;
		h = h_; w = w_;

		attacks = new ArrayList<Attack>();
		index_Expanded = -1;

		//Initialize attack folder list
		tab_height = .1 * h;
		setupFolder();

		viz = new Chart(x+w+CHART_SPACE_LEFTX, tab_height, 
					    width - w - CHART_SPACE_RIGHTX - x - 
					    CHART_SPACE_LEFTX - CHART_EXTRA,
					    tab_height*8);
	}

	void setDims(float w_, float h_) {
		w = w_;
		h = h_;
	}

	//New incident discovered, need to add it to the central program
	//intone here, also some animation as well
	void addIncident(Incident newIncident) {
		attacks.get(indexOf(newIncident.type))
			   .addIncident(newIncident);

		alertFlag(newIncident.type);
	}

	void alertFlag(String label) {
		flagStart = TIME;
		isFlag = true;
		flag = new Flag(label);
	}

	void render(float w_, float h_) {
		setDims(w_, h_);
		tab_height = .1 * h;

		for(int i = 0; i < attacks.size(); i++) {
			attacks.get(i).render(w, tab_height);
		}

		if(isFlag) {
			flag.render();
		}

		viz.render();

	}

	void click() {
		for(int i = 0; i < attacks.size(); i++) {
			Attack n = attacks.get(i);
			if(n.isActive && n.inBounds()) {
				if(index_Expanded == -1) {
					n.expand();
					index_Expanded = i;
				} else {
					attacks.get(i).retract();
					n.expand();
					index_Expanded = i;
				}	 
			}
		}
	}

	//Layout severity hiearchy, initial positions, etc...
	void setupFolder() {
		for(int i = 0; i < NUM_ATTACK_TYPES; i++) {
			switch (i) {
				case 0:
					attacks.add(new Attack("Shell", w, tab_height, i, x));
					break;
				case 1: 
					attacks.add(new Attack("phpMyAdmin", w, tab_height, i, x));
					break;
				case 2: 
					attacks.add(new Attack("wp-admin", w, tab_height, i, x));
					break;
				case 3: 
					attacks.add(new Attack("admin", w, tab_height, i, x));
					break;
				case 4: 
					attacks.add(new Attack("/etc/", w, tab_height, i, x));
					break;
				case 5: 
					attacks.add(new Attack("XSS", w, tab_height, i, x));
					break;
				case 6: 
					attacks.add(new Attack("nmap", w, tab_height, i, x));
					break;
				case 7: 
					attacks.add(new Attack("http error", w, tab_height, i, x));
					break;				
			}
		}
	}

	//Passed attack type, returns index of that type in the attack list 
	int indexOf(String type) {
		if(type.equals("Shell")) return 0;
		if(type.equals("phpMyAdmin")) return 1;
		if(type.equals("wp-admin")) return 2;
		if(type.equals("admin")) return 3;
		if(type.equals("/etc/")) return 4;
		if(type.equals("XSS")) return 5;
		if(type.equals("nmap")) return 6;
		if(type.equals("http error")) return 7;
		else {
			println("INDEX FAIL!");
			return 0;
		}
	}	

	class Flag {
		String label;
		Flag(String label_) {
			label = label_;
		}

		void render() {
			pushStyle();
			int x = width - 200;
			int y = 10;
			pushStyle();
			fill(250, 150, 150);
			noStroke();
			rect(x, y, 190, tab_height/2);

			fill(0);
			textAlign(LEFT, TOP);
			text(("New " + label + " attack!"), x + 8, y*2);
			popStyle();

			fill(255, 255,255, 100 - (flagStart+FLAG_DURATION - TIME));
			noStroke();
			rect(x, y, 190, tab_height/2);
			popStyle();
		}
	}
}