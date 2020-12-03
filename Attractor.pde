// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A class for a draggable attractive body in our world

class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector position;   // position
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  float size, weight;
  int r;
  int b;
  int g;
  int o;
  float lifespan;

  Attractor() 
  {
    position = new PVector(10,10);
    size = 1;
    lifespan = 0;
    mass = size;
    G = 1;
  }
  
  Attractor(float x, float y, float size) {
    position = new PVector(x, y);
    mass = size;
    this.size = size;
    lifespan = 0;
  }
  
  void setLifeSpan(float time)
  {
    lifespan = time;
  }
  
   void setAttractor(float x, float y, float size)
  {
    position = new PVector(x, y);
    mass = size;
    this.size = size;
    G = 1;
    lifespan = 1000;
  }
  
  void run() {
    update();
    display();
  }
  
  void update() 
    {
      lifespan -= 2;
    }
  
    boolean isDead() 
    {
    if (lifespan < 0.0) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(position,m.location);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d,5.0,25.0);                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = 3;      // mis arbitrairement
    force.mult(strength);                                  // Get force vector --> magnitude * direction
    return force;
  }  
  
  // Method to display
  void display() {
    strokeWeight(4);
    stroke(0);
    fill(175,200);
    ellipse(position.x, position.y,size,size);
  }
  
  void setPosition(float x, float y)
  {
    position.x = x;
    position.y = y;
  }
}
