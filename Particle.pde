public class Particle
{
  ParticleType _type;

  PVector s;   // Position (m)
  PVector v;   // Velocity (m/s)
  PVector a;   // Acceleration (m/(s*s))
  PVector f;   // Force (N)
  float m;     // Mass (kg)

  int ttl;   // Time to live (iterations)
  color c;   // Color (RGB)
  
  final static int particleSize = 1;   // Size (pixels)
  final static int casingLength = 10;  // Length (pixels)

  Particle(ParticleType type, PVector _s, PVector _v, float _m, int _ttl, color _c) 
  {
    _type = type;
    
    s = _s.copy();
    v = _v.copy();
    m = _m;

    a = new PVector(0.0 ,0.0, 0.0);
    f = new PVector(0.0, 0.0, 0.0);
   
    ttl = _ttl;
    c = _c;
  }

  void run() 
  {
    update();
    display();
  }

  void update() 
  {
    if (isDead())
      return;
      
    updateForce();
   
    // Codigo con la implementación de las ecuaciones diferenciales para actualizar el movimiento de la partícula
    PVector Ft = f.copy();
    a = PVector.div(Ft, m);
    v.add(PVector.mult(a, SIM_STEP));
    s.add(PVector.mult(v, SIM_STEP));
    
    ttl--;
  }
  
  // Código para calcular la fuerza que actua sobre la partícula
  void updateForce()
  {
    PVector Fp = PVector.mult(G, m);
    PVector Fw = PVector.mult(PVector.sub(windVelocity, v), WIND_CONSTANT);
    
    f = PVector.add(Fp, Fw);
  }
  
  PVector getPosition()
  {
    return s;
  }

  // Codigo para dibujar la partícula. Se debe dibujar de forma diferente según si es la carcasa o una partícula normal
  void display() 
  {
    switch(_type)
    {
      // Dibujado de la carcasa
      case CASING:
        stroke(c, ttl);
        fill(c);
        ellipse(s.x, s.y, casingLength, casingLength);
      break;
        
      // Dibujado de las partículas
      case REGULAR_PARTICLE:
        stroke(c, ttl);
        fill(c, ttl);
        ellipse(s.x, s.y, particleSize, particleSize);
      break;
    }
    
    
  }
  
  boolean isDead() 
  {
    if (ttl < 0.0) 
      return true;
    else
      return false;
  }
}
