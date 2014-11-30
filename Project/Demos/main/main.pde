String access_log = "data8.csv";
Table table;
ArrayList<Incident> incident_list; //Contains entire file of incidents
ArrayList<Incident> live_list;     //Contains solely active incidents

Manager tab_manager;


int NUM_ATTACK_TYPES = 8;
int DEMO_START_INDEX = 1262; //this is Sept 12's first occurrence

float tabs_width;
float tabs_height;

void setup() { 
  background(255);
  size(1000, 800);
	// Parser parser = new Parser(access_log);
	table = loadTable(access_log, "header");
  incident_list = new ArrayList<Incident>();
  live_list = new ArrayList<Incident>();

  tabs_width = width * .3;
  tabs_height = height - 20;
  tab_manager = new Manager(10.0, 10.0, tabs_width, tabs_height);

  parse();
  println("Done parsing!");
}

void draw() {
  //should only have to call Manager.render(width * .3, height * .8) for drawing at least...
  tab_manager.render(tabs_width, tabs_height);
}


void delay(float time_delay)
{
  int now = millis();
  while(millis() - now <= (time_delay * 1000));
}