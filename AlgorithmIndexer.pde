import java.util.Arrays;
import java.util.List;
import java.util.Map;
  
public class AlgorithmIndexer{
  
  HashMap<String, Algorithm> allAlgorithmsByUseCase = new HashMap();
  boolean loaded = false;
  
  public AlgorithmIndexer(){
    loadAlgorithms();
    this.loaded = true;
  }
  
  public Algorithm getAlgorithmBy(SolveState state, AlgorithmUseCase useCase){
                                   
    Algorithm algorithm = null;
    algorithm = allAlgorithmsByUseCase.get(useCase.id);
    
    debug.msg("Use case for requested alg: " + useCase.id);
    if (algorithm == null){
      debug.msg("UNKNOWN ALGORITHM ID: " + useCase.id);
      return null;
    }
    
    return algorithm;
  }
  
  public Algorithm getAlgorithmBy(SolveState state,
                                  ConstrainedPosition startPosition, Orientation startOrientation,
                                  ConstrainedPosition endPosition, Orientation endOrientation){
                                    
    if (state == SolveState.WHITE_CROSS || state == SolveState.FIRST_LAYER || state == SolveState.SECOND_LAYER){
      
      AlgorithmUseCase useCase = null;
      Algorithm algorithm = null;
        
      if (endOrientation == null){
        boolean gotAlgorithm = false;
        List<Face> possibleDirections = Arrays.asList(Face.U, Face.D, Face.R, Face.L, Face.B, Face.F);
        int currFaceInd = 0;
        while (!gotAlgorithm){
          if (currFaceInd >= possibleDirections.size()){
            debug.msg("FAILED TO GET ALG WITH UNKNOWN END ORIENTATION");
            return null;
          }
          endOrientation = new Orientation(Color.WHITE, possibleDirections.get(currFaceInd));
          useCase  = new SinglePieceUseCase(state, startPosition, startOrientation, endPosition, endOrientation);
          algorithm = allAlgorithmsByUseCase.get(useCase.id);
          currFaceInd++;
        }
      }
      else{
        useCase  = new SinglePieceUseCase(state, startPosition, startOrientation, endPosition, endOrientation);
        algorithm = allAlgorithmsByUseCase.get(useCase.id);
        //debug.msg("DEFAULT ALG TYPE (no specific handling defined)");
      }
      
      debug.msg("Use case for requested alg: " + useCase.id);
      
      if (algorithm == null){
        debug.msg("UNKNOWN ALGORITHM ID: " + useCase.id);
        return null;
      }
      
      return algorithm;
    }
    
    return null;
  }
  
  public AlgorithmUseCase buildUseCaseByState(SolveState solveState, Cube cube){
    AlgorithmUseCase useCase = null;
    
    switch(solveState){
      case YELLOW_FACE:
        useCase = new TopLayerUseCase(solveState, cube);
        break;
      case TOP_EDGES:
        useCase = new SolvedPiecesUseCase(solveState, cube);
        break;
      default:
        debug.msg("Unsupported solve state for algorithm use case builder: " + solveState);
        break;
    }
    
    return useCase;
  }

  // Algorithms are defined relatively and will be translated to absolute moves
  private void loadAlgorithms(){
    AlgorithmDefinitions algorithmDefinitions = new AlgorithmDefinitions(); // Load the definitions
    allAlgorithmsByUseCase = algorithmDefinitions.allAlgorithmsByUseCase;
  }
  
  
  
  
  
    //HashMap<AlgorithmId, Algorithm> allAlgorithmsById = new HashMap(); 
  
  
  
    /*public Algorithm getAlgorithmBy(SolveState state, AlgorithmUseCase useCase){
                                    
    if (state == SolveState.WHITE_CROSS || state == SolveState.FIRST_LAYER || state == SolveState.SECOND_LAYER){
      
      Algorithm algorithm = null;
        
      if (endOrientation == null){
        // Todo: this could be done more elegantly with wildcards or something...
        boolean gotAlgorithm = false;
        List<Face> possibleDirections = Arrays.asList(Face.U, Face.D, Face.R, Face.L, Face.B, Face.F);
        int currFaceInd = 0;
        while (!gotAlgorithm){
          if (currFaceInd >= possibleDirections.size()){
            debug.msg("FAILED TO GET ALG WITH UNKNOWN END ORIENTATION");
            return null;
          }
          endOrientation = new Orientation(Color.WHITE, possibleDirections.get(currFaceInd));
          useCase  = new SinglePieceUseCase(state, startPosition, startOrientation, endPosition, endOrientation);
          algorithm = allAlgorithmsByUseCase.get(useCase.id);
          currFaceInd++;
        }
      }
      else{
        algorithm = allAlgorithmsByUseCase.get(useCase.id);
      }
      
      debug.msg("Use case for requested alg: " + useCase.id);
      
      if (algorithm == null){
        debug.msg("UNKNOWN ALGORITHM ID: " + useCase.id);
        return null;
      }
      
      return algorithm;
    }
    
    return null;
  }*/
  
  
  
  
  
  
  
  
    /*public Algorithm getAlgorithmBy(AlgorithmId algorithmId, Face startingFace){
    
    Algorithm algorithm = allAlgorithmsById.get(algorithmId);
    Algorithm convertedAlgorithm;
    
    if (algorithm == null){
      debug.msg("UNKNOWN ALGORITHM ID");
      return null;
    }
    
    // Convert algorithm's moves to starting face (Front face is the default)
    if (startingFace != Face.F){
      HashMap<MoveType, MoveType> moveConversion = new HashMap();
      
      if (startingFace == Face.R){
        moveConversion.put(MoveType.f, MoveType.r);
        moveConversion.put(MoveType.r, MoveType.b);
        moveConversion.put(MoveType.b, MoveType.l);
        moveConversion.put(MoveType.l, MoveType.f);
        moveConversion.put(MoveType.F, MoveType.R);
        moveConversion.put(MoveType.R, MoveType.B);
        moveConversion.put(MoveType.B, MoveType.L);
        moveConversion.put(MoveType.L, MoveType.F);
      }
      else if (startingFace == Face.B){
        moveConversion.put(MoveType.f, MoveType.b);
        moveConversion.put(MoveType.r, MoveType.l);
        moveConversion.put(MoveType.b, MoveType.f);
        moveConversion.put(MoveType.l, MoveType.r);
        moveConversion.put(MoveType.F, MoveType.B);
        moveConversion.put(MoveType.R, MoveType.L);
        moveConversion.put(MoveType.B, MoveType.F);
        moveConversion.put(MoveType.L, MoveType.R);
      }
      else if (startingFace == Face.L){
        moveConversion.put(MoveType.f, MoveType.l);
        moveConversion.put(MoveType.r, MoveType.f);
        moveConversion.put(MoveType.b, MoveType.r);
        moveConversion.put(MoveType.l, MoveType.b);
        moveConversion.put(MoveType.F, MoveType.L);
        moveConversion.put(MoveType.R, MoveType.F);
        moveConversion.put(MoveType.B, MoveType.R);
        moveConversion.put(MoveType.L, MoveType.B);
      }
      // Starting face can only be one of the side faces (yellow always up during solve)
      moveConversion.put(MoveType.u, MoveType.u);
      moveConversion.put(MoveType.U, MoveType.U);
      moveConversion.put(MoveType.d, MoveType.d);
      moveConversion.put(MoveType.D, MoveType.D);
      
      List<Move> convertedMoves = new ArrayList();
      for (Move move : algorithm.moves){
        convertedMoves.add(new Move(moveConversion.get(move.moveType)));
      }
      convertedAlgorithm = new Algorithm(algorithmId, convertedMoves);
    }
    else{
      convertedAlgorithm = algorithm;
    }
    
    debug.msg("Returning algorithm: " + convertedAlgorithm.id);
    return convertedAlgorithm;
  }*/
  
}
