class Minute {
  
  Bond b1;
  Bond b2;
  Bond h1;
  Bond h2;
  Bond h3;
  Bond h4;
  Bond h5;
  Bond[] hyds = new Bond[5];
  int position;
  
  Minute() {
    b1 = new Bond(new PVector(0,radius,0), bondLen, 0, 0, 0);
    b2 = new Bond(new PVector(0,radius+bondLen,0), bondLen, 0, -180 + 109.5, 0);
    h1 = new Bond(new PVector(0,radius+bondLen,0), bondLen*hydLess, 0, -180 + 109.5, 120);
    h2 = new Bond(new PVector(0,radius+bondLen,0), bondLen*hydLess, 0, -180 + 109.5, 240);
    h3 = new Bond(b2.getTip(), bondLen*hydLess, 0, -109.5, 60);
    h4 = new Bond(b2.getTip(), bondLen*hydLess, 0, -109.5, -60);
    h5 = new Bond(b2.getTip(), bondLen*hydLess, 0, 0, 0);
    hyds[0] = h1;
    hyds[1] = h2;
    hyds[2] = h3;
    hyds[3] = h4;
    hyds[4] = h5;
    this.update();
  }
  
  void showNums() {
    PVector pos = b2.getTip();
    float rad = (float)(diskLess*2*Math.sqrt(pos.x*pos.x+pos.z*pos.z));
    push();
    rotate(b2.angleZ);
    translate(0,pos.y,0);
    rotateX(radians(-90));
    int[] colors = {
      color(255,100,100,50),
      color(255,255,100,50),
      color(100,255,100,50),
      color(100,100,255,50),
      color(255,100,255,50)
    };
    rotateZ(direction*PI/5);
    textSize(20);
    textAlign(CENTER, BOTTOM);
    for (int i = 0; i < 5; i++) {
      fill(colors[i]);
      noStroke();
      arc(0,0,rad,rad,-PI/5,PI/5,PIE);
      push();
      stroke(0,150);
      strokeWeight(2);
      fill(0);
      translate(0,0,0.5);
      rotateZ(radians(90));
      text(i,0,-15);
      pop();
      rotateZ(direction*2*PI/5);
    }
    pop();
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
    fill(100, 100, 255);
    b1.show();
    b2.show();
    fill(hydColor);
    for (int i = 0; i < 2*showHydrogens + (showHydrogens / 2); i++) {
      showHyd(hyds[i]);
    }
    if (showDisks.b) {
      this.showNums();
    }
  }
  
  void update() {
    position = minute() / 5;
    b1.angleZ = radians(position * 30);
    b2.angleZ = radians(position * 30);
    b2.angleAround = direction*(java.lang.System.currentTimeMillis()%(5000*60))*2*PI/(5000*60);
    h1.angleZ = radians(position * 30);
    h2.angleZ = radians(position * 30);
    h1.angleAround = direction*(java.lang.System.currentTimeMillis()%(5000*60))*2*PI/(5000*60)+2*PI/3;
    h2.angleAround = direction*(java.lang.System.currentTimeMillis()%(5000*60))*2*PI/(5000*60)+4*PI/3;
    h3.start = b2.getTip();
    h4.start = b2.getTip();
    h5.start = b2.getTip();
    h3.angleZ = radians(position * 30);
    h4.angleZ = radians(position * 30);
    h5.angleZ = radians(position * 30);
    h3.angleAround = direction*(java.lang.System.currentTimeMillis()%(5000*60))*2*PI/(5000*60)+PI/3;
    h4.angleAround = direction*(java.lang.System.currentTimeMillis()%(5000*60))*2*PI/(5000*60)-PI/3;
  }
  
}
