public class BasicFirstLayerSolveStep extends ISolveStep{
  
  CubeletIndexer indexer;
  
  BasicFirstLayerSolveStep(){
    
    /*
    Check if solved
    if not:
      Select a piece (and bring in it position for a placement alg (U moves here)?? could be a good optimization)
      Could optimize which corners to pick first
      Perform the correct alg
      
      If no pieces with white on top, check for ones in slots and extract them
    */
    
    this.stepState = SolveStepState.FIRST_LAYER_START;
  }
  
  public boolean solve(){
    this.indexer = cube.cubeletIndexer;
    
    if (this.stepState == SolveStepState.FIRST_LAYER_START){
      boolean done = firstLayerStart();
      if (done){
        debug.msg("First layer start done");
        this.stepState = SolveStepState.FIRST_LAYER_DONE;
      }
      return false;
    }
    else if (this.stepState == SolveStepState.FIRST_LAYER_DONE){
      debug.msg("First layer complete");
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
  
  
  public boolean firstLayerStart(){
    
    List<Cubelet> bottomCornerCubelets = indexer.getCubeletsBy(Layer.BOTTOM, CubeletType.CORNER, Color.WHITE, Face.D);
    
    // Verify corners are placed
    int placedCornerCount = 0;
    for (Cubelet cubelet : bottomCornerCubelets){
      if (cubelet.isSolved()){
        placedCornerCount++;
      }
    }
    
    if (placedCornerCount == 4){
      debug.msg("All white corners placed!");
      return true;
    }
    else{
      List<Cubelet> topWhiteCornerCubelets = indexer.getCubeletsBy(Layer.TOP, CubeletType.CORNER, Color.WHITE);
      
      if (topWhiteCornerCubelets.size() > 0){
        debug.msg("Got a white corner cubelet on top");
        Cubelet targCubelet = getTargCubelet(topWhiteCornerCubelets); // TODO optimize pick (pick the ones with shortest algs first)
        
        // Get end slot
        ConstrainedPosition targSlot = targCubelet.getSolvedPosition();
        
        Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.FIRST_LAYER, 
                                                              targCubelet.getConstrainedPosition(), targCubelet.getOrientation(Color.WHITE),
                                                              targSlot, new Orientation(Color.WHITE, Face.D));
        
        feeder.performAlgorithm(algorithm);
        return false;
      }
      else{
        debug.msg("No white cubelets left on top, checking bottom");
        
        List<Cubelet> bottomWhiteCubelets = indexer.getCubeletsBy(Layer.BOTTOM, CubeletType.CORNER, Color.WHITE);
        
        // Get solved cubelets
        List<Cubelet> unsolvedBottomWhiteCubelets = new ArrayList();
        for (Cubelet cubelet: bottomWhiteCubelets){
          if (!cubelet.isSolved()){
            unsolvedBottomWhiteCubelets.add(cubelet);        
          }
        }
        
        if (unsolvedBottomWhiteCubelets.size() > 0){
          
          // Insert new cubelet to remove this cubelet from corner (then solve in another step)
          Cubelet targCubelet = getTargCubelet(unsolvedBottomWhiteCubelets);
          ConstrainedPosition targStartSlot = targCubelet.getConstrainedPosition();
          targStartSlot.faces.remove(Face.D);
          Face randomSideFace = targStartSlot.faces.get(0);
          targStartSlot.faces.add(Face.U);
          
          Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.FIRST_LAYER,
                                                                targStartSlot, new Orientation(Color.WHITE, randomSideFace),
                                                                targCubelet.getConstrainedPosition(), new Orientation(Color.WHITE, Face.D));
          feeder.performAlgorithm(algorithm);
          
          return false;
        }
        else{
          debug.msg("No bottom white cubelets left unsolved (ERROR)");
          return true;
        }
      }
    }
  }
  
}
