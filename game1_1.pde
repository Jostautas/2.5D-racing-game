PImage img;
int posX, posY;
PImage car;
int carW, carH;
int imgW, imgH, collumn, row;
PImage[][] mas;

PImage backgr;

int score;

int distanceFromTop;
int distanceFromLeft;
int speed;
int carPosX, carPosY;
int direction;
int[] DirectionX = {0, 1, -1};

void setup(){
  size(1536, 820);  // window size
  
  //backgr  = loadImage("a.png");
  
  img  = loadImage("car.png");
  imgW = img.width;
  imgH = img.height;
  
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
  
  speed = 5;
  
  frameRate(60);
  
  //mas = new.PImage[column][row];
  
}

void draw(){
  //     (.., ats nuo krasto, atst nuo virsaus, rez, rez);
  //image(img, 50, 30, 305, 305);
  
   //System.out.println(direction);
   
   background(50);
   //image(backgr, 0, 0, 1536, 820);
   
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
  car = img.get(carW*posX+1, carH*posY, 96, 64);
  
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
  image(car, carPosX * speed + distanceFromLeft, carPosY, 96*1.5, 64*1.5);
}

void keyPressed(){
  //direction = keyCode == RIGHT? 1 : (keyCode == LEFT? 2 : 0);
  direction = keyCode == RIGHT? 1 : (keyCode == LEFT? 2 : 0);
  if(direction == 0){
    speed += 5;
  }
}
