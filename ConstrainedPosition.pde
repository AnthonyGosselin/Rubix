public class ConstrainedPosition{
  
  List<Face> faces;
  CubeletType type;
  
  // Center piece position
  ConstrainedPosition(Face face1){
    this.faces = new ArrayList(1);
    this.faces.add(face1);
    this.type = CubeletType.CENTER;
  }
  
  // Edge piece position
  ConstrainedPosition(Face face1, Face face2){
    this.faces = new ArrayList(2);
    this.faces.add(face1);
    this.faces.add(face2);
    this.type = CubeletType.EDGE;
  }
  
  // Corner piece position
  ConstrainedPosition(Face face1, Face face2, Face face3){
    this.faces = new ArrayList(3);
    this.faces.add(face1);
    this.faces.add(face2);
    this.faces.add(face3);
    this.type = CubeletType.CORNER;
  }
  
  // Unknown piece position
  ConstrainedPosition(List<Face> faces){
    this.faces = new ArrayList();
    for (Face face : faces){
      this.faces.add(face);
    }
    
    switch(faces.size()){
      case 1:
        this.type = CubeletType.CENTER;
        break;
      case 2:
        this.type = CubeletType.EDGE;
        break;
      case 3:
        this.type = CubeletType.CORNER;
        break;
      default:
        this.type = CubeletType.CORNER;
        break;
    }
  }
  
  public boolean isEqual(ConstrainedPosition pos){
    if (pos.faces.size() != this.faces.size()){
      return false;
    }
    for (Face face : pos.faces){
      if (!this.faces.contains(face)){
        return false;
      }
    }
    
    return true;
  }
  
  // Standard order for faces in id
  private String getFacesString(List<Face> faces){
    String returnString = "";
    for (Face face : ALL_FACES){
      if (faces.contains(face)){
        returnString += face;
      }
    }
    return returnString;
  }
  
  public String id(){
    return getFacesString(faces); 
  }
  
}
