import peasy.*;

PeasyCam cam;
Cube cube;
Cubelet cubelet;
Feeder feeder;
AlgorithmIndexer algorithmIndexer;
Debug debug;

float angle = 0;
Face currFace = Face.U;

void setup() {
  size(800, 800, P3D);
  smooth(8); // Makes edges smoother
  cam = new PeasyCam(this, 200);
  cam.setMinimumDistance(150);
  cam.setMaximumDistance(250);

  cube = new Cube(DIM_X, DIM_Y, DIM_Z);
  //cubelet = new Cubelet(0, 0, 0);
  
  feeder = new Feeder(cube);
  algorithmIndexer = new AlgorithmIndexer();
  debug = new Debug();
}

void draw() {
  background(200);
  scale(1.2);
  
  cube.show();
  //cubelet.show();
}
