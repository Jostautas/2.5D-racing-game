int sizeOfMap;  // how many rows there are in a map
int[][] map1 = {{0, 1, 0}, // one map consists of 10 layers
  {1, 0, 0},
  {0, 1, 0},
  {0, 1, 1},
  {1, 0, 0},
  {0, 1, 0},
  {0, 0, 1},
  {1, 0, 0},
  {0, 0, 1},
  {1, 0, 0}};  // array will be drawn from bottom to top
Table map12;
  
int[][] gap = {{0, 0, 0},
  {0, 0, 0},
  {0, 0, 0}};
int layer;
int startX;  // x coordinate where map starts to be drawn
int startY;
int block;  // rectangular block that represents obstacle

PFont f;

boolean mapPressed;  // is key 1, 2 or 3 (map menus) pressed

PImage backgr1;
PImage backgr2;
int counter;

int score;

int mapProgress;

PImage carMap;
PImage car;
int posX, posY;
int carW, carH;
int imgW, imgH, collumn, row;
int distanceFromTop;
int distanceFromLeft;
int speed;
int carPosX, carPosY;
int XOnScreen;
int direction;
int[] DirectionX = {0, 1, -1};

PImage ob; // obstacle
PImage ob2;
int obsX, obsY;  // used for drawing
int realObsX, realObsY; // actual position on screen

void setup() {
  size(1536, 820);  // window size

  sizeOfMap = 10;
  layer = 0;
  block = 40;
  startX = 1536 - block*3;
  startY = 50;
  
  map12 = loadTable("map1.csv", "header");
  println(map12.getRowCount());
  
  /*
  TableRow mapRow;
  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 3; j++){
      mapRow = i;
      map1[i][j] = mapRow.getInt("1");
    }
  }*/

  f = createFont("Arial", 16, true);

  backgr1 = loadImage("b1.png");
  backgr2 = loadImage("b2.png");

  carMap  = loadImage("car.png");
  imgW = carMap.width;
  imgH = carMap.height;

  mapPressed = false;


  //sets collumn and row widths. car.png has 6 collumns and 4 rows
  collumn = imgW/6;
  row = imgH/4;

  carPosX = 8;
  carPosY = 640;

  score = 0;

  direction = 0; // the car will not go to right or left without input

  // rezolution of one car image in car.png
  carW = 96;
  carH = 64;

  //Enter what car image you want to use
  posX = 0;
  posY = 0;

  speed = 15;

  ob = loadImage("ob.png");
  ob2 = loadImage("ob2.png");
  realObsY = -300;

  mapProgress = 0;

  counter = 0; // background animation counter

  frameRate(30);
}

void draw() {
  //     (.., ats nuo krasto, atst nuo virsaus, rez, rez);
  //image(img, 50, 30, 305, 305);

  //System.out.println(direction);

  //background(50);
  if (counter == 1) {
    image(backgr1, 0, 0, 1536, 820);
    counter = 0;
  } else {
    image(backgr2, 0, 0, 1536, 820);
    ++counter;
  }


  //generateMap(map1);



  if (direction == 1) {  // if car is going to the right
    posX = 3;
    posY = 0;
  } else if (direction == 2) {  //  if car is going to the left
    posX = 2;
    posY = 2;
  } else {
    posX = 0;
    posY = 0;
  }

  // pasiimam dali nuotraukos is img i pav. (poszicijaX, pozicijaY, rezX, rezY)
  car = carMap.get(carW*posX+1, carH*posY, 96, 64);

  carPosX += DirectionX[direction];
  distanceFromLeft = 600;
  distanceFromTop = 200;

  XOnScreen = carPosX * speed + distanceFromLeft;
  //    image, X, Y, sizeX, sizeY
  image(car, XOnScreen, carPosY, 96*2, 64*2);

  drawObs(sizeOfMap, map1, mapProgress, XOnScreen, carPosY);

  mapProgress++;
  realObsY += 20;
}

void keyPressed() {
  //direction = keyCode == RIGHT? 1 : (keyCode == LEFT? 2 : 0);

  if (key == '1') {
    mapPressed = !mapPressed;
    if (mapPressed == true) {
      generateMap(map1);
      noLoop();
    }
  }

  direction = keyCode == RIGHT? 1 : (keyCode == LEFT? 2 : 0);
}

void generateMap(int[][] map) {
  textFont(f, 32);
  fill(255);
  text("Map:", startX, 32);

  fill(50);
  rect(startX, startY, 3 * block, sizeOfMap * block);
  fill(255);
  for (int i = 0; i < sizeOfMap; i++) {
    for (int j = 0; j < 3; j++) {
      if (map[i][j] == 1) {
        square(startX + j * block, startY + i * block, block);
      }
    }
  }
}

void drawObs(int sizeOfMap, int[][] map, int mapProgress, int carX, int carY) {
  realObsX = 0;
  for (int i = 0; i < sizeOfMap; i++) {
    for (int j = 0; j < 3; j++) {
      if (map[i][j] == 1) {
        obsY = mapProgress*20+(i)*300-3000;
        if (j == 0) {  // shifts to left
          obsX = 720-90-mapProgress;  // 90+ to the left from center of the screen
          realObsX = 720-90-mapProgress;
        } else if (j == 2) {  // shifts to right
          obsX = 720+90+mapProgress;
          realObsX = obsX = 720+90+mapProgress;
        } else {  // stays at the center
          obsX = 720;
          realObsX = 720;
        }
        image(ob, obsX, obsY, 96, 64);

        if (realObsY > 700) {
          layer++;
          realObsY -= 300;
          if (j == 2) {
            realObsX += 50;
          } else if (j == 0) {
            realObsX -= 50;
          }
        }

        if (layer == 10) {
          end();
        } else if (map[9-layer][j] == 1) {
          //image(ob2, realObsX, realObsY, 96, 64);
          if ((carX >= realObsX-120 && carX <= realObsX+30) && (realObsY > 600 && realObsY < 1000)) {
            gameOver();
          }
        }
      }
    }
  }
}

void gameOver() {
  textFont(f, 100);
  fill(255);
  text("GAME OVER", 720, 100);

  noLoop();
}
void end() {
  textFont(f, 60);
  fill(255);
  text("CONGRATULATIONS, YOU WON!", 300, 200);

  noLoop();

  //exit();
}
