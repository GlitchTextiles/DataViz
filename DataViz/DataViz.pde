/* dataViz by Phillip Stearns 2015 for aYearInCode();
 * http://ayearincode.tumblr.com
 * revised 2020  
 */

//This program is a ground up re-write of a tool written by Jeroen Holtuis and Phillip Stearns,
//inspired by the LoomPreview application developed for Phillip Stearns by Paul Kerchen.
//Its purpose is to serve as a flexible tool for visualizing raw binary data.
//This preliminary program offers translation of binary data to 0-8 bits per channel RGB
//as well as 8-bit greyscale translation.

// Phillip Stearns: https://phillipstearns.com
// Jeroen Holthuis: https://www.jeroenholthuis.nl/
// Paul Kerchen: https://github.com/kerchen

/****************************************************
 Key Bindings:
 o - open file dialog
 s - save file dialog
 0 - toggle RGB/BW mode
 1-6 - RGB channel swap modes
 r/R - dec/inc channel 1 bit depth
 g/G - dec/inc channel 2 bit depth
 b/B - dec/inc channel 3 bit depth
 q - toggle R chan invert
 w - toggle G chan invert
 e - toggle B chan invert
 Q - toggle chan 1 invert
 W - toggle chan 2 invert
 E - toggle chan 3 invert
 z - invert BW mode
 UPARROW - shift rendering up one screen
 DOWNARROW - shift rendering down one screen until end is reached
 LEFTARROW - shift rendering left 1 pixel
 RIGHTARROW  - shift rendering right 1 pixel
 SHIFT+UPARROW - 
 SHIFT+DOWNARROW - 
 SHIFT+LEFTARROW - decrease bit offset by 1
 SHIFT+RIGHTARROW - increase bit offset by 1
 (/)
 [/]
 {/}
 ****************************************************/

import controlP5.*;
import java.util.BitSet;

// ControlFrame for GUI
ControlFrame gui;

//Control Frame Dimensions and Location
int GUIWidth = 500;
int GUIHeight = 225;
int GUILocationX = 0;
int GUILocationY = 0;

//DataViz Frame Dimensions and Location
int screen_width = 384;
int screen_height = 500;
int WindowLocationX = GUIWidth;
int WindowLocationY = 10;

// store bytes from selected file
BitSet raw_bits = new BitSet();

// render control variables
int mode = 0; // 0 = RGB interleaved, 1 = Greyscale, 2 = RGB planar (TBD)  
int bit_offset = 0; // skips bits 
int pixel_offset = 0; // skips pixels
int line_multiplier = 1;

// sets number of bits to be packed into color channel values
int bw_depth=1, chan1_depth=1, chan2_depth=1, chan3_depth=1, pixel_depth=0, swap_mode=0;

boolean red_invert=false;
boolean green_invert=false;
boolean blue_invert=false;
boolean bw_invert=false;

boolean red_invert_pre=false;
boolean green_invert_pre=false;
boolean blue_invert_pre=false;

PImage render = createImage(screen_width, screen_height, RGB);
String inputPath = "";
String outputPath = "";

void setup() {
  //window setup
  size(0, 0);
  surface.setLocation(WindowLocationX, WindowLocationY);
  //surface.setResizable(true);
  surface.setSize(screen_width, screen_height);
  background(0);
  gui = new ControlFrame(this, GUILocationX, GUILocationY, GUIWidth, GUIHeight);
  setDepth(1, 1, 1);  
  noLoop();
  noSmooth();
}

void draw() {
  background(0);
  if (!raw_bits.isEmpty()) {
    render = bits_to_pixels(raw_bits);
    image(render,0,0);
  }
}

void setDepth(int depth1, int depth2, int depth3) {
  chan1_depth=depth1;
  chan2_depth=depth2;
  chan3_depth=depth3;
  pixel_depth = chan1_depth + chan2_depth + chan3_depth;
}

void loadData(String _thePath) {
  raw_bits = bytes_to_bits(loadBytes(_thePath));
  bit_offset = 0; // skips bits 
  pixel_offset = 0; // skips pixels
  redraw();
}

void saveData(String _thePath) {
  render.save(_thePath+".png");
}

void setScreenSize(int _width, int _height) {
  surface.setSize(_width, _height);
  redraw();
}

BitSet bytes_to_bits(byte[] _bytes) {
  BitSet bits = new BitSet(_bytes.length*8);
  for (int i = 0; i < _bytes.length; i++) {    
    for (int j = 0; j < 8; j++) {    
      bits.set((i*8) + j, boolean(_bytes[i] >> j & 1));
    }
  }
  return bits;
}

PImage bits_to_pixels(BitSet _data) {
  switch(mode) {
  case 0:
    return renderRGB(_data);
  case 1:
    return renderGreyscale(_data);
    default:
    return null;
  }
}

PImage renderRGB(BitSet _data) {
  PImage image = createImage( screen_width, screen_height, RGB);
  image.loadPixels();
  for (int i = 0; i < image.pixels.length; i++) {

    int origin = ( i + pixel_offset ) * pixel_depth;
    int index = 0;
    int chan1 = 0;
    int chan2 = 0; 
    int chan3 = 0; 

    int red = 0;
    int green = 0; 
    int blue = 0; 

    //using some bit shifting voodoo to pack bits into channel values  

    for (int x = 0; x < chan1_depth; x++) {
      int value = 0;
      index = origin + x + bit_offset;
      if (index >=0 && index < _data.size() ) value = int(_data.get(index)) & 1;
      chan1 |= value << x;
    }
    chan1*=(255/(pow(2, (chan1_depth))-1)); //scale to 0-255

    for (int y = 0; y < chan2_depth; y++) {
      int value = 0;
      index = origin + chan1_depth + y + bit_offset;
      if (index >=0 && index < _data.size() ) value = int(_data.get(index)) & 1;
      chan2 |= value << y;
    }
    chan2*=(255/(pow(2, (chan2_depth))-1)); //scale to 0-255

    for (int z = 0; z < chan3_depth; z++) {
      int value = 0;
      index = origin + chan1_depth + chan2_depth + z + bit_offset;
      if (index >=0 && index < raw_bits.size()) value = int(raw_bits.get(index)) & 1;
      chan3 |= value << z;
    }
    chan3*=(255/(pow(2, (chan3_depth))-1)); //scale to 0-255

    //channel invert (pre RGB assignment)
    if (red_invert_pre) chan1^=0xFF;
    if (green_invert_pre) chan2^=0xFF;
    if (blue_invert_pre) chan3^=0xFF;

    //channel swap
    switch(swap_mode) {
    case 0:
      red = chan1;
      green = chan2;
      blue = chan3;
      break;
    case 1:
      red = chan3;
      green = chan1;
      blue = chan2;
      break;
    case 2:
      red = chan2;
      green = chan3;
      blue = chan1;
      break;
    case 3:
      red = chan3;
      green = chan2;
      blue = chan1;
      break;
    case 4:
      red = chan1;
      green = chan3;
      blue = chan2;
      break;
    case 5:
      red = chan2;
      green = chan1;
      blue = chan3;
      break;
    }

    //channel invert (post RGB assignment)
    if (red_invert) red^=0xFF;
    if (green_invert) green^=0xFF;
    if (blue_invert) blue^=0xFF;

    image.pixels[i] = 255 << 24 |red << 16 | green << 8 | blue;
  }
  image.updatePixels();
  return image;
}

PImage renderGreyscale(BitSet _data) {
  PImage image = createImage( screen_width, screen_height, RGB);
  image.loadPixels();
  for (int i = 0; i < image.pixels.length; i++) {
    int origin = (i+pixel_offset) * bw_depth;
    int pixel = 0;
    
    for (int x = 0; x < bw_depth; x++) {
      int value = 0;
      int index = origin+x+bit_offset;
      if (index >= 0 && index < _data.size() ) value = int(_data.get(index));
      pixel |=  value << x;
    }

    pixel *= (255/(pow(2, (bw_depth))-1)); //scale to 0-255

    if (bw_invert)pixel^=0xFF;

    image.pixels[i] = color(pixel);
  }
  image.updatePixels();
  return image;
}
