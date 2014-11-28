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





void parse() {
  int id = 0;
	for (TableRow row : table.rows()) {
    String attack = row.getString("AttackType");
    String ip = row.getString("IP");
    String time_stamp = row.getString("Timestamp");
    String status_ = row.getString("Status");
    
    Incident curr = new Incident(id, attack, ip, time_stamp, status_);

    //Checking for duplicates here...
    //incident_list.add(curr);
    if(id == 0) {
      println("First");
      incident_list.add(curr);
      id++;
    } 
    else {
      Incident prevIncid = incident_list.get(id-1);

      if (!prevIncid.dupe(curr)) {
        curr.printMe();
        incident_list.add(curr);
        id++;
      }
    }
    
  }
}