public class Solver{
  
  SolveState currentState;
  boolean done = false;
  
  ISolveStep whiteCrossStep;
  ISolveStep firstLayerStep;
  ISolveStep secondLayerStep;
  ISolveStep yellowCrossStep;
  ISolveStep yellowFaceStep;
  ISolveStep topCornersStep;
  ISolveStep topEdgesStep;
  
  
  public Solver(){
    this.currentState = SolveState.WHITE_CROSS;
    this.whiteCrossStep = new WhiteCrossDaisySolveStep();
    this.firstLayerStep = new BasicFirstLayerSolveStep();
    this.secondLayerStep = new BasicSecondLayerSolveStep();
    this.yellowCrossStep = new BasicYellowCrossSolveStep();
    this.yellowFaceStep = new BasicTopLayerSolveStep(SolveState.YELLOW_FACE);
    this.topCornersStep = new BasicTopLayerSolveStep(SolveState.TOP_CORNERS);
    this.topEdgesStep = new BasicTopLayerSolveStep(SolveState.TOP_EDGES);
    
    // ...Solved!
  }
  
  public void solve(){
    
    // Change step solve for a set solve state
    if (SOLVE_UNTIL_STATE != null && currentState == SOLVE_UNTIL_STATE && !STEP_SOLVE){
      STEP_SOLVE = true;
    }
    else{
      
      switch(currentState){
        case WHITE_CROSS:
          boolean doneCross = whiteCrossStep.solve();
          if (doneCross){
            currentState = SolveState.FIRST_LAYER; // Set next step
          }
          break;
        case FIRST_LAYER:
          boolean doneFirstLayer = firstLayerStep.solve();
          if (doneFirstLayer){
            currentState = SolveState.SECOND_LAYER;
          }
          break;
        case SECOND_LAYER:
          boolean doneSecondLayer = secondLayerStep.solve();
          if (doneSecondLayer){
            currentState = SolveState.YELLOW_CROSS;
          }
          break;
        case YELLOW_CROSS:
          boolean doneYellowCross = yellowCrossStep.solve();
          if (doneYellowCross){
            currentState = SolveState.YELLOW_FACE;
          }
          break;
        case YELLOW_FACE:
          boolean doneYellowFace = yellowFaceStep.solve();
          if (doneYellowFace){
            currentState = SolveState.TOP_CORNERS;
          }
          break;
        case TOP_CORNERS:
          boolean doneTopCorners = topCornersStep.solve();
          if (doneTopCorners){
            currentState = SolveState.TOP_EDGES;
          }
          break;
        case TOP_EDGES:
          boolean doneTopEdges = topEdgesStep.solve();
          if (doneTopEdges){
            currentState = SolveState.SOLVED;
          }
          break;
        case SOLVED:
          println("Done solving cube!");
          this.done = true;
          cube.removeHighlight();
          break;
        default:
          break;
      }
      
    }
  }
}
