// Following "The Coding Train" tutorial: https://www.youtube.com/watch?v=0L2n8Tg2FwI&list=PLRqwX-V7Uu6ZiZxtDDRCi6uhfTH4FilpH&index=128

PImage kitten;

// How many variations of each color (r,g,b) do we want
// e.g. 2 will give us 1bit colors, or B&W (0-1, 0-1, 0-1)
//      4 will give us 2bit colors (0-3, 0-3, 0-3)
int quantizationFactor = 4;

void setup(){
  size(1024, 512);
  
  kitten = loadImage("kitten.png");
  
  // Display original image on left part of screen
  // If we want, we can have B&W image
  kitten.filter(GRAY);
  image(kitten, 0, 0);
}

int index(int x, int y){
  return x + y * kitten.width;
}

void addErrToPixel(int x, int y, float errR, float errG, float errB, float errScaling){
  int index = index(x, y);
  color c = kitten.pixels[index];
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  r = r + errR * errScaling;
  g = g + errG * errScaling;
  b = b + errB * errScaling;
  kitten.pixels[index] = color(r, g, b);
}

void draw(){
  
  kitten.loadPixels();
  
  // Go trough whole image
  for(int y = 0; y < kitten.height-1; y++){
    for(int x = 1; x < kitten.width-1; x++){
      color pix = kitten.pixels[index(x, y)];
      
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      
      // Find closest color / quantize colors to reduce available palette 
      int newR = round((quantizationFactor-1)*oldR / 255) * (255/(quantizationFactor-1));
      int newG = round((quantizationFactor-1)*oldG / 255) * (255/(quantizationFactor-1));
      int newB = round((quantizationFactor-1)*oldB / 255) * (255/(quantizationFactor-1));
      
      // Assign new pixel value to image
      kitten.pixels[index(x, y)] = color(newR, newG, newB);
      
      // Calculate error: how much has pixel changed
      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;
      
      addErrToPixel(x+1, y  , errR, errG, errB, 7/16.0);
      addErrToPixel(x-1, y+1, errR, errG, errB, 3/16.0);
      addErrToPixel(x  , y+1, errR, errG, errB, 5/16.0);
      addErrToPixel(x+1, y+1, errR, errG, errB, 1/16.0);
    }
  }
  
  kitten.updatePixels();
  
  image(kitten, 512, 0);
}
