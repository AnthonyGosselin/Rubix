public class DefinedTransform {
  
  public ConstrainedPosition position;
  public Orientation orientation;
  
  boolean hasPosition;
  boolean hasOrientation;
  
  boolean isUndefined;
  
  DefinedTransform(ConstrainedPosition position, Orientation orientation){
    buildDefinedTransform(position, orientation);
  }
  
  DefinedTransform(Face posFace1, Color oriColor, Face oriFace){
    buildDefinedTransform(new ConstrainedPosition(posFace1), new Orientation(oriColor, oriFace));
  }
  
  DefinedTransform(Face posFace1, Face posFace2, Color oriColor, Face oriFace){
    buildDefinedTransform(new ConstrainedPosition(posFace1, posFace2), new Orientation(oriColor, oriFace));
  }
  
  DefinedTransform(Face posFace1, Face posFace2, Face posFace3, Color oriColor, Face oriFace){
    buildDefinedTransform(new ConstrainedPosition(posFace1, posFace2, posFace3), new Orientation(oriColor, oriFace));
  }
  
  private void buildDefinedTransform(ConstrainedPosition position, Orientation orientation){
    this.position = position;
    this.orientation = orientation;
    
    this.hasPosition = position == null ? false : true;
    this.hasOrientation = orientation == null ? false : true;
    
    this.isUndefined = !this.hasPosition && !this.hasOrientation ? true : false;
  }
  
  // Null transform definition
  DefinedTransform(){
    this.position = null;
    this.orientation = null;
    
    this.hasPosition = false;
    this.hasOrientation = false;
    
    this.isUndefined = true;
  }
}
