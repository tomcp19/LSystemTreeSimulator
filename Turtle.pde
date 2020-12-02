// Modifié de The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Turtle {

  String todo;
  float len;
  float theta;
  ArrayList<PVector> ends;
  boolean setCount = true;
  
  PVector loc;
  float orientation;
  int count = 0;
  
  boolean tip;
  int colorIndex;
  color[] col = {#728116, #26D33C, #863232, #A74444,#CE5151};
  boolean print = true;
  float r, b, g, a, sw;

  Turtle(String s, float l, float t) 
  {
    todo = s;
    len = l; 
    theta = t;
    
    this.tip = true;
    colorIndex = 1;
    ends = new ArrayList<PVector>();
  } 
  

  void render() 
  {
    //place dans la bonne orientation
    pushMatrix();
    translate(width/2, height);
    rotate(-PI/2);
       
    strokeWeight(sw);
    stroke(r, b, g);

    for (int i = 0; i < todo.length(); i++) 
    {
      char c = todo.charAt(i);
      
      if (c == 'F' || c == 'X') 
      {
        loc = new PVector(0, 0);
        forward(len);
        translate(len, 0);
        
      } 
      else if (c == '+') 
      {
        
        rotate(theta);

      } 
      else if (c == '-')   
      {
        
        rotate(-theta);

      } 
      else if (c == '[') 
      {
        pushMatrix();

      } else if (c == ']') 
      {
        
        if(count == 5)
        {
          ends.add(new PVector(screenX(0,0),screenY(0,0)));
        }
        popMatrix();     
      }
    }
    
    if(setCount)
    {
      count++;
    }
    
    setCount = false;
    popMatrix();
  }

  void setLen(float l) 
  {
    len = l;
  } 

  public ArrayList getEnds()
  {
    return ends;
  }

  public void setCount()
  {
   setCount = true;
  }

  void changeLen(float percent) 
  {
    len *= percent;
  }
  
  void setColor(float r, float b, float g, float a, float sw) 
  {
    this.r = r;
    this.b = b;
    this.g = g;
    this.a =a;
    this.sw = sw;
  }

  void setToDo(String s) 
  {
    todo = s;
  }
  
  void forward(float pixels) //calcaul de la position pour la fin/extrémité
  {
    PVector start = loc;
    PVector end = PVector.add(loc, polar(pixels, orientation));
    linev(start, end); 
    loc = end;
  }
  
  void linev(PVector a, PVector b) //line() mais avec vector
  {
    line(a.x, a.y, b.x, b.y);
  }
  
  PVector polar(float r, float theta) //conversion angle et rayon en vecteur
  {
    return new PVector(r*cos(theta),r*sin(-theta));
  }
}
