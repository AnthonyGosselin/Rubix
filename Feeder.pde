// Feeds algorthims and sequences to the cube for it to perform
class Feeder{
  
  public Cube cube;
  
  public Feeder(Cube cube){
    this.cube = cube;
  }
  
  public boolean areOppositeMoveTypes(MoveType type1, MoveType type2){
    if (type1 == null || type2 == null){
      return false;
    } 
    
    String name1 = type1.toString();
    String name2 = type2.toString();
    boolean name1IsUpper = name1.toUpperCase().equals(name1);

    // Flip case of one and compare
    return (name1IsUpper && name1.toLowerCase().equals(name2)) || (!name1IsUpper && name1.toUpperCase().equals(name2));
  }
  
  public void performAlgorithm(Algorithm alg){
    if (alg != null){
      debug.msg("Running algorithm: " + alg.id);
      for (Move move : alg.moves){
        cube.addMoveToQueue(move);
      }
    }
    else{
      debug.msg("DID NOT FEED ALGORITHM, BECAUSE NULL");
    }
  }
  
  public void shuffleCube(){
   int numMoves = round(random(10, 20));
   MoveType[] allMoveTypes = MoveType.class.getEnumConstants();
   List<MoveType> shuffleSequence = new ArrayList();
   MoveType lastMoveType = null;
   
   for (int i = 0; i < numMoves; i++){
     MoveType nextMoveType;
     do{
       int nextMoveIndex = round(random(1, allMoveTypes.length)) - 1;
       nextMoveType = allMoveTypes[nextMoveIndex];
     }while(areOppositeMoveTypes(lastMoveType, nextMoveType));
     
     cube.addMoveToQueue(new Move(nextMoveType));
     lastMoveType = nextMoveType;
     shuffleSequence.add(nextMoveType);
   }
   
   debug("Shuffle: ");
   for (MoveType moveType : shuffleSequence){
     debug(moveType + " ");
   }
   debug("\n");
  }
  
  
}
