public class BasicSecondLayerSolveStep extends ISolveStep{
  
  CubeletIndexer indexer;
  
  BasicSecondLayerSolveStep(){
    
    
    this.stepState = SolveStepState.SECOND_LAYER_START;
  }
  
  public boolean solve(){
    this.indexer = cube.cubeletIndexer;
    
    if (this.stepState == SolveStepState.SECOND_LAYER_START){
      boolean done = startSolve();
      if (done){
        debug.msg("Second layer start done");
        this.stepState = SolveStepState.SECOND_LAYER_DONE;
      }
      return false;
    }
    else if (this.stepState == SolveStepState.SECOND_LAYER_DONE){
      debug.msg("Second layer complete");
      return true;
    }
    
    return false;
  }
  
  private void highlightSingleCubelet(Cubelet cubelet){
    if (DEBUG){
      cube.removeHighlight();
      cubelet.highlight(true);
    }
  }
  
  private Cubelet getTargCubelet(List<Cubelet> cubelets){
    // Pick piece
    Cubelet targCubelet = cubelets.get(0); // Pick first one (TODO: optimize pick);
    highlightSingleCubelet(targCubelet);
    return targCubelet;
  }
  
  private boolean startSolve(){
    
    List<Cubelet> middleEdgeCubelets = indexer.getCubeletsBy(Layer.MIDDLE, CubeletType.EDGE);
    List<Cubelet> solvedEdgeCubelets = new ArrayList();
    
    for (Cubelet cubelet : middleEdgeCubelets){
      if (cubelet.isSolved()){
        solvedEdgeCubelets.add(cubelet);
      }
    }
    
    if (solvedEdgeCubelets.size() == 4){
      debug.msg("Second layer edges are solved");
      
      return true;
    }
    else{
      debug.msg("Second layer isn't solved, checking for edges on top");
      List<Cubelet> topNotYellowEdgeCubelets = indexer.getCubeletsBy(Layer.TOP, CubeletType.EDGE, Color.YELLOW, false);
      
      if (topNotYellowEdgeCubelets.size() > 0){
        debug.msg("Got edge cubelet on top");
        Cubelet targCubelet = getTargCubelet(topNotYellowEdgeCubelets);
        
        // Get the face that is on the side (not on top)                  // TODO: ideally we shouldn't have to place the cubelet first then call the id of the alg, but rather just give the start and end pos (would need a different way to represent the cubelet, since we don't what colors we are dealing with)
        Color sideColor = null;
        for (Color col : targCubelet.colorToFace.keySet()){
          Face currFace = targCubelet.getCubeFaceByColor(col);
          if (currFace != Face.U){
            sideColor = col;
            break;
          }
        }
        
        Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.SECOND_LAYER, 
                                                              targCubelet.getConstrainedPosition(), targCubelet.getOrientation(sideColor), // The algs use the side color for reference (could add top color too, then we could pick random color here)
                                                              targCubelet.getSolvedPosition(), targCubelet.getSolvedOrientation(sideColor));
        feeder.performAlgorithm(algorithm);
        return false;
      }
      else{
        debug.msg("No edges on top, checking middle layer");
        
        List<Cubelet> unsolvedMiddleEdgeCubelets = new ArrayList();        
        for (Cubelet cubelet : middleEdgeCubelets){
          if (!cubelet.isSolved()){
            unsolvedMiddleEdgeCubelets.add(cubelet);
          }
        }
        
        if (unsolvedMiddleEdgeCubelets.size() > 0){
          Cubelet targCubelet = getTargCubelet(unsolvedMiddleEdgeCubelets);
          
          // Simulate conditions to insert a fictional piece in the desired slot to remove piece from slot  
          List<Color> cubeletColors = targCubelet.colors;
          Color leftmostColor = Settings.getRelativeFace(Settings.getCubeFaceByColor(cubeletColors.get(0)), RelativeDirection.RIGHT) == Settings.getCubeFaceByColor(cubeletColors.get(1)) ? cubeletColors.get(0) : cubeletColors.get(1);
          Face leftmostFace = Settings.getCubeFaceByColor(leftmostColor);
          
          Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.SECOND_LAYER, 
                                                                new ConstrainedPosition(leftmostFace, Face.U), new Orientation(leftmostColor, leftmostFace),
                                                                targCubelet.getConstrainedPosition(), new Orientation(leftmostColor, leftmostFace));
                                                           
          feeder.performAlgorithm(algorithm);
          return false;
        }
        else{
          debug.msg("No unsolved edges on middle layer (ERROR)");
          return true; // Would technically be solved
        }
      }
    }
  }
  
}
