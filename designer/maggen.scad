//////////////////////////////////////////////////////
// maggen / axial flux generator / 3D designer
// (c) 2018-Present kevin meinert
//////////////////////////////////////////////////////
// red:      stator w/ coils
// darkgrey: iron
// grey:     rotor w/magnets
// yellow:   rotor mount w/ shaft coupler
// orange:   coils / coil-bobbin
// units:    mm
// _ means it's a calculated value:  do not edit

// export CAD files:
RENDER_FOR_SHEET_MATERIALS = false;  // set true, render/f6, then export SVG file.
RENDER_FOR_3D_PRINTER = false;       // set true, render/f6, then export STL file

// DISPLAY settings
SHAFT_MOUNT_ATTACH = false; // true: attach shaftmount to rotor in exploded 3D view, false: explode
SHOW_MAGNETS = true;      // show magnets in exploded 3D view
SHOW_SCREWS = true;       // show screws in exploded 3D view
_SHOW_MAGNETS = RENDER_FOR_SHEET_MATERIALS || RENDER_FOR_3D_PRINTER ? false : SHOW_MAGNETS;
_SHOW_SCREWS = RENDER_FOR_SHEET_MATERIALS || RENDER_FOR_3D_PRINTER ? false : SHOW_SCREWS;

// config:
DISTANCE_APART_3D = 30; // how far apart to display each disc in the 3D scene
EMBED_SHAFT_MOUNT = true; // true: embed shaftmount hub inside rotor, or false: external mount
SHAFT_MOUNT_POSTS = true; // true: use raised screw posts when embedded, false: flat flange
_SHAFT_MOUNT_POSTS = !EMBED_SHAFT_MOUNT ? false : SHAFT_MOUNT_POSTS; // true: raised screw posts, or false: flat flange
SCREW_HOLE_RADIUS_MM=1.25; // size of screw holes with threads
SCREW_WASHERHOLE_RADIUS_MM=1.5; // size of screw holes without threads
SCREW_HEAD_RADIUS_MM=2.2;  // size of screw head
SCREW_NUT_RADIUS_MM=2.2;  // size of nut
SHAFT_MOUNT_SCREW_CENTER=false; // center the shaft mount collar set screw (true), or set it flush with the flange (false)
MAGNET_USE_RECTS=true; // true: use rectangles for magnets, false: use circles
STATOR_HALVES=true; // false: stator as one unweildy disc (must be threaded onto the axel), true: drop-in-able halves
TOL=0.2;            // general tolerance of cuts.  laser kerf is ~0.2mm (0.008in)
$fn=40;             // polygonal resolution of circles
overall_radius=30;   // radius of all discs:  stator, iron, rotor
axle_radius = 2.5;   // radius of the axle
magnets_number = 8; // how many magnets on the rotor
magnets_radius=20;   // how far out to place all the magnets (radius to magnet's centerpoint)
magnets_width=7;     // width of each rectangle magnet
magnets_height=12;   // height of each rectangle magnet
magnet_radius=5;     // radius for each circle magnet
magnets_thickness=5; // thickness of each magnet 
iron_outer_radius_mm = overall_radius;
iron_inner_radius_mm = 15;
iron_thickness_mm = 3;
rotor_outer_radius_mm = overall_radius;
rotor_thickness_mm = 3;
rotor_mounting_holes_radius = 10;
rotor_mounting_hole_radius_when_sm_raised = 1.7;
rotor_mounting_hole_radius = _SHAFT_MOUNT_POSTS ? rotor_mounting_hole_radius_when_sm_raised : SCREW_HOLE_RADIUS_MM;
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
shaftmountcollar_mounting_hole_outer_radius = _SHAFT_MOUNT_POSTS ? shaftmountcollar_mounting_hole_outer_radius_when_raised : shaftmountcollar_mounting_hole_outer_radius_when_not_raised; 
shaftmountcollar_mounting_hole_thickness = rotor_thickness_mm - 0.1; 
shaftmountcollar_outer_radius_mm = rotor_mounting_holes_radius + rotor_mounting_hole_radius + (_SHAFT_MOUNT_POSTS ? 0 : SCREW_HEAD_RADIUS_MM);
rotor_inner_radius_mm = EMBED_SHAFT_MOUNT ? shaftmountcollar_middl_radius_mm+TOL : axle_radius + TOL;
stator_outer_radius_mm = overall_radius;
stator_inner_radius_mm = shaftmountcollar_outer_radius_mm;
stator_thickness_mm = 3;

// coils:
coils_number = 8;                     // number of coils
coils_outside_radius=30;              // stator disc radius for outermost coils
coils_inside_radius=13;               // stator disc radius for innermost coils
coil_spacing=0.6;                     // space between each coil
coil_thickness=4;                     // coil thickness (depth of wire wrapped on the bobbin)
coil_thickness2=stator_thickness_mm;  // coil thickness (width of wire on bobbin, should be <= stator_thickness_mm)
bobbin_axle_type = true;              // true: square, false: round
//bobbin_axle_radius = 6.35/2;        // radius (or 1/2 width) of bobbin axle
bobbin_axle_radius = 4.762/2;         // radius (or 1/2 width) of bobbin axle
bobbin_axle_offset = 1.5;            // you can manually center the axle in the bobbin... not automatic yet, sorry
bobbin_wall_thickness=0.5;            // thickness of the bobbin plastic walls
bobbin_display_apart=7;               // in preview, how far apart to show bobbin halves

////////////////////////////////////////////////////////////////////////////

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
  if (_SHOW_SCREWS && !RENDER_FOR_SHEET_MATERIALS && !RENDER_FOR_3D_PRINTER)
    translate([0,0,SHAFT_MOUNT_ATTACH ? 0 : -10])
    _mountingScrews( rotor_mounting_holes_radius, rotor_mounting_hole_radius, rotor_thickness_mm, shaftmountcollar_numholes );
}

module magnets() {
  if (!MAGNET_USE_RECTS) {
    color("SlateGray")
    union() {
      for (i = [0:magnets_number-1]) {
        rotate(i * 360/magnets_number,0,0)
        translate([magnets_radius,0,-magnets_thickness/2 - rotor_thickness_mm/2])
        cylinder(magnets_thickness,magnet_radius,magnet_radius);
      }
    }
  } else  {
    color("SlateGray")
    union() {
      for (i = [0:magnets_number-1]) {
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

module statorCoils() {
  if (_SHOW_MAGNETS) translate([0, 0, 0]) coils();
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

module bobbin_axle( length, tol=0 ) {
  color("darkgrey")
  if (bobbin_axle_type)
    cube( [bobbin_axle_radius*2+tol*2, bobbin_axle_radius*2+tol*2, length], true );
  else
    translate([0,0,-length/2])
    cylinder( length, bobbin_axle_radius+tol, bobbin_axle_radius+tol );
}


// given an x,y offset, a radius and an angle (rad)
// return the computed x,y point
function radialToCartesian( pos,radius,angle_deg ) = [
  pos[0] + radius * cos( angle_deg ),
  pos[1] + radius * sin( angle_deg )
];
// create a vector from a scalar (number)
function vec( n, n2="undefined" ) = [n, n2 == "undefined" ? n : n2];
// square the number
function sqr( n ) = n*n;
// return the magnitude of the vector
function mag( v ) = sqrt( sqr( v[0] ) + sqr( v[1] ) );
// reverse (invert) the direction of the vector
function inv( v ) = [-v[0], -v[1]];
// return the distance from p0 to p1
function dist( p0, p1 ) = mag( sub( p0, p1 ) );
// perpendicular vector (rotated 90 deg)
function perp( v ) = [
  v[0] * cos(-90) - v[1] * sin(-90),
  v[0] * sin(-90) + v[1] * cos(-90)
];
// return the unnormalized vector from p1 to p0
function sub( p0, p1 ) = [p0[0] - p1[0], p0[1] - p1[1]];
// add p1 to p0
function add( p0, p1 ) = [p0[0] + p1[0], p0[1] + p1[1]];
// multiply p1 & p0
function mul( p0, p1 ) = [p0[0] * p1[0], p0[1] * p1[1]];
// normalize the vector
function normalize( v ) = [v[0]/mag( v ), v[1]/mag( v )];
// return the normalized direction vector for the two points.
function dir( p0, p1 ) = normalize( sub( p0, p1 ) );

module makeLoop( ox, oy, x, pos, rot, num_magnets, mag_in_radius, mag_out_radius, coilt ) {
  arc_len_deg = 360/num_magnets;
  // generate some arc stats for this iteration
  s = rot + x * arc_len_deg;
  s1d = arc_len_deg;
  s1 = s+s1d;
  // 1 2
  // 0 3
  inner_end_prev  = radialToCartesian( pos, mag_in_radius, s );
  outer_start     = radialToCartesian( pos, mag_out_radius, s );
  outer_mid       = radialToCartesian( pos, mag_out_radius, (s+s1)/2 );
  outer_end       = radialToCartesian( pos, mag_out_radius, s1 );
  inner_start     = radialToCartesian( pos, mag_in_radius, s1 );
  inner_mid       = radialToCartesian( pos, mag_in_radius, (s+s1)/2 );
  up  = mul( dir( outer_mid, inner_mid ), vec( coilt ) );
  up1 = mul( dir( outer_start, inner_end_prev ), vec( coilt ) );
  up2 = mul( dir( outer_end, inner_start ), vec( coilt ) );
  dn  = inv( up );
  dn1 = inv( up1 );
  dn2 = inv( up2 );
  lt = mul( dir( outer_start, outer_end ), vec( coilt ) );
  rt = mul( dir( outer_end, outer_start ), vec( coilt ) );
  p0 = add( add( add( inner_end_prev, up1 ), rt ), vec(ox,oy) );
  p1 = add( add( add( outer_start, dn1 ),    rt ), vec(ox,oy) );
  p2 = add( add( outer_mid, dn ), vec(ox,oy) );
  p3 = add( add( add( outer_end, dn2 ),      lt ), vec(ox,oy) );
  p4 = add( add( add( inner_start, up2 ),    lt ), vec(ox,oy) );
  polygon(points=[p0,p1,p3,p4]);
}
module makeLoops( pos, rot, num_magnets, mag_in_dia, mag_out_dia, coilt ) {
  rotate([0,0,90])
   for (x = [0:num_magnets-1]) {
     makeLoop( 0,0, x, pos, rot, num_magnets, mag_in_dia, mag_out_dia, coilt );
   }
}


module coil() {
  color("DarkOrange")
  difference() {
    linear_extrude(height = coil_thickness2, center = true, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
    makeLoop( 0,0, 0, [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_spacing );
    linear_extrude(height = coil_thickness2+1, center = true, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
    makeLoop( 0,0, 0, [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_thickness+coil_spacing );
  }
}
module coils() {
  translate([0,0,-coil_thickness2/2])
  scale([1,1,1.01])
  color("DarkOrange")
  difference() {
    linear_extrude(height = coil_thickness2, center = true, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
    makeLoops( [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_spacing );

    //translate([0,0,-0.5])
    linear_extrude(height = coil_thickness2+1, center = true, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
    makeLoops( [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_thickness+coil_spacing );
  }
}


module bobbin1() {
  arc_len_deg = 360/coils_number;
  
  color("DarkOrange")
  translate([0,0,0])
  difference() {
    translate([-(coils_inside_radius + (coils_outside_radius-coils_inside_radius) / 2) + bobbin_axle_offset,0,0])
    rotate([0,0,-arc_len_deg/2])
    difference() {
      union() {
        // plate
        linear_extrude(height = bobbin_wall_thickness, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
        makeLoop( 0,0, 0, [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_spacing );

        // inside
        linear_extrude(height = bobbin_wall_thickness + coil_thickness2, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
        makeLoop( 0,0, 0, [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_thickness+coil_spacing );
      }
      
      // remove
      union() {
        translate([0,0,bobbin_wall_thickness])
        linear_extrude(height = coil_thickness2 + TOL, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
        makeLoop( 0,0, 0, [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_thickness+coil_spacing+bobbin_wall_thickness );
      }
    }
    
    bobbin_axle( 1000, TOL );
  }
}
module bobbin2() {
  arc_len_deg = 360/coils_number;
  
  color("DarkOrange")
  translate([0,0,0])
  //scale([1,1,-1])
  difference() {
    translate([-(coils_inside_radius + (coils_outside_radius-coils_inside_radius) / 2) + bobbin_axle_offset,0,0])
    rotate([0,0,-arc_len_deg/2])
    difference() {
      union() {
        // plate
        linear_extrude(height = bobbin_wall_thickness, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
        makeLoop( 0,0, 0, [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_spacing );

        // inside
        linear_extrude(height = bobbin_wall_thickness + coil_thickness2, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
        makeLoop( 0,0, 0, [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_thickness+coil_spacing+bobbin_wall_thickness );
      }
      
      // remove
      union() {
        translate([0,0,bobbin_wall_thickness])
        linear_extrude(height = coil_thickness2 + TOL, center = false, convexity = 10, twist = 0, slices = 1, scale = 1.0) 
        makeLoop( 0,0, 0, [0,0], 0, coils_number, coils_inside_radius, coils_outside_radius, coil_thickness+coil_spacing+bobbin_wall_thickness*2 );
      }
    }
    
    bobbin_axle( 1000, TOL );
  }
}

module explodedRotor() {
  translate([0, 0, SHAFT_MOUNT_ATTACH ? 0 : (_SHAFT_MOUNT_POSTS || EMBED_SHAFT_MOUNT) ? DISTANCE_APART_3D*0.5 : -DISTANCE_APART_3D*0.2]) shaftMountCollar();

  translate([0, 0, 0]) rotorDisc();
  if (_SHOW_MAGNETS) translate([0, 0, 0]) magnets();

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
  translate([rotor_outer_radius_mm*3.5, 0]) rotate([0,0,0]) bobbin1();
  translate([rotor_outer_radius_mm*4.5, 0]) rotate([0,0,0]) bobbin2();
} else {
  rotate([0,90,0]) {
    translate([0, 0, 0]) axle( DISTANCE_APART_3D*5 );
    translate([0, 0, DISTANCE_APART_3D*6]) rotorFixture();
    translate([0, 0, DISTANCE_APART_3D*4]) statorMold();
    
    translate([0, 0, DISTANCE_APART_3D*2]) ironDisc();
    translate([0, 0, DISTANCE_APART_3D*1]) explodedRotor();    
    translate([0, 0, 0]) statorDisc();
    translate([0, 0, 0]) statorCoils();
    translate([0, 0, -DISTANCE_APART_3D*1]) explodedRotor();      
    translate([0, 0, -DISTANCE_APART_3D*2]) ironDisc();
    
    translate([0, 80, 0]) bobbin_axle( DISTANCE_APART_3D*5 );
    translate([0, 80, 0]) bobbin1();
    translate([0, 80, bobbin_display_apart + (bobbin_wall_thickness*2 + coil_thickness2)]) scale([1,1,-1]) bobbin2();
  }
}
