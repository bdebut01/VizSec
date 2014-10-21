import java.util.regex.*;

//for IP, 
//stupid java/processing refuses to accept \. the escaped dot.
//\b(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))\b
String REGEX_EXP = "\\b(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))\\b";

public class Parser {
	Parser(String file) {
		String data[] = loadStrings(file);

		Pattern r = Pattern.compile(REGEX_EXP);
		
		for(int i = 0; i < data.length; i++) {
			String line = data[i];
			Matcher m = r.matcher(line);

			println("IP: " + m.group(0));
		}	
	}
}