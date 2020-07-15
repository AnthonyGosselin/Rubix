
                                           
public class Transform{
  
  PMatrix3D matrix;
  
  Transform(float x, float y, float z){
    this.matrix = new PMatrix3D();
    matrix.translate(x, y, z);
  }
  
  public PVector getPos(){
    return new PVector(this.matrix.m03, this.matrix.m13, this.matrix.m23);
  }
  
  // Grouped horizontally
  public PVector getRotX(){
    return new PVector(round(this.matrix.m00), round(this.matrix.m01), round(this.matrix.m02));
  }
  
  public PVector getRotY(){
    return new PVector(round(this.matrix.m10), round(this.matrix.m11), round(this.matrix.m12));
  }
  
  public PVector getRotZ(){
    return new PVector(round(this.matrix.m20), round(this.matrix.m21), round(this.matrix.m22));
  }
  
  // Actually not sure what this is... (group vertically in matrix)
  public PVector getOrientationX(){
    return new PVector(round(this.matrix.m00), round(this.matrix.m10), round(this.matrix.m20));
  }
  
  public PVector getOrientationY(){
    return new PVector(round(this.matrix.m01), round(this.matrix.m11), round(this.matrix.m21));
  }
  
  public PVector getOrientationZ(){
    return new PVector(round(this.matrix.m02), round(this.matrix.m12), round(this.matrix.m22));
  }
  
  public void updatePos(float x, float y, float z){
    this.matrix.m03 = x;
    this.matrix.m13 = y;
    this.matrix.m23 = z;
  }
 
  public void rotationAroundAxis(float angle, Axis axis){
    
    PVector rot = new PVector(0, 0, 0);
    if (axis == Axis.X){ 
      rot = getRotX();
    }
    else if (axis == Axis.Y){
      rot = getRotY();
      angle = -angle; // The definition of the y axis for rubix cube is the inverse of processing                                
    }
    else if (axis == Axis.Z){
      rot = getRotZ();
    }
    else{
      println("INVALID AXIS OF ROTATION");
    }

    if (rot.x != 0){
      int sign = rot.x < 0? -1 : 1;
      this.matrix.rotateX(sign * angle);
    }
    if (rot.y != 0){
      int sign = rot.y < 0? -1 : 1;
      this.matrix.rotateY(sign * angle);
    }
    if (rot.z != 0){
      int sign = rot.z < 0? -1 : 1;
      this.matrix.rotateZ(sign * angle);
    }   
  }


  
}
