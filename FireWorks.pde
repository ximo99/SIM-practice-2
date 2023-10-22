public class FireWorks
{
  ArrayList<Rocket> rockets;

  FireWorks() 
  {
    rockets = new ArrayList<Rocket>();
  }
  
  // Código para añadir un cohete a la simulación
  void addRocket(RocketType type, PVector pos, PVector vel, color c)
  {
    Rocket rocket_aux = new Rocket(type, pos, vel, c);
    rockets.add(rocket_aux);
  }
  
  int getNumRockets()
  {
    return rockets.size();
  }
  
  void run()
  {
    for (int i = 0; i < rockets.size(); i++)
    {
      Rocket r = rockets.get(i);
      r.run();
    }
    
    simTime += SIM_STEP;    
  }
}
