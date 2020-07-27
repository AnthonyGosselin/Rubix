
public class Orientation{
  
  public Axis axis; // The chosen axis to check for given color
  public PVector rot;
  public Color col;
  public Face face;

  public Orientation(Color col, Face face){
    this.col = col;
    this.face = face;
    
    setRotation(col, face);
  }
  
  private void setRotation(Color col, Face face){
    int flip = 1;
    switch(col){
      case YELLOW:
        flip = -1;
      case WHITE:
        this.axis = Axis.Y;
        break;
      case RED:
        flip = -1;
      case ORANGE:
        this.axis = Axis.X;
        break;
      case BLUE:
        flip = -1;
      case GREEN:
        this.axis = Axis.Z;
        break;
      default:
        println("UNDEFINED COLOR FOR ROTATION");
        break; 
    }
    
    switch(face){
      case U:
        this.rot = new PVector(0, -1 * flip, 0); // Inverse Y convention in Processing
        break;
      case D:
        this.rot = new PVector(0, 1 * flip, 0);
        break;
      case R:
        this.rot = new PVector(1 * flip, 0, 0);
        break;
      case L:
        this.rot = new PVector(-1 * flip, 0, 0);
        break;
      case F:
        this.rot = new PVector(0, 0, -1 * flip);
        break;
      case B:
        this.rot = new PVector(0, 0, 1 * flip);
        break;
      default:
        println("UNDEFINED DIRECTION FOR ORIENTATION");
        break;
    }
  }
  
  public boolean isEqual(Orientation otherOrientation){
    return (this.col == otherOrientation.col && this.face == otherOrientation.face);
  }
  
  public String id(){
     String id = "";
    
     id += col + "_";
     id += face;
    
     return id;
   }
  
  
}
