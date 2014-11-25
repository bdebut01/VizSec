String access_log = "data.csv";
Table table;

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
	Parser parser = new Parser(access_log);
	table = loadTable("data.csv", "header");
}

void draw() {}





void parse() {
	for (int i = 0; i < table.getRowCount(); i++) {
		//Make a list of events?
	}
}