class Manager {
	ArrayList<Attack> attacks;
	float x, y; 
	float w, h;
	float tab_height;

	Manager(float x_, float y_, float w_, float h_) {
		x = x_; y = y_;
		h = h_; w = w_;

		attacks = new ArrayList<Attack>();
		
		//Initialize attack folder list
		setupFolder();
	}

	void setDims(float w_, float h_) {
		w = w_;
		h = h_;
	}

	//New incident discovered, need to add it to the central program
	//intone here, also some animation as well
	void addIncident(Incident newIncident) {
		attacks.get(indexOf(newIncident.type))
			   .incidents.add(newIncident);
	}

	

	//only render an attack box if it's incident list is > 0
	void render() {
		setDims(width, height);

		tab_height = .1 * h;

		for(int i = 0; i < attacks.size(); i++) {
			Attack curr = attacks.get(i);
			if(curr.incidents.size() > 0) {
				curr.render();
			}
		}
	}


	//Layout severity hiearchy, initial positions, etc...
	void setupFolder() {
		for(int i = 0; i < NUM_ATTACK_TYPES; i++) {
			switch (i) {
				case 0:
					attacks.add(new Attack("Shell", w, tab_height, i));
					break;
				case 1: 
					attacks.add(new Attack("phpMyAdmin", w, tab_height, i));
					break;
				case 2: 
					attacks.add(new Attack("wp-admin", w, tab_height, i));
					break;
				case 3: 
					attacks.add(new Attack("admin", w, tab_height, i));
					break;
				case 4: 
					attacks.add(new Attack("/etc/", w, tab_height, i));
					break;
				case 5: 
					attacks.add(new Attack("XSS", w, tab_height, i));
					break;
				case 6: 
					attacks.add(new Attack("nmap", w, tab_height, i));
					break;
				case 7: 
					attacks.add(new Attack("http error", w, tab_height, i));
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
	
}