class Mover extends GraphicObject {
  float topSpeed = 5;
  float topSteer = 0.05;
  
  float mass = 1;
  
  float r = 10; // Rayon du boid
  
  float radiusSeparation = 10 * r;
  float radiusAlignment = 20 * r;
  float radiusCohesion = 30 * r;

  float weightSeparation = 2;
  float weightAlignment = 1;
  float weightCohesion = 1;
  
  PVector steer;
  PVector sumAlignment;
  PVector sumCohesion;

  PVector zeroVector = new PVector(0, 0);
  
  Mover () {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  Mover (PVector loc, PVector vel) 
  {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
  }
  
  void checkEdges() 
  {
    if (location.x < 410) //bord du tableau de controle
    {
      this.velocity.x *= -1;
    } 
    else if (location.x + r> width) 
    {
      this.velocity.x *= -1;
    }
    
    if (location.y < 0) 
    {
      this.velocity.y *= -1;
    } 
    else if (location.y + r > height) 
    {
      this.velocity.y *= -1;
    }
  }
  
  void flock (ArrayList<Mover> boids) 
  {
    PVector separation = separate(boids);
    PVector alignment = align(boids);
    PVector cohesion = cohesion(boids);
    
    separation.mult(weightSeparation);
    alignment.mult(weightSeparation);
    cohesion.mult(weightCohesion);

    applyForce(separation);
    applyForce(alignment);
    applyForce(cohesion);
  }
  
  
  void update(float deltaTime) 
  {
    checkEdges();
    velocity.add (acceleration);
    velocity.add(random(-2,2), random(-2,2));//pour imiter le comportement de vol de mouches / insectes
    velocity.limit(topSpeed);
    location.add (velocity);
    acceleration.mult (0);      
  }
  
  void display() 
  {
    noStroke();
    fill (fillColor);
    
    pushMatrix();
    translate(location.x, location.y);
     
      ellipse(0,0, 8, 8);
      ellipse(3,-3, 6, 6);
      ellipse(-3,-3, 6, 6);
    
    popMatrix();
    
  }
  
  PVector separate (ArrayList<Mover> boids) 
  {
    if (steer == null) 
    {
      steer = new PVector(0, 0, 0);
    }
    else 
    {
      steer.setMag(0);
    }
    
    int count = 0;
    
    for (Mover other : boids) 
    {
      float d = PVector.dist(location, other.location);
      
      if (d > 0 && d < radiusSeparation) 
      {
        PVector diff = PVector.sub(location, other.location);
        
        diff.normalize();
        diff.div(d);
        
        steer.add(diff);
        
        count++;
      }
    }
    
    if (count > 0) 
    {
      steer.div(count);
    }
    
    if (steer.mag() > 0) 
    {
      steer.setMag(topSpeed);
      steer.sub(velocity);
      steer.limit(topSteer);
    }
    
    return steer;
  }

  PVector align (ArrayList<Mover> boids) 
  {

    if (sumAlignment == null) 
    {
      sumAlignment = new PVector();      
    } 
    else 
    {
      sumAlignment.mult(0);
    }

    int count = 0;

    for (Mover other : boids) 
    {
      float d = PVector.dist(this.location, other.location);

      if (d > 0 && d < radiusAlignment) 
      {
        sumAlignment.add(other.velocity);
        count++;
      }
    }

    if (count > 0) 
    {
      sumAlignment.div((float)count);
      sumAlignment.setMag(topSpeed);

      PVector steer = PVector.sub(sumAlignment, this.velocity);
      steer.limit(topSteer);

      return steer;
    } 
    else 
    {
      return zeroVector;
    }
  }

   // Méthode qui calcule et applique une force de braquage vers une cible
  // STEER = CIBLE moins VITESSE
  
  PVector seek (PVector target) 
  {
    // Vecteur différentiel vers la cible
    PVector desired = PVector.sub (target, this.location);
    
    // VITESSE MAXIMALE VERS LA CIBLE
    desired.setMag(topSpeed);
    
    // Braquage
    PVector steer = PVector.sub (desired, velocity);
    steer.limit(topSteer);
    
    return steer;    
  }

  PVector cohesion (ArrayList<Mover> boids) 
  {
    if (sumCohesion == null) 
    {
      sumCohesion = new PVector();      
    } 
    else 
    {
      sumCohesion.mult(0);
    }

    int count = 0;

    for (Mover other : boids) {
      float d = PVector.dist(location, other.location);

      if (d > 0 && d < radiusCohesion) {
        sumCohesion.add(other.location);
        count++;
      }
    }

    if (count > 0) {
      sumCohesion.div(count);

      return seek(sumCohesion);
    } else {
      return zeroVector;
    }
    
  }
  
  void applyForce (PVector force) 
  {
    PVector f;
    
    if (mass != 1)
      f = PVector.div (force, mass);
    else
      f = force;
   
    this.acceleration.add(f);    
  }
  
}
