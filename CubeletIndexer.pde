public class CubeletIndexer{
  
  List<Cubelet> allCubelets;
  
  public CubeletIndexer(List<Cubelet> allCubelets){
    // Copy list
    this.allCubelets = new ArrayList<Cubelet>();
    for (Cubelet cubelet : allCubelets){
      this.allCubelets.add(cubelet);
    }
    
    // Create pre-computed lists
  }
  
  // ----------- Helper functions ------------------
  private boolean isOnLayer(Cubelet cubelet, Layer layer){
    float yHeight = cubelet.transform.getPos().y;
    
    if (layer == Layer.TOP){
      return yHeight < 0;
    }
    else if (layer == Layer.MIDDLE){
      return yHeight == 0;
    }
    else if (layer == Layer.BOTTOM){
      return yHeight > 0;
    }  
    return false;
  }

  private boolean isType(Cubelet cubelet, CubeletType type){
    return cubelet.type == type;
  }
  
  private boolean hasColor(Cubelet cubelet, Color col){
    Face face = cubelet.getColorFace(col);
    return face != null;
  }
  
  private boolean hasOrientation(Cubelet cubelet, Orientation orientation){
    PVector axisRot = new PVector(0, 0, 0);
    if (orientation.axis == Axis.X){
      axisRot = cubelet.transform.getRotX();
    }
    else if (orientation.axis == Axis.Y){
      axisRot = cubelet.transform.getRotY();
    }
    else if (orientation.axis == Axis.Z){
      axisRot = cubelet.transform.getRotZ();
    }
    return axisRot.x == orientation.rot.x && axisRot.y == orientation.rot.y && axisRot.z == orientation.rot.z;
  }
  
  // -----------------------------------------------
  
  
  // All cubelets in a LAYER
  public List<Cubelet> getCubeletsBy(Layer layer){
    List<Cubelet> returnCubelets = new ArrayList();
    for (Cubelet cubelet : allCubelets){
      if (isOnLayer(cubelet, layer)){
        returnCubelets.add(cubelet);
      }
    }
    return returnCubelets;
  }
  
  // All cubelets in a LAYER and of a certain TYPE
  public List<Cubelet> getCubeletsBy(Layer layer, CubeletType cubeletType){
    List<Cubelet> returnCubelets = new ArrayList();
    for (Cubelet cubelet : allCubelets){
      if (isOnLayer(cubelet, layer) && isType(cubelet, cubeletType)){
        returnCubelets.add(cubelet);
      }
    }
    return returnCubelets;
  }
  
  // All cubelets in a LAYER, of a certain TYPE and containing ONE COLOR
  public List<Cubelet> getCubeletsBy(Layer layer, CubeletType cubeletType, Color col){
    List<Cubelet> returnCubelets = new ArrayList();
    for (Cubelet cubelet : allCubelets){
      if (isOnLayer(cubelet, layer) && isType(cubelet, cubeletType) && hasColor(cubelet, col)){
        returnCubelets.add(cubelet);
      }
    }
    return returnCubelets;
  }
  
  // All cubelets in a LAYER, of a certain TYPE and NOT containing a certain COLOR
  public List<Cubelet> getCubeletsBy(Layer layer, CubeletType cubeletType, Color col, boolean hasColor){
    if (hasColor){
      return this.getCubeletsBy(layer, cubeletType, col);
    }
    else{
      List<Cubelet> returnCubelets = new ArrayList();
      for (Cubelet cubelet : allCubelets){
        if (isOnLayer(cubelet, layer) && isType(cubelet, cubeletType) && !hasColor(cubelet, col)){
          returnCubelets.add(cubelet);
        }
      }
      return returnCubelets;
    }
  }
  
  // All cubelets in a LAYER, of a certain TYPE and containing ONE COLOR in a certain DIRECTION
  public List<Cubelet> getCubeletsBy(Layer layer, CubeletType cubeletType, Color col, Face face){
    Orientation targOrientation = new Orientation(col, face);
    List<Cubelet> returnCubelets = new ArrayList();
    for (Cubelet cubelet : allCubelets){
      if (isOnLayer(cubelet, layer) && isType(cubelet, cubeletType) && hasOrientation(cubelet, targOrientation)){
        returnCubelets.add(cubelet);
      }
    }
    return returnCubelets;
  }
  
  
  
  // Single cubelet return ----------------------------
  
  public Cubelet getCubeletBy(ConstrainedPosition constrainedPosition){
    for (Cubelet cubelet : allCubelets){
      boolean isOnFaces = true;
      for (Face face : constrainedPosition.faces){
        if (!cubelet.isOnFace(face)){
          isOnFaces = false;
          break; // Break inner loop
        }
      }
      if (isOnFaces){
        return cubelet;
      }
    }
    return null;
  }
  
  
}
