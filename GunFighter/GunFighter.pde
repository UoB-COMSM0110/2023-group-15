import gifAnimation.*;

//String[] playerBlueImages = new String[]{
//    "bulletBlue.png", "bulletBlueLeft.png",
//    "playerBlueDefault.gif","playerBlueFacingLeft.gif",
//    "playerBlueJump.gif","playerBlueJumpFacingLeft.gif","playerBlueJumpLeft.gif","playerBlueJumpRight.gif",
//    "playerBlueMoveLeft.gif","playerBlueMoveRight.gif",
//    "playerBlueShoot.gif","playerBlueShootFacingLeft.gif"
//}
//String[] playerRedImages = new String[]{
//    "bulletRed.png", "bulletRedLeft.png",
//    "playerRedDefault.gif","playerRedFacingLeft.gif",
//    "playerRedJump.gif","playerRedJumpFacingLeft.gif","playerRedJumpLeft.gif","playerRedJumpRight.gif",
//    "playerRedMoveLeft.gif","playerRedMoveRight.gif",
//    "playerRedShoot.gif","playerRedShootFacingLeft.gif"
//}

PImage shortFloor;
PImage longFloor;
PImage deadFloor;

PImage bulletBlueImage;
PImage bulletBlue;
PImage bulletBlueLeft;
Gif playerBlueImage;
Gif playerBlueDefault;
Gif playerBlueFacingLeft;
Gif playerBlueJump;
Gif playerBlueJumpFacingLeft;
Gif playerBlueJumpLeft;
Gif playerBlueJumpRight;
Gif playerBlueMoveLeft;
Gif playerBlueMoveRight;
Gif playerBlueShoot;
Gif playerBlueShootFacingLeft;


ArrayList<Platform> platforms;
Platform deadLine; //bottom line
ArrayList<Bullet> bullets;
final float keypressRespondSpeed = 5;
Player playerBlue = new Player(600,552,true);
Player playerRed = new Player(600,552,false);

float period = 0; // the period which new platform
float platMoveDis = 0.5;
//int dis = height/5;


void setup(){
    size(1000,700);
    frameRate(60);
    
    
    int dis = height/5;
    platforms = new ArrayList();
    //initial
    platforms.add(new Platform(width/3*2+50, height-dis, 20, 250, 1));
    platforms.add(new Platform(width/3-50, height-dis, 20, 250, 1));
    platforms.add(new Platform(width/2, height-2*dis, 20, 250, 1));
    platforms.add(new Platform(width/3*2+50, height-3*dis, 20, 250, 1));
    platforms.add(new Platform(width/3-50, height-3*dis, 20, 250, 1));
    platforms.add(new Platform(width/2, height-4*dis, 20, 250, 1));
    platforms.add(new Platform(width/3*2+50, 0, 20, 250, 1));
    platforms.add(new Platform(width/3-50, 0, 20, 250, 1));

    deadLine = new Platform(width/2,height-10,50, width, 1);

    
    bullets = new ArrayList();
    bulletBlue = loadImage("bulletBlue.png");
    bulletBlueLeft = loadImage("bulletBlueLeft.png");
    
    shortFloor = loadImage("floor.jpg");            //
    shortFloor.resize(width/3,40);                  //
    longFloor = loadImage("floor.jpg");            //
    longFloor.resize(width/2,40);        //
    
    deadFloor = loadImage("deadline.png");
    deadFloor.resize(width, 80);
    
    bulletBlue.resize(10,10);
    bulletBlueLeft.resize(10,10);
    
    playerBlueDefault = new Gif(this, "playerBlueDefault.gif");
    playerBlueFacingLeft = new Gif(this, "playerBlueFacingLeft.gif");
    playerBlueJump = new Gif(this,"playerBlueJump.gif");
    playerBlueJumpFacingLeft = new Gif(this,"playerBlueJumpFacingLeft.gif");
    playerBlueJumpLeft = new Gif(this,"playerBlueJumpLeft.gif");
    playerBlueJumpRight = new Gif(this,"playerBlueJumpRight.gif");
    playerBlueMoveLeft = new Gif(this,"playerBlueMoveLeft.gif");
    playerBlueMoveRight = new Gif(this,"playerBlueMoveRight.gif");
    
    playerBlueShootFacingLeft = new Gif(this,"playerBlueShootFacingLeft.gif");
    playerBlueShoot = new Gif(this,"playerBlueShoot.gif");
    
    playerBlueDefault.loop();
    playerBlueFacingLeft.loop();
    playerBlueJump.loop();
    playerBlueJumpFacingLeft.loop();
    playerBlueJumpLeft.loop();
    playerBlueJumpRight.loop();
    playerBlueMoveLeft.loop();
    playerBlueMoveRight.loop();
    //playerBlueShoot.loop();
    playerBlueImage = playerBlueDefault;
}

void draw(){
  background(255);
  //playerBlueImage = playerBlueDefault;
  line(0,580,1200,580);
  line(0,600,1200,600);
  
  float dis = height/5;
  if(period == dis){
    if(platforms.get(0).y == platforms.get(1).y){
      platforms.remove(0);
      platforms.remove(1);
    }else{
      platforms.remove(0);
    }
    
    int num = (int)random(2);   // num = 0  one long Plat ; num = 1 two short plats
    if(num == 0){
      platforms.add(new Platform(width/2, 0, 20, 250, 1));
    }else{
      platforms.add(new Platform(width/3*2+50, 0, 20, 250, 1));
      platforms.add(new Platform(width/3-50, 0, 20, 250, 1));
    }
    period = 0;
  }
  period = period + platMoveDis;
  

  playerBlue.update();
  playerBlue.display(playerBlueImage); 
  //start interface
  for(int i = 0; i < platforms.size(); i++){
    platforms.get(i).display(shortFloor);
    platforms.get(i).y += platMoveDis;
    playerBlue.collide(platforms.get(i).x, platforms.get(i).y, platforms.get(i).h, platforms.get(i).w, platforms.get(i).type);
  }
  deadLine.display(deadFloor);


  //deadLine.(floor);
  
  playerBlue.update();
  playerBlue.display(playerBlueImage); 
  //playerBlue.collide(600,600,250,20,1);
  
  if(bullets.size( ) != 0){
       bullets.get(bullets.size()-1).display(bulletBlueImage);
       bullets.get(bullets.size()-1).update();
   }
}
