
// red:      stator w/ coils
// darkgrey: iron
// grey:     rotor w/magnets
// yellow:   rotor mount w/ shaft coupler
// units:    mm

// export CAD files:
RENDER_FOR_SHEET_MATERIALS = false;  // set true, render/f6, then export SVG file.
RENDER_FOR_3D_PRINTER = false;       // set true, render/f6, then export STL file

// DISPLAY settings
SHAFT_MOUNT_ATTACH=false; // attach the shaftmount to the rotor in the exploded 3D view.
SHOW_MAGNETS = RENDER_FOR_SHEET_MATERIALS || RENDER_FOR_3D_PRINTER ? false : true;
SHOW_SCREWS = RENDER_FOR_SHEET_MATERIALS || RENDER_FOR_3D_PRINTER ? false : true;

// config:
DISTANCE_APART_3D = 30; // how far apart to display each disc in the 3D scene
SHAFT_MOUNT_POSTS = false; // true: embeded screw posts, or false: flat flange
EMBED_SHAFT_MOUNT = false; // true: embeded hub into rotor, or false: external mount
SHAFT_MOUNT_RAISED_HOLES_WHEN_EMBEDDED = true;
SHAFT_MOUNT_RAISED_HOLES_WHEN_NOT_EMBEDDED = false;
SHAFT_MOUNT_RAISED_HOLES = EMBED_SHAFT_MOUNT ? SHAFT_MOUNT_RAISED_HOLES_WHEN_EMBEDDED : SHAFT_MOUNT_RAISED_HOLES_WHEN_NOT_EMBEDDED;
SCREW_HOLE_RADIUS_MM=1.25; // size of screw holes with threads
SCREW_WASHERHOLE_RADIUS_MM=1.5; // size of screw holes without threads
SCREW_HEAD_RADIUS_MM=2.2;  // size of screw head
SCREW_NUT_RADIUS_MM=2.2;  // size of nut
SHAFT_MOUNT_SCREW_CENTER=false; // center the shaft mount collar set screw (true), or set it flush with the flange (false)
MAGNET_USE_RECTS=true; // use rectangles (true) or circles (false) for magnets
STATOR_HALVES=true; // want your stator in one unweildy donut, or in drop-in-able halves?
TOL=0.2;
$fn=40;    // resolution of circles
overall_radius=30;
axle_radius = 2.5;
magnets_number = 12;
magnets_radius=20; // how far out to place all the magnets (radius to their centerpoint)
magnets_width=7;
magnets_height=12;
magnet_radius=5;   // radius for each circle magnet
magnets_thickness=5;
iron_outer_radius_mm = overall_radius;
iron_inner_radius_mm = 15;
iron_thickness_mm = 3;
rotor_outer_radius_mm = overall_radius;
rotor_thickness_mm = 3;
rotor_mounting_holes_radius = 10;
rotor_mounting_hole_radius_when_sm_raised = 1.7;
rotor_mounting_hole_radius = SHAFT_MOUNT_RAISED_HOLES ? rotor_mounting_hole_radius_when_sm_raised : SCREW_HOLE_RADIUS_MM;
shaftmountcollar_numholes = 6;
shaftmountcollar_clampingslot_width_mm = 1;
shaftmountcollar_clampingslot_screwpad_mm = 3;
shaftmountcollar_middl_radius_mm = 7;
shaftmountcollar_inner_radius_mm = axle_radius;
shaftmountcollar_thicknessOut_mm = 1;
shaftmountcollar_thicknessIn_mm = 4.01;
shaftmountcollar_offset_mm = EMBED_SHAFT_MOUNT ? shaftmountcollar_thicknessOut_mm : -rotor_thickness_mm;
shaftmountcollar_mounting_holes_radius = rotor_mounting_holes_radius;
shaftmountcollar_mounting_hole_inner_radius = SCREW_HOLE_RADIUS_MM;
shaftmountcollar_mounting_hole_outer_radius_when_raised = rotor_mounting_hole_radius_when_sm_raised;
shaftmountcollar_mounting_hole_outer_radius_when_not_raised = 0;
shaftmountcollar_mounting_hole_outer_radius = SHAFT_MOUNT_RAISED_HOLES ? shaftmountcollar_mounting_hole_outer_radius_when_raised : shaftmountcollar_mounting_hole_outer_radius_when_not_raised; 
shaftmountcollar_mounting_hole_thickness = rotor_thickness_mm - 0.1; 
shaftmountcollar_outer_radius_mm = rotor_mounting_holes_radius + rotor_mounting_hole_radius + (EMBED_SHAFT_MOUNT ? 0 : SCREW_HEAD_RADIUS_MM);
rotor_inner_radius_mm = EMBED_SHAFT_MOUNT ? shaftmountcollar_middl_radius_mm+TOL : axle_radius;
stator_outer_radius_mm = overall_radius;
stator_inner_radius_mm = shaftmountcollar_outer_radius_mm;
stator_thickness_mm = 3;




//Round head screw
in=25.4;  // Set "in" variable to make it easier to work in inches
          // and still output a metric STL file
dt=0.132*in;               // screw shaft diameter
lt=.5*in;
dh=.26*in;
hh=.103*in;
r=dh*dh/(8*hh)+hh/2;
dc=hh-r;
hole_clearance = -0.008 * in;      // +amount diameter to add for probe/collet/screw hole (0.008 kerf)

module washer()
{
  color("lightgreen")
  linear_extrude (.05*in)
  difference ()
  {
     circle (.25*in/2);
     circle (.156*in/2);
  }
}

module nut( nut_thickness=2, nut_id=3, nut_size=6 )
{
  nut_dia = nut_size/cos(30);
  color("grey")
  translate([0,0,0.2]) // screw the nut on .2 mm past the end
  rotate([0,0,30])
  linear_extrude( nut_thickness )
  {
     difference ()
     {
        circle (nut_dia/2, $fn=6);
        circle (nut_id/2,$fn=10);
     }
  }
}

// shoulder_screw(2, 4, thickness, 3, 3, 1.5);
module shoulder_screw(hhead, dhead, lshoulder, dshoulder, lthd, dthd)
{
  in=25.4;
  $fn=20;
  color("lightblue")
  union  ()
  {
    cylinder (hhead,dhead/2,dhead/2);
    translate ([0,0,-lshoulder]) cylinder (lshoulder,dshoulder/2,dshoulder/2);
    translate ([0,0,-lthd-lshoulder]) cylinder (lthd,dthd/2,dthd/2);
  }
}

module m3screwshaft( length, dia=3, AS_HOLE=false ) {
  translate ([0,0,-length + (AS_HOLE ? 0.001 : 0)])
  cylinder (length, (dia + (AS_HOLE ? hole_clearance : 0)) * 0.5,
                (dia + (AS_HOLE ? hole_clearance : 0)) * 0.5);
}

// roundhead screw
module rh_m3screw( lt=8, dia=3, head_height=1.5, head_dia=5.5, AS_HOLE = false )
{
  $fn=20;
  color([0.7,0.5,0])
  translate([0,0,lt])
  union() {
    if (!AS_HOLE) {
      translate([0,0,head_height])
      scale([1,1,0.3])
      difference ()
      {
        translate ([0,0,0]) sphere(head_dia/2);
        translate ([0,0,-head_dia/2]) cube (head_dia,center=true);
      }
      cylinder(head_height, head_dia/2, head_dia/2); 
    }
    m3screwshaft( lt, dt );
  }
}

// sockethead m3 screw
module sh_m3screw( lt=8, dia=3, head_height=3, head_dia=5.5, AS_HOLE = false )
{
  $fn=20;
  translate([0,0,lt])
  union() {
    m3screwshaft( lt, dia );
    if (!AS_HOLE) translate ([0,0,0]) cylinder (head_height,head_dia/2,head_dia/2);
  }
}

// panhead m3 screw
module pan_m3screw( lt=8, dia=3, head_height=2, head_dia=5.5, AS_HOLE = false )
{
  $fn=20;
  translate([0,0,lt])
  union() {
    m3screwshaft( lt, dia );
    if (!AS_HOLE) translate ([0,0,0]) cylinder (head_height,dia/2,head_dia/2);
  }
}

module rh_m3screw_nut( lt=8, dia=3, head_height=1.5, head_dia=6, s, n, AS_HOLE = false ) {
  translate([0,0, s]) rh_m3screw(lt, dia, head_height, head_dia, AS_HOLE);
  if (!AS_HOLE) nut();
}


// TEST
/*
translate([0,0,0]) rh_m3screw( 10, 3, 1.5, 5.5 );
translate([6,0,0]) sh_m3screw( 10, 3, 3, 5.5 );
translate([12,0,0]) pan_m3screw( 10, 3, 2, 5.5 );
translate([18,0,0]) rh_m3screw_nut( 10, 3, 1.5, 5.5 );
*/

module disc( c, thickness, or, ir ) {
  color(c)
  difference() {
    translate ([0,0,-thickness]) cylinder(thickness,or,or);
    translate ([0,0,-thickness*1.05]) cylinder(thickness*1.1,ir,ir);
  }
}

module shaftMountCollar() {
  translate([0,0,0])
  color( "orange" )
  difference() {
    union() {
      // flange mount
      translate ([0,0,shaftmountcollar_offset_mm])
      disc( "orange", shaftmountcollar_thicknessOut_mm, shaftmountcollar_outer_radius_mm, shaftmountcollar_inner_radius_mm );

      // shaft collar
      translate ([0,0,shaftmountcollar_offset_mm - shaftmountcollar_thicknessOut_mm])
      disc( "orange", shaftmountcollar_thicknessIn_mm, shaftmountcollar_middl_radius_mm, shaftmountcollar_inner_radius_mm );

      // riser standoffs
      translate ([0,0,shaftmountcollar_offset_mm - shaftmountcollar_thicknessOut_mm])
      mountingHoles( shaftmountcollar_mounting_holes_radius, shaftmountcollar_mounting_hole_outer_radius, shaftmountcollar_mounting_hole_thickness, 0 );
    }
    
    union() {
      // mounting-screw head indents
      translate ([0,0,shaftmountcollar_offset_mm - shaftmountcollar_thicknessOut_mm - shaftmountcollar_mounting_hole_thickness])
      mountingHoles( shaftmountcollar_mounting_holes_radius, SCREW_HEAD_RADIUS_MM, shaftmountcollar_mounting_hole_thickness, 0 );

      // mounting-screw holes
      translate ([0,0,shaftmountcollar_offset_mm])
      mountingHoles( shaftmountcollar_mounting_holes_radius, shaftmountcollar_mounting_hole_inner_radius, shaftmountcollar_thicknessOut_mm + shaftmountcollar_thicknessIn_mm, 0.1 );

      // clamp slot
      translate([0,999/2, 0]) cube([shaftmountcollar_clampingslot_width_mm,999,999], true);
      
      // clamp screw threads
      translate([0,shaftmountcollar_inner_radius_mm + (shaftmountcollar_middl_radius_mm-shaftmountcollar_inner_radius_mm)/2,
      shaftmountcollar_offset_mm-shaftmountcollar_thicknessOut_mm - (SHAFT_MOUNT_SCREW_CENTER ? shaftmountcollar_thicknessIn_mm/2 : SCREW_HEAD_RADIUS_MM)])
      rotate([0,90,0])
      cylinder( 20, SCREW_HOLE_RADIUS_MM, SCREW_HOLE_RADIUS_MM );
      
      // clamp screw nut
      translate([shaftmountcollar_clampingslot_width_mm/2 + shaftmountcollar_clampingslot_screwpad_mm,shaftmountcollar_inner_radius_mm + (shaftmountcollar_middl_radius_mm-shaftmountcollar_inner_radius_mm)/2,shaftmountcollar_offset_mm-shaftmountcollar_thicknessOut_mm - (SHAFT_MOUNT_SCREW_CENTER ? shaftmountcollar_thicknessIn_mm/2 : SCREW_HEAD_RADIUS_MM)])
      rotate([0,90,0])
      cylinder( 20, SCREW_HEAD_RADIUS_MM, SCREW_HEAD_RADIUS_MM );
      
      // clamp screw hole
      translate([0,shaftmountcollar_inner_radius_mm + (shaftmountcollar_middl_radius_mm-shaftmountcollar_inner_radius_mm)/2,
      shaftmountcollar_offset_mm-shaftmountcollar_thicknessOut_mm - (SHAFT_MOUNT_SCREW_CENTER ? shaftmountcollar_thicknessIn_mm/2 : SCREW_HEAD_RADIUS_MM)])
      rotate([0,-90,0])
      cylinder( 20, SCREW_WASHERHOLE_RADIUS_MM, SCREW_WASHERHOLE_RADIUS_MM );
      
      // clamp screw head
      translate([-shaftmountcollar_clampingslot_width_mm/2 - shaftmountcollar_clampingslot_screwpad_mm,shaftmountcollar_inner_radius_mm + (shaftmountcollar_middl_radius_mm-shaftmountcollar_inner_radius_mm)/2,
      shaftmountcollar_offset_mm-shaftmountcollar_thicknessOut_mm - (SHAFT_MOUNT_SCREW_CENTER ? shaftmountcollar_thicknessIn_mm/2 : SCREW_HEAD_RADIUS_MM)])
      rotate([0,-90,0])
      cylinder( 20, SCREW_HEAD_RADIUS_MM, SCREW_HEAD_RADIUS_MM );
    }
  }
}
module ironDisc() {
  disc( "grey", iron_thickness_mm, iron_outer_radius_mm, iron_inner_radius_mm );
}

// o is to tweak it slightly longer on both ends (for difference() ops)
module mountingHoles( holes_radius, hole_radius, thickness, o ) {
  union() {
    for (i = [0:shaftmountcollar_numholes]) {
      rotate(i * 360/shaftmountcollar_numholes,0,0)
      translate([holes_radius,0,-thickness*(1+o*0.5)])
      cylinder(thickness*(1+o),hole_radius,hole_radius);
    }
  }
}

module _mountingScrews( holes_radius, hole_radius, thickness, num ) {
  color( "lightblue" )
  union() {
    for (i = [0:num]) {
        rotate([0,180,0]) rotate(i * 360/num,0,0)
        translate([holes_radius,0,0])
        rh_m3screw( thickness );
    }
  }
}

module mountingScrews() {
  if (SHOW_SCREWS && !RENDER_FOR_SHEET_MATERIALS && !RENDER_FOR_3D_PRINTER)
    translate([0,0,SHAFT_MOUNT_ATTACH ? 0 : -10])
    _mountingScrews( rotor_mounting_holes_radius, rotor_mounting_hole_radius, rotor_thickness_mm, shaftmountcollar_numholes );
}

module magnets() {
  if (!MAGNET_USE_RECTS) {
    color("SlateGray")
    union() {
      for (i = [0:magnets_number]) {
        rotate(i * 360/magnets_number,0,0)
        translate([magnets_radius,0,-magnets_thickness/2 - rotor_thickness_mm/2])
        cylinder(magnets_thickness,magnet_radius,magnet_radius);
      }
    }
  } else  {
    color("SlateGray")
    union() {
      for (i = [0:magnets_number]) {
        rotate(i * 360/magnets_number,0,0)
        translate([magnets_radius,0,-rotor_thickness_mm/2 ])
        cube([magnets_height,magnets_width,magnets_thickness], true);
      }
    }
  }
}


module rotorDisc() {
  color( "darkgrey" )
  translate( [0,0,0] )
  difference() {
    disc( "darkgrey", rotor_thickness_mm, rotor_outer_radius_mm, rotor_inner_radius_mm );
    
    union() {
      scale([1,1,0.999]) magnets();
      mountingHoles( rotor_mounting_holes_radius, rotor_mounting_hole_radius, rotor_thickness_mm, 0.1 );
    }
  }
}

module rotorFixture() {
  color( "lightblue" )
  translate( [0,0,0] )
  difference() {
    disc( "purple", rotor_thickness_mm, rotor_outer_radius_mm, rotor_inner_radius_mm );
    
    translate([0,0,-magnets_thickness/2]) magnets();
  }
}

module statorDisc() {
  color( "red" )
  translate( [0,0,0] )
  difference() {
    disc( "red", stator_thickness_mm, stator_outer_radius_mm, stator_inner_radius_mm );
    
    // cut stator in half
    if (STATOR_HALVES) color( "red" ) translate([0,0, 0]) cube([1,999,999], true);
  }
}

module statorMold() {
  color("lightblue")
  difference() {
    translate([0,0,-stator_thickness_mm]) cylinder(stator_thickness_mm+4,stator_outer_radius_mm+4,stator_outer_radius_mm+4);
    scale([1,1,1.01]) statorDisc();
  }
}

module axle( length ) {
  color("darkgrey")
  translate([0,0,-length/2])
  cylinder( length, axle_radius, axle_radius );
}

module explodedRotor() {
  translate([0, 0, SHAFT_MOUNT_ATTACH?0:DISTANCE_APART_3D*0.5]) shaftMountCollar();

  translate([0, 0, 0]) rotorDisc();
  if (SHOW_MAGNETS) translate([0, 0, 0]) magnets();

  translate([0, 0, SHAFT_MOUNT_ATTACH?0:-DISTANCE_APART_3D*0.05]) mountingScrews();
}

if (RENDER_FOR_SHEET_MATERIALS) {
  translate([rotor_outer_radius_mm*2.1, 0]) projection(cut=false) statorDisc();
  translate([0, 0]) projection(cut=false) rotorDisc();
  translate([-rotor_outer_radius_mm*2.1, 0]) projection(cut=false) ironDisc();
}
if (RENDER_FOR_3D_PRINTER) {
  translate([0, 0]) rotate([0,180,0]) shaftMountCollar();
  translate([-rotor_outer_radius_mm*2.1, 0]) rotate([0,180,0]) statorMold();
  translate([rotor_outer_radius_mm*2.1, 0]) rotate([0,180,0]) rotorFixture();
} else {
  rotate([0,90,0]) {
    translate([0, 0, 0]) axle( DISTANCE_APART_3D*5 );
    translate([0, 0, DISTANCE_APART_3D*6]) rotorFixture();
    translate([0, 0, DISTANCE_APART_3D*4]) statorMold();
    
    translate([0, 0, DISTANCE_APART_3D*2]) ironDisc();
    translate([0, 0, DISTANCE_APART_3D*1]) explodedRotor();    
    translate([0, 0, 0]) statorDisc();
    translate([0, 0, -DISTANCE_APART_3D*1]) explodedRotor();      
    translate([0, 0, -DISTANCE_APART_3D*2]) ironDisc();
  }
}
