ArrayList<Mover> flock;
int flockSize = 2;
Attractor a;
boolean initAttractor = true;
boolean popMover = false;
int popCounter;

//----ControlP5 ----//
import controlP5.*;
ControlP5 cp5;
int c1, c2;
float n,n1;
int start_Time;
float setAngle;
PFont angleValue, axiom, seq;

boolean changedText=false;
String AngleText;
boolean changedSlider=false;
float AngleValue;

//----Framerate ----//
int currentTime;
int previousTime;
int deltaTime;

//----L-System & Turtle ----//
int counter;
LSystem lsys;
Turtle turtle;
boolean firstTime = true;
ArrayList<Tree> Models = new ArrayList();
Tree CurrentModel = new Tree();

//---- fleurs et fruits ----//
ArrayList<Fruit> Fruits = new ArrayList();
boolean setFruits = false;

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
    
    flock = new ArrayList<Mover>();
  
  for (int i = 0; i < flockSize; i++) 
  {
    Mover m = new Mover(new PVector(random(630, width), random(0, height)), new PVector(random (-2, 2), random(-2, 2)));
    m.fillColor = color(0, 0, 0);
    flock.add(m);
  }
  
  a = new Attractor();
  popCounter = 0;
     
//----Framerate ----//
  currentTime = millis();
  previousTime = currentTime;
  
  //----Parallax ----//
  fullScreen(P2D);
  loadBackgroundLayers();

//----L-System & Turtle ----//
  if(firstTime)
  {  
    Tree model1 = new Tree ("Herbacee", 1, 'F', "F[+F]F[-F]F", "F", 25.7, 254, 208, 110, 0, 2, 15, 5);
    Tree model2 = new Tree ("Arbuste", 1, 'F', "FF-[-F+F+F]+[+F-F-F]", "F", 22.5, 133, 92, 53, 0, 4, 10, 10);
    Tree model3 = new Tree ("Fougere", 2, 'X', "F[+X][-X]FX", "X", 25.7,'F',"FF", 0, 208, 0, 0, 2, 25,1);
    
    Models.add(model1);
    Models.add(model2);
    Models.add(model3);

    firstTime = false;
    CurrentModel = Models.get(0);
    setAngle = CurrentModel.getAngle();
   }

   lsys = new LSystem( CurrentModel.getLSysChar(), CurrentModel.getRuleset());
   turtle = new Turtle(lsys.getSentence(), height/5, radians(CurrentModel.getAngle()));
   turtle.setColor(CurrentModel.getTreeColorsR(),CurrentModel.getTreeColorsB(),CurrentModel.getTreeColorsG(),CurrentModel.getTreeColorsA(), CurrentModel.getTreeColorsSW());
    
        //----ControlP5 ----//
   cp5 = new ControlP5(this);
   cp5.addButton("Arbuste")
     .setValue(0)
     .setPosition(10,050)
     .setSize(400,100)
     .getCaptionLabel()
       .setSize(24)
     ;
     
   cp5.addButton("Herbacee")
     .setValue(1)
     .setPosition(10,150)//1300.150
     .setSize(400,100)
     .getCaptionLabel()
       .setSize(24)
     ;
     
   cp5.addButton("Fougere")
     .setValue(2)
     .setPosition(10,260)
     .setSize(400,100)
     .getCaptionLabel()
       .setSize(24)
     ;
     
   cp5.addSlider("setAngle")
    .setPosition(100,800)
    .setSize(250,50)
    .setRange(0,90)
    .setColorLabel(#000000)
    .setLabel("Angle")
    .getCaptionLabel()
      .setFont(createFont("arial", 24))
      .setVisible(false)
     ;
     
    cp5.addButton("Submit")
     .setValue(2)
     .setPosition(100,900)
     .setSize(200,50)
     .setCaptionLabel("Submit Dammit!")    
     .getCaptionLabel()
       .setSize(24)   
     ;
    
    cp5.addTextfield("Angle")
     .setPosition(30, 800)
     .setSize(60, 50)
     .setAutoClear(false)
     .setValue(str(CurrentModel.getAngle()))
     .setFont(createFont("arial", 24))
     .setColorLabel(#000000);
    
    cp5.addTextfield("Axiom")
     .setPosition(35, 700)
     .setSize(30, 50)
     .setAutoClear(false)
     .setValue(str(CurrentModel.getAxiom1()))
     .setFont(createFont("arial", 24))
     .setColorLabel(#000000)
     .getCaptionLabel()
       .setVisible(false);
    
    cp5.addTextfield("Sequence")
     .setPosition(100, 700)
     .setSize(250, 50)
     .setAutoClear(false)
     .setValue(CurrentModel.getEquation1())
     .setFont(createFont("arial", 24))
     .setColorLabel(#000000)
     .getCaptionLabel()
       .getStyle()
         .setMarginLeft(-70);
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
  
  fill(255);
  stroke(10);
  rect(10, 370, 400, 600);
  textFont(angleValue,30); 
  fill(0); 
  text("Nom : " + CurrentModel.getNom() , 30, 420); 
  text("Angle : " +CurrentModel.getAngle() + " °", 30, 500); 
  text("Custom", 15, 690 ); 
  text(" => ", 60, 735 ); 
  text("Sequence : \n" + CurrentModel.getAxiom1() + " => " + CurrentModel.getEquation1(), 30, 570);
  
  if(CurrentModel.getEquation2() != null)
  {
    text( CurrentModel.getAxiom2() + " => " + CurrentModel.getEquation2() ,30,650);
  }
  
  if(setFruits)
  {
    if(initAttractor)
    {
     a.setAttractor(Fruits.get(0).location.x,Fruits.get(0).location.y, Fruits.get(0).size);
     initAttractor = false;
     popMover = true;
    }

  }
  
  if(!a.isDead())
  {
     a.display();
  }

}

//***********************************************************************************************
void update(int delta) {
  //----Parallax ----//
  bgLayers.get(2).velocity.x = 0; 
  
  for (Background bg : bgLayers) 
  {
    bg.update(delta);
  } 

  cp5.getController("setAngle").setUpdate(false);

  if(cp5.get(Textfield.class, "Angle").isFocus())
  {
    changedText = true;
  }
  
  if(changedText)
  {
    if(!cp5.get(Textfield.class, "Angle").isFocus())
    {
      cp5.getController("setAngle").update();//faire update de slider
      cp5.getController("setAngle").setValue(Float.parseFloat((cp5.get(Textfield.class,"Angle").getText()).replace(',', '.')));
      changedText=false;
    }
  }
  
  if(cp5.getController("setAngle").getValue() != AngleValue)//si chg slider
  {
     String val = String.format("%.1f",cp5.getController("setAngle").getValue());
     cp5.get(Textfield.class, "Angle").setText(val);
     AngleValue = cp5.getController("setAngle").getValue();
     AngleText = val;
     
  }
  
    for (Mover m : flock) 
    {
    m.flock(flock);
    m.update(delta);
    if(setFruits)
    {
      if(!a.isDead())
      {
        a.update();
        a.setPosition(Fruits.get(0).location.x,Fruits.get(0).location.y);
        PVector force = a.attract(m);
        m.applyForce(force);
      }
      if(popMover && a.isDead())
      {
        PVector popUpward = new PVector(50,-50);
        m.applyForce(popUpward); //sert de debug si pris dans le plancher
        popCounter++;
        if(popCounter >10)
        {
        popMover = false;
        }
      }
    }
   }
  
     if(setFruits)
     {

       for (Fruit f: Fruits)
       {
        if(!a.isDead())
          {
             PVector gravity = new PVector (0,random(0, 2)*0.1*f.weight);//avec effet de flottement
             PVector floating = new PVector (random(-2, 2),0);//avec effet de flottement de gauche a droite
             
             float c = 0.05;
             PVector friction = f.velocity.get();
             friction.mult(-1); 
             friction.normalize();
             friction.mult(c);
             
             f.applyForce(friction);
             f.applyForce(gravity);
             if(f.location.y < height-f.size/2)
             {
               f.applyForce(floating);
             }
                      
             if (mousePressed) 
              {
    
                if(mouseX < f.location.x)
                {
                    PVector wind = new PVector(1, 0);
                    f.applyForce(wind);      
                }
                  
                if(mouseX > f.location.x)
                {
                    PVector wind = new PVector(-1, 0);
                    f.applyForce(wind);
                  }  
              }
             f.update();
             if(!a.isDead())
             {       
              
             }
             f.checkEdges();
           }
       }
     }
}

//***********************************************************************************************

void display () {
  
    //----Parallax ----//
  for (Background bg : bgLayers) 
  {
    bg.display();
  }
  displayTree();
  
    for (Mover m : flock) 
    {
      if (mousePressed) 
      {

       if(mouseX < m.location.x)
       {
          PVector wind = new PVector(.1, 0);
          m.applyForce(wind);
       
       }
              
       if(mouseX > m.location.x)
       {
         PVector wind = new PVector(-.1, 0);
         m.applyForce(wind);
             
       }  
     }
      m.display();
    }
    //----fleurs et fruits ----//
  if(counter >5)
   {
     if(!setFruits)
     {
        CurrentModel.setBranchTip(turtle.getEnds());
        CurrentModel.setFruits(10,15);
        Fruits = CurrentModel.getFruits();
        setFruits = true;
     }
      
    if(!a.isDead())
    {
     for (Fruit f: Fruits)
     {
        fill(f.getColorR(), f.getColorB(), f.getColorG(), f.getColorO());//red
        //strokeWeight(0);
        noStroke();
        ellipse(f.location.x,f.location.y,f.size,f.size);   
     }
      
     if(counter>6)
     {
        for (Fruit f: Fruits)
        {
          fill(f.getColorR(), f.getColorB(), f.getColorG(), f.getColorO());
          ellipse(f.location.x,f.location.y,f.size,f.size);
        
          if (mousePressed) 
          {

              if(mouseX < f.location.x)
              {
                PVector wind = new PVector(.1, 0);
                f.applyForce(wind);
       
              }
              
             if(mouseX > f.location.x)
              {
                PVector wind = new PVector(-.1, 0);
                f.applyForce(wind);
             
              }  
          }
        }
      }
    }
    }  
  }


void displayTree () {

  //---- Turtle ----//
  turtle.render();
  
}
//***********************************************************************************************

void keyPressed() {

  
    if (key == 'r') 
    {  
       Reset();
    }
  
    if (key == 'g') 
    {  
        if (counter < 4) 
        {
          turtle.setCount();
          pushMatrix();
          lsys.generate();
          turtle.setToDo(lsys.getSentence());
          turtle.changeLen(0.5);
          popMatrix();
        }
        counter++;
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
  if(millis()-start_Time<2000)
  {
    return;
  }
  
  CurrentModel=Models.get(2);
  setAngle = CurrentModel.getAngle();
  Reset(); 
}

public void Arbuste() 
{
  if(millis()-start_Time<2000)
  {
    return;
  }
  
  CurrentModel = Models.get(1);
  setAngle = CurrentModel.getAngle();
  Reset();
  
}

public void Herbacee() 
{
  if(millis()-start_Time<2000)
  {
    return;
  }
  
  CurrentModel = Models.get(0);
  setAngle = CurrentModel.getAngle();
  Reset();

}

public void Submit() { //a des erreurs de broadcast lors du launch
  if(millis()-start_Time<1000)
  {
    return;
  }
  
  //récupération des données et formatage
  char a = 'F';
  String StrCustomAxiom = cp5.get(Textfield.class,"Axiom").getText();
  
  for (int i = 0; i < 1; i++) 
    {
      a = StrCustomAxiom.charAt(i);
    }
    
  StrCustomAxiom = Character.toString(a);
  Float CustomAngle = Float.parseFloat((cp5.get(Textfield.class,"Angle").getText()).replace(',', '.'));
  String Equation = cp5.get(Textfield.class,"Sequence").getText();
  
  if(CurrentModel.getNom() != "Fougere")
  {
    CurrentModel = new Tree("Custom", 1, a, Equation, StrCustomAxiom, CustomAngle, 0, 0, 0, 0, 2, 10, 3);
  }
  
  else
  { //pour prendre plus qu'une fougere custom, on doit reloader la fougere entre les itération sinon il va prendre le modele avec 1 seul axiome. Le générateur a été fait avec une seule règle à suivre en tête, pas 2 ou +
    CurrentModel = new Tree("Custom", 2, a, Equation, StrCustomAxiom, CustomAngle, 'F', "FF", 0, 0, 0, 0, 2, 10, 3);
  }
  
  setAngle = CustomAngle;
  Reset();
}

public void Reset()
{
  Fruits.clear();
  setFruits=false;
  counter = 0;
  firstTime = false;
  initAttractor = true;
    popCounter = 0;
  setup();
  
}
