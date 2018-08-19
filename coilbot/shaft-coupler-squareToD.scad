
//include <support.scad>; 

tol=0.8; // general tolerance.   0.2 per side (squish), and extra .4

nut_thickness = 2;
nut_width = 5.25;
nut_cavity_clearance = tol;

m3_screw_dia_threads = 2.82;
m3_screw_dia_clearancehole = m3_screw_dia_threads+tol;

cyl_height = 30;
body_radius = 13;

thumb_screw_depth_below_surface = 5; // depth under the top of cyl
thumb_screw_flat_depth = 1; // flat spot for screw heads

// 7.46
endmill_dia = 6.35; // 0.25in
endmill_clearance = tol-0.1;

m3_screw_depth = 16;
m3_screw_depth2 = 10;
m3_nut_depth = 6.5;

wire_chan_thickness = 3;
wire_chan_offset = 5.35;
wire_chan_vert_rot = 30;

wire_hole_length = 60;

cyl_res = 360;

$fn=cyl_res;

difference() {
  // body
  translate([0,0,-cyl_height*0.5]) cylinder( cyl_height, body_radius, body_radius );
  
  // subtract stuff
  union() {
    // hole for endmill
    translate([0,0,-.5-cyl_height*0.5]) cylinder( cyl_height+1, endmill_dia*0.5 + endmill_clearance*0.5, endmill_dia*0.5 + endmill_clearance*0.5, $fn=cyl_res );

    // endmill set-screw
    rotate([0,0,0])
    {
      // m3 thumbscrew hole
      translate([0,0,cyl_height*0.5 - thumb_screw_depth_below_surface]) 
      rotate([90,0,0]) cylinder( 17, m3_screw_dia_clearancehole*0.5, m3_screw_dia_clearancehole*0.5, $fn=cyl_res );
      
      
      // m3 nut hole
      translate([0,-m3_nut_depth,cyl_height*0.5 - thumb_screw_depth_below_surface])
      rotate([90,0,0]) 
      translate([0 - (nut_width+nut_cavity_clearance)*0.5,
                 0 - (nut_width+nut_cavity_clearance)*0.5,
                 0 - (nut_thickness+nut_cavity_clearance)*0.5])
      color([0.6,0.6,0])
      cube([nut_width+nut_cavity_clearance,
            10+nut_width+nut_cavity_clearance,
            nut_thickness+nut_cavity_clearance]);
    }

    // touchplate set-screw
    translate([0,0,1]) 
    rotate([0,180,0])
    {
      // m3 screw hole
      translate([0,0,cyl_height*0.5 - 5]) 
      rotate([90,0,0]) cylinder( 17, m3_screw_dia_clearancehole*0.5, m3_screw_dia_clearancehole*0.5, $fn=cyl_res );

      // m3 nut hole
      translate([0,-m3_nut_depth,cyl_height*0.5 - 5])
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
    translate([10,-body_radius + thumb_screw_flat_depth,-cyl_height*0.5 - 0.5])
      color([0.6,0.6,0])
      rotate([0,0,180])
      cube([20,4,cyl_height+1]);
    

    // bottom wire channel
    scale([-1,1,1]) {
      translate([-(wire_chan_offset + wire_chan_thickness + nut_width*0.5 + nut_cavity_clearance*0.5), -body_radius, -cyl_height*0.5 - 0.5])
        color([1.0,0.6,0])
        cube([wire_chan_thickness,body_radius-m3_nut_depth + nut_thickness*0.5,3+1]);

      translate([-(wire_chan_offset+wire_chan_thickness + nut_width*0.5 + nut_cavity_clearance*0.5),
                 -(m3_nut_depth + wire_chan_thickness*0.5),
                 -cyl_height*0.5 - 0.5])
        color([1.0,0.6,0])
        cube([wire_chan_offset + wire_chan_thickness, wire_chan_thickness,3+1]);
    }
    
    // top wire channel
    scale([-1,1,-1]) {
      translate([-(wire_chan_offset + wire_chan_thickness + nut_width*0.5 + nut_cavity_clearance*0.5), -body_radius, -cyl_height*0.5 - 0.5])
        color([1.0,0.6,0])
        cube([wire_chan_thickness,body_radius-m3_nut_depth + nut_thickness*0.5,3+1]);

      translate([-(wire_chan_offset+wire_chan_thickness + nut_width*0.5 + nut_cavity_clearance*0.5),
                 -(m3_nut_depth + wire_chan_thickness*0.5),
                 -cyl_height*0.5 - 0.5])
        color([1.0,0.6,0])
        cube([wire_chan_offset + wire_chan_thickness, wire_chan_thickness,3+1]);
    }

    // hole for wires
    translate([wire_chan_offset + wire_chan_thickness*0.5 + nut_width*0.5,wire_hole_length*0.5,0])
    rotate([90,0,0])
    color([0,1,0])
    //cylinder( wire_hole_length, 3, 3, $fn=cyl_res );
    translate([-3.5*0.5, -6*0.5, 0])
    cube( [3.5, 6, wire_hole_length] );

    // vertical wire channel
    rotate([0,0,-wire_chan_vert_rot])
        translate([0,-wire_chan_thickness*0.5,-cyl_height*0.5 -0.5])
        translate([body_radius-wire_chan_thickness,0,0])
        rotate([0,0,wire_chan_vert_rot])
        color([1.0,0.6,0])
        rotate([0,0,-90])
        cube([wire_chan_thickness*2, wire_chan_thickness+ nut_cavity_clearance*0.5,cyl_height+1]);
  }
}


/*
// endmill set-screw
rotate([0,0,0])
{
  // m3 thumbscrew hole
  translate([0,0.5,cyl_height*0.5 - thumb_screw_depth_below_surface]) 
  rotate([90,0,0]) color([1,0,0]) cylinder( m3_screw_depth, m3_screw_dia_threads*0.5, m3_screw_dia_threads*0.5, $fn=cyl_res );
}




// touchplate set-screw
translate([0,0,1]) 
rotate([0,180,0])
{
  // m3 screw hole
  translate([0,-m3_nut_depth + nut_width*0.5,cyl_height*0.5 - 5]) 
  rotate([90,0,0]) color([1,0,0]) cylinder( m3_screw_depth2, m3_screw_dia_threads*0.5, m3_screw_dia_threads*0.5, $fn=cyl_res );
}
*/