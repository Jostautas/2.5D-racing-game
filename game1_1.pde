int sizeOfMap;  // how many rows there are in a map
int[][] map1 = {{0, 1, 0},
                {1, 0, 0},
                {0, 0, 1},
                {0, 0, 0},
                {1, 0, 0},
                {0, 1, 0},
                {0, 0, 0},
                {1, 0, 0},
                {1, 0, 1},
                {1, 0, 0}};
int startX;  // x coordinate where map starts to be drawn
int startY;
int block;  // rectangular block that represents obstacle

PFont f;

PImage backgr1;
PImage backgr2;
int counter;

int score;

PImage carMap;
PImage car;
int posX, posY;
int carW, carH;
int imgW, imgH, collumn, row;
int distanceFromTop;
int distanceFromLeft;
int speed;
int carPosX, carPosY;
int direction;
int[] DirectionX = {0, 1, -1};

PImage ob; // obstacle

void setup(){
  size(1536, 820);  // window size
  
  sizeOfMap = 10;
  block = 40;
  startX = 1536 - block*3;
  startY = 50;
  
  f = createFont("Arial", 16, true);
  
  backgr1 = loadImage("b1.png");
  backgr2 = loadImage("b2.png");
  
  carMap  = loadImage("car.png");
  imgW = carMap.width;
  imgH = carMap.height;
  
  
  
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
  
  counter = 0; // background animation counter
  
  frameRate(30);
  
  //mas = new.PImage[column][row];
  
}

void draw(){
  //     (.., ats nuo krasto, atst nuo virsaus, rez, rez);
  //image(img, 50, 30, 305, 305);
  
   //System.out.println(direction);
   
   //background(50);
   if(counter == 1){
     image(backgr1, 0, 0, 1536, 820);
     counter = 0;
   }
   else{
     image(backgr2, 0, 0, 1536, 820);
     ++counter;
   }
   
   
   //generateMap(map1);
   
   
   
   if(direction == 1){  // if car is going to the right
     posX = 3;
     posY = 0;
   }
   else if(direction == 2){  //  if car is going to the left
     posX = 2;
     posY = 2;
   }
   else{
     posX = 0;
     posY = 0;
   }
  
  // pasiimam dali nuotraukos is img i pav. (poszicijaX, pozicijaY, rezX, rezY)
  car = carMap.get(carW*posX+1, carH*posY, 96, 64);
  
  /*
  posX++;
  if(posX > collumn){
    posX = 0;
    posY++;
      if(posY > row){
      posX = 0;
      posY = 0;
    }
  }
  */
  
  carPosX += DirectionX[direction];
  distanceFromLeft = 696;
  distanceFromTop = 200;
  
  //    image, mouseX, mouseY, sizeX, sizeY
  image(car, carPosX * speed + distanceFromLeft, carPosY, 96*2, 64*2);
}

void keyPressed(){
  //direction = keyCode == RIGHT? 1 : (keyCode == LEFT? 2 : 0);
  if(key == 1 || key == 1){
    generateMap(map1);
  }
  direction = keyCode == RIGHT? 1 : (keyCode == LEFT? 2 : 0);
  if(direction == 0){
    speed += 5;
  }
}

void generateMap(int[][] map){
  textFont(f, 32);
  fill(255);
  text("Map:", startX, 32);
  
  fill(50);
  rect(startX, startY, 3 * block, sizeOfMap * block);
  fill(255);
  for(int i = 0; i < sizeOfMap; i++){
    for(int j = 0; j < 3; j++){
      if(map[i][j] == 1){
         square(startX + j * block, startY + i * block, block);
      }  
    }
  }
}
