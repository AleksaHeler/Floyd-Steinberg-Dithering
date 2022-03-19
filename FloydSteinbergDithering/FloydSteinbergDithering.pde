PImage kitten;

void setup(){
  size(1024, 512);
  
  // Load and display original image on left part of screen
  kitten = loadImage("kitten.png");
  image(kitten, 0, 0);
}

void draw(){
  kitten.loadPixels();
  
  for(int x = 0; x < kitten.width; x++){
    for(int y = 0; y < kitten.height; y++){
      int index = x + y * kitten.width;
      
      color pix = kitten.pixels[index];
      
      float r = red(pix);
      float g = green(pix);
      float b = blue(pix);
      
      r = round(r / 255) * 255;
      g = round(g / 255) * 255;
      b = round(b / 255) * 255;
      
      kitten.pixels[index] = color(r,g,b);
    }
  }
  
  kitten.updatePixels();
  
  image(kitten, 512, 0);
}
