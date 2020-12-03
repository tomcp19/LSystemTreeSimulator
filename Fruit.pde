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
float lifespan;
  
  
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
    lifespan = 1000;
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
  
  void applyForce (PVector force) 
  {
    PVector f = PVector.div (force, weight);
    this.acceleration.add(f);
  }
  
  void update()
  {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration = new PVector(0,0);
  }
  
  boolean isDead() 
    {
    if (lifespan < 0.0) 
    {
      return true;
    } 
    else {
      return false;
    }
  }

  
  void checkEdges() 
  {
    if (location.x > width) 
    {
      location.x = width;
      velocity.x *= -1;
    } 
    else if (location.x < 0) //taille du menu de modelisation
    {
      location.x = 0;
      velocity.x *= -1;
    }

    if (location.y >= height) 
    {
      velocity.y *= -0.3; //on ne veut pas que ca rebondissent trop, ce sont des feuilles/fleurs/fruits
      location.y = height;
    }
  }
}
