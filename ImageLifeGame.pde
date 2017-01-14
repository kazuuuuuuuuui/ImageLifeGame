boolean[][] now;
boolean[][] next;

int w, h;

void setup() 
{
  size(500, 500, P3D);

  frameRate(4);

  w = width /20;
  h = height /20;

  now = new boolean[w][h];
  next = new boolean[w][h];

  for (int i = 0; i< w; i++) {
    for (int j = 0; j< h; j++) {
      now[i][j] = random(0, 1) < 0.2;
    }
  }
}

void simulate()
{
  for (int i = 0; i < now.length; i++) {
    for (int j = 0; j < now[i].length; j++) {
      int up = (j-1+now[i].length) % now[i].length;
      int down = (j+1+now[i].length) % now[i].length;
      int left = (i-1+now.length) % now.length;
      int right = (i+1) % now.length;

      int count = 0;
      if (now[left][j])count++;
      if (now[left][up])count++;
      if (now[i][up])count++;
      if (now[right][up])count++;
      if (now[right][j])count++;
      if (now[right][down])count++;
      if (now[i][down])count++;
      if (now[left][down])count++;

      if (now[i][j] && (count == 2 || count == 3)) {
        next[i][j]= true;
      } else if (now[i][j] ==false && count == 3) {
        next[i][j]=true;
      } else {
        next[i][j] = false;
      }
    }
  }
}

void draw()
{
  background(0);
  lights();

  int aaa = 270;

  beginCamera();
  camera(
    width/2.0+aaa, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0)*6, 
    width/2.0+aaa, height/2.0, 0, 
    0, 1, 0);
  rotateX(1);
  endCamera();


  simulate();
  for (int i = 0; i < now.length; i++) {
    for (int j = 0; j < now[i].length; j++) {
      now[i][j] = next[i][j];
      color c;
      if (now[i][j])
        c = color(255, 0, 0);
      else
        c = color(128);
      fill(c);
      pushMatrix();
      translate(i*50, j*50, 0);
      box(50);
      popMatrix();
    }
  }
}