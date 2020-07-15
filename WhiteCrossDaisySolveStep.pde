
// We could event add another layer of abstraction and make it inherit from a "WhiteCrossSolveStep" which inherits from solve step
// (just so we can control what is assigned to the white cross strategy step)
public class WhiteCrossDaisySolveStep extends ISolveStep{
  
  List<ConstrainedPosition> correctDaisySlots;
  List<ConstrainedPosition> emptyDaisySlots;
  CubeletIndexer indexer;
   
  public WhiteCrossDaisySolveStep(){
    // Phase 1, step 1:
    // LOOP:
      // Identify vacant daisy slots: if none daisy complete, go to second phase
      // Look for white edges on second layer and solve them to vacant daisy slot (pick one of the vacant daisy slots to send it (pick smart)
        // (Bonus: make them focus on white edges on top layer that are the wrong way, to bring back down)
      // If found one, get and call algorithm then restart loop
      // Else: look for pieces that are on the bottom (and facing front or down)
        // place it then restart loop
      // Look for pieces in daisy slots but not orientated correctly
    //END LOOP
      
    // Phase 2:
    // Align colors and turn down...
    this.stepState = SolveStepState.DAISY_START;
  }
  
  public boolean solve(){
    
    this.indexer = cube.cubeletIndexer;
    
    if (this.stepState == SolveStepState.DAISY_START){
      boolean done = daisyStart();
      if (done){
        debug.msg("Daisy start done");
        this.stepState = SolveStepState.DAISY_END;
      }
      return false;
    }
    else if (this.stepState == SolveStepState.DAISY_END){
      boolean done = daisyEnd();
      if (done){
        debug.msg("Daisy end done");
        this.stepState = SolveStepState.DAISY_DONE; // Go to next step when done (MOVE THIS)
      }
      return false;
    }
    else if (this.stepState == SolveStepState.DAISY_DONE){
      debug.msg("White cross complete!");
      return true;
    }
    
    return false;
  }
  
  private boolean isEmptyDaisySlot(ConstrainedPosition targPos){
    for (ConstrainedPosition pos : this.correctDaisySlots){
      if (pos.isEqual(targPos)){
        return false;
      }
    }
    return true;
  }
  
  private void checkDaisySlots(){
    this.correctDaisySlots = new ArrayList();
    List<Cubelet> correctDaisyCubelets = indexer.getCubeletsBy(Layer.TOP, CubeletType.EDGE, Color.WHITE, Face.U);
    
    for (Cubelet cubelet : correctDaisyCubelets){
      this.correctDaisySlots.add(cubelet.getConstrainedPosition());
    }
    
    // Get empty slots
    this.emptyDaisySlots = new ArrayList();
    List<Cubelet> allDaisyCubelets = indexer.getCubeletsBy(Layer.TOP, CubeletType.EDGE);
    for (Cubelet cubelet : allDaisyCubelets){
      if (!correctDaisyCubelets.contains(cubelet)){
        this.emptyDaisySlots.add(cubelet.getConstrainedPosition());
      }
    }
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
    debug.msg(targCubelet.getCubeFaceByColor(Color.WHITE));
    return targCubelet;
  }
  
  private Face getEdgeOtherFace(Cubelet cubelet, Face referenceFace){
    Face otherFace = null;
    for (Face face : ALL_FACES){
      if (face != referenceFace && cubelet.isOnFace(face)){
        otherFace = face;
      }
    }
    return otherFace;
  }
  
  private Color getEdgeOtherColor(Cubelet cubelet, Color referenceCol){
    Color otherColor = null;
    for (Color col : cubelet.colorToFace.keySet()){
      if (col != referenceCol){
        otherColor = col;
      }
    }
    return otherColor;
  }
  
  public boolean daisyStart(){
    
    // Identify vacant daisy slots
    checkDaisySlots();
    if (this.correctDaisySlots.size() == 4){
      // Daisy done
      return true;
    }
    else{
      // Check for white edges on side
      debug.msg("Check for white on side");
      List<Cubelet> middleEdgeCubelets = indexer.getCubeletsBy(Layer.MIDDLE, CubeletType.EDGE, Color.WHITE);
      if (middleEdgeCubelets.size() > 0){
        
        Cubelet targCubelet = getTargCubelet(middleEdgeCubelets);
        debug.msg("Got white on side");

        // Pick daisy slot to send piece
        ConstrainedPosition targDaisySlot;
        Face whiteCubeFace = targCubelet.getCubeFaceByColor(Color.WHITE);
        Face otherFace = getEdgeOtherFace(targCubelet, whiteCubeFace); // Get the other face that the edge is on (other than its white face)

        if (isEmptyDaisySlot(new ConstrainedPosition(Face.U, otherFace))){
          targDaisySlot = new ConstrainedPosition(Face.U, otherFace);
        }
        else{
          // Pick a different slot
          targDaisySlot = this.emptyDaisySlots.get(0); // Pick first one (TODO: optimize pick)
        }
        
        // White edge on side to top
        Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.WHITE_CROSS, 
                                                              targCubelet.getConstrainedPosition(), targCubelet.getOrientation(Color.WHITE),
                                                              targDaisySlot, new Orientation(Color.WHITE, Face.U));
        
        feeder.performAlgorithm(algorithm);
        return false;
      }
      else{
        // Check for white edges on bottom
        debug.msg("No white on side, checking for white on bottom");
        
        List<Cubelet> bottomWhiteCubelets = indexer.getCubeletsBy(Layer.BOTTOM, CubeletType.EDGE, Color.WHITE);
        
        if (bottomWhiteCubelets.size() > 0){
          Cubelet targCubelet = getTargCubelet(bottomWhiteCubelets);
          debug.msg("Got bottom white");
          
          // Pick a daisy slot
          ConstrainedPosition targDaisySlot;
          Face whiteCubeFace = targCubelet.getCubeFaceByColor(Color.WHITE);
          
          if (whiteCubeFace == Face.D){
            // Try to get same face first first
            Face otherFace = getEdgeOtherFace(targCubelet, whiteCubeFace); // Get the other face that the edge is on (other than its white face)
            
            if (isEmptyDaisySlot(new ConstrainedPosition(Face.U, otherFace))){
              targDaisySlot = new ConstrainedPosition(Face.U, otherFace);
            }
            else{
              // Pick a different slot
              targDaisySlot = this.emptyDaisySlots.get(0); // Pick first one (TODO: optimize pick)
            }
          }
          else{
            // Pick slot on right, else on left, else front or back for less moves
            Face targFace = Settings.getRelativeFace(whiteCubeFace, RelativeDirection.RIGHT);
            if (isEmptyDaisySlot(new ConstrainedPosition(Face.U, targFace))){
              targDaisySlot = new ConstrainedPosition(Face.U, targFace);
            }
            else{
              targFace = Settings.getRelativeFace(whiteCubeFace, RelativeDirection.LEFT); // Check left
              if (isEmptyDaisySlot(new ConstrainedPosition(Face.U, targFace))){
                targDaisySlot = new ConstrainedPosition(Face.U, targFace);
              }
              else{
                targDaisySlot = this.emptyDaisySlots.get(0); // Pick first one (either front or back) (TODO: optimize pick)
              }
            } 
          }
          
          Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.WHITE_CROSS, 
                                                              targCubelet.getConstrainedPosition(), targCubelet.getOrientation(Color.WHITE),
                                                              targDaisySlot, new Orientation(Color.WHITE, Face.U));
          
          feeder.performAlgorithm(algorithm);
          
          return false;
        }
        else{
          debug.msg("No white on bottom, checking top");
          
          List<Cubelet> allTopWhiteCubelets = indexer.getCubeletsBy(Layer.TOP, CubeletType.EDGE, Color.WHITE);
          // Remove place daisy slots
          List<Cubelet> topWhiteCubelets = new ArrayList();
          for (Cubelet cubelet : allTopWhiteCubelets){
            if (cubelet.getCubeFaceByColor(Color.WHITE) != Face.U){
              topWhiteCubelets.add(cubelet);
            }
          }
          
          if (topWhiteCubelets.size() > 0){
            
            Cubelet targCubelet = getTargCubelet(topWhiteCubelets);
            debug.msg("Got top white");
            
            // Pick a daisy slot
            ConstrainedPosition targDaisySlot;
            Face whiteCubeFace = targCubelet.getCubeFaceByColor(Color.WHITE);
            /*Face whiteCubeFace = null;
            for (Face face : targCubelet.colorToFace.values()){
              if (face != Face.U){
                whiteCubeFace = face;
              }
            }*/
            
            // Pick slot on right, else on left, else front or back for less moves
            Face targFace = Settings.getRelativeFace(whiteCubeFace, RelativeDirection.RIGHT);
            if (isEmptyDaisySlot(new ConstrainedPosition(Face.U, targFace))){
              targDaisySlot = new ConstrainedPosition(Face.U, targFace);
            }
            else{
              targFace = Settings.getRelativeFace(whiteCubeFace, RelativeDirection.LEFT); // Check left
              if (isEmptyDaisySlot(new ConstrainedPosition(Face.U, targFace))){
                targDaisySlot = new ConstrainedPosition(Face.U, targFace);
              }
              else{
                targDaisySlot = this.emptyDaisySlots.get(0); // Pick first one (either front or back) (TODO: optimize pick)
              }
            }
            
            Algorithm algorithm = algorithmIndexer.getAlgorithmBy(SolveState.WHITE_CROSS, 
                                                                  targCubelet.getConstrainedPosition(), targCubelet.getOrientation(Color.WHITE),
                                                                  targDaisySlot, new Orientation(Color.WHITE, Face.U));
          
            feeder.performAlgorithm(algorithm);
            
            return false;
          }
          else{
            debug.msg("White cubelets not found (error)");
            return false;
          }
        }
      }
    }
  }
  
  // -----
  
  public boolean daisyEnd(){
    
    debug.msg("Start daisy end");
    
    // Check if any of the middle pieces match with their center
    List<Cubelet> daisyCubelets = indexer.getCubeletsBy(Layer.TOP, CubeletType.EDGE, Color.WHITE, Face.U);
    
    Cubelet placedDaisyCubelet = null;
    ConstrainedPosition targSlot = null;
    
    if (daisyCubelets.size() > 0){
      debug.msg("Got daisy cubelets on top");
      for (Cubelet cubelet : daisyCubelets){
        Face whiteCubeFace = cubelet.getCubeFaceByColor(Color.WHITE);
        Face otherFace = getEdgeOtherFace(cubelet, whiteCubeFace);
        Color sideColor = getEdgeOtherColor(cubelet, Color.WHITE);
        
        if (Settings.getColorByCubeFace(otherFace) == sideColor){
          placedDaisyCubelet = cubelet;
          targSlot = new ConstrainedPosition(Face.D, otherFace);
          highlightSingleCubelet(cubelet);
          break;
        }
      }
      
      Algorithm algorithm;
      if (placedDaisyCubelet != null){
        debug.msg("Got a placed daisy cubelet");
        algorithm = algorithmIndexer.getAlgorithmBy(SolveState.WHITE_CROSS, 
                                                    targSlot, new Orientation(Color.WHITE, Face.D),
                                                    placedDaisyCubelet.getConstrainedPosition(), placedDaisyCubelet.getOrientation(Color.WHITE)); // ** Use case is taking bottom one to top, which is the same as top to bottom
                                                                                                                                                  // We would need to implement algorithm reverse in algorithm indexer to specify the other way around
        feeder.performAlgorithm(algorithm);
        return false;
      }
      else{
        debug.msg("No placed daisy cubelets, turning once");
        cube.addMoveToQueue(new Move(MoveType.u)); // Perform top turn
        return false;
      }
    }
    else{
      debug.msg("No more daisy cubelets left on top");
      return true;
    }
  }
    
}
