// With a lot of thanks to Cube Hero !!! He saved my day.
// https://cubehero.com/2013/12/31/creating-cookie-cutters-using-offsets-in-openscad/

translate ([-20,2,0])square(40);
color("white") offset(r = -10) translate ([-80,-80,0]) square(40);
color("blue") fillet(10) translate ([-40,-40,0]) square(40);
color("red") chamfer(10) translate ([0,-40,0]) square(40);

color("green") cutterize_2d_fillet(2) 
  translate ([-62,2,0]) square(40);
color("green") cutterize_2d_chamfer(2) 
  translate ([22,2,0]) square(40);
  
color("purple") cutterize_3d_fillet(2, 20) 
  translate ([-62,46,0]) square(40);
color("purple") cutterize_3d_chamfer(2, 20) 
  translate ([22,46,0]) square(40);
  
color("pink") cutterize_3d_offset (thickness = 1)  
  translate ([-20,90,0]) square(40);
  
module fillet(r) {
   offset(r = r) {
     offset(r = -r) {
       children();
     }
   }
 }

module chamfer(r) {
   offset(delta = r, chamfer = true) {
     offset(r = -r) {
       children();
     }
   }
 }

module cutterize_2d_fillet (thickness = 1) {
  difference () {
    offset(r = thickness) fillet(thickness) children();
    fillet(thickness) children();
  }
} 

module cutterize_2d_chamfer (thickness = 1) {
  difference () {
    offset(delta = thickness, chamfer = true) chamfer(thickness) children();
    chamfer(thickness) children();
  }
} 

module cutterize_2d_offset (thickness = 1) {
  difference () {
    offset(delta = thickness, chamfer = false) chamfer(thickness) children();
    chamfer(thickness) children();
  }
} 

module cutterize_3d_fillet (thickness = 1, height = 10) {
  linear_extrude(height) cutterize_2d_fillet(thickness) children();
} 

module cutterize_3d_chamfer (thickness = 1, height = 10) {
  linear_extrude(height) cutterize_2d_chamfer(thickness) children();
} 

module cutterize_3d_offset (thickness = 1, height = 10) {
  linear_extrude(height) cutterize_2d_offset(thickness) children();
} 

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

module cutterize_2d_offset_min (thickness = 1) {
  difference() {
    render() {
      minkowski() {
        children();
        square([2 * thickness, 2 * thickness, 2 * thickness], center=true);
      }
    }
    translate([0, 0, -5 * thickness]) scale([1, 1, 100])
      children();
  }
}

module cutterize_3d_offset_min (thickness = 1, height = 10) {
  difference() {
    render() {
      minkowski() {
        linear_extrude(height) children();
        cube([2 * thickness, 2 * thickness, 2 * thickness], center=true);
      }
    }
    translate([0, 0, -5 * thickness]) scale([1, 1, 100])
      linear_extrude(height) children();
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
