import java.util.LinkedList; 
import java.util.Queue; 

public class Cube{
  
  PVector dim; // Cube dimensions (ex.: 3x3x3)
  List<Cubelet> cubelets = new ArrayList<Cubelet>();
  CubeletIndexer cubeletIndexer;
  Solver solver = null;
  Queue<Move> nextMoves = new LinkedList();
  Move currentMove = null;
  boolean solving = false;

  Cube(int xDim, int yDim, int zDim){
    this.dim = new PVector(xDim, yDim, zDim);
    
    // Construct cube from cubelets
    float dist = UNIT * 2 * (EXPLODE_CUBE? 2 : 1);
    PVector offset = new PVector(int(dim.x/2) * dist, int(dim.y/2) * dist, int(dim.z/2) * dist);
    for (int x = 0; x < xDim; x++){
      for (int y = 0; y < yDim; y++){
        for (int z = 0; z < zDim; z++){
          PVector newPos = new PVector(x * dist - offset.x, y * dist - offset.y, z * dist - offset.z);
          cubelets.add(new Cubelet(newPos));
        }
      }
    }
    cubeletIndexer = new CubeletIndexer(cubelets);
  }
  
  private void rotateCubeletAroundAxis(Cubelet qb, Axis axis, float angle){
    // Y axis turn
    PVector pos = qb.transform.getPos();
    
    List<Float> posTab = new ArrayList();
    posTab.add(pos.x);
    posTab.add(pos.y);
    posTab.add(pos.z);
    
    List<Float> posTab2D = new ArrayList();
    posTab2D.add(pos.x);
    posTab2D.add(pos.y);
    posTab2D.add(pos.z);
    posTab2D.remove(axis.getValue());
   
    // Final position in 2D
    PMatrix2D positionMatrix = new PMatrix2D();
    positionMatrix.rotate(angle); // Will depend on direction
    positionMatrix.translate(posTab2D.get(0), posTab2D.get(1)); // Exclude the axis of rotation

    int axisSetCount = 0; // We have two axis to set
    for (int i = 0; i < 3; i++){
      if (i != axis.getValue()){
        float newValue = (axisSetCount == 0? round(positionMatrix.m02) : round(positionMatrix.m12));
        posTab.set(i, newValue);
        axisSetCount++;
      }
    }
    
    qb.transform.updatePos(posTab.get(0), posTab.get(1), posTab.get(2));
    qb.transform.rotationAroundAxis(angle, axis);
  }
  
  public void addMoveToQueue(Move move){
    this.nextMoves.add(move);
    if (currentMove == null){
      turn(); // Start turning if not turning
    }
  }
  
  public void addMovesToQueue(Move[] moves){
    for (Move move : moves){
      addMoveToQueue(move);
    }
  } 

  public void turn(){
    if (nextMoves.size() > 0){
      this.currentMove = nextMoves.remove();
      this.currentMove.isAnimating = true;
      debug.msg("Move: " + currentMove.moveType);
    }
    else{
      this.currentMove = null;
      debug.msg("NEXT MOVES QUEUE IS EMPTY");
    }
  }
  
  public void removeHighlight(){
    for (Cubelet cubelet : cubelets){
      cubelet.highlight(false);
    }
  }
  
  public void solve(){
    if (this.solver == null || this.solver.done){
      debug.msg("Create solver");
      this.solver = new Solver();
    }
    this.solving = true;
    this.solver.solve();
  }
  
  public void show(){
     
    // Update animation
    if (this.currentMove != null){
      if (this.currentMove.isAnimating){
        this.currentMove.increaseAnimatingAngle();
      }
      
      if (!currentMove.isAnimating){
        // Perform update on the appropriate cubelets
        for (Cubelet qb : cubelets){
          if (qb.isOnFace(currentMove.face)){
            rotateCubeletAroundAxis(qb, currentMove.axis, currentMove.angle);
          }
        }
        turn(); // Move is done, so start a new one
      }
    }
    
    // Get next solve moves
    if (this.currentMove == null){
      if (solving){
        if (!STEP_SOLVE && !solver.done){
          debug.msg("Calling solve for next step...");
          solver.solve(); // Get next move
        }
      }
    }

    // Draw animation and cube
    for (Cubelet cubelet : cubelets){
      push(); // Not sure what these would be for
      if (currentMove != null && currentMove.isAnimating && cubelet.isOnFace(currentMove.face)){

        if (currentMove.axis.getValue() == 0){
          rotateX(currentMove.getAnimatingAngle());
        }
        if (currentMove.axis.getValue() == 1){
          rotateY(-currentMove.getAnimatingAngle());
        }
        if (currentMove.axis.getValue() == 2){
          rotateZ(currentMove.getAnimatingAngle());
        }
      }
      
      cubelet.show();
      pop();
    }
  }
}
