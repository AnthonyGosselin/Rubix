
public class Algorithm{
  
  List<Move> moves = new ArrayList<Move>();
  AlgorithmId id;
  AlgorithmUseCase useCase;
  
  public Algorithm(AlgorithmId id, List<Move> moves){
    this.id = id;
    this.moves = moves;
  }
 
}
