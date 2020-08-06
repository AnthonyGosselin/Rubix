class Move{
  
  public MoveType moveType;
  public Face face;
  public Axis axis;
  public float angle;
  public boolean isAnimating = false;
  private float currentAnimatingAngle = 0;
  
  public void increaseAnimatingAngle(){
    if (this.isAnimating == true){
      this.currentAnimatingAngle += (angle < 0? -ANIM_ANGLE_INC : ANIM_ANGLE_INC);
      if (abs(currentAnimatingAngle) >= abs(angle)){
        isAnimating = false;
      }
    }
    else{
      print("CANNOT INCREASE ANIMATION ANGLE IF ANIMATION IS NOT IN PROGRESS");
    }
  }
  
  public float getAnimatingAngle(){
    return this.currentAnimatingAngle;
  }
  
  public Move(MoveType moveType){
    this.moveType = moveType;
    
    switch (moveType){
      case u:
        this.face = Face.U;
        this.axis = Axis.Y;
        this.angle = QUARTER_TURN;
        break;
      case f:
        this.face = Face.F;
        this.axis = Axis.Z;
        this.angle = QUARTER_TURN;
        break;
      case r:
        this.face = Face.R;
        this.axis = Axis.X;
        this.angle = QUARTER_TURN;
        break;
      case d:
        this.face = Face.D;
        this.axis = Axis.Y;
        this.angle = -QUARTER_TURN;
        break;
      case b:
        this.face = Face.B;
        this.axis = Axis.Z;
        this.angle = -QUARTER_TURN;
        break;
      case l:
        this.face = Face.L;
        this.axis = Axis.X;
        this.angle = -QUARTER_TURN;
        break;
        
      // Prime moves ----
      case U:
        this.face = Face.U;
        this.axis = Axis.Y;
        this.angle = -QUARTER_TURN;
        break;
      case F:
        this.face = Face.F;
        this.axis = Axis.Z;
        this.angle = -QUARTER_TURN;
        break;
      case R:
        this.face = Face.R;
        this.axis = Axis.X;
        this.angle = -QUARTER_TURN;
        break;
      case D:
        this.face = Face.D;
        this.axis = Axis.Y;
        this.angle = QUARTER_TURN;
        break;
      case B:
        this.face = Face.B;
        this.axis = Axis.Z;
        this.angle = QUARTER_TURN;
        break;
      case L:
        this.face = Face.L;
        this.axis = Axis.X;
        this.angle = QUARTER_TURN;
        break;
        
      case m:
        this.face = Face.M;
        this.axis = Axis.X;
        this.angle = -QUARTER_TURN;
        break;
      case e:
        this.face = Face.E;
        this.axis = Axis.Y;
        this.angle = -QUARTER_TURN;
        break;
      case s:
        this.face = Face.S;
        this.axis = Axis.Z;
        this.angle = QUARTER_TURN;
        break;
        
      case M:
        this.face = Face.M;
        this.axis = Axis.X;
        this.angle = QUARTER_TURN;
        break;
      case E:
        this.face = Face.E;
        this.axis = Axis.Y;
        this.angle = QUARTER_TURN;
        break; 
      case S:
        this.face = Face.S;
        this.axis = Axis.Z;
        this.angle = -QUARTER_TURN;
        break;
      default:
        print("INVALID MOVE CREATED");
        break;
    }
  }

}
