import com.hamoid.*;
import java.awt.*;
//------video export and robot---
PImage screenshot;
VideoExport videoExport;
//-------------------------------

PGraphics pg; // graphic image for screenrecord
boolean recording;
PImage rec, recOn, stop; // buttons

void setup() {
  size(280, 140);

  pg = createGraphics(displayWidth, displayHeight); // ton screenSize image

  String outputVideo = "videoExported-"+year()+month()+day()+".mp4"; // save named at 
  //--------------export settings -----
  videoExport = new VideoExport(this, outputVideo, pg);
  videoExport.setFrameRate(30);
  videoExport.setQuality(100, 192);
  videoExport.startMovie();
  //----images-----------
  rec = loadImage("costume1.png");
  recOn = loadImage("costume3.png");
  stop = loadImage("costume2.png");

  rec.resize(140, 140);
  recOn.resize(140, 140);
  stop.resize(140, 140);
  //---app settings
  surface.setTitle("plyWood");
  surface.setIcon(rec);
  surface.setLocation(0, 0);
}

void draw() {
  //-----hud------
  background(0);
  if (!recording)image(rec, 0, 0);
  if (recording)image(recOn, 0, 0);
  image(stop, 140, 0);
  //-----------

  //-----recording---------
  if (!focused && recording) {
    screenshot();
    pg.beginDraw();
    if (screenshot != null) pg.image(screenshot, 0, 0, displayWidth, displayHeight);
    pg.endDraw();
    videoExport.saveFrame();
  }
  //-----------------------
}

void mouseClicked() {
  //------ui usage--------------
  if (mouseX > 140 && mouseX < 280 && mouseY > 0 && mouseY < 140 ) {
    videoExport.endMovie();
    exit();
  }
  if (mouseX > 0 && mouseX < 140 && mouseY > 0 && mouseY < 140 ) {
    recording = !recording;
  }
}

//-----robot for screenShoting
void screenshot() {
  try {
    screenshot = new PImage(new Robot().createScreenCapture(new Rectangle(0, 0, displayWidth, displayHeight)));
  }
  catch (AWTException e) {
  }
}
