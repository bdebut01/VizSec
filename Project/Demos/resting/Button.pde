class Button {
  float x, y; // Center of rectangle
  float w, h; // Width and height of rectangle
  float r; // Radius of edges
  String label;
  int id;
  color DEFAULTc;
  color HIGHLIGHTc;
  
  Button(float xi, float yi, float ri, String s,
          int id_) {
    x = xi; y = yi; 
    r = ri;
    label = s;
    id = id_;
    DEFAULTc = C_BUTTON;
    HIGHLIGHTc = C_HIGHLIGHT;
  }
  

  Button drawButton() {
    pushStyle();

    //Fill Mode
    color fillM = inBounds() ? HIGHLIGHTc : DEFAULTc;
    fill(fillM);

    //Button
    strokeWeight(2);
    rectMode(CORNER);
    ellipse(x, y, r, r);
    
    //Text
    textAlign(LEFT,CENTER);
    fill(C_TEXT);
    textSize(14);
    text(label, x+r, y);

    popStyle();
    return this;
  }

  boolean inBounds() {
    float d = dist(mouseX, mouseY, x, y);
    return (d < r);
  }
  
  void triggerSound() {
    snd[id].trigger();
    delay(TONE_DURATION);
    snd[id].stop();
  } 
}