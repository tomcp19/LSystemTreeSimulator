//----ControlP5 ----//
import controlP5.*;
ControlP5 cp5;
int c1, c2;
float n,n1;
int start_Time;
boolean firstTime = true;

//----Framerate ----//
int currentTime;
int previousTime;
int deltaTime;

//----L-System & Turtle ----//
int counter;
LSystem lsys;
Turtle turtle;
ArrayList<PVector> MainEnd;

float angle;
Rule[] ruleset;
int nbRules;
char axiom1;
String equation1;
String LSysChar;
char axiom2;
String equation2;
//String LSysChar2;

//---- fleurs et fruits ----//

int r = 255;
int b = 0;
int g = 0;
int o = 60;

//**********************************************************************************************
//----Parallax ----//
ArrayList<Background> bgLayers;

void setup() {
    start_Time = millis();
    counter = 0;
    lsys=null;
    turtle = null;

    //----ControlP5 ----//
    cp5 = new ControlP5(this);
    cp5.addButton("Arbuste")
    //.setBroadcast(false)
     .setValue(0)
     .setPosition(0,050)
     .setSize(400,100)
     .getCaptionLabel()
       .setSize(24)
     ;
     
    cp5.addButton("Herbacee")
    //.setBroadcast(false)
     .setValue(1)
     .setPosition(00,150)//1300.150
     .setSize(400,100)
     .getCaptionLabel()
       .setSize(24)
     ;
     
    cp5.addButton("Fougere")
    //.setBroadcast(false)
     .setValue(2)
     .setPosition(0,260)
     .setSize(400,100)
     .getCaptionLabel()
       .setSize(24)
     ;
     
  
//----Framerate ----//
  currentTime = millis();
  previousTime = currentTime;
  
  
  //----Parallax ----//
  fullScreen(P2D);
  loadBackgroundLayers();

//----L-System & Turtle ----//
  if(firstTime)
  {  
    nbRules = 1;
    angle = 25.7;
    axiom1 = 'F';
    LSysChar = "F";
    equation1 = "F[+F]F[-F]F";   //"FF-[-F+F+F]+[+F-F-F]";      //"FF+[+F-F-F]-[-F+F+F]";
    ruleset=new Rule[nbRules];
    ruleset[0] = new Rule(axiom1, equation1);
    println("FirstTime!!!yAAAA");

    firstTime = false;
   }

     //lsys = LSystem.setLSystem( LSysChar, ruleset);
    lsys = new LSystem( LSysChar, ruleset);
    turtle = new Turtle(lsys.getSentence(), height/5, radians(angle));
     println("Donnees : "+ axiom1 +" -> "+ equation1);
     println("lSysChar : " + LSysChar);
     println("ruleset : " + ruleset[0]);
     println("lsysSentence : "+ lsys.getSentence());

     
   

  
}
//***********************************************************************************************
void draw() {
  background(255);  
  fill(0);
  
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
//----L-System & Turtle ----//
 
  update(deltaTime); 
  display();
  displayTree();

}

//***********************************************************************************************
void update(int delta) {
  //----Parallax ----//
  bgLayers.get(2).velocity.x = 0; 
  
  for (Background bg : bgLayers) {
    bg.update(delta);
  }
}

//***********************************************************************************************

void display () {
  
    //----Parallax ----//
  for (Background bg : bgLayers) {
    bg.display();
    
    //----fleurs et fruits ----//
    if (MainEnd != null)
    {
      for (PVector p:MainEnd)
      {
        fill(r, b, g, o);//red
          ellipse(p.x,p.y,8,8);   
          p.y += random(0, 2);
          p.x += random(-1, 1);
      }
    }
  } 
  
      if (mousePressed && MainEnd != null) 
      {
        for (PVector p:MainEnd)
        {
          if(mouseX < p.x)
          {
            //PVector wind = new PVector (.1, 0);
            p.x += 1;        
          }
          
         if(mouseX > p.x)
          {
            //PVector wind = new PVector (-.1, 0);
            p.x += -1;
          }  
        }
    }
  
}

void displayTree () {

  //---- Turtle ----//
  turtle.render();
  
}
//***********************************************************************************************
/*
void mousePressed() {
 // println(equation1);
  if (counter < 4) {
    turtle.setCount();
    pushMatrix();
    lsys.generate();
    //println(lsys.getSentence());
    turtle.setToDo(lsys.getSentence());
    turtle.changeLen(0.5);
    popMatrix();
    counter++;
  }
  if(counter == 3)
  {
    //println(counter);
    MainEnd = turtle.getEnds();
  }
}*/

void keyPressed() {

    if(key == 'f') 
    {
      MainEnd = turtle.getEnds();
      redraw();
    }
  
    if (key == 'r') 
    {  
      MainEnd.clear();
       setup();
    }
  
    if (key == 'g') 
    {  
         // println(equation1);
        if (counter < 4) 
        {
          turtle.setCount();
          pushMatrix();
          lsys.generate();
          //println(lsys.getSentence());
          turtle.setToDo(lsys.getSentence());
          turtle.changeLen(0.5);
          popMatrix();
          counter++;
        }
        if(counter == 3)
        {
          //println(counter);
          MainEnd = turtle.getEnds();
        }
    }
  
  
}

//----Parallax ----//
private void loadBackgroundLayers() {
  bgLayers = new ArrayList<Background>();
  bgLayers.add( new Background("sky.png"));
  bgLayers.add( new Background("rocks_1.png"));
  bgLayers.add( new Background("clouds_1.png"));
  bgLayers.add( new Background("clouds_2.png"));
  bgLayers.add( new Background("clouds_3.png"));
  bgLayers.add( new Background("clouds_4.png"));
  
  float speedIncrement = 0.25;
  float currentSpeed = 1;
  
  
  for (int i = 0; i < bgLayers.size(); i++) 
  {
    Background current = bgLayers.get(i);
    
    if (i > 1) 
    {      
      current.isParallax = true;
      current.velocity.x = currentSpeed;
      currentSpeed += speedIncrement;
    } 
    
    current.scale = 0.5;
  }
}

public void Fougere(int theValue) 
{
  if(!firstTime){return;}
  println("testde mute fougere ");
  r=255;
  b=0;
  g=0;
  o=100;
}

public void Arbuste(int theValue) 
{
  if(millis()-start_Time<2000){return;}
  println("test de mute arbuste ");
  r=0;
  b=255;
  g=0;
  o=100;
  nbRules = 1;
  ruleset[0]=null;
  angle = 22.5;
  axiom1 = 'F';
  LSysChar = "F";
  equation1 = "FF-[-F+F+F]+[+F-F-F]";
  ruleset[0] = new Rule(axiom1, equation1);
  println(equation1);
  MainEnd.clear();
  firstTime = false;
 
  setup();
  
}

public void Herbacee(int theValue) 
{
  if(millis()-start_Time<2000){return;}
  
  println("testde mute herb ");
  r=0;
  b=0;
  g=255;
  o=100;
  nbRules = 1;
  angle = 25.7;
  axiom1 = 'F';
  LSysChar = "F";
  equation1 = "F[+F]F[-F]F";
    ruleset[0] = null;
  ruleset[0] = new Rule(axiom1, equation1);
  println(equation1);
  MainEnd.clear();

  firstTime = false;
  setup();
  
}

public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
  //n = 0;
}
