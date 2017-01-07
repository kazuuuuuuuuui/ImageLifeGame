PImage img;

boolean[][] now;
boolean[][] next;

boolean start;

void setup() 
{
  start = false;

  size(800, 800);//画像と合わせてるのがなんかアレ
  img = loadImage("mario.jpg");
  //img = loadImage("suraimu.jpg");
  //img = loadImage("pika.jpg");
  //img = loadImage("pikotaro.jpg");


  now = new boolean[img.width][img.height];
  next = new boolean[img.width][img.height];

  for (int i = 0; i< img.width; i++) {
    for (int j = 0; j< img.height; j++) {
      color c = img.pixels[img.width * j + i];
      float average = (red(c)+green(c)+blue(c))/3.0;
      if (average > 128)
        now[i][j] = true;
      else 
      now[i][j] = false;
    }
  }

  image(img, 0, 0);
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
  if (start) {
    simulate();
    loadPixels();
    for (int i = 0; i < now.length; i++) {
      for (int j = 0; j < now[i].length; j++) {
        now[i][j] = next[i][j];
        color c;
        if (now[i][j])
          c = color(255);
        else
          c = color(0);
        pixels[height * j + i] = c;
      }
    }
    updatePixels();
  }
}

void keyPressed()
{
  start = true;
}