public class PermutationUseCase extends AlgorithmUseCase{
  
  // Could inherit from a "MultiplePieceUseCase" class
  List<Permutation> orderedPermutations;
  
  // TODO: implement a constructor that can be created from any set of transforms
  
  PermutationUseCase(SolveState state, List<Permutation> permutations){
    this.state = state;
    
    addPermutations(permutations);
    generateId();
  }
  
  // Build set of transforms from current disposition
  PermutationUseCase(SolveState state, Cube cube){
    this.state = state;
    
    List<Cubelet> topCubelets = cube.cubeletIndexer.getCubeletsBy(Layer.TOP);
    
    List<Permutation> allPermutations = getAllPermutations(topCubelets);
    addPermutations(allPermutations);
    generateId();
  }
  
  // Clone another useCase
  PermutationUseCase(PermutationUseCase useCase){
    this.state = useCase.state;
    this.orderedPermutations = new ArrayList<Permutation>(useCase.orderedPermutations);
    generateId();
  }
  
  public AlgorithmUseCase duplicate(){
    return new PermutationUseCase(this);
  }
  
  private List<Permutation> getAllPermutations(List<Cubelet> cubelets){
    List<Permutation> allPermutations = new ArrayList();
    
    for (Cubelet cubelet : cubelets){
      if (!cubelet.isSolved()){
        allPermutations.add(cubelet.getNeededPermutation());
      }
    }
    
    return allPermutations;
  }
  
  private void addPermutations(List<Permutation> permutations){
    // Order permutations by currentPosition (start), no need for null values for missing permutations
    this.orderedPermutations = new ArrayList();
    
    // Get the edge pieces
    HashMap<Face, Permutation> sideFaceToPermutation = new HashMap(4);
    for (Permutation permutation : permutations){
      if (permutation != null && permutation.currentPosition.type == CubeletType.EDGE){
        
        // Get side face for ordering
        Face sideFace = null;
        for (Face face : permutation.currentPosition.faces){
          if (face != Face.U){
            sideFace = face;
            break;
          }
        }
        sideFaceToPermutation.put(sideFace, permutation);
      }
    }
    
    // Pre-defined order for edges
    List<Face> edgeSideFaceOrder = new ArrayList(4);
    edgeSideFaceOrder.add(Face.F);
    edgeSideFaceOrder.add(Face.L);
    edgeSideFaceOrder.add(Face.B);
    edgeSideFaceOrder.add(Face.R);
    
    for (Face face : edgeSideFaceOrder){
      if (sideFaceToPermutation.containsKey(face)){
        this.orderedPermutations.add(sideFaceToPermutation.get(face));
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
      for (Permutation permutation : permutations){
        if (permutation != null && permutation.currentPosition.isEqual(cornerPositionOrder.get(i))){
          this.orderedPermutations.add(permutation);
          break;
        }
      }
    }
    
  }
  
  public void generateId(){
    this.id = "";
    this.id += state;
    
    // TODO: Need to insert in a fixed order...
    for (Permutation permutation : this.orderedPermutations){
      this.id += "__/__";
      this.id += permutation.id();
    }
    
  }
  
  public void transpose(Face transposeFace){
    HashMap<Face, Face> convertFace = this.getFaceTransposeMap(transposeFace);
    
    List<Permutation> newOrderedPermutations = new ArrayList();

    // Convert all transforms
    for (Permutation permutation : this.orderedPermutations){
      
      // Current position
      ConstrainedPosition newCurrentPosition = null;
      List<Face> faces = new ArrayList();
      for (Face face : permutation.currentPosition.faces){
        faces.add(convertFace.get(face));
      }
      newCurrentPosition = new ConstrainedPosition(faces);
      
      // TargetPosition
      ConstrainedPosition newTargetPosition = null;
      faces = new ArrayList();
      for (Face face : permutation.targetPosition.faces){
        faces.add(convertFace.get(face));
      }
      newTargetPosition = new ConstrainedPosition(faces);
      
      newOrderedPermutations.add(new Permutation(newCurrentPosition, newTargetPosition));
    }
    
    addPermutations(newOrderedPermutations);
    generateId(); // Regenerate the id
  }
  
}
