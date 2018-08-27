include <screw.scad>

////////   When flexible_coupling is true, Print with infill first (perimiters 2nd)
  
tol=0.8;                      // general tolerance.   0.2 per side (squish), and extra .4

coupler_height = 30;          // length of coupler
coupler_radius = 13;          // radius of coupler

nut_thickness = 2;
nut_width = 5.25;
nut_cavity_clearance = tol;

thumbscrew_dia_threads = 2.82;                             // threaded screw hole dia
thumbscrew_dia_clearancehole = thumbscrew_dia_threads+tol; // smooth screw hole dia
thumb_screw_flat_depth = 1;  // depth of the flat spot for thumbscrew heads

// top hole is for the bobbin rod
bobbinRod_isSquare = true;       // type of "bobbin rod" to use
bobbinRod_square_sideslot=true;  // side slot for the SQUARE  "bobbin rod" to slide out
bobbinRod_wh=6.35;               // width/height of the SQUARE "bobbin rod"
bobbinRod_dia = 6.35;            // diameter of the ROUND "bobbin rod"
bobbinRod_clearance = tol-0.1;   // tolerance larger, to allow rod to slide into the coupler
bobbinRod_nut_depth = 6.5;       // depth into the coupler to put the nut
bobbinRod_thumb_screw_pos_below_top = (coupler_height/2)/2; // thumbscrew hole position below top of coupler

// bottom hole is for the stepper shaft
stepper_dia = 5;             // true measure of the stepper shaft diameter
stepper_clearance = tol-0.1; // tolerance larger, to allow shaft to slide into the coupler
stepper_nut_depth = 6.5;     // depth into the coupler to put the nut
stepper_thumb_screw_pos_above_bottom = (coupler_height/2)/2-1; // thumbscrew hole position above bottom of coupler

flexible_coupling = true;        // make the coupler flexible, to eliminate slight angular differences

cyl_res = 100;                   // resolution (number of polygons) for the coupler / holes

$fn=cyl_res;

  
difference() {
  // body
  translate([0,0,-coupler_height*0.5]) cylinder( coupler_height, coupler_radius, coupler_radius );
  
  // subtract stuff
  union() {
    // slot for the rod to slide in from the side
    
    if (bobbinRod_isSquare) {
      // square hole for square rod
      translate([(bobbinRod_square_sideslot ? coupler_radius/2 : 0),0,10])
        cube([bobbinRod_wh + bobbinRod_clearance*0.5 + (bobbinRod_square_sideslot ? coupler_radius : 0),
              bobbinRod_wh + bobbinRod_clearance*0.5,
              20], true);
    } else {
      // round hole for square rod
      translate([0,0,0])
        cylinder( coupler_height/2+1, bobbinRod_dia*0.5 + bobbinRod_clearance*0.5,
                  bobbinRod_dia*0.5 + bobbinRod_clearance*0.5, $fn=cyl_res );
    }
    
    // round hole for stepper shaft
    translate([0,0,-.5-coupler_height*0.5])
      cylinder( coupler_height/2 + 0.6, stepper_dia*0.5 + stepper_clearance*0.5,
                stepper_dia*0.5 + stepper_clearance*0.5, $fn=cyl_res );

    // square "bobbin rod" set-screw
    rotate([0,0,0])
    {
      // m3 thumbscrew hole
      translate([0,0,coupler_height*0.5 - bobbinRod_thumb_screw_pos_below_top]) 
      rotate([90,0,0])
        cylinder( 17, thumbscrew_dia_clearancehole*0.5, thumbscrew_dia_clearancehole*0.5,
                  $fn=cyl_res );
      
      // m3 nut hole
      translate([0,-bobbinRod_nut_depth,coupler_height*0.5 - bobbinRod_thumb_screw_pos_below_top])
      rotate([90,0,0]) 
      translate([0 - (nut_width+nut_cavity_clearance)*0.5,
                 0 - (nut_width+nut_cavity_clearance)*0.5,
                 0 - (nut_thickness+nut_cavity_clearance)*0.5])
      color([0.6,0.6,0])
        cube([nut_width+nut_cavity_clearance,
              10+nut_width+nut_cavity_clearance,
              nut_thickness+nut_cavity_clearance]);
    }

    // D-shaped "stepper shaft" set-screw
    rotate([0,180,0])
    {
      // m3 thumbscrew hole
      translate([0,0,coupler_height*0.5 - stepper_thumb_screw_pos_above_bottom]) 
      rotate([90,0,0])
        cylinder( 17,
                  thumbscrew_dia_clearancehole*0.5,
                  thumbscrew_dia_clearancehole*0.5,
                  $fn=cyl_res );

      // m3 nut hole
      translate([0,-stepper_nut_depth,coupler_height*0.5 - stepper_thumb_screw_pos_above_bottom])
      rotate([90,0,0]) 
      translate([0 - (nut_width+nut_cavity_clearance)*0.5,
                 0 - (nut_width+nut_cavity_clearance)*0.5,
                 0 - (nut_thickness+nut_cavity_clearance)*0.5])
      color([0.6,0.6,0])
        cube([nut_width+nut_cavity_clearance,
              10+nut_width+nut_cavity_clearance,
              nut_thickness+nut_cavity_clearance]);
    }
    
    
    // flatten where the screw heads tighten
    translate([10,-coupler_radius + thumb_screw_flat_depth,-coupler_height*0.5 - 0.5])
      color([0.6,0.6,0])
      rotate([0,0,180])
      cube([20,4,coupler_height+1]);
    
    if (flexible_coupling) {
      // cavity
      translate([0,0,-5.5])
        cylinder( 10, stepper_dia/2 + 2.3, stepper_dia/2 + 2.3 );

      // make it flexible with a screw pattern
      translate([0,0,-7.6]) {      
        // screw pattern
        rotate([0,0,-60])
        screw(
            id=stepper_dia/2-tol,
            od=coupler_radius+tol,
            inc=360/cyl_res,
            thickness=0.8,
            height_inc=3.4,
            angle=2.95*360
          );
      }
    }    
    
  }
}

