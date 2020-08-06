public class Permutation {
  
  public ConstrainedPosition currentPosition;
  public ConstrainedPosition targetPosition;
  
  public Permutation(ConstrainedPosition currentPosition, ConstrainedPosition targetPosition){
    buildPermutation(currentPosition, targetPosition);
  }
  
  public Permutation(Face currFace1, Face currFace2, Face targFace1, Face targFace2){
    buildPermutation(new ConstrainedPosition(currFace1, currFace2), new ConstrainedPosition(targFace1, targFace2));
  }
  
  public Permutation(Face currFace1, Face currFace2, Face currFace3, Face targFace1, Face targFace2, Face targFace3){
    buildPermutation(new ConstrainedPosition(currFace1, currFace2, currFace3), new ConstrainedPosition(targFace1, targFace2, targFace3));
  }
  
  public String id(){
    return (this.currentPosition.id() + "->" + this.targetPosition.id());
  }
  
  private void buildPermutation(ConstrainedPosition currentPosition, ConstrainedPosition targetPosition){
    this.currentPosition = currentPosition;
    this.targetPosition = targetPosition;
  }
}
