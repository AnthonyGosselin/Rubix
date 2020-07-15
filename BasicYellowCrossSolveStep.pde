public class BasicYellowCrossSolveStep extends ISolveStep{
  
  CubeletIndexer indexer;
  
  BasicYellowCrossSolveStep(){
    this.stepState = SolveStepState.YELLOW_CROSS_START;
  }
  
  public boolean solve(){
    this.indexer = cube.cubeletIndexer;
    
    if (this.stepState == SolveStepState.YELLOW_CROSS_START){
      boolean done = startSolve();
      if (done){
        debug.msg("Yellow cross start done");
        this.stepState = SolveStepState.YELLOW_CROSS_DONE;
      }
      return false;
    }
    else if (this.stepState == SolveStepState.YELLOW_CROSS_DONE){
      debug.msg("Yellow cross complete");
      return true;
    }
    
    return false;
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
    
    List<Cubelet> solvedCrossCubelets = indexer.getCubeletsBy(Layer.TOP, CubeletType.EDGE, Color.YELLOW, Face.U);
    if (solvedCrossCubelets.size() == 4){
      debug.msg("All four yellow cross pieces are in place");
      return true;
    }
    else{
      debug.msg("Yellow cross is not formed, finding algorithm");
      // TODO: add some cool highlighting during solve
      
      List<Cubelet> topEdgePieces = indexer.getCubeletsBy(Layer.TOP, CubeletType.EDGE);
      List<DefinedTransform> edgePieceTransforms = new ArrayList();
      
      for (Cubelet cubelet : topEdgePieces){
        edgePieceTransforms.add(cubelet.getDefinedTransform(Color.YELLOW));
      }
      
      AlgorithmUseCase useCase = new TopLayerUseCase(SolveState.YELLOW_CROSS, edgePieceTransforms);
      Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.YELLOW_CROSS, useCase);
      feeder.performAlgorithm(algorithm);
      
      return false; // In theory it should be solved in one step, but we can redo the validation with another loop //<>//
    }
  }
  
}
