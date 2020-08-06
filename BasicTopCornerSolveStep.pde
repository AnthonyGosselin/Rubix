class BasicTopCornerSolveStep extends ISolveStep {
  
  CubeletIndexer indexer;
  SolveState globalState; 
  
  BasicTopCornerSolveStep(){
    this.stepState = SolveStepState.TOP_CORNER_STEP_START;
    this.globalState = SolveState.TOP_CORNERS;
  }
  
  
  private boolean checkIfSolved(){
    List<Cubelet> cornerCubelets = indexer.getCubeletsBy(Layer.TOP, CubeletType.CORNER);
    boolean allSolved = true;
    for (Cubelet cubelet : cornerCubelets){
      if (!cubelet.isSolved()){
        allSolved = false;
        break;
      }
    }
    
    return allSolved;
  }
   
  public boolean solve(){
    this.indexer = cube.cubeletIndexer;

    removeAllHighlights();
    
    if (this.stepState == SolveStepState.TOP_CORNER_STEP_START){
      boolean done = orientStep();
      if (done){
        debug.msg("Orient top corners step done");
        this.stepState = SolveStepState.TOP_CORNER_STEP_SOLVE;
      }
      return false;
    }
    else if (this.stepState == SolveStepState.TOP_CORNER_STEP_SOLVE){
      boolean done = solveStep();
      if (done){
        debug.msg("Top corner solve step done");
        this.stepState = SolveStepState.TOP_CORNER_STEP_DONE;
      }
      return false;
    }
    else if (this.stepState == SolveStepState.TOP_CORNER_STEP_DONE){
      debug.msg("Top corner solve done");
      return true; 
    }
    
    return false;
  }
  
  private void highlightCubelet(Cubelet cubelet){
    if (DEBUG){
      cubelet.highlight(true);
    }
  }
  
  private void highlightCubelets(List<Cubelet> cubelets){
    if (DEBUG){
      for (Cubelet cubelet : cubelets){
        cubelet.highlight(true);
      }
    }
  }
  
  private void removeAllHighlights(){
    cube.removeHighlight();
  }
  
  private boolean orientStep(){
    
    // 1. Find any two corners that have the same color on the one face
    debug.msg("Checking for pair of solved corners");
    List<Cubelet> solvedCornerPair = null;
    Color solvedColor = null;
    for (Color col : SIDE_COLORS){
      List<Cubelet> cubeletsWithColor = indexer.getCubeletsBy(Layer.TOP, CubeletType.CORNER, col);
      // Compare to see if the two cubelets with given color is pointing the same way
      if (cubeletsWithColor.get(0).getOrientation(col).isEqual(cubeletsWithColor.get(1).getOrientation(col))){
        solvedCornerPair = cubeletsWithColor;
        solvedColor = col;
        break;
      }
    }
    
    if (solvedCornerPair != null){
      if (solvedCornerPair.get(0).isSolved()){
        debug.msg("Corner pair already orientated");
        return true;
      }
      debug.msg("Got pair of solved corners: orient them");
      
      highlightCubelets(solvedCornerPair);
      
      Cubelet qb0 = solvedCornerPair.get(0);
      AlgorithmUseCase useCase = new SinglePieceUseCase(SolveState.TOP_CORNERS, qb0.getConstrainedPosition(), qb0.getOrientation(solvedColor), qb0.getSolvedPosition(), qb0.getSolvedOrientation(solvedColor));
      Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.TOP_CORNERS, useCase);
      feeder.performAlgorithm(algorithm);
      
      return true;
    }
    else{
      debug.msg("Looking for solved corner");
      List<Cubelet> allCorners = indexer.getCubeletsBy(Layer.TOP, CubeletType.CORNER);
      Cubelet solvedCorner = null;
      for (Cubelet cubelet : allCorners){
        if (cubelet.isSolved()){
          solvedCorner = cubelet;
        }
      }
      
      if (solvedCorner != null){
        debug.msg("Got solved corner: proceeding to next step");
        highlightCubelet(solvedCorner);
        return true;
      }
      else{
        debug.msg("No solved pair, solving random corner");
      
        Cubelet qb0 = allCorners.get(0);
        highlightCubelet(qb0);
        AlgorithmUseCase useCase = new SinglePieceUseCase(SolveState.TOP_CORNERS, qb0.getConstrainedPosition(), qb0.getOrientation(solvedColor), qb0.getSolvedPosition(), qb0.getSolvedOrientation(solvedColor));
        Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.TOP_CORNERS, useCase);
        feeder.performAlgorithm(algorithm);
        
        return true;
      }
    }
  }
  
  private boolean solveStep(){
    
    if (this.checkIfSolved()){
      debug.msg("Corners already solved!");
      return true;
    }
    
   else{
     debug.msg("Looking for algorithm to solved all corners");
     
     List<Cubelet> cornerCubelets = indexer.getCubeletsBy(Layer.TOP, CubeletType.CORNER);
     AlgorithmUseCase useCase = new SolvedPiecesUseCase(this.globalState, cornerCubelets);
     Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.TOP_CORNERS, useCase);
     feeder.performAlgorithm(algorithm);
        
     return true;
   } 
  }
}
