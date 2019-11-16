//////////////////////////////////////////////
// GUI
//////////////////////////////////////////////

public class ControlFrame extends PApplet {

  int w, h, x, y;
  PApplet parent;
  ControlP5 cp5;
  boolean shift = false;
  float value = 0.0;

  public ControlFrame(PApplet _parent, int _x, int _y, int _w, int _h) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    x=_x;
    y=_y;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(x, y);
    cp5 = new ControlP5(this);

    background(0);

    // controls for skipping bits 
    cp5.addSlider("set_bit_offset")
      .setLabel("bit offset")
      .setRange(0, 24)
      .setSize(100, 20)
      .setPosition(10, 160)
      .setNumberOfTickMarks(25)
      ;

    // controls for skipping pixels     
    cp5.addSlider("set_pixel_offset")
      .setLabel("pixel offset")
      .setRange(0, 1)
      .setValue(0)
      .setPosition(10, 190)
      .setSize(400, 20)
      ;

    //step forward a pixel  
    cp5.addBang("pixel_inc")
      .setPosition(175, 140)
      .setSize(20, 20)
      .setLabel("px+")
      ;
    //jump back a pixel
    cp5.addBang("pixel_dec")
      .setPosition(205, 140)
      .setSize(20, 20)
      .setLabel("px-")
      ;
    //step forward a line  
    cp5.addBang("line_inc")
      .setPosition(235, 140)
      .setSize(20, 20)
      .setLabel("ln+")
      ;
    //jump back a line 
    cp5.addBang("line_dec")
      .setPosition(265, 140)
      .setSize(20, 20)
      .setLabel("ln-")
      ;
    //specify how many lines to skip  
    cp5.addNumberbox("line_multiplier")
      .setPosition(295, 140)
      .setSize(20, 20)
      .setRange(-100, 100)
      .setValue(1)
      .setDirection(0)
      .setLabel("ln*")
      ;

    // exits program       
    cp5.addBang("quit")
      .setPosition(470, 140)
      .setSize(20, 20)
      .setLabel("EXIT")
      ;

    cp5.addRadioButton("swap_mode")
      .setPosition(10, 10)
      .setSize(20, 20)
      .setItemsPerRow(2)
      .setSpacingColumn(30)
      .setSpacingRow(1)
      .addItem("RGB", 0)
      .addItem("GBR", 1)
      .addItem("BRG", 2)
      .addItem("BGR", 3)
      .addItem("GRB", 4)
      .addItem("RBG", 5)
      .activate(0)
      .setValue(0)
      ;


    // controls for color channel depth
    cp5.addSlider("set_chan1_depth")
      .setLabel("ch1 depth")
      .setRange(0, 8)
      .setPosition(120, 10)
      .setSize(50, 20)
      .setValue(1)
      .setNumberOfTickMarks(9)
      ;

    cp5.addSlider("set_chan2_depth")
      .setLabel("ch2 depth")
      .setPosition(120, 45)
      .setSize(50, 20)
      .setRange(0, 8)
      .setValue(1)
      .setNumberOfTickMarks(9)
      ;

    cp5.addSlider("set_chan3_depth")
      .setLabel("ch3 depth")
      .setPosition(120, 80)
      .setSize(50, 20)
      .setRange(0, 8)
      .setValue(1)
      .setNumberOfTickMarks(9)
      ; 

    cp5.addSlider("depth")
      .setPosition(400, 45)
      .setSize(50, 20)
      .setRange(0, 8)
      .setValue(1)
      .setNumberOfTickMarks(9)
      ;

    cp5.addToggle("set_color_mode")
      .setPosition(400, 10)
      .setSize(20, 20)
      .setLabel("GRAY")
      ;

    cp5.addToggle("R_INV_PRE")
      .setPosition(10+(0*30), 75)
      .setSize(20, 20)
      .plugTo(parent, "red_invert_pre")
      .setLabel("PRE")
      ;

    cp5.addToggle("G_INV_PRE")
      .setPosition(10+(1*30), 75)
      .setSize(20, 20)
      .plugTo(parent, "green_invert_pre")
      .setLabel("PRE")
      ;

    cp5.addToggle("B_INV_PRE")
      .setPosition(10+(2*30), 75)
      .setSize(20, 20)
      .plugTo(parent, "blue_invert_pre")
      .setLabel("PRE")
      ;

    cp5.addToggle("R_INV")
      .setPosition(10+(0*30), 120)
      .setSize(20, 20)
      .plugTo(parent, "red_invert")
      .setLabel("!R")
      ;

    cp5.addToggle("G_INV")
      .setPosition(10+(1*30), 120)
      .setSize(20, 20)
      .plugTo(parent, "green_invert")
      .setLabel("!G")
      ;

    cp5.addToggle("B_INV")
      .setPosition(10+(2*30), 120)
      .setSize(20, 20)
      .plugTo(parent, "blue_invert")
      .setLabel("!B")
      ;

    cp5.addToggle("INV")
      .setPosition(430, 10)
      .setSize(20, 20)
      .plugTo(parent, "bw_invert")
      .setLabel("!")
      ;

    //controls for changing the screen size
    cp5.addNumberbox("window_width")
      .setPosition(240, 10)
      .setSize(50, 20)
      .setMin(1)
      .setValue(screen_width)
      .setLabel("width")
      ; 
    cp5.addNumberbox("window_height")
      .setPosition(240, 45)
      .setSize(50, 20)
      .setMin(1)
      .setValue(screen_height)
      .setLabel("height")
      ; 

    cp5.addTextfield("set_window_width")
      .setPosition(300, 10)
      .setSize(50, 20)
      .setLabel("enter width")
      ;
      
    cp5.addTextfield("set_window_height")
      .setPosition(300, 45)
      .setSize(50, 20)
      .setLabel("enter height")
      ;

    cp5.addButton("open_file")
      .setPosition(350, 140)
      .setSize(40, 20)
      .setLabel("open")
      ;

    cp5.addButton("save_file")
      .setPosition(400, 140)
      .setSize(40, 20)
      .setLabel("save")
      ;
  }

  void draw() {
    background(0);
  }

  //////////////////////////////////////////////
  // Key Bindings
  //////////////////////////////////////////////

  void keyPressed() {

    // Bindings for arrow/direction keys
    if (keyCode == SHIFT) shift = true;
    if (shift) {
      switch(keyCode) {
      case 38: //UPARROW
        frame_inc(1);
        break;
      case 40: //DOWNARROW
        frame_dec(1);
        break;
      case 37: //LEFTARROW
        if (bit_offset>0) cp5.getController( "set_bit_offset").setValue(bit_offset-1);
        break;
      case 39: //RIGHTARROW
        if (bit_offset<pixel_depth) cp5.getController( "set_bit_offset").setValue(bit_offset+1);
        break;
      }
    } else {
      switch(keyCode) {
      case 38: //UPARROW
        frame_inc(screen_height-1);
        break;
      case 40: //DOWNARROW
        frame_dec(screen_height-1);
        break;
      case 37: //LEFTARROW
        pixel_dec();
        break;
      case 39: //RIGHTARROW
        pixel_inc();
        break;
      }
    }

    switch(key) {
    case 'o':
      open_file();
      break;
    case 's':
      save_file();
      break;
    case 'f':
      println(generateFilename());
      break;
    case '0':
      cp5.get(Toggle.class, "set_color_mode").setValue(mode^1);
      break;
    case '1':
      swap_mode(0);
      cp5.get(RadioButton.class, "swap_mode").activate(0);
      break;
    case '2':
      swap_mode(1);
      cp5.get(RadioButton.class, "swap_mode").activate(1);
      break;
    case '3':
      swap_mode(2);
      cp5.get(RadioButton.class, "swap_mode").activate(2);
      break;
    case '4':
      swap_mode(3);
      cp5.get(RadioButton.class, "swap_mode").activate(3);
      break;
    case '5':
      swap_mode(4);
      cp5.get(RadioButton.class, "swap_mode").activate(4);
      break;
    case '6':
      swap_mode(5);
      cp5.get(RadioButton.class, "swap_mode").activate(5);
      break;
    case 'q':
      if (red_invert) {
        value = 0.0;
      } else {
        value = 1.0;
      }
      cp5.getController("R_INV").setValue(value);
      break;
    case 'w':
      if (green_invert) {
        value = 0.0;
      } else {
        value = 1.0;
      }
      cp5.getController("G_INV").setValue(value);
      break;
    case 'e':
      if (blue_invert) {
        value = 0.0;
      } else {
        value = 1.0;
      }
      cp5.getController("B_INV").setValue(value);
      break;
    case 'Q':
      if (red_invert_pre) {
        value = 0.0;
      } else {
        value = 1.0;
      }
      cp5.getController("R_INV_PRE").setValue(value);
      break;
    case 'W':
      if (green_invert_pre) {
        value = 0.0;
      } else {
        value = 1.0;
      }
      cp5.getController("G_INV_PRE").setValue(value);
      break;
    case 'E':
      if (blue_invert_pre) {
        value = 0.0;
      } else {
        value = 1.0;
      }
      cp5.getController("B_INV_PRE").setValue(value);
      break;
    case 'z':
      if (bw_invert) {
        value = 0.0;
      } else {
        value = 1.0;
      }
      cp5.getController("INV").setValue(value);
      break;
    case 'r': //incrase red channel bit depth
      if (chan1_depth >= 0) cp5.getController("set_chan1_depth").setValue(++chan1_depth);
      break;
    case 'R': //decrease red channel bit depth
      if (chan1_depth < 8) cp5.getController("set_chan1_depth").setValue(--chan1_depth);
      break;
    case 'g': //increase green channel bit depth
      if (chan2_depth >= 0) cp5.getController("set_chan2_depth").setValue(++chan2_depth);
      break;
    case 'G': //decrease green channel bit depth
      if (chan2_depth < 8) cp5.getController("set_chan2_depth").setValue(--chan2_depth);
      break;
    case 'b': //increase blue channel bit depth
      if (chan3_depth >= 0) cp5.getController("set_chan3_depth").setValue(++chan3_depth);
      break;
    case 'B': //decrease blue channel bit depth 
      if (chan3_depth < 8) cp5.getController("set_chan3_depth").setValue(--chan3_depth);
      break;
    case '(': //decrease greyscale bit depth
      if (bw_depth>1) cp5.getController("depth").setValue(bw_depth-1);
      break;
    case ')': //increase greyscale bit depth 
      if (bw_depth<24) cp5.getController("depth").setValue(bw_depth+1);
    case '[': //decrease window width by 1 pixel
      set_window_width(screen_width-1);
      break;
    case ']': //increase window width by 1 pixel
      set_window_width(screen_width+1);
      break;
    case '{': //decrease window height by 1 pixel
      set_window_height(screen_height-1);
      break;
    case '}': //increase window height by 1 pixel
      set_window_height(screen_height+1);
      break;
    }
    parent.redraw();
  }

  public void keyReleased() {
    if (keyCode == SHIFT) shift = false;
  }

  /////////////////////////////////////////////////////////////////
  // File Handling
  /////////////////////////////////////////////////////////////////

  String generateFilename() {
    //format: <inputFile>-<ch1_depth><ch2_depth><ch3_depth><swap_mode>-<bit_offset>-<pixeloffset>
    String sep = "-";
    String filename= "";
    if (thePath.length() > 0) {
      String[] parsedPath = splitTokens(thePath, "/\\");
      String inputFile = charSub(parsedPath[parsedPath.length-1]);
      int radioIndex=int(cp5.get(RadioButton.class, "swap_mode").getValue());
      String swap_mode=cp5.get(RadioButton.class, "swap_mode").getItem(radioIndex).getName();
      filename+=inputFile;
      filename+= sep;
      if (red_invert_pre) filename+="!";
      filename+= chan1_depth;
      if (green_invert_pre) filename+="!";
      filename+= chan2_depth;
      if (blue_invert_pre) filename+="!";
      filename+= chan3_depth;
      if (red_invert) filename+="!";
      filename+= swap_mode.charAt(0);
      if (green_invert) filename+="!";
      filename+= swap_mode.charAt(1);
      if (blue_invert) filename+="!";
      filename+= swap_mode.charAt(2);
      filename+= sep;
      filename+= "b" + bit_offset;
      filename+= sep;
      filename+= pixel_offset;
      filename+= sep;
      filename+= render.width + "x" + render.height;
      filename+=".png";
    }
    return filename;
  }

  String charSub(String _string) {
    String s = "";
    for (int i = 0; i < _string.length(); ++i) {
      char c = _string.charAt(i);
      switch(c) {
      case ' ':
      case ',':
      case '.':
      case '<':
      case '>':
      case ':':
      case '{':
      case '}':
      case '[':
      case ']':
      case '!':
      case '@':
      case '#':
      case '$':
      case '%':
      case '^':
      case '&':
      case '*':
      case '(':
      case ')':
      case '-':
      case '_':
      case '+':
      case '=':
      case '?':
        c = '_';
        break;
      }
      if (s.length() > 0) {
        if ( c != '_' || s.charAt(s.length()-1) != '_') {
          s+=c;
        }
      } else {
        s+=c;
      }
    }
    return s;
  }

  public void open_file() {
    selectInput("Select a file to process:", "inputSelection");
  }

  public void inputSelection(File input) {
    if (input == null) {
      println("Window was closed or the user hit cancel.");
    } else {
      println("User selected " + input.getAbsolutePath());
      loadData(input.getAbsolutePath());
      updatePixelOffsetSlider();
    }
  }

  public void save_file() {
    selectOutput("Select a file to process:", "outputSelection");
  }

  public void outputSelection(File output) {
    if (output == null) {
      println("Window was closed or the user hit cancel.");
    } else {
      println("User selected " + output.getAbsolutePath());
      saveData(output.getAbsolutePath());
    }
  }

  /////////////////////////////////////////////////////////////////
  // Images Size
  /////////////////////////////////////////////////////////////////

  public void set_window_width(int _width) {
    if (_width > 0) cp5.get(Numberbox.class, "window_width").setValue(_width);
  }

  public void set_window_height(int _height) {
    if (_height > 0) cp5.get(Numberbox.class, "window_height").setValue(_height);
  }

  public void window_height(int _screen_height) {
    if (_screen_height > 0) {
      screen_height=_screen_height;
      setScreenSize(screen_width, screen_height);
      updatePixelOffsetSlider();
    }
  }
  public void window_width(int _screen_width) {
    if (_screen_width > 0 ) {
      screen_width = _screen_width;
      setScreenSize(screen_width, screen_height);
      updatePixelOffsetSlider();
    }
  }

  /////////////////////////////////////////////////////////////////
  // Render Controls
  /////////////////////////////////////////////////////////////////

  public void set_chan1_depth(int _value) {
    setDepth(_value, chan2_depth, chan3_depth);
    updatePixelOffsetSlider();
  }

  public void set_chan2_depth(int _value) {
    setDepth(chan1_depth, _value, chan3_depth);
    updatePixelOffsetSlider();
  }

  public void set_chan3_depth(int _value) {
    setDepth(chan1_depth, chan2_depth, _value);
    updatePixelOffsetSlider();
  }

  public void set_color_mode(int _mode) {
    mode = _mode;
    updatePixelOffsetSlider();
  }

  public void depth(int value) {
    bw_depth = value;
    updatePixelOffsetSlider();
  }

  public void updatePixelOffsetSlider() {
    if (raw_bits.length > 0) {
      float divisor=1.0;
      switch(mode) {
      case 0:
        if (pixel_depth>0) divisor = pixel_depth;
        break;
      case 1:
        if (bw_depth>0) divisor = bw_depth;
        break;
      default:
        break;
      }
      float maxOffset = constrain((raw_bits.length/divisor)-(screen_height*screen_width), 1, (raw_bits.length/divisor));
      cp5.get(Slider.class, "set_pixel_offset")
        .setRange(0, maxOffset)
        .setValue(pixel_offset)
        ;
    }
  }

  public void swap_mode(int id) {
    if (id!= -1) swap_mode = id;
  }

  public void quit() {
    exit();
  }

  public void set_bit_offset(int _value) {
    bit_offset = _value;
  }

  public void set_pixel_offset(int _offset) {
    if (raw_bits.length>0) {
      float divisor=1.0;
      switch(mode) {
      case 0:
        if (pixel_depth>0) divisor = pixel_depth;
        break;
      case 1:
        if (bw_depth>0) divisor = bw_depth;
        break;
      default:
        break;
      }
      int maxOffset = (int) constrain((raw_bits.length/divisor)-(screen_height*screen_width), 0, (raw_bits.length/divisor));

      if ( _offset >= 0 ) {
        if (_offset < maxOffset) {
          pixel_offset = _offset;
        } else {
          pixel_offset = maxOffset;
        }
      }
    }
  }

  public void pixel_inc() {
    set_pixel_offset(pixel_offset+1);
  }

  public void pixel_dec() {
    set_pixel_offset(pixel_offset-1);
  }

  public void line_multiplier(int _value) {
    line_multiplier = _value;
  }

  public void line_inc() {
    if (pixel_offset < raw_bits.length/pixel_depth) cp5.getController("set_pixel_offset").setValue(pixel_offset+(screen_width*line_multiplier));
  }

  public void line_dec() {
    if (pixel_offset >= screen_width*line_multiplier) cp5.getController("set_pixel_offset").setValue(pixel_offset-(screen_width*line_multiplier));
  }

  public void frame_inc(int _lines) {
    if (pixel_offset < raw_bits.length/pixel_depth) cp5.getController("set_pixel_offset").setValue(pixel_offset+screen_width*_lines);
  }

  public void frame_dec(int _lines) {
    if (pixel_offset>_lines*pixel_depth) cp5.getController("set_pixel_offset").setValue(pixel_offset-screen_width*_lines);
    if (pixel_offset<_lines*pixel_depth) cp5.getController("set_pixel_offset").setValue(0);
  }


  //public void frame_dec(int _lines) {
  //  if (pixel_offset>0) pixel_offset-=screen_width*_lines;
  //  if (pixel_offset<0) pixel_offset=0;
  //}

  public void mouseReleased() {
    parent.redraw();
  }
}
