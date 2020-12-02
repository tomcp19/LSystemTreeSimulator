class Fruit {
 
PVector location;
PVector PSize;
PVector velocity;
PVector acceleration;

float size, weight; 
int r;
int b;
int g;
int o;
boolean isVisible;
  
  
    Fruit () 
  {
    //fill(255,0,0,60);
    //ellipse(0,0,8,8);
  }
  
  Fruit(PVector _location, float size) 
  {
    this.location = _location;
    this.size = size;
    PSize = new PVector(size, size);
    this.velocity = new PVector (0, 0);
    this.acceleration = new PVector (0 , 0);
    this.weight = size;
    isVisible = true;
  }
  
  
  public void setColors(int _r, int _b, int _g, int _o)
  {
    this.r = _r;
    this.b = _b;
    this.g = _g;
    this.o = _o;
  }
  
  public int getColorR()
  {
    return r;
  }
  
  public int getColorB()
  {
    return b;
  }
  
  public int getColorG()
  {
    return g;
  }
  
  public int getColorO()
  {
    return o;
  }
  
  public int getSize()
  {
    return int(size);
  }
}
