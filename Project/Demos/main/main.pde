String access_log = "data8.csv";
Table table;
ArrayList<Incident> incident_list; //Contains entire file of incidents
ArrayList<Incident> live_list;     //Contains solely active incidents



int DEMO_START_INDEX = 4075; //this is Sept 12's first occurrence


void setup() { 
	// Parser parser = new Parser(access_log);
	table = loadTable(access_log, "header");
  incident_list = new ArrayList<Incident>();
  live_list = new ArrayList<Incident>();

  parse();
  println("Size: " + incident_list.size());
  println("Done parsing!");
}

void draw() {
  
}

