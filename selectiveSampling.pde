

// parameters :
float pixelSize = 5;
float pixelSeparation = 100;
float scalePic = 5;

// global vars :
PGraphics sampledPic;
String[] files;
int currentIndex=0;
int nbSavedPics = 0;

void setup() {
  size(300, 300);
  surface.setResizable(true);
  files = getAllFilesFrom("D:/recup/vrac/paintings");
  noSmooth();
}

void draw() {
  if (sampledPic!=null) {
    surface.setSize(floor(sampledPic.width*scalePic), floor(sampledPic.height*scalePic));
    image(sampledPic, 0, 0, width, height);
  }
}

void processPic(String url) {
  try {
    PImage orig = loadImage(url);
    int nbSqX = 0;
    int nbSqY = 0;
    while (nbSqX*pixelSeparation+pixelSize<orig.width) nbSqX++;
    while (nbSqY*pixelSeparation+pixelSize<orig.height) nbSqY++;
    sampledPic = createGraphics(floor(nbSqX*pixelSize), floor(nbSqY*pixelSize), JAVA2D);
    sampledPic.beginDraw();
    for (int x=0; x<nbSqX; x++) {
      for (int y=0; y<nbSqY; y++) {
        sampledPic.image(orig.get(floor(x*pixelSeparation), floor(y*pixelSeparation), floor(pixelSize), floor(pixelSize)), x*pixelSize, y*pixelSize);
      }
    }
    sampledPic.endDraw();
  } 
  catch (Exception e) {
  }
}

void keyPressed() {
  if (keyCode==ENTER) currentIndex++;
  if (keyCode==UP) pixelSize+=1;
  if (keyCode==DOWN) pixelSize-=1;
  if (keyCode==RIGHT) pixelSeparation-=10;
  if (keyCode==LEFT) pixelSeparation+=10;
  pixelSize = max(pixelSize, 1);
  pixelSeparation = max(pixelSeparation, 1);
  processPic(files[(currentIndex)%files.length]);
  if (keyCode==TAB) save(nf(nbSavedPics++, 5)+".png");
}