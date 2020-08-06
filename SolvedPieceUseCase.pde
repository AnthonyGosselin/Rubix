public class SolvedPiecesUseCase extends AlgorithmUseCase{
  
  // Could inherit from a "MultiplePieceUseCase" class
  List<Boolean> initialOrderedSolvedList;
  List<Boolean> orderedSolvedList;
  
  // TODO: implement a constructor that can be created from any set of transforms
  
  SolvedPiecesUseCase(SolveState state, List<Cubelet> topCubelets){
    this.state = state;
    
    addCubelets(topCubelets);
    generateId();
  }
  
  // Build set of transforms from current disposition
  SolvedPiecesUseCase(SolveState state, Cube cube){
    this.state = state;
    
    List<Cubelet> topCubelets = cube.cubeletIndexer.getCubeletsBy(Layer.TOP);
    addCubelets(topCubelets);
    generateId();
  }
  
  // Define use case with booleans directly
  SolvedPiecesUseCase(SolveState state, Boolean defineBool, List<Boolean> orderedSolvedList){
    this.state = state;
    
    if (orderedSolvedList.size() != 8){
      debug.msg("WARNING: incorrect bool list size for SolvedPiecesUseCase. Expected 8"); 
    }
    
    this.orderedSolvedList = new ArrayList<Boolean>(orderedSolvedList);
    this.initialOrderedSolvedList = new ArrayList<Boolean>(orderedSolvedList);
    generateId();
  }
  
  // Clone another useCase
  SolvedPiecesUseCase(SolvedPiecesUseCase useCase){
    this.state = useCase.state;
    this.orderedSolvedList = new ArrayList<Boolean>(useCase.orderedSolvedList);
    this.initialOrderedSolvedList = new ArrayList<Boolean>(useCase.orderedSolvedList);
    generateId();
  }
  
  public AlgorithmUseCase duplicate(){
    return new SolvedPiecesUseCase(this);
  }
  
  private void addCubelets(List<Cubelet> topCubelets){
    // Order transforms and insert null transforms for the ones that are not specified
    this.orderedSolvedList = new ArrayList(8);
    
    // Get the edge pieces
    HashMap<Face, Cubelet> sideFaceToCubelet = new HashMap(4);
    for (Cubelet cubelet : topCubelets){
      if (cubelet != null && cubelet.type == CubeletType.EDGE){
        
        // Get side face for ordering
        Face sideFace = null;
        for (Face face : cubelet.faces){
          if (face != Face.U){
            sideFace = face;
            break;
          }
        }
        sideFaceToCubelet.put(sideFace, cubelet);
      }
    }
    
    // Pre-defined order for edges
    List<Face> edgeSideFaceOrder = new ArrayList(4);
    edgeSideFaceOrder.add(Face.F);
    edgeSideFaceOrder.add(Face.L);
    edgeSideFaceOrder.add(Face.B);
    edgeSideFaceOrder.add(Face.R);
    
    for (Face face : edgeSideFaceOrder){
      if (sideFaceToCubelet.containsKey(face)){
        this.orderedSolvedList.add(sideFaceToCubelet.get(face).isSolved());
      }
      else{
        this.orderedSolvedList.add(null);
      }
    }
    
    // Get corner pieces
      // Pre-defined order for corners
    List<ConstrainedPosition> cornerPositionOrder = new ArrayList(4);
    cornerPositionOrder.add(new ConstrainedPosition(Face.U, Face.L, Face.F));
    cornerPositionOrder.add(new ConstrainedPosition(Face.U, Face.L, Face.B));
    cornerPositionOrder.add(new ConstrainedPosition(Face.U, Face.R, Face.B));
    cornerPositionOrder.add(new ConstrainedPosition(Face.U, Face.R, Face.F));
    
    for (int i = 0; i < cornerPositionOrder.size(); i++){
      boolean foundCorner = false;
      for (Cubelet cubelet : topCubelets){
        if (cubelet != null && cubelet.getConstrainedPosition().isEqual(cornerPositionOrder.get(i))){
          this.orderedSolvedList.add(cubelet.isSolved());
          foundCorner = true;
          break;
        }
      }
      if (!foundCorner){
        this.orderedSolvedList.add(null);
      }
    }
    
    // Save to initial list
    this.initialOrderedSolvedList = new ArrayList<Boolean>(this.orderedSolvedList);
    
  }
  
  public void generateId(){
    this.id = "";
    this.id += state;
    
    // TODO: Need to insert in a fixed order...
    for (Boolean bool : orderedSolvedList){
      this.id += "__/__";
      this.id += bool != null ? String.valueOf(bool) : "*";
    }
    
  }
  
  public void transpose(Face transposeFace){
    HashMap<Face, Face> convertFace = this.getFaceTransposeMap(transposeFace);
    
    int newStartIndex = 0;
    Face convertedFace = convertFace.get(Face.F);
    if (convertedFace == Face.L){
      newStartIndex = 1;
    }
    else if (convertedFace == Face.B){
      newStartIndex = 2;
    }
    else if (convertedFace == Face.R){
      newStartIndex = 3;
    }
    
    // Convert order
    List<Boolean> newOrderedSolvedList = new ArrayList(8);
    
    // Edges
    int ind = newStartIndex;
    for (int c = 0; c < 4; c++){
      if (ind > 3){
        ind = 0;
      }
      newOrderedSolvedList.add(this.initialOrderedSolvedList.get(ind));
      ind++;
    }
    
    // Corners
    ind = newStartIndex + 4;
    for (int c = 0; c < 4; c++){
      if (ind > 7){
        ind = 4;
      }
      newOrderedSolvedList.add(this.initialOrderedSolvedList.get(ind));
      ind++;
    }
    
    this.orderedSolvedList = newOrderedSolvedList;
    generateId(); // Regenerate the id
  }
  
}
