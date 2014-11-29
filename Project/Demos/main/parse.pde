void parse() {
  int id = 0;
	for (TableRow row : table.rows()) {
    String attack = row.getString("AttackType");
    String ip = row.getString("IP");
    String time_stamp = row.getString("Timestamp");
    String status_ = row.getString("Status");
    
    Incident curr = new Incident(id, attack, ip, time_stamp, status_);

    //Checking for duplicates here...
    if(id == 0) {
      incident_list.add(curr);
      id++;
    } 
    else {
      Incident prevIncid = incident_list.get(id-1);

      if (!prevIncid.dupe(curr)) {
        incident_list.add(curr);
        id++;
      }
    }
  }
}