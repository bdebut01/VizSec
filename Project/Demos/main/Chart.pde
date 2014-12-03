class Chart {
	float x, y; 
	float w, h;
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
	}
}