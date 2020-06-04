class Bond {
  PVector start;
  float len;
  float angleZ;
  float angleFromVert;
  float angleAround;
  
  Bond(PVector start, float len, float angleZ, float angleFromVert, float angleAround) {
    this.start = start;
    this.len = len;
    this.angleZ = radians(angleZ);
    this.angleFromVert = radians(angleFromVert);
    this.angleAround = radians(angleAround);
    // + rotation is clockwise
  }
  
  PVector getTip() {
    float newY = this.len * cos(this.angleFromVert);
    float newX = -this.len * sin(this.angleFromVert) * cos(this.angleAround);
    float newZ = this.len * sin(this.angleFromVert) * sin(this.angleAround);
    PVector addition = new PVector(newX,newY,newZ);
    PVector hi = new PVector(this.start.x, this.start.y, this.start.z);
    return hi.add(addition);
  }
  
  void show() {
    push();
    noStroke();
    rotateZ(angleZ);
    translate(start.x, start.y, start.z);
    rotateY(angleAround);
    rotateZ(angleFromVert);
    beginShape(QUAD_STRIP);
    for (int i = 0; i < tubeRes; i++) {
      float x = tubeX[i] * bondRad;
      float z = tubeY[i] * bondRad;
      vertex(x, 0, z);
      vertex(x, this.len, z);
    }
    endShape(CLOSE);
    sphere(bondRad);
    translate(0,this.len,0);
    sphere(bondRad);
    
    pop();
  }
}
