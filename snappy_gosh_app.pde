
snappy_gosh p=new snappy_gosh(100, 300);
WALLS w=new WALLS();


class snappy_gosh
{ 
  float positionX, positionY, speed=5, alive=1;
  snappy_gosh (float x, float y) {
    positionX=x;
    positionY=y;
  }
  float get_x () {
    return positionX;
  }

  float get_y () {
    return positionY;
  }
  void jump_gosh() {
    delay(500);
    for (int i=1; i<=5; i++)
      draw_gosh();
    positionY-=speed;
    speed-=1;
  }
  void fly_gosh() {
    {
      draw_gosh();
      positionY-=speed;
      speed-=1;
    }
  }
  void fall_gosh () {
    draw_gosh();
    positionY+=speed;
  }
  void draw_gosh () {
    fill(255, 255, 0);
    ellipse(positionX, positionY, 100, 100);
  }
  void ded () {
    fill(255, 0, 0);
    ellipse(positionX, positionY, 100, 100);
  }
  void update_gosh()
  {
    if (keyPressed==true)
    {
      //speed=10;
      //jump_gosh();
      speed=10;
      fly_gosh();
    } else
    {
      speed=10;
      fall_gosh();
    }
  }
}

class wall 
{
  float y=random(700), x=1080;

  void draw_wall()
  {  
    fill(102, 51, 0);
    rect(x, 0, 200, y-100);
    rect(x, y+450, 200, 2050 -y);
    fill(255, 0, 0);
    ellipse(x+100, y-75, 200, 200);
    ellipse(x+100, y+425, 200, 200);
  }
  float get_x()
  {
    return x;
  }
  float get_y()
  {
    return y;
  }
  float get_up_x()
  {
    return x+100;
  }
  float get_up_y()
  {
    return y-75;
  }
  float get_down_x()
  {
    return x+100;
  }
  float get_down_y()
  {
    return y+425;
  }
  void update_wall()
  {
    x-=5;
    draw_wall();
  }
}
class WALLS
{
  ArrayList<wall> walls = new ArrayList<wall>();
  void add_wall()
  {
    walls.add(new wall());
  }
  int get_size()
  {
    return walls.size();
  }
  wall get_wall(int index)
  { 
    return walls.get(index);
  }
  void update_walls()
  {

    for (int i=0; i<walls.size(); i++)
    {
      wall v=walls.get(i);
      if (v.get_x()==-200)
      {
        walls.remove(i);
      } else 
      {
        if (v.get_x()==540)
          walls.add(new wall());
        v.update_wall();
      }
    }
  }
}

int gosh_collides_wall(snappy_gosh p, WALLS w)
{
  float gosh_x=p.get_x(), wall_x;
  float gosh_y=p.get_y(), wall_y;
  float gosh_r=50, wall_r=100;
  wall v;
  int result=1;
  
  
    v=w.get_wall(0);
    wall_x=v.get_up_x();
    wall_y=v.get_up_y();
    if (dist(gosh_x, gosh_y, wall_x, wall_y)<=gosh_r+wall_r)
      return result;
    if ((wall_x+wall_r)-(gosh_x+gosh_r)<=150 && gosh_y<wall_y)
      return result;
    


    wall_x=v.get_down_x();
    wall_y=v.get_down_y();
    if (dist(gosh_x, gosh_y, wall_x, wall_y)<=gosh_r+wall_r)
      return result; 
    if (dist(gosh_x, gosh_y, wall_x, wall_y)<=gosh_r+wall_r)
      return result;
    if ((wall_x+wall_r)-(gosh_x+gosh_r)<=150 && gosh_y>wall_y)
      return result;
  
  result=0;   
  return result;
}
void setup()
{

  size(1080, 2400);
  w.add_wall();
}


void draw()
{
  if (p.alive==1)
  {
    noStroke();
    background(50, 70, 200);
    w.update_walls();
    p.update_gosh();
    if (gosh_collides_wall(p, w)==1)
      p.alive=0;
  }
  else p.ded();
}
