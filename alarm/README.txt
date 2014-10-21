Assignment 2, Benjamin deButts

All parts have been correctly implemented.
Collaborated/discussed assignment with Sunjay Bhatia. Additionally, I used online resources like github, stackoverflow, etc. to aid in the writing of this program.

Hours spent: ~4 hrs


1) Heuristics
	Null and Xmas scans, out of all the incidents we are tasked with detecting, are the only unquestionably accurate scans. By their current definition at least, they will always have the same flags set to 1 or 0. Credit card detection is iffy at best as it will pick up on false positives easily. Any numbers that just so happen to match the regex expressions for the 4 companies will trigger. 	
	My alarm only detects nmap scans when they are explicitly labelled as such. Assuming all nmap scans are labelled in said way, then great. Incident detection will be good and accurate. However, I doubt this is the case.
	Finally, the shell commands are also not that great of a detection system. I found that shell commands, although they generally follow the regex I wrote, also contain some weird quirks which could probably sneak undetected through my alarm.

2) Add/change with regards to detecting incidents
	With more time, I would expand the types of TCP Scanning detections to include types other than just XMAS and NULL (protocol, proxy, ideal, CatSCAN, etc..). I would also look into other types of malicious scans other than nmap (it appears Kali has a few) and work to detect those. 
