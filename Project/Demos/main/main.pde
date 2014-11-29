String access_log = "data8.csv";
Table table;
ArrayList<Incident> incident_list; //Contains entire file of incidents
ArrayList<Incident> live_list;     //Contains solely active incidents



int DEMO_START_INDEX = 1262; //this is Sept 12's first occurrence


void setup() { 
	// Parser parser = new Parser(access_log);
	table = loadTable(access_log, "header");
  incident_list = new ArrayList<Incident>();
  live_list = new ArrayList<Incident>();

  parse();
  println("Size: " + incident_list.size());
  println("Done parsing!");

  findSeptember();
}

void draw() {
  
}

void findSeptember() {
  for(int i =0;i<incident_list.size();i++) {
    Incident n = incident_list.get(i);
    if(n.time_stamp.equals("09/12/2014 00:38:26")) {
      println (i);
      return;
    }
  }
}