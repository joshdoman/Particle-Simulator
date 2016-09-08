class Ball {

  PVector pos, vel;
  float diameter;

  Ball(float myX, float myY, float r) {
    pos = new PVector(myX, myY);
    vel = new PVector(random(-1*speed, speed), random(-1*speed, speed));
    diameter = r;
  }

  void render() {
    fill(255);
    noStroke();
    ellipse(pos.x, pos.y, diameter, diameter);
  }

  void update() {
    pos.add(vel);
    if (collisionOn) {
      for (int i=0; i < balls.size(); i++) {
        Ball currentBall = balls.get(i);
        if (currentBall == this) continue;
        PVector post = currentBall.pos;
        PVector velt = currentBall.vel;
        if (dist(pos.x, pos.y, post.x, post.y) < diameter) {
          PVector velnew = new PVector(vel.x, vel.y);
          vel.set(new PVector(velt.y, velt.x));
          pos.add(vel);
          currentBall.vel.set(velnew);
          currentBall.pos.add(currentBall.vel);
        }
      }
    }
    if (pos.x+diameter/2>width||pos.x-diameter/2<0) {
      vel.x *= -1;
    }
    if (pos.y+diameter/2>height||pos.y-diameter/2<0) {
      vel.y *= -1;
    }
    for (int i =0; i < lines.size(); i++) {
      Line currentLine = lines.get(i);
      PVector P0 = currentLine.P0;
      PVector P1 = currentLine.P1;
      if (pos.x>P0.x&&pos.x<P1.x||pos.x<P0.x&&pos.x>P1.x) {
        if (pos.y>P0.y&&pos.y<P1.y||pos.y<P0.y&&pos.y>P1.y) {
          if (dist(pos.x, pos.y, P0.x, P0.y)<diameter/2) {
            vel.mult(-1);
          } 
          if (dist(pos.x, pos.y, P1.x, P1.y)<diameter/2) {
            vel.mult(-1);
          }
          if (distance(pos.x, pos.y, diameter, P0.x, P0.y, P1.x, P1.y) < diameter/2) {
            vel.set(findVel(vel, P0, P1));
          }
        }
      }
    }
  }

  float distance(float px, float py, float rad, float x0, float y0, float x1, float y1) {
    float s = abs(-1*(y0-y1)*px+(x0-x1)*py+(y0*x1-x0*y1));
    float p = sqrt(sq(-1*(y0-y1))+sq((x0-x1)));
    float distance = s/p;
    return distance;
  }

  PVector findVel(PVector vel, PVector P0, PVector P1) {
    PVector normal = new PVector(P0.y-P1.y, -1*(P0.x-P1.x));
    normal.normalize();
    float dot = vel.dot(normal);
    vel.set(vel.x-2*(dot)*normal.x, vel.y-2*(dot)*normal.y);
    return vel;
  }
}