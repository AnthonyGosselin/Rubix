public class BasicTopLayerSolveStep extends ISolveStep{
  
  CubeletIndexer indexer;
  SolveState globalState; 
  
  BasicTopLayerSolveStep(SolveState globalState){
    this.globalState = globalState;
    this.stepState = SolveStepState.TOP_LAYER_STEP_START;
  }
  
  public boolean solve(){
    this.indexer = cube.cubeletIndexer;
    
    boolean success = startSolve();
    
    if (success){
      debug.msg("Top layer step complete");
    }
    else{
      debug.msg("ERROR: top layer step failed");
    }
    
    return success;
  }
  
  private void highlightCubelet(Cubelet cubelet){
    if (DEBUG){
      cubelet.highlight(true);
    }
  }
  
  private void removeAllHighlights(){
    cube.removeHighlight();
  }
  
  private boolean startSolve(){
    
    // This solve step type assumes it can complete the step in one algorithm
    debug.msg("Finding algorithm for step: " + this.globalState);
    AlgorithmUseCase useCase = new TopLayerUseCase(this.globalState, cube);
    Algorithm algorithm = algorithmIndexer.getAlgorithmBy(this.globalState, useCase);
    feeder.performAlgorithm(algorithm);
    
    return true;
  }
  
}
