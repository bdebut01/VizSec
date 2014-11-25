String access_log = "data8.csv";
Table table;
ArrayList<Incident> incident_list;

/* Table Usage
table = loadTable("mammals.csv", "header");

  println(table.getRowCount() + " total rows in table"); 

  for (TableRow row : table.rows()) {
    
    int id = row.getInt("id");
    String species = row.getString("species");
    String name = row.getString("name");
    
    println(name + " (" + species + ") has an ID of " + id);
*/


void setup() { 
	// Parser parser = new Parser(access_log);
	table = loadTable(access_log, "header");
  incident_list = new ArrayList<Incident>();
  parse();
  println("Done parsing!");

}

void draw() {}





void parse() {
  int i = 0;
	for (TableRow row : table.rows()) {
    int id = i;
    String attack = row.getString("AttackType");
    String ip = row.getString("IP");
    String time_stamp = row.getString("Timestamp");
    String status_ = row.getString("Status");

    incident_list.add(new Incident(id, attack, ip, time_stamp, status_));
    i++;
	}
}