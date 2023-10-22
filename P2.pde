// Authors:
// Julián Rodríguez
// Ximo Casanova

// Problem description:
// Fireworks

// Tipos de palmera
enum RocketType 
{
  CIRCULO,
  PALMERA,
  CORAZON,
  LINEA_DIAGONAL,
  LINEA_VERTICAL,
  ESPIRAL,
  RANDOM
}

final int NUM_ROCKET_TYPES = RocketType.values().length;
RocketType _type = RocketType.RANDOM;

// Tipos de particulas
enum ParticleType 
{
  CASING,
  REGULAR_PARTICLE 
}

// Particle control:
FireWorks fw;   // Main object of the program
int numParticles = 0;   // Number of particles of the simulation

// Problem variables:
final float Gc = 9.801;   // Gravity constant (m/(s*s))
final PVector G = new PVector(0.0, Gc);   // Acceleration due to gravity (m/(s*s))
PVector windVelocity = new PVector(10.0, 0.0);   // Wind velocity (m/s)
final float WIND_CONSTANT = 1.0;   // Constant to convert apparent wind speed into wind force (Kg/s)

// Display values:
final boolean FULL_SCREEN = false;
final int [] BACKGROUND_COLOR = {10, 10, 25};
final int DRAW_FREQ = 50;    // Draw frequency (Hz or Frame-per-second)
int DISPLAY_SIZE_X = 1500;   // Display width (pixels)
int DISPLAY_SIZE_Y = 1000;   // Display height (pixels)

// Time control:
int lastTimeDraw = 0;   // Last measure of time in draw() function (ms)
float deltaTimeDraw = 0.0;   // Time between draw() calls (s)
float simTime = 0.0;   // Simulated time (s)
float elapsedTime = 0.0;   // Elapsed (real) time (s)
final float SIM_STEP = 0.02;   // Simulation step (s)

void settings()
{
  if (FULL_SCREEN)
  {
    fullScreen();
    DISPLAY_SIZE_X = displayWidth;
    DISPLAY_SIZE_Y = displayHeight;
  } 
  else
    size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y);
}

void setup()
{
  frameRate(DRAW_FREQ);
  lastTimeDraw = millis();

  fw = new FireWorks();
  numParticles = 0;
}

void printInfo()
{
  fill(255);
  textSize(15);
  text("Number of particles : " + numParticles, width*0.025, height*0.05);
  text("Frame rate = " + 1.0/deltaTimeDraw + " fps", width*0.025, height*0.075);
  text("Elapsed time = " + elapsedTime + " s", width*0.025 , height*0.100);
  text("Simulated time = " + simTime + " s ", width*0.025, height*0.125);
  text("Tipo de cohete = " + _type, width*0.025, height*0.150);
  
  /*
  text("Pulse la tecla 0 para crear círculos.", width*0.025, height*0.775);
  text("Pulse la tecla 1 para crear palemeras.", width*0.025, height*0.800);
  text("Pulse la tecla 2 para crear corazones.", width*0.025, height*0.825);
  text("Pulse la tecla 3 para crear líneas diagonales.", width*0.025, height*0.850);
  text("Pulse la tecla 4 para crear líneas verticales.", width*0.025, height*0.875);
  text("Pulse la tecla 5 para crear espirales.", width*0.025, height*0.900);
  text("Pulse la tecla 6 para crear formas aleatorias.", width*0.025, height*0.925);
  text("Pulse el ratón para añadir fuegos artificiales.", width*0.025, height*0.950);
  text("Pulse las flechas para modificar la dirección del viento.", width*0.025, height*0.975);
  */
  
  text("Pulse la tecla 0 para crear círculos.", width*0.7, height*0.05);
  text("Pulse la tecla 1 para crear palmeras.", width*0.7, height*0.075);
  text("Pulse la tecla 2 para crear corazones.", width*0.7, height*0.100);
  text("Pulse la tecla 3 para crear líneas diagonales.", width*0.7, height*0.125);
  text("Pulse la tecla 4 para crear líneas verticales.", width*0.7, height*0.150);
  text("Pulse la tecla 5 para crear espirales.", width*0.7, height*0.175);
  text("Pulse la tecla 6 para crear formas aleatorias.", width*0.7, height*0.200);
  text("Pulse el ratón para añadir fuegos artificiales.", width*0.7, height*0.225);
  text("Pulse las flechas para modificar la dirección del viento.", width*0.7, height*0.250);
}

// Código para dibujar el vector que representa el viento
void drawWind()
{
  pushMatrix();
  translate(width/2, 100);
  stroke(255);
  
  PVector windArrow = new PVector(windVelocity.x, windVelocity.y);
  strokeWeight(5);
  line(0, 0, windArrow.x, windArrow.y);
  popMatrix();
}

void draw()
{
  int now = millis();
  deltaTimeDraw = (now - lastTimeDraw)/1000.0;
  elapsedTime += deltaTimeDraw;
  lastTimeDraw = now;

  background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);
  
  fw.run();
  printInfo();  
  drawWind();
  
  // Código añadido para parar la simulación en el segundo 10 mostrando el tiempo medio que cuesta simular cada paso de simulación
  /*
  if (simTime > 10) {
    print(elapsedTime - simTime);
    
    exit();
  }
  */
}

void mousePressed()
{
  PVector pos = new PVector(mouseX, mouseY);
  PVector vel = new PVector((pos.x - width/2), (pos.y - height));
  color c = color(random(255),random(255),random(255));
  
  int type = 1;
  
  if (_type == RocketType.CIRCULO) {
    type = 0;
  }
  else if (_type == RocketType.PALMERA) {
    type = 1;
  }
  else if (_type == RocketType.CORAZON) {
    type = 2;
  }
  else if (_type == RocketType.LINEA_DIAGONAL) {
    type = 3;
  }
  else if (_type == RocketType.LINEA_VERTICAL) {
    type = 4;
  }
  else if (_type == RocketType.ESPIRAL) {
    type = 5;
  }
  else if (_type == RocketType.RANDOM) {
    type = (int)(random(0,6));
  }
  
  fw.addRocket(RocketType.values()[type], new PVector(width/2, height), vel, c);
}

// Código para manejar la interfaz de teclado
void keyPressed()
{
  switch(key)
  {
    case '0':
      _type = RocketType.CIRCULO;
    break;
    
    case '1':
      _type = RocketType.PALMERA;
    break;
    
    case '2':
      _type = RocketType.CORAZON;
    break;
    
    case '3':
      _type = RocketType.LINEA_DIAGONAL;
    break;
    
    case '4':
      _type = RocketType.LINEA_VERTICAL;
    break;
    
    case '5':
      _type = RocketType.ESPIRAL;
    break;
    
    case '6':
      _type = RocketType.RANDOM;
    break;
    
    case 's':
    case 'S':
      stop();
    break;
    
    default:
    break;
  }

  switch(keyCode)
  {
    case UP:
        windVelocity.add(0.0, -5.0);
    break;
    
    case DOWN:
        windVelocity.add(0.0, +5.0);
    break;
    
    case RIGHT:
        windVelocity.add(5.0, 0.0);
    break;
    
    case LEFT:
        windVelocity.add(-5.0, 0.0);
    break;
    
    default:
    break;
  }
}
