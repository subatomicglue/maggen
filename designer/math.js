//////////////////////////////////////
// math and vector math  {x: 0, y: 0}
//////////////////////////////////////

// given an x,y offset, a radius and an angle (rad)
// return the computed x,y point
function radialToCartesian( x,y,radius,angle_rad ) {
   return {
      x: x + radius * Math.cos( angle_rad ),
      y: y + radius * Math.sin( angle_rad )
   };
}
// create a vector from a scalar (number)
function vec( n, n2=n ) { return {x: n, y: n2}; }
// square the number
function sqr( n ) { return n*n; }
// return the magnitude of the vector
function mag( v ) {
   return Math.sqrt( sqr( v.x ) + sqr( v.y ) );
}
// reverse (invert) the direction of the vector
function inv( v ) {
   return {x: -v.x, y: -v.y};
}
// return the distance from p0 to p1
function dist( p0, p1 ) {
   return mag( sub( p0, p1 ) );
}
// perpendicular vector (rotated 90 deg)
function perp( v ) {
   let theta = -90 * Math.PI / 180;
   let cs = Math.cos(theta);
   let sn = Math.sin(theta);
   return {
      x: v.x * cs - v.y * sn,
      y: v.x * sn + v.y * cs,
   }
}
// return the unnormalized vector from p1 to p0
function sub( p0, p1 ) {
   return {x: p0.x - p1.x, y: p0.y - p1.y};
}
// add p1 to p0
function add( p0, p1 ) {
   return {x: p0.x + p1.x, y: p0.y + p1.y};
}
// multiply p1 & p0
function mul( p0, p1 ) {
   return {x: p0.x * p1.x, y: p0.y * p1.y};
}
// normalize the vector
function norm( v ) {
   let d = mag( v );
   return {x: v.x/d, y: v.y/d};
}
// return the normalized direction vector for the two points.
function dir( p0, p1 ) {
   return norm( sub( p0, p1 ) );
}
// http://paulbourke.net/geometry/pointlineplane/
function line_intersect(v1, v2, v3, v4) {
   let denom = (v4.y - v3.y)*(v2.x - v1.x) - (v4.x - v3.x)*(v2.y - v1.y);
   if (denom == 0) {
      return null; // parallel lines;
   }
   let ua = ((v4.x - v3.x)*(v1.y - v3.y) - (v4.y - v3.y)*(v1.x - v3.x))/denom;
   let ub = ((v2.x - v1.x)*(v1.y - v3.y) - (v2.y - v1.y)*(v1.x - v3.x))/denom;
   return {
      x: v1.x + ua * (v2.x - v1.x),
      y: v1.y + ua * (v2.y - v1.y),
      seg1: ua >= 0 && ua <= 1, // if both are true, then line SEGMENTS intersect, 
      seg2: ub >= 0 && ub <= 1  // if either are false, then lines intersect
   };
}

