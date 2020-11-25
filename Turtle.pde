// The Nature of Code
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
  int countdata = 0;
  
  boolean tip;
  int colorIndex;
  color[] col = {#728116, #26D33C, #863232, #A74444,#CE5151};
  boolean print = true;

  Turtle(String s, float l, float t) {
    todo = s;
    len = l; 
    theta = t;
    
    this.tip = true;
    colorIndex = 1;
    ends = new ArrayList<PVector>();
  } 
  
  /*public void setTurtle(String s, float l, float t)
{
    todo = s;
    len = l; 
    theta = t;
     ends = new ArrayList<PVector>();
     setCount = true;
  
  count = 0;
  countdata = 0;
}*/

  void render() {
    
    pushMatrix();
    translate(width/2, height);
    rotate(-PI/2);
    
    countdata = 0;
    stroke(0, 175);

    for (int i = 0; i < todo.length(); i++) 
    {
      char c = todo.charAt(i);
      
      if (c == 'F' || c == 'G') 
      {
        loc = new PVector(0, 0);
        forward(len);
        translate(len, 0);
        
      } else if (c == '+') 
      {
        
        rotate(theta);

      } else if (c == '-')   
      {
        
        rotate(-theta);

      } else if (c == '[') 
      {
        pushMatrix();

      } else if (c == ']') 
      {
        
        if(count == 3)
        {
          ends.add(new PVector(screenX(0,0),screenY(0,0), countdata));
          countdata++;
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

  void setToDo(String s) {
    todo = s;
  }
  
  void forward(float pixels) //calculate positions when moving forward
  {
    PVector start = loc;
    PVector end = PVector.add(loc, polar(pixels, orientation));
    linev(start, end);
    loc = end;
  }
  
  void linev(PVector a, PVector b) //new line function with PVectors. used by forward function
  {
    line(a.x, a.y, b.x, b.y);
  }
  
  PVector polar(float r, float theta) //converts an angle and radius into a vector
  {
    return new PVector(r*cos(theta),r*sin(-theta)); // negate y for left handed coordinate system
  }
}
