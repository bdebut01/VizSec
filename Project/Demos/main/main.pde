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
  int i = 1;
	for (TableRow row : table.rows()) {
    int id = i;
    String attack = row.getString("AttackType");
    String ip = row.getString("IP");
    String time_stamp = row.getString("Timestamp");
    String status_ = row.getString("Status");

    //Checking for duplicates here...
    if(i == 1) incident_list.add(new Incident(id, attack, ip, time_stamp, status_));
    else {
      Incident prevIncid = incident_list.get(i-1);
      if (!duplicateIncident(prevIncid, attack, ip, time_stamp, status_)) {  
        println("DUPLICATE FOUND!");
        incident_list.add(new Incident(id, attack, ip, time_stamp, status_));
        i++;
      }
    }
    
  }
}

boolean duplicateIncident(Incident i, String type, String ip, String time_,
                       String status_) {
  i.printMe();
  return (i.type == type && i.ip == ip &&
       i.time_stamp == time_ && i.req_status == status_);
}