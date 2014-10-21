import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.regex.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class proj extends PApplet {

String access_log = "access.log";

public void setup() { 
	Parser parser = new Parser(access_log);
}

public void draw() {}


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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "proj" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
