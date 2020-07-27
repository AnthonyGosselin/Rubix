public class SolvedPiecesUseCase extends AlgorithmUseCase{
  
  // Could inherit from a "MultiplePieceUseCase" class
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
  
  // Clone another useCase
  SolvedPiecesUseCase(SolvedPiecesUseCase useCase){
    this.state = useCase.state;
    this.orderedSolvedList = new ArrayList(8);
    this.orderedSolvedList = useCase.orderedSolvedList;
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
    
    List<Integer> newIndexOrder;
    if (convertFace.get(Face.F) == Face.R){
      
    }
    else if (convertFace.get(Face.F) == Face.B){
      
    }
    else if (convertFace.get(Face.F) == Face.L){
      
    }
    
    
    
    List<Face> orderedFaces = Arrays.asList(Face.F, Face.L, Face.B, Face.R);
    
    List<DefinedTransform> newOrderedSolvedList = new ArrayList(8);

    // Convert all bools order
    
    for (Boolean bool : this.orderedSolvedList){
      
     
      newOrderedSolvedList.add();
    }
    
    addTransforms(newStartTransforms);
    generateId(); // Regenerate the id
  }
  
}
