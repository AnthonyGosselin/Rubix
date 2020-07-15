
public class Cubelet{

  Transform transform; // Position and rotation of cubelet
  
  float size;
  HashMap<Color, Face> colorToFace; // this is kind of misleading... not sure what the color value is useful for
  private HashMap<CubeletFace, Integer> cubeletFaceToColor; // The local position of colors that does not vary (Colors are converted to ints (as they always are))
  List<Color> colors;
  List<Face> faces;
  CubeletType type;
  private color strokeColor = BLACK;
  private int strokeSize = STROKE_SIZE;
  
  boolean rotateBool = false;
  
  Cubelet(PVector pos){
    this.size = UNIT;
    
    this.transform = new Transform(pos.x, pos.y, pos.z);
    determineStartingFaceColors();
  }
  
  Cubelet(float x, float y, float z){
    this.size = UNIT;
    
    this.transform = new Transform(x, y, z);
    determineStartingFaceColors();
  }
  
  public boolean isOnFace(Face face){
    PVector pos = transform.getPos();
    
    switch(face){
      case U:
        return pos.y < 0;
      case D:
        return pos.y > 0;
      case R:
        return pos.x > 0;
      case L:
        return pos.x < 0;
      case F:
        return pos.z > 0;
      case B:
        return pos.z < 0;
      default:
        return false;
    }
  }
  
  public ConstrainedPosition getConstrainedPosition(){
    List<Face> faces = new ArrayList();
    for (Face face : ALL_FACES){
      if (isOnFace(face)){
        faces.add(face);
      }
    }
    
    return new ConstrainedPosition(faces);
  }
  
  public Orientation getOrientation(Color col){
    return new Orientation(col, getCubeFaceByColor(col));
  }
  
  public DefinedTransform getDefinedTransform(Color col){
    return new DefinedTransform(this.getConstrainedPosition(), this.getOrientation(col));
  }
  
  public Face getCubeFaceByColor(Color col){
    // Find which cube face has a normal parallel and in the same direction as cubelet color face
    Face returnFace = null;
    if (colorToFace.get(col) != null){
      // Get rot for axis that corresponds to face
      PVector rot;
      int flip = 1;
      switch(col){
        case YELLOW:
          flip = -1;
        case WHITE:
          rot = this.transform.getOrientationY();
          break;
        case RED:
          flip = -1;
        case ORANGE:
          rot = this.transform.getOrientationX();
          break;
        case BLUE:
          flip = -1;
        case GREEN:
          rot =  this.transform.getOrientationZ();
          break;
        default:
          println("UNDEFINED COLOR FOR ROTATION");
          rot = new PVector(0, 0, 0);
          break;
      }    
      rot.x *= flip;
      rot.y *= flip;
      rot.z *= flip;
      
      if (rot.x == 1){
        returnFace = Face.R;
      }
      else if (rot.x == -1){
        returnFace = Face.L;
      }
      else if (rot.y == 1){
        returnFace = Face.D;
      }
      else if (rot.y == -1){
        returnFace = Face.U; 
      }
      else if (rot.z == -1){
        returnFace = Face.B;
      }
      else if (rot.z == 1){
        returnFace = Face.F; 
      }
    }

    return returnFace;
  }
  
  public Face getColorFace(Color targetColor){
    Face currentFace = colorToFace.get(targetColor);
    return currentFace;
  }
  
  public void highlight(boolean bool){
    if (bool){
      strokeColor = WHITE;
      strokeSize = 25;
    }
    else{
      strokeColor = BLACK;
      strokeSize = STROKE_SIZE;
    }
  }
  
  public boolean isSolved(){
    
    for (Color col : colorToFace.keySet()){
      Face currentFace = getCubeFaceByColor(col);
      Color expectedColor = Settings.getColorByCubeFace(currentFace);
       
      if (expectedColor != col){
        return false;
      }
    }
    return true;
  }
  
  public ConstrainedPosition getSolvedPosition(){
    
    List<Face> faces = new ArrayList();
    for (Face face : colorToFace.values()){
      faces.add(face);
    }
    
    return new ConstrainedPosition(faces);
  }
  
  public Orientation getSolvedOrientation(Color col){
    Face solvedFace = colorToFace.get(col);
    if (solvedFace == null){
      debug.msg("Cubelet doesn't contain the request color to find solved orientation");
      return null;
    }
    println("Solved orientation:", col, solvedFace);
    return new Orientation(col, solvedFace);
  }
  

  // NOTE: This function is only designed for the 3x3x3
  private void determineStartingFaceColors(){
    PVector p = transform.getPos(); // Get translation
    cubeletFaceToColor = new HashMap(6);
    colorToFace = new HashMap(3); // Max three colored faces
    faces = new ArrayList();
    colors = new ArrayList();
    /*colorToFace = new HashMap(6);
    colorToFace.put(Color.YELLOW, Face.U);
    colorToFace.put(Color.WHITE, Face.D);
    colorToFace.put(Color.RED, Face.L);
    colorToFace.put(Color.ORANGE, Face.R);
    colorToFace.put(Color.GREEN, Face.F);
    colorToFace.put(Color.BLUE, Face.B);*/
    
    // By default, each face is black
    cubeletFaceToColor.put(CubeletFace.U, BLACK);
    cubeletFaceToColor.put(CubeletFace.D, BLACK);
    cubeletFaceToColor.put(CubeletFace.L, BLACK);
    cubeletFaceToColor.put(CubeletFace.R, BLACK);
    cubeletFaceToColor.put(CubeletFace.F, BLACK);
    cubeletFaceToColor.put(CubeletFace.B, BLACK);
    
    /*cubeletFaceToColor.put(CubeletFace.U, YELLOW);
    cubeletFaceToColor.put(CubeletFace.D, WHITE);
    cubeletFaceToColor.put(CubeletFace.L, RED);
    cubeletFaceToColor.put(CubeletFace.R, ORANGE);
    cubeletFaceToColor.put(CubeletFace.F, GREEN);
    cubeletFaceToColor.put(CubeletFace.B, BLUE);*/
    
    // Up & down (Y)
    if (p.y < 0){
      cubeletFaceToColor.put(CubeletFace.U, YELLOW);
      colorToFace.put(Color.YELLOW, Face.U);
      faces.add(Face.U);
      colors.add(Color.YELLOW);
    }
    else if (p.y > 0){
      cubeletFaceToColor.put(CubeletFace.D, WHITE);
      colorToFace.put(Color.WHITE, Face.D);
      faces.add(Face.D);
      colors.add(Color.WHITE);
    }
    
    // Left & right (X)
    if (p.x > 0){
      cubeletFaceToColor.put(CubeletFace.R, ORANGE);
      colorToFace.put(Color.ORANGE, Face.R);
      faces.add(Face.R);
      colors.add(Color.ORANGE);
    }
    else if (p.x < 0){
      cubeletFaceToColor.put(CubeletFace.L, RED); 
      colorToFace.put(Color.RED, Face.L); 
      faces.add(Face.L);
      colors.add(Color.RED);
    }
    
    // Front & back (Z)
    if (p.z > 0){
      cubeletFaceToColor.put(CubeletFace.F, GREEN);
      colorToFace.put(Color.GREEN, Face.F);
      faces.add(Face.F);
      colors.add(Color.GREEN);
    }
    else if (p.z < 0){
      cubeletFaceToColor.put(CubeletFace.B, BLUE);
      colorToFace.put(Color.BLUE, Face.B);
      faces.add(Face.B);
      colors.add(Color.BLUE);
    }
    
    // Determine cubelet type
    int coloredFaceCount = colorToFace.size();
    if (coloredFaceCount == 3){
      this.type = CubeletType.CORNER;
    }
    else if (coloredFaceCount == 2){
      this.type = CubeletType.EDGE;
    }
    else if (coloredFaceCount == 1){
      this.type = CubeletType.CENTER; 
    }
  }
  
  public void show(){
    fill(250);
    stroke(strokeColor);
    strokeWeight(strokeSize);
    pushMatrix();
    
    // Update position and rotation
    applyMatrix(transform.matrix);
    
    float l = UNIT;
    
    // Front
    beginShape();
    fill(cubeletFaceToColor.get(CubeletFace.F));
    vertex(-l, -l, l);
    vertex(l, -l, l);
    vertex(l, l, l);
    vertex(-l, l, l);
    vertex(-l, -l, l);
    endShape();
    
    // Back
    beginShape();
    fill(cubeletFaceToColor.get(CubeletFace.B));
    vertex(-l, -l, -l);
    vertex(l, -l, -l);
    vertex(l, l, -l);
    vertex(-l, l, -l);
    vertex(-l, -l, -l);
    endShape();
    
    // Down
    beginShape();
    fill(cubeletFaceToColor.get(CubeletFace.D));
    vertex(-l, l, l);
    vertex(l, l, l);
    vertex(l, l, -l);
    vertex(-l, l, -l);
    vertex(-l, l, l);
    endShape();
    
    // Up
    beginShape();
    fill(cubeletFaceToColor.get(CubeletFace.U));
    vertex(l, -l, l);
    vertex(-l, -l, l);
    vertex(-l, -l, -l);
    vertex(l, -l, -l);
    vertex(l, -l, l);
    endShape();
    
    // Right
    beginShape();
    fill(cubeletFaceToColor.get(CubeletFace.R));
    vertex(l, l, l);
    vertex(l, l, -l);
    vertex(l, -l, -l);
    vertex(l, -l, l);
    vertex(l, l, l);
    endShape();
    
    // Left
    beginShape();
    fill(cubeletFaceToColor.get(CubeletFace.L));
    vertex(-l, l, l);
    vertex(-l, l, -l);
    vertex(-l, -l, -l);
    vertex(-l, -l, l);
    vertex(-l, l, l);
    endShape();
    
    if (SHOW_CUBELET_AXIS){
      stroke(255, 0, 0);
      line(l/2, 0, 0, 2*l, 0, 0); // X axis
      stroke(0, 255, 0);
      line(0, l/2, 0, 0, 2*l, 0); // Y axis
      stroke(0, 0, 255);
      line(0, 0, l/2, 0, 0, 2*l); // Z axis
    }
    
    popMatrix();
  }
  
}
