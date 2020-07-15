public class TopLayerUseCase extends AlgorithmUseCase{
  
  // Could inherit from a "MultiplePieceUseCase" class
  List<DefinedTransform> startTransforms;
  
  // TODO: implement a constructor that can be created from any set of transforms
  
  TopLayerUseCase(SolveState state, List<DefinedTransform> newTransforms){
    this.state = state;
    
    addTransforms(newTransforms);
    generateId();
  }
  
  // Build set of transforms from current disposition
  TopLayerUseCase(SolveState state, Cube cube){
    this.state = state;
    
    List<Cubelet> topCubelets = cube.cubeletIndexer.getCubeletsBy(Layer.TOP);
    List<DefinedTransform> unorderedTransforms = new ArrayList(8);
    for (Cubelet cubelet : topCubelets){
      if (cubelet.type != CubeletType.CENTER){
        ConstrainedPosition position = cubelet.getConstrainedPosition();
        Orientation orientation = cubelet.getOrientation(Color.YELLOW);
        DefinedTransform transform = new DefinedTransform(position, orientation);
        unorderedTransforms.add(transform); // Use case is for top layer, YELLOW color is used to define orientation by default
      }
    }
    
    addTransforms(unorderedTransforms);
    generateId();
  }
  
  // Clone another useCase
  TopLayerUseCase(TopLayerUseCase useCase){
    this.state = useCase.state;
    this.startTransforms = new ArrayList(8);
    this.startTransforms = useCase.startTransforms;
    generateId();
  }
  
  public AlgorithmUseCase duplicate(){
    return new TopLayerUseCase(this);
  }
  
  private void addTransforms(List<DefinedTransform> newTransforms){
    // Order transforms and insert null transforms for the ones that are not specified
    this.startTransforms = new ArrayList(8);
    
    // Get the edge pieces
    HashMap<Face, DefinedTransform> sideFaceToEdgeTransform = new HashMap(4);
    for (DefinedTransform transform : newTransforms){
      if (transform != null && transform.hasPosition && transform.position.type == CubeletType.EDGE){
        
        // Get side face for ordering
        Face sideFace = null;
        for (Face face : transform.position.faces){
          if (face != Face.U){
            sideFace = face;
          }
        }
        sideFaceToEdgeTransform.put(sideFace, transform);
      }
    }
    
    // Pre-defined order for edges
    List<Face> edgeSideFaceOrder = new ArrayList(4);
    edgeSideFaceOrder.add(Face.F);
    edgeSideFaceOrder.add(Face.L);
    edgeSideFaceOrder.add(Face.B);
    edgeSideFaceOrder.add(Face.R);
    
    for (Face face : edgeSideFaceOrder){
      if (sideFaceToEdgeTransform.containsKey(face)){
        this.startTransforms.add(sideFaceToEdgeTransform.get(face));
      }
      else{
        this.startTransforms.add(new DefinedTransform());
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
      for (DefinedTransform transform : newTransforms){
        if (transform != null && transform.hasPosition && transform.position.isEqual(cornerPositionOrder.get(i))){
          this.startTransforms.add(transform);
          foundCorner = true;
          break;
        }
      }
      if (!foundCorner){
        this.startTransforms.add(new DefinedTransform());
      }
    }
    
  }
  
  public void generateId(){
    this.id = "";
    this.id += state;
    
    // TODO: Need to insert in a fixed order...
    for (DefinedTransform transform : startTransforms){
      this.id += "__/__";
      this.id += transform.hasPosition ? transform.position.id() : "*";
      this.id += "__";
      this.id += transform.hasOrientation ? transform.orientation.id() : "*";
    }
    
  }
  
  public void transpose(Face transposeFace){
    HashMap<Face, Face> convertFace = this.getFaceTransposeMap(transposeFace);
    
    List<DefinedTransform> newStartTransforms = new ArrayList(8);

    // Convert all transforms
    for (DefinedTransform transform : this.startTransforms){
      
      // Position
      ConstrainedPosition newPosition = null;
      if (transform.hasPosition){
        List<Face> faces = new ArrayList();
        for (Face face : transform.position.faces){
          faces.add(convertFace.get(face));
        }
        newPosition = new ConstrainedPosition(faces);
      }
      
      // Orientation
      Orientation newOrientation = null;
      if (transform.hasOrientation){
        newOrientation = new Orientation(Color.YELLOW, convertFace.get(transform.orientation.face));
      }
      
      newStartTransforms.add(new DefinedTransform(newPosition, newOrientation));
    }
    
    addTransforms(newStartTransforms);
    generateId(); // Regenerate the id
  }
  
}
