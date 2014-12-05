import ddf.minim.*; //Minim library
import java.util.Random;

String access_log = "data8.csv";
Table table;
ArrayList<Incident> incident_list; //Contains entire file of incidents
ArrayList<Incident> live_list;     //Contains solely active incidents

ArrayList<Attack> attacks; //global attacks list

Manager tab_manager;

int hover_sev;

float tabs_width;
float tabs_height;

Minim minim; //base minim object
AudioSample snd[]; //AudioSamples are "triggered" sounds
boolean isSmart = false;
float TONE_DURATION = 25; //now some jank constant related to framerate

int NUM_ATTACK_TYPES = 8;
int DEMO_START_INDEX = 0; //this is Sept 12's first occurrence

//Time simulator
float FREQUENCY = 400; //higher it is, the more infrequent
Random r;
int PROB_HIGH = 400; //20 == OFTEN, 120 == SOME, 400 == RARE



int TIME;

void setup() { 
  background(255);
  size(1100, 800);
	// Parser parser = new Parser(access_log);
	table = loadTable(access_log, "header");
  incident_list = new ArrayList<Incident>();
  live_list = new ArrayList<Incident>();

  //Tab Manager
  tabs_width = width * .3;
  tabs_height = height - 20;
  tab_manager = new Manager(10.0, 10.0, tabs_width, tabs_height);

  //Time simulator
  r = new Random();

  //Sounds
  minim = new Minim(this);
  snd = new AudioSample[NUM_ATTACK_TYPES];
  setupSound();

  parse();
  //Start demo at specific time
  for(int i = DEMO_START_INDEX; i < incident_list.size(); i++) {
    live_list.add(incident_list.get(i));
  }
}

void draw() {
  smooth();
  background(255);
  
  tab_manager.render(tabs_width, tabs_height);

  TIME++;
  // if(TIME%FREQUENCY == 0) {
  //   tab_manager.addIncident(live_list.remove(0));
  // }

  float probability = r.nextInt(PROB_HIGH);
  if(TIME == PROB_HIGH*2) {
    tab_manager.addIncident(live_list.remove(0));
  }
 /* if(probability == 0) {
    tab_manager.addIncident(live_list.remove(0));
  }*/
}


void mouseClicked() {
  tab_manager.click();
}

void setupSound() {
  int extension = 340;
  for(int i = 0; i < NUM_ATTACK_TYPES; i++) {
    snd[i] = minim.loadSample("tones/" + (extension - i * 20) + ".wav");
  }
}

void aud_stopAll() {
  for(int i = 0; i < NUM_ATTACK_TYPES; i++) {
    snd[i].close();
  }
}

//Delays in seconds
void delay(float time_delay)
{
  int now = millis();
  while(millis() - now <= (time_delay * 1000));
}