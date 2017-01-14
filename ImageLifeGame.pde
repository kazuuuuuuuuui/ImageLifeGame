boolean[][] now;
boolean[][] next;

int w, h;

void setup() 
{
  size(500, 500);//画像と合わせてるのがなんかアレ

  frameRate(4);

  w = width /20;
  h = height /20;

  now = new boolean[w][h];
  next = new boolean[w][h];

  for (int i = 0; i< w; i++) {
    for (int j = 0; j< h; j++) {
      now[i][j] = false;
    }
  }

  now[0][0] = true;
  now[1][0] = true;
  now[0][1] = true;
  now[3][2] = true;
  now[3][3] = true;
  now[2][3] = true;
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
   simulate();
  //loadPixels();
  for (int i = 0; i < now.length; i++) {
    for (int j = 0; j < now[i].length; j++) {
      now[i][j] = next[i][j];
      color c;
      if (now[i][j])
        c = color(255);
      else
        c = color(0);
      // pixels[height * j + i] = c;
      fill(c);
      rect(i*w, j*h, w, h);
    }
  }

  //updatePixels();
}