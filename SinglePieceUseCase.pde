public class SinglePieceUseCase extends AlgorithmUseCase{
  
  // TODO: implement construction and use with definedTransforms
  DefinedTransform startTransform;
  DefinedTransform endTransform;
  
  ConstrainedPosition startPosition;
  Orientation startOrientation;
  ConstrainedPosition endPosition;
  Orientation endOrientation;
  
  SinglePieceUseCase(SolveState state, 
                     ConstrainedPosition startPosition, Orientation startOrientation, 
                     ConstrainedPosition endPosition,   Orientation endOrientation){
    this.state = state;
    this.startPosition = startPosition;
    this.startOrientation = startOrientation;
    this.endPosition = endPosition;
    this.endOrientation = endOrientation;
    generateId();
  }
  
  // Clone another useCase
  SinglePieceUseCase(SinglePieceUseCase useCase){
    this.state = useCase.state;
    this.startPosition = useCase.startPosition;
    this.startOrientation = useCase.startOrientation;
    this.endPosition = useCase.endPosition;
    this.endOrientation = useCase.endOrientation;
    generateId();
  }
  
  public AlgorithmUseCase duplicate(){
    return new SinglePieceUseCase(this);
  }

  public void generateId(){
    this.id = "";
    this.id += state;
    this.id += "__";
    
    this.id += startPosition.id();
    this.id += "__";
    
    this.id += startOrientation.id();
    this.id += "__/__";
    
    this.id += endPosition.id();
    this.id += "__";
    
    this.id += endOrientation.id();
  }
  
  public void transpose(Face transposeFace){
    HashMap<Face, Face> convertFace = this.getFaceTransposeMap(transposeFace);

    // Start position
    List<Face> faces = new ArrayList();
    for (Face face : this.startPosition.faces){
      faces.add(convertFace.get(face));
    }
    this.startPosition = new ConstrainedPosition(faces);
    
    // End position
    List<Face> faces2 = new ArrayList();
    for (Face face : this.endPosition.faces){
      faces2.add(convertFace.get(face));
    }
    this.endPosition = new ConstrainedPosition(faces2);
    
    // Start orientation
    Color startOrientationColor = Settings.getColorByCubeFace(convertFace.get(Settings.getCubeFaceByColor(this.startOrientation.col)));
    this.startOrientation = new Orientation(startOrientationColor, convertFace.get(this.startOrientation.face));
    
    // End orientation
    Color endOrientationColor = Settings.getColorByCubeFace(convertFace.get(Settings.getCubeFaceByColor(this.endOrientation.col)));
    this.endOrientation = new Orientation(endOrientationColor, convertFace.get(this.endOrientation.face));
    
    generateId(); // Regenerate the id
  }
  
}
