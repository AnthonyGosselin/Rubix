public abstract class AlgorithmUseCase{
  
  String id;
  SolveState state;
  
  protected HashMap<Face, Face> getFaceTransposeMap(Face transposeFace){
    HashMap<Face, Face> moveConversion = new HashMap();
    if (transposeFace == Face.R){
      moveConversion.put(Face.F, Face.R);
      moveConversion.put(Face.R, Face.B);
      moveConversion.put(Face.B, Face.L);
      moveConversion.put(Face.L, Face.F);
    }
    else if (transposeFace == Face.B){
      moveConversion.put(Face.F, Face.B);
      moveConversion.put(Face.R, Face.L);
      moveConversion.put(Face.B, Face.F);
      moveConversion.put(Face.L, Face.R);
    }
    else if (transposeFace == Face.L){
      moveConversion.put(Face.F, Face.L);
      moveConversion.put(Face.R, Face.F);
      moveConversion.put(Face.B, Face.R);
      moveConversion.put(Face.L, Face.B);
    }
    // Starting face can only be one of the side faces (yellow always up during solve)
    moveConversion.put(Face.U, Face.U);
    moveConversion.put(Face.D, Face.D);
    
    return moveConversion;
  }
  
  public abstract void generateId();
  
  public abstract void transpose(Face transposeFace); //<>// //<>// //<>//
  
  public abstract AlgorithmUseCase duplicate();
  
}
