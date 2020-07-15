
void keyPressed() {
  if (key == 'u') {
    cube.addMoveToQueue(new Move(MoveType.u));
  }
  else if (key == 'f'){
    cube.addMoveToQueue(new Move(MoveType.f));
  }
  else if (key == 'r'){
    cube.addMoveToQueue(new Move(MoveType.r));
  }
  else if (key == 'd'){
    cube.addMoveToQueue(new Move(MoveType.d));
  }
  else if (key == 'l'){
    cube.addMoveToQueue(new Move(MoveType.l));
  }
  else if (key == 'b'){
    cube.addMoveToQueue(new Move(MoveType.b));
  }
  /*if (key == 'u') {
    cubelet.transform.rotationAroundAxis(QUARTER_TURN, Axis.Y);
  }
  else if (key == 'f'){
    cubelet.transform.rotationAroundAxis(QUARTER_TURN, Axis.Z);
  }
  else if (key == 'r'){
    cubelet.transform.rotationAroundAxis(QUARTER_TURN, Axis.X);
  }
  else if (key == 'U'){
    cubelet.transform.rotationAroundAxis(-QUARTER_TURN, Axis.Y);
  }
  else if (key == 'F'){
    cubelet.transform.rotationAroundAxis(-QUARTER_TURN, Axis.Z);
  }
  else if (key == 'R'){
    cubelet.transform.rotationAroundAxis(-QUARTER_TURN, Axis.X);
  }*/
  // Prime moves
  else if (key == 'U') {
    cube.addMoveToQueue(new Move(MoveType.U));
  }
  else if (key == 'F'){
    cube.addMoveToQueue(new Move(MoveType.F));
  }
  else if (key == 'R'){
    cube.addMoveToQueue(new Move(MoveType.R));
  }
  else if (key == 'D'){
    cube.addMoveToQueue(new Move(MoveType.D));
  }
  else if (key == 'L'){
    cube.addMoveToQueue(new Move(MoveType.L));
  }
  else if (key == 'B'){
    cube.addMoveToQueue(new Move(MoveType.B));
  }
  
  else if (key == 's'){
    feeder.shuffleCube();
  }
  else if (key == 'S'){
    cube.solve();
  }
  
  // Fast-forward moves
  else if (key == '1'){
    if (ANIM_ANGLE_INC != HALF_PI){
      ANIM_ANGLE_INC = HALF_PI;
    }
    else{
      ANIM_ANGLE_INC = 0.17;
    }
  }
  
  // Toggle step solve
  else if (key == '2'){
    if (!STEP_SOLVE){
      STEP_SOLVE = true;
    }
    else{
      STEP_SOLVE = false;
    }
  }
  
  else if (key == '3'){
    List<Cubelet> cubelets = cube.cubeletIndexer.getCubeletsBy(Layer.BOTTOM, CubeletType.CORNER, Color.YELLOW, Face.R);
    cube.removeHighlight();
    for (Cubelet qb : cubelets){
      qb.highlight(true);
    }
  }
  
  else if (key == '4'){   
    AlgorithmUseCase useCase = new TopLayerUseCase(SolveState.YELLOW_CROSS, cube);
    debug.msg(useCase.id);
  }
  
}
