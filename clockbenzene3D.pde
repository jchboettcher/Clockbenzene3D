import peasy.*;

PeasyCam cam;
float angle;
int tubeRes = 200;
float[] tubeX = new float[tubeRes];
float[] tubeY = new float[tubeRes];
//Bond b;
PMatrix3D baseMat;
float bondRad = 4;
Bond[] benzene = new Bond[18];
Bond[] hydrogens = new Bond[12];
float bondLen = 100;
boolean switcher = false;
int currsec = 0;
int startMills;
float radius = (float)(Math.sqrt(6)+Math.sqrt(2))*0.5*bondLen;
int direction;
Second secondHand;
Minute minuteHand;
Hour hourHand;
Checkbox showDisks;
Checkbox animate;
Checkbox showHyd1;
Checkbox showHyd2;
//Checkbox[] boxes = new Checkbox[2];
int benzeneColor = 100;
int hydColor = 255;
int showHydrogens = 1; // 0 = no, 1 = only essential, 2 = all
float hydLess = 0.7;
float diskLess = 0.929;
int last;
boolean resetting = false;


void setup() {
  currsec = second();
  while (currsec == second()) {
    startMills = millis();
  }
  // java.lang.System.currentTimeMillis()
  size(600, 600, P3D);
  baseMat = g.getMatrix(baseMat);
  cam = new PeasyCam(this, 600);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(3000);
  cam.setResetOnDoubleClick(false);
  float angle = 370.0 / tubeRes;
  for (int i = 0; i < tubeRes; i++) {
    tubeX[i] = cos(radians(i * angle));
    tubeY[i] = sin(radians(i * angle));
  }
  //b = new Bond(new PVector(0,0,0), 100, 180, 0, 0, 0);
  secondHand = new Second();
  minuteHand = new Minute();
  hourHand = new Hour();
  createBenzene();
  createHyds();
  showDisks = new Checkbox(10,height-40, "Show disks",20);
  animate = new Checkbox(10,height-70, "Animate",20);
  showHyd1 = new Checkbox(10,height-10, "Show Hydrogens",20);
  showHyd2 = new Checkbox(140,height-10, "Show all",20);
  showHyd1.b = true;
  //boxes[0] = new Checkbox(10,height-30);
  //boxes[1] = new Checkbox(40,height-30);
  angle = 0;
  last = millis()-500;
}

void mousePressed(){
  //for(int i=0; i< boxes.length; i++){
  //  boxes[i].click();
  //}
  showDisks.click();
  animate.click();
  showHyd1.click();
  showHyd2.click();
  if (millis() - last < 300) {
    resetting = true;
    cam.reset();
    animate.b = false;
  }
  //System.out.print(mouseX);
  //System.out.print(", ");
  //System.out.println(mouseY);
  last = millis();
}

//void keyPressed() {
//  if (key == ' ') {
//    showHydrogens = (showHydrogens + 1) % 3;
//  }
//}

void createBenzene() {
  for (int i = 0; i < 12; i++) {
    benzene[i] = new Bond(new PVector(0,radius,0),
      bondLen,30*i,105,0);
  }
  float less = (float)(1-7.5*bondRad/(2+Math.sqrt(3))/bondLen);
  for (int i = 0; i < 6; i++) {
    benzene[i+12] = new Bond(new PVector(0,radius*less,0),
      bondLen*less,60*i,105,0);
  }
}

void createHyds() {
  for (int i = 0; i < 12; i++) {
    hydrogens[i] = new Bond(new PVector(0,radius,0),
      bondLen*hydLess, 30*i, 0, 0);
  }
}

void drawBenzene() {
  fill(benzeneColor);
  push();
  if (random(1) > 0.98) {
    switcher = !switcher;
  }
  if (switcher) {
    rotateZ(radians(30));
  }
  for (int i = 0; i < 18; i++) {
    benzene[i].show();
  }
  pop();
}

void drawHyds() {
  fill(hydColor);
  int no1 = hour() % 12;
  int no2 = minute() / 5;
  int no3 = second() / 5;
  for (int i = 0; i < 12; i++) {
    if (i != no1 && i != no2 && i != no3) {
      hydrogens[i].show();
      push();
      rotate(radians(i * 30));
      translate(hydrogens[i].getTip().x,hydrogens[i].getTip().y,hydrogens[i].getTip().z);
      noStroke();
      sphere(10);
      pop();
    }
  }
}

void draw() {
  background(245);
  rotateZ(radians(180));
  rotateY(angle);
  if (animate.b) {
    angle = (angle + 0.01) % (2*PI);
  } else if (resetting) {
    if (angle > PI) {
      if (angle < 2*PI - 0.1) {
        angle += 0.1;
      } else {
        angle = 0;
        resetting = false;
      }
    } else {
      if (angle > 0.1) {
        angle -= 0.1;
      } else {
        angle = 0;
        resetting = false;
      }
    }
  }
  if (showHyd1.b) {
    if (showHyd2.b) {
      showHydrogens = 2;
    } else {
      showHydrogens = 1;
    }
  } else {
    showHydrogens = 0;
  }
  if (hour() < 12) {
    direction = 1;
  } else {
    direction = -1;
  }
  scale(0.7);
  stroke(0);
  strokeWeight(1);
  fill(255);
  strokeWeight(1);
  pushMatrix();
  g.setMatrix(baseMat);
  directionalLight(210, 210, 210, 100, 150, -100);
  ambientLight(120, 120, 120);
  popMatrix();
  drawBenzene();
  if (showHydrogens == 2) {
    drawHyds();
  }
  secondHand.show();
  secondHand.update();
  minuteHand.show();
  minuteHand.update();
  hourHand.show();
  hourHand.update();
  showDisks.render();
  animate.render();
  showHyd1.render();
  if (showHyd1.b) {
    showHyd2.render();
  }
}
