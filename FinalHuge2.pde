ArrayList<Ball>balls = new ArrayList<Ball>();
ArrayList<Line> lines = new ArrayList<Line>();
ArrayList<Points> point = new ArrayList<Points>();

int s;
float speed;
float r;
boolean paused;
boolean collisionOn;
float start;
float size;
float begin;
float positionx;
float positiony;
float restart;

void setup () {
  size(400, 400);

  //ball stuff below
  speed = 1.5;       //speed limit
  //initial position
  positionx=random(r+10, width-r-10);
  positiony=random(r+10, height-r-10);


  for (int i =0; i<2; i++) {
    Points p = new Points(new PVector(30, 30), new PVector(50, 50));
    point.add(p);
  }
  s = 2;
  paused = false;
  start = 0;
  size = 0;
  begin = 0;
  r=2;
  restart=0;
  collisionOn=false;
}

void draw() {
  background(0); 
  if (start == 0) {
    surface.setResizable(true);
    String sizenew = nf(size, 1, 0);
    fill(200);
    noStroke();
    rect(width/10, height/10, 4*width/5, 4*height/5);
    textSize(25*width/400);
    fill(0);
    text("Number of Balls", 1.3*width/5, height/5);
    textSize(55*width/400);
    text(sizenew, 1.6*width/5, 3*height/5);
    textSize(15*width/400);
    text("Press enter to done", 1.6*width/5, 4*height/5);
    text("Press UP arrow to increase", 1.2*width/5, 1.5*height/5);
    text("Press DOWN arrow to decrease", 1.2*width/5, 1.9*height/5);
  }
  if (start == 1) {
    surface.setResizable(true);
    String rnew = nf(r, 1, 0);
    noStroke();
    fill(200);
    rect(width/10, height/10, 4*width/5, 4*height/5);
    textSize(25*width/400);
    fill(0);
    text("Size of Ball", 1.7*width/5, height/5);
    textSize(55*width/400);
    text(rnew, 1.6*width/5, 3*height/5);
    textSize(30*width/400);
    text("pixels", 2.6*width/5, 3*height/5);
    textSize(15*width/400);
    text("Press enter to done", 1.6*width/5, 4*height/5);
    text("Press UP arrow to increase", 1.2*width/5, 1.5*height/5);
    text("Press DOWN arrow to decrease", 1.2*width/5, 1.9*height/5);
  }
  if (start == 2) {
    surface.setResizable(true);
    noStroke();
    fill(200);
    rect(width/10, height/10, 4*width/5, 4*height/5);
    textSize(30*width/400);
    fill(0);
    text("Controls", 1.8*width/5, height/5);
    textSize(15*width/400);
    text("1) Press backspace to delete a line", 1.02*width/5, 1.4*height/5);
    text("2) Press enter to pause", 1.02*width/5, 1.7*height/5);
    text("3) Press spacebar to create a ball", 1.02*width/5, 2*height/5);
    text("4) Press shift to turn ball-on-ball", 1.02*width/5, 2.3*height/5);
    text("collision on/off", 1.02*width/5, 2.55*height/5);
    text("5) Click to add an endpoint of a line", 1.02*width/5, 2.8*height/5);
    text("6) Click a second time to add the", 1.02*width/5, 3.1*height/5);
    text("other endpoint", 1.02*width/5, 3.35*height/5);
    text("7) To restart, press r", 1.02*width/5, 3.6*height/5);
    text("Press enter to begin", 1.6*width/5, 4.15*height/5);
    if (begin == 0) {
      for (int i =0; i < size; i++) {
        Ball b = new Ball(positionx, positiony, r);
        balls.add(b);
        begin+=1;
      }
    }
  } 
  if (start>2) {
    surface.setResizable(false);

    //collision on?
    fill(255);
    if (collisionOn) {
      textSize(10);
      text("Collisions: ON", 10, 10);
    } else {
      textSize(10);
      text("Collisions: OFF", 10, 10);
    }

    //cursor
    noCursor();
    stroke(255);
    fill(0);
    ellipse(mouseX, mouseY, 15, 15);
    line(mouseX+10, mouseY, mouseX-10, mouseY);
    line(mouseX, mouseY+10, mouseX, mouseY-10);
    if (s%2==0) {
      if (point.size()>0) {
        for (int i=0;i< point.size();i=i+2) {
          Points currentPoints = point.get(i);
          PVector P0 = currentPoints.P0;
          PVector P1 = currentPoints.P1;
          PVector pos = new PVector(mouseX, mouseY);
          float d1 = dist(P0.x, P0.y, pos.x, pos.y);
          float d2 = dist(P1.x, P1.y, pos.x, pos.y);
          if (d1<10||d2<10) {
            fill(240, 30, 19);
            ellipse(mouseX, mouseY, 15, 15);
            line(mouseX+10, mouseY, mouseX-10, mouseY);
            line(mouseX, mouseY+10, mouseX, mouseY-10);
          }
        }
      }
    }

    for (int i =0; i < balls.size();i++) {
      Ball currentBall = balls.get(i);
      if (!paused) {
        currentBall.update();
      }
      currentBall.render();
    }

    for (int l =0; l <lines.size();l++) {
      Line currentLine = lines.get(l);
      currentLine.drawit();
    }
    if (s%2==1) {
      Points currentPoints = point.get(s-1);
      PVector P0 = currentPoints.P0;
      PVector P1 = currentPoints.P1;
      makeline2(P0, P1);
    }
  }
  if (restart == 1) {
    s = 2;
    paused = false;
    start = 0;
    size = 0;
    begin = 0;
    r=2;
    collisionOn = false;
    positionx=random(r+10, width-r-10);
    positiony=random(r+10, height-r-10);
    restart=0;
    lines.clear();
    balls.clear();
    point.clear();
    for (int i =0; i<2; i++) {
      Points p = new Points(new PVector(30, 30), new PVector(50, 50));
      point.add(p);
    }
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    start+=1;
  }
  if (start == 0) {
    if (size<10) {
      if (keyCode == UP) {
        size+=1;
      }
      if (keyCode == DOWN) {
        if (size>0) {
          size-=1;
        }
      }
    }
    else if (size>=10&&size<50) {
      if (keyCode == UP) {
        size+=5;
      }
      if (keyCode == DOWN) {
        if (size>0) {
          size-=5;
        }
      }
    }
    else if (size>=50&&size<100) {
      if (keyCode == UP) {
        size+=10;
      }
      if (keyCode == DOWN) {
        if (size>0) {
          size-=10;
        }
      }
    }
    else if (size>=100) {
      if (size<5000) {
        if (keyCode == UP) {
          size+=100;
        }
      }
      if (keyCode == DOWN) {
        if (size>0) {
          size-=100;
        }
      }
    }
  }
  if (start == 1) {
    if (keyCode == UP) {
      if (r<30) {
        r+=1;
      }
    }
    if (keyCode == DOWN) {
      if (r>2) {
        r-=1;
      }
    }
  }
  if (start>1) {
    if (keyCode == BACKSPACE) {
      if (s%2==0) {
        for (int i=2;i< point.size();i=i+2) {
          Points currentPoints = point.get(i);
          PVector P0 = currentPoints.P0;
          PVector P1 = currentPoints.P1;
          PVector pos = new PVector(mouseX, mouseY);
          float d1 = dist(P0.x, P0.y, pos.x, pos.y);
          float d2 = dist(P1.x, P1.y, pos.x, pos.y);
          if (d1<10||d2<10) {
            lines.remove(i/2-1);
            point.remove(i);
            point.remove(i-1);
            s=s-2;
          }
        }
      }
    } 
    if (key == ' ') {
      balls.add(new Ball(mouseX, mouseY, r));
    }
    if (keyCode == ENTER) {
      paused = !paused;
    }
    if (keyCode == SHIFT) {
      collisionOn = !collisionOn;
    }
    if (key == 'r') {
      restart=1;
    }
  }
}

void mousePressed() {
  if (start>2) {
    s +=1; 
    if (s%2==1) {
      makeline(new PVector(30, 30), new PVector(300, 300));
    }
    if (s%2==0) {
      Points currentPoints = point.get(s-2);
      PVector P0 = currentPoints.P0;
      PVector P1 = currentPoints.P1;
      makeline(P0, P1);
    }
  }
}

void makeline(PVector P0, PVector P1) {
  if (s%2==0) {
    P1.set(mouseX, mouseY);
  }
  if (s%2==1) {
    P0.set(mouseX, mouseY);
  }
  if (s%2==0) {
    Line a = new Line (P0, P1);
    lines.add(a);
  }
  Points c = new Points(P0, P1);
  point.add(c);
}

void makeline2(PVector P0, PVector P1) {
  P1.set(mouseX, mouseY);
  stroke(255);
  line(P0.x, P0.y, P1.x, P1.y);
}