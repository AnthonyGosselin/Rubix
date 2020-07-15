import java.util.*;

enum AlgorithmId{
  Quarter_Clock,
  Quarter_Counter,
  Quarter_Clock_Right,
  Quarter_Clock_Left,
  Quarter_Clock_Back,
  Quarter_Counter_Right,
  Quarter_Counter_Left,
  Quarter_Counter_Back,
  Half_Turn,
  Half_Turn_Right,
  Half_Turn_Left,
  Half_Turn_Back,
  Remove_Corner,
  
  Null
}

public class AlgorithmDefinitions {
  
  HashMap<String, Algorithm> allAlgorithmsByUseCase = new HashMap();
  
  public AlgorithmDefinitions(){
    
    List<Algorithm> allAlgorithms = new ArrayList();
    AlgorithmUseCase useCase;
  
    // Daisy white cross algs ------------------
    
      // White edges on side to top
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.L), new Orientation(Color.WHITE, Face.L), new ConstrainedPosition(Face.U, Face.F), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Quarter_Clock, useCase, Arrays.asList("f")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.L), new Orientation(Color.WHITE, Face.L), new ConstrainedPosition(Face.U, Face.R), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Quarter_Clock_Right, useCase, Arrays.asList("u", "f")));//, "U"))); // Last move could be removed because in white cross
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.L), new Orientation(Color.WHITE, Face.L), new ConstrainedPosition(Face.U, Face.L), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Quarter_Clock_Left, useCase, Arrays.asList("U", "f")));//, "u"))); // Last move could be removed because in white cross
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.L), new Orientation(Color.WHITE, Face.L), new ConstrainedPosition(Face.U, Face.B), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Quarter_Clock_Back, useCase, Arrays.asList("u", "u", "f")));//, "U", "U"))); // Last 2 moves could be removed because in white cross
    //--
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.R), new Orientation(Color.WHITE, Face.R), new ConstrainedPosition(Face.U, Face.F), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Quarter_Counter, useCase, Arrays.asList("F")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.R), new Orientation(Color.WHITE, Face.R), new ConstrainedPosition(Face.U, Face.R), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Quarter_Counter_Right, useCase, Arrays.asList("u", "F")));//, "U"))); // Last move could be removed because in white cross
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.R), new Orientation(Color.WHITE, Face.R), new ConstrainedPosition(Face.U, Face.L), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Quarter_Counter_Left, useCase, Arrays.asList("U", "F")));//, "u"))); // Last move could be removed because in white cross
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.R), new Orientation(Color.WHITE, Face.R), new ConstrainedPosition(Face.U, Face.B), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Quarter_Counter_Back, useCase, Arrays.asList("u", "u", "F")));//, "U", "U"))); // Last 2 moves could be removed because in white cross
    // ----
  
      // White edges on bottom facing bottom
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.D), new Orientation(Color.WHITE, Face.D), new ConstrainedPosition(Face.U, Face.F), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Half_Turn, useCase, Arrays.asList("f", "f")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.D), new Orientation(Color.WHITE, Face.D), new ConstrainedPosition(Face.U, Face.R), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Half_Turn_Right, useCase, Arrays.asList("u", "f", "f")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.D), new Orientation(Color.WHITE, Face.D), new ConstrainedPosition(Face.U, Face.L), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Half_Turn_Left, useCase, Arrays.asList("U", "f", "f")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.D), new Orientation(Color.WHITE, Face.D), new ConstrainedPosition(Face.U, Face.B), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Half_Turn_Back, useCase, Arrays.asList("u", "u", "f", "f")));
    //--
  
      // White edges on bottom facing front
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.D), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.U, Face.F), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("u", "f", "L", "U", "l")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.D), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.U, Face.R), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("F", "r", "f")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.D), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.U, Face.L), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("f", "L", "F")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.D), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.U, Face.B), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("U", "f", "L", "F", "u")));
    //--
  
      // White edges on top facing front
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.U), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.U, Face.F), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("F", "u", "L")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.U), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.U, Face.R), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("f", "r")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.U), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.U, Face.L), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("F", "L")));
  
    useCase = new SinglePieceUseCase(SolveState.WHITE_CROSS, new ConstrainedPosition(Face.F, Face.U), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.U, Face.B), new Orientation(Color.WHITE, Face.U));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("F", "U", "L")));
    //----
  
  
    // First layer algs -----------------
  
      // White towards left (4 slots) 
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.F, Face.U, Face.R), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("R", "f", "r", "F"))); // Sledgehammer
  
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.F, Face.U, Face.L), new Orientation(Color.WHITE, Face.L), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("r", "U", "R"))); // "backwards insert"
  
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.B, Face.U, Face.L), new Orientation(Color.WHITE, Face.B), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("r", "U", "U", "R"))); // "backwards insert"
  
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.B, Face.U, Face.R), new Orientation(Color.WHITE, Face.R), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("u", "R", "f", "r", "F"))); // Sledghammer
    //--
  
      // Sledge hammer, white towards right (4 slots)
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.F, Face.U, Face.R), new Orientation(Color.WHITE, Face.R), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("f", "R", "F", "r"))); // Sledghammer
  
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.F, Face.U, Face.L), new Orientation(Color.WHITE, Face.F), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("U", "f", "R", "F", "r"))); // Sledghammer
  
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.B, Face.U, Face.L), new Orientation(Color.WHITE, Face.L), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("F", "U", "U", "f")));  // "backwards insert"
  
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.B, Face.U, Face.R), new Orientation(Color.WHITE, Face.B), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("F", "u", "f")));  // "backwards insert"
    //--
  
      // White towards top
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.F, Face.U, Face.R), new Orientation(Color.WHITE, Face.U), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("u", "f", "U", "F", "F", "u", "f")));
  
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.F, Face.U, Face.L), new Orientation(Color.WHITE, Face.U), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("f", "U", "F", "F", "u", "f")));
  
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.B, Face.U, Face.L), new Orientation(Color.WHITE, Face.U), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("U", "f", "U", "F", "F", "u", "f")));
  
    useCase = new SinglePieceUseCase(SolveState.FIRST_LAYER, new ConstrainedPosition(Face.B, Face.U, Face.R), new Orientation(Color.WHITE, Face.U), new ConstrainedPosition(Face.D, Face.F, Face.R), new Orientation(Color.WHITE, Face.D));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("u", "u", "f", "U", "F", "F", "u", "f")));
    //--
  
    //--------------
  
  
    // Second layer algs ----------------- 
      // Insert edge left to right
    useCase = new SinglePieceUseCase(SolveState.SECOND_LAYER, new ConstrainedPosition(Face.L, Face.U), new Orientation(Color.GREEN, Face.L), new ConstrainedPosition(Face.F, Face.R), new Orientation(Color.GREEN, Face.F));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("r", "U", "R", "f", "R", "F", "r")));
  
    useCase = new SinglePieceUseCase(SolveState.SECOND_LAYER, new ConstrainedPosition(Face.F, Face.U), new Orientation(Color.GREEN, Face.F), new ConstrainedPosition(Face.F, Face.R), new Orientation(Color.GREEN, Face.F));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("u", "r", "U", "R", "f", "R", "F", "r")));
  
    useCase = new SinglePieceUseCase(SolveState.SECOND_LAYER, new ConstrainedPosition(Face.B, Face.U), new Orientation(Color.GREEN, Face.B), new ConstrainedPosition(Face.F, Face.R), new Orientation(Color.GREEN, Face.F));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("U", "r", "U", "R", "f", "R", "F", "r")));
  
    useCase = new SinglePieceUseCase(SolveState.SECOND_LAYER, new ConstrainedPosition(Face.R, Face.U), new Orientation(Color.GREEN, Face.R), new ConstrainedPosition(Face.F, Face.R), new Orientation(Color.GREEN, Face.F));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("u", "u", "r", "U", "R", "f", "R", "F", "r")));
    //--
  
      // Insert edge right to left
    useCase = new SinglePieceUseCase(SolveState.SECOND_LAYER, new ConstrainedPosition(Face.R, Face.U), new Orientation(Color.GREEN, Face.R), new ConstrainedPosition(Face.F, Face.L), new Orientation(Color.GREEN, Face.F));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("L", "u", "l", "F", "l", "f", "L")));
  
    useCase = new SinglePieceUseCase(SolveState.SECOND_LAYER, new ConstrainedPosition(Face.F, Face.U), new Orientation(Color.GREEN, Face.F), new ConstrainedPosition(Face.F, Face.L), new Orientation(Color.GREEN, Face.F));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("U", "L", "u", "l", "F", "l", "f", "L")));
  
    useCase = new SinglePieceUseCase(SolveState.SECOND_LAYER, new ConstrainedPosition(Face.B, Face.U), new Orientation(Color.GREEN, Face.B), new ConstrainedPosition(Face.F, Face.L), new Orientation(Color.GREEN, Face.F));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("u", "L", "u", "l", "F", "l", "f", "L")));
  
    useCase = new SinglePieceUseCase(SolveState.SECOND_LAYER, new ConstrainedPosition(Face.L, Face.U), new Orientation(Color.GREEN, Face.L), new ConstrainedPosition(Face.F, Face.L), new Orientation(Color.GREEN, Face.F));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("U", "U", "L", "u", "l", "F", "l", "f", "L")));
    //--
    
    
    // Yellow cross algs ------------------
      // 'L'
    useCase = new TopLayerUseCase(SolveState.YELLOW_CROSS, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(new ConstrainedPosition(Face.L, Face.U), new Orientation(Color.YELLOW, Face.U)), // Could change for shorthand version of DefinedTransform constructor
                                                                                                         new DefinedTransform(new ConstrainedPosition(Face.B, Face.U), new Orientation(Color.YELLOW, Face.U)),
                                                                                                         new DefinedTransform(new ConstrainedPosition(Face.R, Face.U), new Orientation(Color.YELLOW, Face.R)),
                                                                                                         new DefinedTransform(new ConstrainedPosition(Face.F, Face.U), new Orientation(Color.YELLOW, Face.F)) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("f", "u", "r", "U", "R", "F")));
    
      // Line
    useCase = new TopLayerUseCase(SolveState.YELLOW_CROSS, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(new ConstrainedPosition(Face.L, Face.U), new Orientation(Color.YELLOW, Face.U)),
                                                                                                         new DefinedTransform(new ConstrainedPosition(Face.B, Face.U), new Orientation(Color.YELLOW, Face.B)),
                                                                                                         new DefinedTransform(new ConstrainedPosition(Face.R, Face.U), new Orientation(Color.YELLOW, Face.U)),
                                                                                                         new DefinedTransform(new ConstrainedPosition(Face.F, Face.U), new Orientation(Color.YELLOW, Face.F)) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("f", "r", "u", "R", "U", "F")));
    
      // Dot
    useCase = new TopLayerUseCase(SolveState.YELLOW_CROSS, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(new ConstrainedPosition(Face.L, Face.U), new Orientation(Color.YELLOW, Face.L)),
                                                                                                         new DefinedTransform(new ConstrainedPosition(Face.B, Face.U), new Orientation(Color.YELLOW, Face.B)),
                                                                                                         new DefinedTransform(new ConstrainedPosition(Face.R, Face.U), new Orientation(Color.YELLOW, Face.R)),
                                                                                                         new DefinedTransform(new ConstrainedPosition(Face.F, Face.U), new Orientation(Color.YELLOW, Face.F)) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("f", "r", "u", "R", "U", "F",   "b", "u", "l", "U", "L", "B"))); // Line, then 'L' (Any more direct way?)
    //--
    
    //--------------------------------------
    // Top layer algs ----------------------
    //--------------------------------------
    
    // OLL ALGS -------------
    
      // Driving car
    useCase = new TopLayerUseCase(SolveState.YELLOW_FACE, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(Face.U, Face.F, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.R, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.L, Color.YELLOW, Face.B),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.R, Color.YELLOW, Face.B),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.R, Color.YELLOW, Face.U) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("R", "u", "L", "u", "r", "U", "l", "u", "u", "R", "u", "r")));                                                                                                    
                                                                                                        
      // Firefly bug                                                                                                   
    useCase = new TopLayerUseCase(SolveState.YELLOW_FACE, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(Face.U, Face.F, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.R, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.R, Color.YELLOW, Face.B),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.R, Color.YELLOW, Face.F) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("R", "F", "l", "f", "r", "F", "L", "f")));
    
      // Drop off, pick up                                                                                                 
    useCase = new TopLayerUseCase(SolveState.YELLOW_FACE, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(Face.U, Face.F, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.R, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.L, Color.YELLOW, Face.L),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.L, Color.YELLOW, Face.L),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.R, Color.YELLOW, Face.B),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.R, Color.YELLOW, Face.F) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("r", "u", "u",  "r", "r", "U", "r", "r", "U",  "r", "r", "u", "u", "r")));
    
      // Factory conveyor belt                                                                                                 
    useCase = new TopLayerUseCase(SolveState.YELLOW_FACE, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(Face.U, Face.F, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.R, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.L, Color.YELLOW, Face.F),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.L, Color.YELLOW, Face.L),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.R, Color.YELLOW, Face.B),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.R, Color.YELLOW, Face.U) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("L", "U", "l", "U", "L", "u", "u", "l")));
    
      // Tease chair                                                                                                  
    useCase = new TopLayerUseCase(SolveState.YELLOW_FACE, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(Face.U, Face.F, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.R, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.L, Color.YELLOW, Face.L),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.R, Color.YELLOW, Face.B),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.R, Color.YELLOW, Face.U) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("r", "u", "u", "R", "U",   "r", "u", "R", "U", "r", "u", "R", "U",   "r", "U", "R")));   
    
      // Small chair left                                                                                                   
    useCase = new TopLayerUseCase(SolveState.YELLOW_FACE, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(Face.U, Face.F, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.R, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.L, Color.YELLOW, Face.F),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.L, Color.YELLOW, Face.L),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.R, Color.YELLOW, Face.B),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.R, Color.YELLOW, Face.U) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("L", "U", "l", "U", "L", "u", "u", "l"))); 
    
      // Small chair right                                                                                                   
    useCase = new TopLayerUseCase(SolveState.YELLOW_FACE, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(Face.U, Face.F, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.R, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.L, Color.YELLOW, Face.B),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.R, Color.YELLOW, Face.R),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.R, Color.YELLOW, Face.F) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("r", "u", "R", "u", "r", "U", "U", "R"))); 
    //-- End OLL
    
    
    // PLL ALGS ------------
    
    
   /* 
      // Solved template                                                                                                    
    useCase = new TopLayerUseCase(SolveState.TOP_CORNERS, new ArrayList<DefinedTransform>(Arrays.asList(new DefinedTransform(Face.U, Face.F, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.R, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.L, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.B, Face.R, Color.YELLOW, Face.U),
                                                                                                        new DefinedTransform(Face.U, Face.F, Face.R, Color.YELLOW, Face.U) )));
    allAlgorithms.add(createAlgorithm(AlgorithmId.Null, useCase, Arrays.asList("")));
    */
                                                                                                        
                                                                                                        

    
    
    
    // End of list -----------------
    
    
    for (Algorithm algorithm : allAlgorithms){
      allAlgorithmsByUseCase.put(algorithm.useCase.id, algorithm);
      print("(Original) " + algorithm.useCase.id + " : ");
      for (Move move : algorithm.moves){
        print(move.moveType, " ");
      }
      print("\n");
      transposeAlgorithm(algorithm);
      println("--------\n");
    }
  }
  
  private void transposeAlgorithm(Algorithm algorithm){
    // By default the algorithms are planned with the green in front, but we need to transpose with the three other faces in front
    // Flip algorithm with the three other faces in front (other than green)
    
    List<Face> transposeFaces = Arrays.asList(Face.R, Face.B, Face.L);
    
    for (Face transposeFace : transposeFaces){
      HashMap<MoveType, MoveType> moveConversion = new HashMap();
      if (transposeFace == Face.R){
        moveConversion.put(MoveType.f, MoveType.r);
        moveConversion.put(MoveType.r, MoveType.b);
        moveConversion.put(MoveType.b, MoveType.l);
        moveConversion.put(MoveType.l, MoveType.f);
        moveConversion.put(MoveType.F, MoveType.R);
        moveConversion.put(MoveType.R, MoveType.B);
        moveConversion.put(MoveType.B, MoveType.L);
        moveConversion.put(MoveType.L, MoveType.F);
      }
      else if (transposeFace == Face.B){
        moveConversion.put(MoveType.f, MoveType.b);
        moveConversion.put(MoveType.r, MoveType.l);
        moveConversion.put(MoveType.b, MoveType.f);
        moveConversion.put(MoveType.l, MoveType.r);
        moveConversion.put(MoveType.F, MoveType.B);
        moveConversion.put(MoveType.R, MoveType.L);
        moveConversion.put(MoveType.B, MoveType.F);
        moveConversion.put(MoveType.L, MoveType.R);
      }
      else if (transposeFace == Face.L){
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
      
      // Convert algorithm 
      List<Move> convertedMoves = new ArrayList();
      for (Move move : algorithm.moves){
        convertedMoves.add(new Move(moveConversion.get(move.moveType)));
      }
      Algorithm convertedAlgorithm = new Algorithm(algorithm.id, convertedMoves);
      
      // Converted useCase
      AlgorithmUseCase convertedUseCase = algorithm.useCase.duplicate();  // Clone use case
      convertedUseCase.transpose(transposeFace);
      
      
      
      if (!allAlgorithmsByUseCase.containsKey(convertedUseCase.id)){
        allAlgorithmsByUseCase.put(convertedUseCase.id, convertedAlgorithm);
        print(convertedUseCase.id + " : ");
        for (Move move : convertedAlgorithm.moves){
          print(move.moveType, " ");
        }
        print("\n");
      }
      else{
        if (convertedUseCase.state == SolveState.WHITE_CROSS || convertedUseCase.state == SolveState.FIRST_LAYER || convertedUseCase.state == SolveState.SECOND_LAYER){
          println("[Already contains alg with use case:", convertedUseCase.id, "]"); 
        }
        else{
           // Don't warn for symmetrical useCases; just don't create a new alg
        }
      }
      
      // TODO: Also reverse algorithm
      
    }
  }
  
  private Algorithm createAlgorithm(AlgorithmId id, AlgorithmUseCase useCase, List<String> moveStrings){
    
    List<Move> moves = new ArrayList();
    for (String moveString : moveStrings){
      moves.add(new Move(getMoveTypeByString(moveString)));
    }
    
    Algorithm algorithm = new Algorithm(id, moves);
    algorithm.useCase = useCase;
    return algorithm;
  }
  
  private MoveType getMoveTypeByString(String moveString){
    switch (moveString){
        case "u":
          return MoveType.u;
        case "f":
          return MoveType.f;
        case "r":
          return MoveType.r;
        case "d":
          return MoveType.d;
        case "b":
          return MoveType.b;
        case "l":
          return MoveType.l;

        // Prime moves ----
        case "U":
          return MoveType.U;
        case "F":
          return MoveType.F;
        case "R":
          return MoveType.R;
        case "D":
          return MoveType.D;
        case "B":
          return MoveType.B;
        case "L":
          return MoveType.L;
        default:
          print("INVALID MOVE STRING: " + moveString);
          return null;
      }
  }
}
