
//////////////////////////////////////
// SVG generators
//////////////////////////////////////
// clear out the svg
function clearSvg( svg ) {
   while (svg.lastChild) {
      svg.removeChild(svg.lastChild);
   }
}
// convert [[{x:0,y:0},..,{x:0,y:0}],[{x:0,y:0},..,..]] to <path d=''> data
function arrayOfVecArraysToSvgPathData( paths ) {
   return paths.map( p => vecArrayToSvgPathData( p ) ).join(' ');
}
// convert [{x:0,y:0},..,{x:0,y:0}] to <path d=''> data
function vecArrayToSvgPathData( path ) {
   return makePath( path.map( r => { return `${r.x},${r.y}` } ) );
}
// append a <path id='id'> to the <svg>
function newPath( svg, id ) {
   let path = document.createElementNS('http://www.w3.org/2000/svg',"path");
   path.id = id;
   //path.setAttribute( 'id', id );
   path.setAttribute( 'd', '' );
   svg.appendChild( path );
   return path;
}
// generate the 'd' attribute for a <path> from an array of points in `${x},${y}` (or 'x,y' or "x,y") string format.
function makePath( path ) {
   path[0] = "M" + path[0]; // warning, modifies array
   path[1] = "L" + path[1];
   path.push("Z");
   return path.join(' ');
}
// setup the <svg><path> from a given color [c] and 'd' attribute [path].  (see makePath, circlePath, arcPath, rectPath)
function setPath( svgpath, c, pathdata, strokewidth=0.2 ) {
   //console.error( path );
   svgpath.setAttribute('d',pathdata);
   svgpath.setAttribute('stroke', c);
   svgpath.setAttribute('stroke-width', strokewidth);
   svgpath.setAttribute('fill','none');
}
function addPath( svgpath, c, pathdata, strokewidth=0.2 ) {
   svgpath.setAttribute('d', svgpath.getAttribute('d') + pathdata);
   svgpath.setAttribute('stroke', c);
   svgpath.setAttribute('stroke-width', strokewidth);
   svgpath.setAttribute('fill','none');
}
function onAnimate() {
   console.log( svgmagpath.getAttribute('class') );
   if (svgmagpath.getAttribute('class') == 'rot') {
      svgmagpath.setAttribute('class', '');
      svgmagpath2.setAttribute('class', '');
   } else {
      svgmagpath.setAttribute('class', 'rot');
      svgmagpath2.setAttribute('class', 'rot');
   }
}
function clearPath( svgpath ) {
   svgpath.setAttribute('d','');
}
// generate the 'd' attribute for a <svg><path> in the shape of an arc.  Use (0, 2*Math.PI) for circle.
function arcPath( x, y, r, start, stop ) {
   let path = [];
   for (let s=start; s <= stop; s += 2*Math.PI/30) { // resolution of 30
      let xy = radialToCartesian( x,y,r,s );
      path.push(`${xy.x},${xy.y}`);
   }
   return makePath( path );
}
// generate the 'd' attribute for a <svg><path> in the shape of a circle.
function circlePath( x, y, radius ) {
   return arcPath( x, y, radius, 0, 2*Math.PI )
}
// rotate a point x,y by a (rad), then offset by ox,oy
function rotPoint(ox,oy,x,y,a) {
   return { x: ox + x*Math.cos(a) - y*Math.sin(a),   y: oy + x*Math.sin(a) + y*Math.cos(a) };
}
// generate the 'd' attribute for a <svg><path> in the shaped of a rectangle.
// use a (rad) to rotate the rectangle.  x,y is the center point.  w,h is the size.
function rectPath( x,y,w,h, a ) {
   let path = [];
   let p0 = rotPoint( x,y,-w/2, -h/2, a );
   let p1 = rotPoint( x,y,+w/2, -h/2, a );
   let p2 = rotPoint( x,y,+w/2, +h/2, a );
   let p3 = rotPoint( x,y,-w/2, +h/2, a );
   path.push(`${p0.x},${p0.y}`);
   path.push(`${p1.x},${p1.y}`);
   path.push(`${p2.x},${p2.y}`);
   path.push(`${p3.x},${p3.y}`);
   return makePath(path);
}
function createSVGDownload(svg, ahref) {
   // first create a clone of our svg node so we don't mess the original one
   var clone = svg.cloneNode(true);
   // parse the styles
   //parseStyles(clone);

   // create a doctype
   var svgDocType = document.implementation.createDocumentType('svg', "-//W3C//DTD SVG 1.1//EN", "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd");
   // a fresh svg document
   var svgDoc = document.implementation.createDocument('http://www.w3.org/2000/svg', 'svg', svgDocType);
   // replace the documentElement with our clone 
   svgDoc.replaceChild(clone, svgDoc.documentElement);
   // get the data
   var svgData = (new XMLSerializer()).serializeToString(svgDoc);

   // now you've got your svg data, the following will depend on how you want to download it
   // e.g yo could make a Blob of it for FileSaver.js
   /*
   var blob = new Blob([svgData.replace(/></g, '>\n\r<')]);
   saveAs(blob, 'myAwesomeSVG.svg');
   */
   // here I'll just make a simple a with download attribute

   ahref.href = 'data:image/svg+xml; charset=utf8, ' + encodeURIComponent(svgData.replace(/></g, '>\n\r<'));
   ahref.download = 'file.svg';
   //ahref.innerHTML = 'download the svg file';
};


