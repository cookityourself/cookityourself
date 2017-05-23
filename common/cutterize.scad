// With a lot of thanks to Cube Hero !!!
// https://cubehero.com/2013/12/31/creating-cookie-cutters-using-offsets-in-openscad/

module cutterize (thickness = 1) {
  difference() {
    render() {
      minkowski() {
        children();
        cube([2 * thickness, 2 * thickness, 2 * thickness], center=true);
      }
    }
    translate([0, 0, -5 * thickness]) scale([1, 1, 100])
      children();
  }
}