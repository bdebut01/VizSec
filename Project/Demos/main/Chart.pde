class Chart {
	float x, y; 
	float w, h;

	int TICK_HEIGHT = 10;

	Chart(float x_, float y_, float w_, float h_) {
		x = x_; y = y_;
		h = h_; w = w_;
	}

	void render() {
		axis();
	}

	void axis() {
		line(x, y+h, x+w, y+h);	//x
		line(x, y+h, x, y);		//y

		//intervals
		//x-axis
		float iWidth = w / 8;
		for(int i = 1; i < 9; i++) {
			line(x+iWidth*i, y+h, x+iWidth*i, y+h+TICK_HEIGHT);
		}
	}
}