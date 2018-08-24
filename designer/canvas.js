
function clear(c="grey") {
  //var c = document.getElementById("myCanvas");
  var ctx = turbine.getContext("2d");
  ctx.save();
  ctx.beginPath();
  ctx.rect(0, 0, turbine.width, turbine.height);
  ctx.strokeStyle = c;
  ctx.fillStyle = c;
  ctx.fill();
  ctx.restore();
}
function arc( c, x,y, radius, start, end, ccw=false ) {
  var ctx = turbine.getContext("2d");
  ctx.save();
  ctx.beginPath();
  ctx.arc(x, y, radius, start, end, ccw);
  ctx.strokeStyle=c;
  ctx.stroke();
  ctx.restore();
}
function circle( c, x,y, radius ) {
  var ctx = turbine.getContext("2d");
  ctx.save();
  ctx.beginPath();
  ctx.arc(x, y, radius, 0, 2*Math.PI, false);
  ctx.strokeStyle=c;
  ctx.stroke();
  ctx.restore();
}
function rect( c, x,y,w,h, a ) {
  var ctx = turbine.getContext("2d");
  ctx.save();
  ctx.strokeStyle = c;
  ctx.translate(x,y);
  ctx.rotate(a);
  ctx.strokeRect(-w*0.5,-h*0.5,w,h);
  ctx.restore();
}
function line( c, x, y, x2, y2 ) {
  var ctx = turbine.getContext("2d");
  ctx.save();
  ctx.strokeStyle=c;
  ctx.beginPath();
  ctx.moveTo( x, y );
  ctx.lineTo( x2, y2 );
  ctx.stroke();
  ctx.restore();
}


