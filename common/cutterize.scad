// With a lot of thanks to Cube Hero !!! He saved my day.
// https://cubehero.com/2013/12/31/creating-cookie-cutters-using-offsets-in-openscad/

module cutterize_offset (thickness = 1) {
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

module cutterize_offset_round (thickness = 1) {
  difference() {
    render() {
      minkowski() {
        children();
        cylinder(d=2*thickness, h=2*thickness, center=true);
      }
    }
    translate([0, 0, -5*thickness]) scale([1, 1, 100])
      children();
  }
}

module inset_shell(thickness = 0.5, bbox = [5000, 5000, 5000]) {
  module invert(bbox = [5000, 5000, 5000]) {
    difference() {
      cube(bbox, true);
      children();
    }        
  }

  module inset(thickness = 0.5, bbox = [5000, 5000, 5000]) {
    render() {
      invert(0.9 * bbox)
        minkowski() {
          invert() children();
          cube([2 * thickness, 2 * thickness, 2 * thickness], center=true);
        }
    }
  }

  render() {
    difference() {
      children();
      translate([0, 0, -5 * thickness]) scale([1, 1, 100]) translate([0, 0, -2 * thickness])
        inset(thickness, bbox)
          children();
    }
  }
}

module inset_shell_round(thickness = 0.5, bbox = [5000, 5000, 5000]) {
  module invert(bbox = [5000, 5000, 5000]) {
    difference() {
      cube(bbox, true);
      children();
    }        
  }

  module inset(thickness = 0.5, bbox = [5000, 5000, 5000]) {
    render() {
      invert(0.9 * bbox)
        minkowski() {
          invert() children();
          cylinder(d=2*thickness, h=2*thickness, center=true);
        }
    }
  }

  render() {
    difference() {
      children();
      translate([0, 0, -5 * thickness]) scale([1, 1, 100]) translate([0, 0, -2 * thickness])
        inset(thickness, bbox)
          children();
    }
  }
}
