class Checkbox {
  int x, y, size;
  boolean b;
  String txt;
  Checkbox(int _x, int _y, String _txt, int _size){
    x = _x;
    y = _y;
    b = false;
    txt = _txt;
    size = _size;
  }
  void render(){
    pushMatrix();
    cam.beginHUD();
    //g.setMatrix(baseMat);
    translate(x,y-size);
    fill(isOver()?220:240);
    noStroke();
    rect(0, 0, size, size);
    fill(0);
    rect(0,0,size,1);
    rect(size,0,1,size);
    rect(0,size,size,1);
    rect(0,0,1,size);
    textAlign(LEFT,CENTER);
    //textSize(13);
    text(txt,size+6,size*0.45);
    if(b){
      scale(size*0.05);
      translate(0,-10);
      drawcheckmark();
    }
    cam.endHUD();
    popMatrix();
  }
  void click(){
    if(isOver()){
      b=!b;
    }
  }
  boolean isOver(){
    return(mouseX>x&&mouseX<(x+size)&&mouseY>(y-size)&&mouseY<y&&(txt != "Show all"||showHyd1.b));
  }
  void drawcheckmark() {
    noStroke();
    fill(0,230,0);
    beginShape();
    vertex(3.1799998,17.76);
    vertex(4.02,18.119999);
    vertex(4.68,18.66);
    vertex(5.3399997,19.439999);
    vertex(6.0,20.64);
    vertex(6.8399997,22.5);
    vertex(7.7999997,24.779999);
    vertex(8.58,26.64);
    vertex(8.76,27.66);
    vertex(10.0199995,26.58);
    vertex(11.46,25.68);
    vertex(12.9,22.439999);
    vertex(14.34,19.92);
    vertex(15.78,17.52);
    vertex(17.88,14.759999);
    vertex(20.1,12.179999);
    vertex(21.24,10.98);
    vertex(22.56,9.78);
    vertex(23.699999,8.76);
    vertex(25.08,7.74);
    vertex(25.92,7.2);
    vertex(27.9,4.68);
    vertex(27.24,3.72);
    vertex(25.32,5.16);
    vertex(23.039999,6.7799997);
    vertex(21.0,8.46);
    vertex(18.66,10.74);
    vertex(15.96,13.44);
    vertex(13.98,15.9);
    vertex(12.179999,18.3);
    vertex(10.679999,20.58);
    vertex(9.9,22.08);
    vertex(7.9199996,17.88);
    vertex(6.54,16.68);
    vertex(5.4,16.44);
    vertex(4.62,16.74);
    vertex(3.84,17.22);
    endShape(CLOSE);
  }
}
