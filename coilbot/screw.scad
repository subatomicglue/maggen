// SCREW
// Simple module to create square screw threads
// useful e.g. for modeling shaft couplers with flexible compensation
module screw( id, od, inc, thickness, height_inc, angle ) {
  union()
  for(i = [0 : inc : angle])
    polyhedron( points = [
      [id*cos(i), id*sin(i), i*height_inc/360],
      [id*cos((i+inc)), id*sin((i+inc)), (i+inc)*height_inc/360],
      [id*cos((i+inc)), id*sin((i+inc)), (i+inc)*height_inc/360+thickness],
      [id*cos(i), id*sin(i), i*height_inc/360+thickness],
      [od*cos(i), od*sin(i), i*height_inc/360],
      [od*cos((i+inc)), od*sin((i+inc)), (i+inc)*height_inc/360],
      [od*cos((i+inc)), od*sin((i+inc)), (i+inc)*height_inc/360+thickness],
      [od*cos(i), od*sin(i), i*height_inc/360+thickness],
    ], faces = [
      [1, 0, 3, 2],
      [4, 5, 6, 7],
      [4,0,1],   // non-planar top face, split to triangle
      [4,  1,5], // non-planar top face, split to triangle
      [6,2,3],   // non-planar bottom face, split to triangle
      [6,  3,7], // non-planar bottom face, split to triangle
      [7,3,0,4],
      [5,1,2,6],
    ],
    convexity = 10);
}

// simple test
module screwTest() {
  screw(
    id=5,
    od=15,
    inc=10,
    thickness=3,
    height_inc=5,
    //angle=0.025*360,
    angle=12*360
  );
}

// uncomment to test
//screwTest();




