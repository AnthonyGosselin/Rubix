final float UNIT = 10;
final float QUARTER_TURN = HALF_PI;

final int X_AXIS = 0;
final int Y_AXIS = 1;
final int Z_AXIS = 2;

final int STROKE_SIZE = 8;
final int DIM_X = 3, DIM_Y = 3, DIM_Z = 3;
final boolean EXPLODE_CUBE = false;
final boolean SHOW_CUBELET_AXIS = false;
final static boolean DEBUG = true;
boolean STEP_SOLVE = false; // Manually activate each step of solve
final SolveState SOLVE_UNTIL_STATE = SolveState.TOP_CORNERS;
boolean SPEED_SOLVE = false;
float ANIM_ANGLE_INC = SPEED_SOLVE ? HALF_PI : 0.25; // In radians

final color RED = color(240, 22, 22);
final color ORANGE = color(247, 140, 47);
final color BLUE = color(25, 150, 252);
final color GREEN = color(51, 217, 17);
final color WHITE = color(245, 245, 245);
final color YELLOW = color(252, 245, 25);
final color BLACK = color(0, 0, 0);

enum Face{
 U,
 D,
 L, 
 R,
 F, 
 B
}
final Face[] ALL_FACES = {Face.U, Face.D, Face.L, Face.R, Face.F, Face.B};
final Color[] SIDE_COLORS = {Color.GREEN, Color.ORANGE, Color.BLUE, Color.RED};

enum CubeletFace{
 U,
 D,
 L, 
 R,
 F, 
 B
}

enum Axis{
  X(0),
  Y(1),
  Z(2);
  int value;
  private Axis(int i){this.value = i;}
  public int getValue(){return value;}
}

// This is relative to the fact that yellow face is held up, but the cube can turn around
enum Layer{
  TOP, 
  MIDDLE,
  BOTTOM,
}

enum Color{
  RED, 
  ORANGE,
  GREEN,
  BLUE,
  YELLOW, 
  WHITE
}

enum CubeletType{
  CORNER,
  EDGE,
  CENTER
}

// Lowercase is clcokwise and uppercase for counter-clockwise
enum MoveType{
 u,
 d,
 l, 
 r,
 f, 
 b,
 U,
 D,
 L, 
 R,
 F, 
 B
}


enum SolveState{
  WHITE_CROSS,
  FIRST_LAYER,
  SECOND_LAYER,
  YELLOW_CROSS,
  YELLOW_FACE,
  TOP_CORNERS,
  TOP_EDGES,
  SOLVED,
  
  ANY
}

// The sub states of the SolveStates
enum SolveStepState{
  DAISY_START,
  DAISY_END,
  DAISY_DONE,
  
  FIRST_LAYER_START,
  FIRST_LAYER_DONE,
  
  SECOND_LAYER_START,
  SECOND_LAYER_DONE,
  
  YELLOW_CROSS_START,
  YELLOW_CROSS_DONE,
  
  TOP_LAYER_STEP_START,
  TOP_LAYER_STEP_DONE,
  
  TOP_CORNER_STEP_START,
  TOP_CORNER_STEP_SOLVE,
  TOP_CORNER_STEP_DONE
}

enum RelativeDirection{
  RIGHT, 
  LEFT, 
  OPPOSITE
}

  

public static class Settings{
 
  
  public static Face getRelativeFace(Face face, RelativeDirection relDir){
    HashMap<Face, Face> faceConversion = new HashMap();
    if (relDir == RelativeDirection.RIGHT){
      faceConversion.put(Face.F, Face.R);
      faceConversion.put(Face.R, Face.B);
      faceConversion.put(Face.B, Face.L);
      faceConversion.put(Face.L, Face.F);
    }
    else if (relDir == RelativeDirection.OPPOSITE){
      faceConversion.put(Face.F, Face.B);
      faceConversion.put(Face.R, Face.L);
      faceConversion.put(Face.B, Face.F);
      faceConversion.put(Face.L, Face.R);
    }
    else if (relDir == RelativeDirection.LEFT){
      faceConversion.put(Face.F, Face.L);
      faceConversion.put(Face.R, Face.F);
      faceConversion.put(Face.B, Face.R);
      faceConversion.put(Face.L, Face.B);
    }
    // Starting face can only be one of the side faces (yellow always up during solve)
    faceConversion.put(Face.U, Face.U);
    faceConversion.put(Face.D, Face.D);
    
    return faceConversion.get(face);
  }
  
  public static Color getColorByCubeFace(Face face){
    switch(face){
      case U:
        return Color.YELLOW;
      case D:
        return Color.WHITE;
      case F:
        return Color.GREEN;
      case B:
        return Color.BLUE;
      case R:
        return Color.ORANGE;
      case L:
        return Color.RED;
      default:
        return null;
    }
  }
  
  public static Face getCubeFaceByColor(Color col){
    switch(col){
      case YELLOW:
        return Face.U;
      case WHITE:
        return Face.D;
      case GREEN:
        return Face.F;
      case BLUE:
        return Face.B;
      case ORANGE:
        return Face.R;
      case RED:
        return Face.L;
      default:
        return null;
    }
  }
  
}
