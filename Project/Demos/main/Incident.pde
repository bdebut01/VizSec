class Incident {
	int id;
	String type;
	String ip;
	String time_stamp;
	String req_status;

	Incident(int id_, String type_, String ip_, String time_stamp_, String req_status_) {
		id = id_;
		type = type_;
		ip = ip_;
		time_stamp = time_stamp_;
		req_status = req_status_;
	}

	void printMe() {
		println("Attack type: " + type 		+ " " +
			   "IP Address: "  + ip     	+ " " +
			   "Time stamp: "  + time_stamp + " " +
			   "Status: " 	   + req_status);
	}

	boolean dupe(Incident j) {
		return (this.type.equals(j.type)		&&
				this.ip.equals(j.ip) 			&&
				this.time_stamp.equals(j.time_stamp) &&
				this.req_status.equals(j.req_status));
	}
}