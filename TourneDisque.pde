import SimpleOpenNI.*;
import ddf.minim.*;
import beads.*;

SimpleOpenNI context;
SmartPoint sp;
Btn btn1, btn2, btn3, btn4;

AudioContext ac;

SamplePlayer son1, son2, son3;

Gain sampleGain;
Glide gainValue;
Glide rateValue;

PImage img1, img2, img3, img4, img5, img6;
float counter;
int x,y,a;

void setup(){
  size(600, 600);
  
  context = new SimpleOpenNI(this);
  context.setMirror(true);
  context.enableDepth();
  sp = new SmartPoint();
  
  btn1 = new Btn (width-570, 10, 40, 40, color(255, 0, 0),1,5);
  btn2 = new Btn(width-420, 10, 30, 30, color(0, 255, 0), 2, 5);
  btn3 = new Btn(width-270, 10, 30, 30, color(0, 255, 0), 2, 5);
  btn4 = new Btn(width-45, 10, 30, 30, color(0, 255, 0), 2, 5);
  img1 = loadImage("dz.png");
  img2 = loadImage("fr.png");
  img3 = loadImage("cu.png");
  img4 = loadImage("close.png");
  img5 = loadImage("Vinyl4.png");
  img6 = loadImage("fond.jpg");
  
  ac = new AudioContext();
  //vérifier que les sons sont bien charger
  try{
    son1 = new SamplePlayer (ac, new Sample(sketchPath("") + "alg.mp3"));
    son2 = new SamplePlayer (ac, new Sample(sketchPath("") + "france.mp3"));
    son3 = new SamplePlayer (ac, new Sample(sketchPath("") + "cuba.mp3"));
  }
  catch (Exception e)
  {
      println("Echec du chargement des fichiers");
      e.printStackTrace();
      exit();
  }
  son1.setKillOnEnd(false);//Permet de rélire plusieurs fois un son 
  son2.setKillOnEnd(false);
  son3.setKillOnEnd(false);
  
  rateValue = new Glide (ac, 1, 30); //initialise la position de lecture du son
  son1.setRate(rateValue);
  son2.setRate(rateValue);
  son3.setRate(rateValue);
  // initialisation du volume
  gainValue = new Glide (ac, 0.0, 30);
  sampleGain = new Gain (ac, 1, gainValue); 
  sampleGain.addInput(son1);
  sampleGain.addInput(son2);
  sampleGain.addInput(son3);
  
  ac.out.addInput(sampleGain);
}

void draw(){
  background(255);
 // image(img6, 0, 0, 600, 600);
  context.update();
  sp.update();
  tint (255, 120);
  tint (255, 255);
  
  //btn1.display();
  //btn2.display();  
  //btn3.display();  
  //btn4.display();
  image(img1, width-570, 10, 60, 40);  
  image(img2,width-420, 10, 60, 40);
  image(img3,width-270, 10, 60, 40);
  image(img4, width-50, 10, 40, 40);
  sp.display();
  sp.manipSon();
  //counter=0;
  if (sp.hitTarget(btn1)){
    // démarrage du context audio
    ac.start();
    // set the start position to the end of the file
    son2.setToEnd();
    son3.setToEnd();
    // set the start position to the beginning
    son1.setPosition(000);
    //Lecture du son
    son1.start(); 
  }
  else if (sp.hitTarget(btn2)){
    ac.start();
    son1.setToEnd();
    son3.setToEnd();
    son2.setPosition(000);
    son2.start(); 
  } else if (sp.hitTarget(btn3)){
    ac.start();    
    son1.setToEnd();
    son2.setToEnd();
    son3.setPosition(000);
    son3.start();   
  }
  if (sp.hitTarget(btn4)){
    exit();
  }
  //Rotation du vinyl par rapport à la position du pt le plus proche cam
  counter++;
  translate(width/2, height/2);
  if (sp.lastLocation.x<300) {
    x = int(sp.lastLocation.x)-300;
    rotate(x/100*counter*TWO_PI/(360));
    translate(-200, -200);
  } else {
    y=int(sp.lastLocation.x)-300;
    rotate(y/100*counter*TWO_PI/360);
    translate(-200, -200);
    
  }
  image(img5, 0, 0, 400, 400);
  //println(int(sp.lastlocation.x));
}
