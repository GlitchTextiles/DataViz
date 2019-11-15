//////////////////////////////////////////////
// GUI

public class ControlFrame extends PApplet {

  int w, h, x, y;
  PApplet parent;
  ControlP5 cp5;

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
    ;
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
      .setDirection(Controller.HORIZONTAL)
      .setLabel("width")
      ; 
    cp5.addNumberbox("window_height")
      .setPosition(240, 45)
      .setSize(50, 20)
      .setMin(1)
      .setValue(screen_height)
      .setDirection(Controller.HORIZONTAL)
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

  boolean shift = false;

  void keyPressed() {

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
    case '0':
      cp5.get(Toggle.class, "set_color_mode").setValue(mode^1);
      break;
    case '1':
      swap_mode(0);
      cp5.get(RadioButton.class, "swap_mode").activate(0);
      println("channel swap mode: "+swap_mode);
      break;
    case '2':
      swap_mode(1);
      cp5.get(RadioButton.class, "swap_mode").activate(1);
      println("channel swap mode: "+swap_mode);
      break;
    case '3':
      swap_mode(2);
      cp5.get(RadioButton.class, "swap_mode").activate(2);
      println("channel swap mode: "+swap_mode);
      break;
    case '4':
      swap_mode(3);
      cp5.get(RadioButton.class, "swap_mode").activate(3);
      println("channel swap mode: "+swap_mode);
      break;
    case '5':
      swap_mode(4);
      cp5.get(RadioButton.class, "swap_mode").activate(4);
      println("channel swap mode: "+swap_mode);
      break;
    case '6':
      swap_mode(5);
      cp5.get(RadioButton.class, "swap_mode").activate(5);
      println("channel swap mode: "+swap_mode);
      break;
    case 'q':
      red_invert=!red_invert;
      println("red_invert = "+red_invert);
      break;
    case 'w':
      green_invert=!green_invert;
      println("green_invert = "+green_invert);
      break;
    case 'e':
      blue_invert=!blue_invert;
      println("blue_invert = "+blue_invert);
      break;
    case 'Q':
      red_invert_pre=!red_invert_pre;
      println("red_invert_pre = "+red_invert_pre);
      break;
    case 'W':
      green_invert_pre=!green_invert_pre;
      println("green_invert_pre = "+green_invert_pre);
      break;
    case 'E':
      blue_invert_pre=!blue_invert_pre;
      println("blue_invert_pre = "+blue_invert_pre);
      break;
    case 'z':
      bw_invert=!bw_invert;
      println("invert = "+bw_invert);
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
      if (bw_depth>1) bw_depth--;
      break;
    case ')': //increase greyscale bit depth 
      if (bw_depth<24) bw_depth++;
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
    screen_height=_screen_height;
    setScreenSize(screen_width, screen_height);
    updatePixelOffsetSlider();
  }
  public void window_width(int _screen_width) {
    screen_width = _screen_width;
    setScreenSize(screen_width, screen_height);
    updatePixelOffsetSlider();
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
