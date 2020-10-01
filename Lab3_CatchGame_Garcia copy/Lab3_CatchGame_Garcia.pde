
//declaring the five objects
RectObjects rect1;
RectObjects rect2;
RectObjects rect3;
RectObjects rect4;
RectObjects rect5;

//declaring the space from the right edge to the paddle
int gap;

//the score
int score = 0;

//variables for the buttons
boolean play=false;
int buttonx;
int buttony;
int buttonwidth;
int buttonheight;
int buttoncolor=255;

void setup() {
  size(600, 600);
  background(255);

  //variable values for the buttons
  buttonwidth=width/3;
  buttonheight=height/5;
  buttonx=width/4;
  buttony=height/2;

  //the value for the space from the right edge to the paddle
  gap = width - 30;

  //giving the 5 objects values
  rect1 = new RectObjects(color(0, random(0, 255), 120), 0, random(30, height/5), random(2, 5), random((width/30.0), (height/20.0)));
  rect2 = new RectObjects(color(0, random(0, 255), 120), 0, random(height/5, (height/5)*2), random(2, 5), random((width/30.0), (height/20.0)));
  rect3 = new RectObjects(color(0, random(0, 255), 120), 0, random((height/5)*2, (height/5)*3), random(2, 5), random((width/30.0), (height/20.0)));
  rect4 = new RectObjects(color(0, random(0, 255), 120), 0, random((height/5)*3, (height/5)*4)-30, random(2, 5), random((width/30.0), (height/20.0)));
  rect5 = new RectObjects(color(0, random(0, 255), 120), 0, random((height/5)*4, (height/5)*5)-30, random(2, 5), random((width/30.0), (height/20.0)));
}

void draw() {
  background(255);

  //drawing the actual buttons
  fill(255);
  rectMode(CENTER);
  rect(buttonx, buttony, buttonwidth, buttonheight);
  rect((buttonx)*3, buttony, buttonwidth, buttonheight);

  //the text for the menu page
  fill(0);
  textAlign(CENTER);
  textSize(width/20);
  text("The Catch Game", width/2, height/8);
  textSize(width/40);
  text("Once you start the game, \n there are objects that will move from the left to the right side of the screen.", width/2, height/5.5);
  text("The objective is to catch as many objects as you can \n by using the paddle to catch the objects.", width/2, height/4);
  text("When you catch the objects, your score will increase. \n If the objects go past the right edge of the window, your score will decrease.", width/2, height/3);
  text("The more objects you catch, the faster the objects will move. \n The more objects that make it to the right edge, the slower the ojbects will move.", width/2, height/1.5);
  textSize(width/20);
  text("FLASH WARNING!!!", width/2, height/1.2);

  //text for the buttons
  fill(0);
  textAlign(CENTER);
  textSize(width/55);
  text("I am ready to \n absolutely dominate this game!", buttonx, buttony);

  fill(0);
  textSize(width/55);
  text("Maybe I'll try to beat \n this game at a later time.", buttonx*3, buttony);
  fill(255);

  //when the start button is clicked, do this(start the game)
  if (play) {
    background(255);

    //flashing squares
    fill(random(255), random(255), random(255));
    for (int i=0; i<=width; i=i+width/19) {
      rect(i, 15, 30, 30);
    }
    for (int i=0; i<=width; i= i+width/19) {
      rect(i, height-15, 30, 30);
    }

    //text for the score board
    fill(0);
    textAlign(BASELINE);
    textSize(width/30);
    text("Score: " + score, width/30, height/10);


    //running all of the methods that make up the five objects
    rect1.run();

    rect2.run();

    rect3.run();

    rect4.run();

    rect5.run();

    //the paddle
    rectMode(CENTER);
    fill(0);
    rect(gap, constrain(mouseY, (height/7)/2, height-((height/7)/2)), width/20, height/7);
  }
}

//the class(blueprint) for the objects
class RectObjects {
  color rcolor; 
  float x;
  float y;
  float dx;
  float size;

  RectObjects(color rcolor, float x, float y, float dx, float size) {
    this.rcolor = rcolor;
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.size = size;
  }

  //the method that displays the objects
  void display() {
    stroke(0);
    fill(rcolor);
    rectMode(CENTER);
    rect(x, y, size, size);
  }

  //the method that makes the objects move
  void move() {
    x+=dx;
  }

  //the method that tells the program what to do if the player scores (if the player catches an object)
  void score() {
    if (x >= gap-size && y > mouseY-((height/7)/2) && y < mouseY+((height/7)/2)) {
      x = 0;
      y = random(size, height-size);
      size = random(width/30, height/20);
      rcolor = color(0, random(0, 255), 120);
      dx+=0.5;

      score++;
    }
  }

  //the method that tells the program what to do if the player misses an object
  void miss() {
    if (x > width+size) {
      x = 0;
      y = random(size, height-size);
      size = random(width/30, height/20);
      rcolor = color(0, random(0, 255), 120);
      dx=constrain(dx-0.5, 2, 5);

      score--;
    }
  }

  //the method that combines all of the methods so that the code looks neater
  void run() {
    display();
    move();
    score();
    miss();
  }
} 

//the code that says if the mouse is clicked inside of the buttons then the game will either start or the window will close
void mouseClicked() {
  if (play==false && mouseX>=buttonx-(buttonwidth/2)&& mouseX<=buttonx+(buttonwidth/2)&& mouseY>=buttony-(buttonheight/2)&& mouseY<=buttony+(buttonheight/2)) {
    play=true;
  }

  if (play==false && mouseX>=(buttonx*3)-(buttonwidth/2)&& mouseX<=(buttonx*3)+(buttonwidth/2)&& mouseY>=buttony-(buttonheight/2)&& mouseY<=buttony+(buttonheight/2)) {
    exit();
  }
}
