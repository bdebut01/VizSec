import java.util.Random;
String access_log = "data8.csv";
Table table;
ArrayList<Incident> incident_list; //Contains entire file of incidents
ArrayList<Incident> live_list;     //Contains solely active incidents

Manager tab_manager;

int NUM_ATTACK_TYPES = 8;
int DEMO_START_INDEX = 1262; //this is Sept 12's first occurrence
float FREQUENCY = 400; //higher it is, the more infrequent
Random r;
int PROB_HIGH = 100;

float tabs_width;
float tabs_height;

float TIME;

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

  r = new Random();

  parse();
  println("Done parsing!");
  for(int i = DEMO_START_INDEX; i < incident_list.size(); i++) {
    live_list.add(incident_list.get(i));
  }
}

void draw() {
  smooth();
  background(255);
  

  //should only have to call Manager.render(width * .3, height * .8) for drawing at least...
  tab_manager.render(tabs_width, tabs_height);

  TIME++;
  // if(TIME%FREQUENCY == 0) {
  //   tab_manager.addIncident(live_list.remove(0));
  // }

  float probability = r.nextInt(PROB_HIGH);
  if(probability == 0) {
    tab_manager.addIncident(live_list.remove(0));
  }
}


void mouseClicked() {
  tab_manager.click();
}

void delay(float time_delay)
{
  int now = millis();
  while(millis() - now <= (time_delay * 1000));
}