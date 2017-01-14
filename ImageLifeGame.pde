/*
Unityに移植してくる
 */


int timer;

Cell[][] nowCells;
Cell[][] nextCells;

/*
boolean[][] now;
 boolean[][] next;
 */

int w, h;

void setup() 
{
  size(500, 500, P3D);

  //frameRate(4);

  w = width /20;
  h = height /20;

  nowCells = new Cell[w][h];
  nextCells = new Cell[w][h];

  /*
  now = new boolean[w][h];
   next = new boolean[w][h];
   */

  for (int i = 0; i< w; i++) {
    for (int j = 0; j< h; j++) {
      boolean life = random(0, 1) < 0.2;
      nowCells[i][j] = new Cell(life, i*50, 0, j*50);
      nextCells[i][j] = new Cell(false, i*50, 0, j*50);
    }
  }
}

void simulate()
{
  for (int i = 0; i < nowCells.length; i++) {
    for (int j = 0; j < nowCells[i].length; j++) {
      int up = (j-1+nowCells[i].length) % nowCells[i].length;
      int down = (j+1+nowCells[i].length) % nowCells[i].length;
      int left = (i-1+nowCells.length) %nowCells.length;
      int right = (i+1) % nowCells.length;

      int count = 0;
      if (nowCells[left][j].myLife)count++;
      if (nowCells[left][up].myLife)count++;
      if (nowCells[i][up].myLife)count++;
      if (nowCells[right][up].myLife)count++;
      if (nowCells[right][j].myLife)count++;
      if (nowCells[right][down].myLife)count++;
      if (nowCells[i][down].myLife)count++;
      if (nowCells[left][down].myLife)count++;

      if (nowCells[i][j].myLife && (count == 2 || count == 3)) {
        nextCells[i][j].myLife= true;
      } else if (nowCells[i][j].myLife ==false && count == 3) {
        nextCells[i][j].myLife=true;
      } else {
        nextCells[i][j].myLife = false;
      }
    }
  }
}

void draw()
{
  timer++;

  background(0);
  lights();
  int dx = 330;
  int dy = 51;

  beginCamera();
  camera(
    width/2.0+dx, height/2.0+dy, (height/2.0) / tan(PI*30.0 / 180.0)*9, 
    width/2.0+dx, height/2.0+dy, 0, 
    0, 1, 0);
  //rotateX(1.5);
  endCamera();

  if (timer % 60 ==0)simulate();//ここ
  for (int i = 0; i < nowCells.length; i++) {
    for (int j = 0; j < nowCells[i].length; j++) {
      if (timer % 60 ==0)nowCells[i][j].myLife = nextCells[i][j].myLife;//ここ

      if (nowCells[i][j].myLife)nowCells[i][j].y = 10;

      nowCells[i][j].display();
    }
  }
}