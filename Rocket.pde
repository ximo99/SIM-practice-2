public class Rocket
{
  RocketType _type;

  Particle casing;
  ArrayList<Particle> particles;
  
  PVector launchPoint;
  PVector launchVel;  
  PVector explosionPoint;
  
  int partCasing = 500;  // Número de partículas en una carcasa
  boolean hasExploded;
  color c;

  Rocket(RocketType type, PVector pos, PVector vel, color _c) 
  {
    _type = type;
    particles = new ArrayList<Particle>();
    
    launchPoint = pos.copy();
    launchVel = vel.copy();
    explosionPoint = new PVector(0.0, 0.0, 0.0);
    
    c = _c;
    hasExploded = false;
    
    createCasing();
  }
  
  // Codigo para crear la carcasa
  void createCasing()
  {
    int type = 0;  // Inicialización de la partícula en el tipo carcasa
    int ttl = 50;  // Inicialización de las carcasas con un TTL = 50
    float m = 4;   // Inicialización de las carcasas con una masa de 4 kg
    
    casing = new Particle(ParticleType.values()[type], launchPoint, launchVel, m, ttl, c);
    numParticles++;
  }
  
  // Codigo para utilizar el vector de partículas, creando particulas en él con diferentes velocidades para recrear distintos tipos de palmeras
  void explosion() 
  {
    float m = 2;    // Inicialización de las partículas del interior de las carcasas con una masa 2 kg
    int ttl = 200;  // Inicialización de las partículas del interior de las carcasa con un TTL = 200
    
    // Código para añadir un cohete a la simulación
    switch(_type)
    {
      case CIRCULO:
          for (int i = 0; i < partCasing; i++)
          {
            float ang = random(0, TWO_PI);
            PVector v_ang = new PVector(4, 4);
            PVector vel = new PVector(v_ang.x * 10 * cos(ang), v_ang.y * 10 * sin(ang));
            
            Particle particle_aux = new Particle(ParticleType.values()[1], explosionPoint, vel, m, ttl, c);
            particles.add(particle_aux);
            numParticles++;
          }
          
      break;
        
      case PALMERA:
          for (int i=0; i<partCasing; i++)
          {
            float rand = random(1, 20);
            PVector vel = new PVector(2 * rand*cos(i), 2 * rand*sin(i));
            
            Particle particle_aux = new Particle(ParticleType.values()[1], explosionPoint, vel, m, ttl, c);
            particles.add(particle_aux);
            numParticles++;
          }
      break;
        
      case CORAZON:
          for (int i=0; i<partCasing; i++)
          {
            PVector vel = new PVector(12 * sin(i) - 4 * sin(3*i), - (13 * cos(i) - 5 * cos(2*i) - 2 * cos(3*i) - cos(4*i)));
                        
            Particle particle_aux = new Particle(ParticleType.values()[1], explosionPoint, vel, m, ttl, c);
            particles.add(particle_aux);
            numParticles++;
          }
      break;
       
      case LINEA_DIAGONAL:
          for (int i=0; i<partCasing; i++)
          {
            PVector vel = new PVector(tan(i), tan(i));
            
            Particle particle_aux = new Particle(ParticleType.values()[1], explosionPoint, vel, m, ttl, c);
            particles.add(particle_aux);
            numParticles++;
          }
      break; 
      
      case LINEA_VERTICAL:
          for (int i=0; i<partCasing; i++)
          {
            PVector vel = new PVector(0, 10*random(-1,5));
            
            Particle particle_aux = new Particle(ParticleType.values()[1], explosionPoint, vel, m, ttl, c);
            particles.add(particle_aux);
            numParticles++;
          }
      break;

      case ESPIRAL:
          for (int i=0; i<partCasing; i++)
          {
            float ang = random(0, TWO_PI);
            PVector v_ang = new PVector (ang, ang);
            PVector vel = new PVector (v_ang.x * 10 * cos(ang), v_ang.y * 10 * sin(ang));
            
            Particle particle_aux = new Particle(ParticleType.values()[1], explosionPoint, vel, m, ttl, c);
            particles.add(particle_aux);
            numParticles++;
          }
         
      break;
    }
  }

  void run() 
  {
    // Codigo con la lógica de funcionamiento del cohete. En principio no hay que modificarlo.
    // Si la carcasa no ha explotado, se simula su ascenso.
    // Si la carcasa ha explotado, se genera su explosión y se simulan después las partículas creadas.
    // Cuando una partícula agota su tiempo de vida, es eliminada.
    
    if (!casing.isDead())
      casing.run();
    else if (casing.isDead() && !hasExploded)
    {
      numParticles--;
      hasExploded = true;

      explosionPoint = casing.getPosition().copy();
      explosion();
    }
    else
    {
      for (int i = particles.size() - 1; i >= 0; i--) 
      {
        Particle p = particles.get(i);
        p.run();
        
        if (p.isDead()) 
        {
          numParticles--;
          particles.remove(i);
        }
        
        // Código añadido para parar la simulación cuando el sistema se quede sin partículas mostrando el frame rate
        /*
        if(particles.size() == 0 || numParticles ==0)
          exit();
      
        print(1.0/deltaTimeDraw, "\n");
        */
      }
    }
  }
}
