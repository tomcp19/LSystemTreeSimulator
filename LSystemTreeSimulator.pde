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
String nom;
PFont angleValue, axiom, seq;

float tr,tb,tg,ta,sw;

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
    angleValue = createFont("Arial",16,true); 
    axiom = createFont("Arial",16,true); 
    seq = createFont("Arial",16,true); 
   
  
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
    tr = 254;
    tb = 208;
    tg= 110;
    ta= 0;
    sw = 2;
    nom = "Herbacee";

    firstTime = false;
   }

    lsys = new LSystem( LSysChar, ruleset);
    turtle = new Turtle(lsys.getSentence(), height/5, radians(angle));
    turtle.setColor(tr,tb,tg,ta, sw);
    
        //----ControlP5 ----//
    cp5 = new ControlP5(this);
    cp5.addButton("Arbuste")
    //.setBroadcast(false)
     .setValue(0)
     .setPosition(10,050)
     .setSize(400,100)
     .getCaptionLabel()
       .setSize(24)
     ;
     
    cp5.addButton("Herbacee")
    //.setBroadcast(false)
     .setValue(1)
     .setPosition(10,150)//1300.150
     .setSize(400,100)
     .getCaptionLabel()
       .setSize(24)
     ;
     
    cp5.addButton("Fougere")
    //.setBroadcast(false)
     .setValue(2)
     .setPosition(10,260)
     .setSize(400,100)
     .getCaptionLabel()
       .setSize(24)
     ;
     
    cp5.addButton("Submit")
    //.setBroadcast(false)
     .setValue(2)
     .setPosition(100,900)
     .setSize(200,50)
     .setCaptionLabel("Submit Dammit!")    
     .getCaptionLabel()
       .setSize(24)
       
     ;
     
    /*String Axiom = cp5.get(Textfield.class,"textInput_1").getText();
    for (int i = 0; i < 1; i++) 
    {
      axiom1 = Axiom.charAt(i);
    }*/

  cp5.addTextfield("Angle").setPosition(30, 800).setSize(60, 50).setAutoClear(false).setValue(str(angle)).setFont(createFont("arial", 24)).setColorLabel(#000000);
  cp5.addTextfield("Axiom").setPosition(35, 700).setSize(30, 50).setAutoClear(false).setValue(str(axiom1)).setFont(createFont("arial", 24)).setColorLabel(#000000).getCaptionLabel().setVisible(false);;
  cp5.addTextfield("Sequence").setPosition(100, 700).setSize(250, 50).setAutoClear(false).setValue(equation1).setFont(createFont("arial", 24)).setColorLabel(#000000);
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
  
  fill(255);
  stroke(10);
  rect(10, 370, 400, 600);
  textFont(angleValue,30); 
  fill(0); 
  text("Nom : " +nom , 30, 420 ); 
  text("Angle : " +angle + " °", 30, 500 ); 
  text("Custom", 15, 690 ); 
  text(" => ", 60, 735 ); 
  textFont(axiom,30); 
  text("Sequence : \n" + axiom1 + " => " + equation1 ,30,570);
  if(equation2 != null)
  {
    text( axiom2 + " => " + equation2 ,30,650);
  }

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
        //strokeWeight(0);
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

    if(key == 'f') //pourra flusher
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

public void Fougere() 
{
  if(millis()-start_Time<2000){return;}
  //println("testde mute fougere ");
  nom = "Fougere";
  r=255;
  b=0;
  g=0;
  o=100;
  nbRules = 2;
  angle = 25.7;
  axiom1 = 'X';
  LSysChar = "X";
  equation1 ="F[+X][-X]FX";
  axiom2 = 'F';
  equation2 ="FF";
  //ruleset[0] = null;
  //ruleset[1] = null;
  ruleset = new Rule[2];
  ruleset[0] = new Rule(axiom1, equation1);
  ruleset[1] = new Rule(axiom2, equation2);
  nom = "Fougere";
  tr = 53;
  tb = 136;
  tg= 86;
  ta= 0;
  sw = 2;
  
  MainEnd.clear();
  firstTime = false;
  setup();
}

public void Arbuste() 
{
  if(millis()-start_Time<2000){return;}
  //println("test de mute arbuste ");
  r=0;
  b=255;
  g=0;
  o=100;
  nbRules = 1;
  //ruleset[0]=null;
  //ruleset[1] = null;
  ruleset = new Rule[1];
  angle = 22.5;
  axiom1 = 'F';
  axiom2 = ' ';
  equation2 = null;
  LSysChar = "F";
  equation1 = "FF-[-F+F+F]+[+F-F-F]";
  ruleset[0] = new Rule(axiom1, equation1);
  nom = "Arbuste";
  tr = 133;
  tb = 92;
  tg= 53;
  ta= 0;
  sw = 4;
  MainEnd.clear();
  firstTime = false;
 
  setup();
  
}

public void Submit() {
  if(millis()-start_Time<1000){return;}
  println("the following text was submitted :");
  String Axiom = cp5.get(Textfield.class,"Axiom").getText();
      for (int i = 0; i < 1; i++) 
    {
      axiom1 = Axiom.charAt(i);
    }
  angle = Float.parseFloat(cp5.get(Textfield.class,"Angle").getText());
  equation1 = cp5.get(Textfield.class,"Sequence").getText();
  
  println(" textInput 1 = " + axiom1);
  println(" textInput 2 = " + equation1);
  println();
  
  //angle = 25.7;
  //axiom1 = 'F';
  LSysChar = Axiom;
  //equation1 = "F[+F]F[-F]F";
  axiom2 = ' ';
  equation2 = null;
  ruleset = new Rule[1];
  ruleset[0] = new Rule(axiom1, equation1);
  nom = "Custom";
  tr = 255;
  tb = 255;
  tg= 255;
  ta= 0;
  sw = 2;
  
    MainEnd.clear();

  firstTime = false;
  setup();
}

public void Herbacee() 
{
  if(millis()-start_Time<2000){return;}
  
  //println("testde mute herb ");
  r=0;
  b=0;
  g=255;
  o=100;
  nbRules = 1;
  angle = 25.7;
  axiom1 = 'F';
  LSysChar = "F";
  equation1 = "F[+F]F[-F]F";
    axiom2 = ' ';
  equation2 = null;
  ruleset = new Rule[1];
  ruleset[0] = new Rule(axiom1, equation1);
  nom = "Herbacee";
  tr = 254;
  tb = 208;
  tg= 110;
  ta= 0;
  sw = 2;
  
  MainEnd.clear();

  firstTime = false;
  setup();
  
}
/*
public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
  //n = 0;
}*/
