class Line {

  PVector P0, P1;

  Line (PVector myP0, PVector myP1) {
    P0 = myP0;
    P1 = myP1;
  }

  void drawit() {
    stroke(255);
    line(P0.x, P0.y, P1.x, P1.y);
  }
}

