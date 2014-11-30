String access_log = "data8.csv";
Table table;
ArrayList<Incident> incident_list; //Contains entire file of incidents
ArrayList<Incident> live_list;     //Contains solely active incidents



int DEMO_START_INDEX = 1262; //this is Sept 12's first occurrence


void setup() { 
  size(1000, 800);
	// Parser parser = new Parser(access_log);
	table = loadTable(access_log, "header");
  incident_list = new ArrayList<Incident>();
  live_list = new ArrayList<Incident>();

  parse();
  println("Done parsing!");
}

void draw() {
  
}


void delay(float time_delay)
{
  int now = millis();
  while(millis() - now <= (time_delay * 1000));
}