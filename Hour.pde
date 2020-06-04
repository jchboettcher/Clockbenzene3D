class Hour {
  
  Bond b1;
  Bond h1;
  Bond h2;
  Bond h3;
  Bond[] hyds = new Bond[3];
  int position;
  
  Hour() {
    b1 = new Bond(new PVector(0,radius,0), bondLen, 0, 0, 0);
    h1 = new Bond(new PVector(0,radius+bondLen,0), bondLen*hydLess, 0, -180 + 109.5, 0);
    h2 = new Bond(new PVector(0,radius+bondLen,0), bondLen*hydLess, 0, -180 + 109.5, 120);
    h3 = new Bond(new PVector(0,radius+bondLen,0), bondLen*hydLess, 0, -180 + 109.5, 240);
    hyds[0] = h1;
    hyds[1] = h2;
    hyds[2] = h3;
    this.update();
  }
  
  void showHyd(Bond h) {
    h.show();
    push();
    rotate(radians(position * 30));
    translate(h.getTip().x,h.getTip().y,h.getTip().z);
    noStroke();
    sphere(10);
    pop();
  }
  void show() {
    fill(150, 255, 100);
    b1.show();
    fill(hydColor);
    for (int i = 0; i < (showHydrogens / 2) * 3; i++) {
      showHyd(hyds[i]);
    }
  }
  
  void update() {
    position = hour() % 12;
    b1.angleZ = radians(position * 30);
    h1.angleZ = radians(position * 30);
    h1.angleAround = direction*(java.lang.System.currentTimeMillis()%(5000*60*12))*2*PI/(5000*60*12);
    h2.angleZ = radians(position * 30);
    h3.angleZ = radians(position * 30);
    h2.angleAround = direction*(java.lang.System.currentTimeMillis()%(5000*60*12))*2*PI/(5000*60*12)+2*PI/3;
    h3.angleAround = direction*(java.lang.System.currentTimeMillis()%(5000*60*12))*2*PI/(5000*60*12)+4*PI/3;
  }
  
}
