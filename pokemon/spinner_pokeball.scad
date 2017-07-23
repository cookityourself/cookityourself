// TODO : export in an external library

d_eurocent1 = 16.25;  // official diameter in mm
t_eurocent1 = 1.67;   // official thickness in mm
d_eurocent2 = 18.75;  // official diameter in mm
t_eurocent2 = 1.67;   // official thickness in mm
d_eurocent5 = 21.25;  // official diameter in mm
t_eurocent5 = 1.67;   // official thickness in mm
d_margin = 0.05; // margin to apply on diameter to allow insertion
  
module eurocent1 (h=t_eurocent1, d=d_eurocent1+d_margin, center = false) {
  eurocent(h,d,center);
}

module eurocent2 (h=t_eurocent2, d=d_eurocent2+d_margin, center = false) {
  eurocent(h,d,center);
}

module eurocent5 (h=t_eurocent5, d=d_eurocent5+d_margin, center = false) {
  eurocent(h,d,center);
}

module eurocent(h,d,center=false) {
  color ("Sienna") cylinder(h=h, d=d, center = center);
}

// ************************************************************
// * This model is gracefully offered by cookityourself
// * Feel free to do what you want with it
// * Please just add a link to our github if you use some of
// * our code in your own creations
// ************************************************************
// Model for a spinner in a shape of a pokeball
// this model is designed to be printed with a 2 heads printer
// and in 2 parts to avoid support that could prevent getting a 
// smooth surface.
// Choose the name of the part you want to export to create
// the files accordign to your printer (1 or 2 heads) and 
// need to avoid support.
// ************************************************************


scale([1/1,1/1,1/1]){
  
  // Choose here what you want to export:
  // "preview" : not designed for printing, final view of the spinner
  // "pokeball" : all the pokeball in one piece for a 1 head printer
  // "part1" : half the pokeball for a 1 head printer
  // "part2" : other half of the pokeball for a 1 head printer
  // "fil1" : part of the pokeball to print with filament #1 with support
  // "fil2" : part of the pokeball to print with filament #2 with support
  // "part1_fil1" : half of the pokeball to print with filament #1 with support
  // "part2_fil1" : other half of the pokeball to print with filament #2 with support
  // "part1_fil2" : half of the pokeball to print with filament #1 with support
  // "part2_fil2" : other half of the pokeball to print with filament #2 with support
  // "stubs" : pieces to print to fullfill the holes after adding the 1 eurocent coins to weight the model
  export = "part1_black"; 
  
  //----------------------------------------------------------
  
  $fn = 100;
  //$fn = 30; // debug
  
  r_adult = 45;
  r_child = 35;
  export_r = r_child;
  
  bb_int_d = 8; // internal diameter of the ball bearing
  bb_ext_d = 22; // external diameter of the ball bearing in mm
  bb_support_dout = bb_ext_d+4; // external diameter of the ball bearing support
  bb_support_h = 15; // height of the ball bearing support
  
  weight_margin = 4; // margin between weigths in mm

  black_center_h = export_r*0.2;

  if (export == "preview") {
    spinner_pokeball(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "pokeball") {
    fil1 (export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    fil2 (export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "part1") {
    translate ([0,0,-t_eurocent1]) mirror([0,0,1]) {
      part1_fil1(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
      part1_fil2(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    }
  }
  else if (export == "part2") {
    translate ([0,0,t_eurocent1]) {
      part2_fil1(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
      part2_fil2(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    }
  }  
  else if (export == "fil1") {
    fil1 (export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "fil2") {
    fil2 (export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "part1_fil1") {
    mirror([0,0,1])part1_fil1(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "part2_fil1") {
    part2_fil1(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "part1_fil2") {
    mirror([0,0,1])part1_fil2(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "part2_fil2") {
    part2_fil2(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "part1_white") {
    mirror([0,0,1])part1_white(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "part2_white") {
    part2_white(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "part1_black") {
    mirror([0,0,1])part1_black(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "part2_black") {
    part2_black(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  else if (export == "stubs"){
    stub (export_r, bb_ext_d, bb_support_dout, bb_support_h/2, black_center_h, weight_margin);
  }

}

// ************************************************************
// * Submodules
// ************************************************************


module spinner_pokeball (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  fil1 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  fil2 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  
  stub (radius, bb_ext_d, bb_support_dout, bb_support_h/2, black_center_h, weight_margin);
}

// ************************************************************

// Cut the piece to print with filament #1 in two part to be able to print without support
module part1_fil1(radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {
  difference () {
    fil1 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([-2*radius, -2*radius, -t_eurocent1]) cube (8*radius);
  }
}

module part2_fil1(radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {
  difference () {
    fil1 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([-2*radius, -2*radius, -8*radius-t_eurocent1]) cube (8*radius);
  }
}

// Piece to print with filament #1
module fil1 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  difference () {
    fil1_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([0,0,-t_eurocent1]) weights (radius, bb_support_h, weight_margin);
  }

}


module fil1_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  // pokeball red part
  color ("red") difference () {
    pokeball(radius, bb_support_h+3, bb_support_dout/2);
    translate([-2*radius, -4*radius+black_center_h/2, -2*radius]) cube(4*radius);
  }

}


// ************************************************************


module part1_white (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {
  
  difference () {
    piece_white (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([-2*radius, -2*radius, -t_eurocent1]) cube (8*radius);
  }
  
}

module part2_white (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {
  
  difference () {
    piece_white (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([-2*radius, -2*radius, -8*radius-t_eurocent1]) cube (8*radius);
  }
  
}

module part1_black (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {
  
  difference () {
    piece_black (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([-2*radius, -2*radius, -t_eurocent1]) cube (8*radius);
  }
}

module part2_black (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {
  
  difference () {
    piece_black (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([-2*radius, -2*radius, -8*radius-t_eurocent1]) cube (8*radius);
  }
}


module piece_white (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  difference () {
    piece_white_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([0,0,-t_eurocent1]) weights (radius, bb_support_h, weight_margin);
  }


}


module piece_black (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  piece_black_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
}

module piece_white_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  // pokeball white part
  color ("white") difference () {
    pokeball(radius, bb_support_h+3, bb_support_dout/2);
    translate([-2*radius, -black_center_h/2, -2*radius]) cube(4*radius);
  }

}

module piece_black_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  // ballbearing hole
  translate ([0,0,-bb_support_h/2]) color ("black") linear_extrude (bb_support_h) 
    difference (){
      circle (d=bb_support_dout);
      circle (d=bb_ext_d);
    }

  // pokeball black part
  difference () {
    color ("black") pokeball(radius-1, bb_support_h+1, bb_support_dout/2);
    translate([-2*radius, black_center_h/2, -2*radius]) cube(4*radius);
    piece_white_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  }
  

}

// ************************************************************


// Cut the piece to print with filament #2 in two part to be able to print without support
module part1_fil2(radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {
  
  part1_black (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  part1_white (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
}

module part2_fil2(radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  part2_black (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  part2_white (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
}

// Piece to print with filament #2
module fil2 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {


  piece_black (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  piece_white (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);

}

module fil2_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  piece_black_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  
  piece_white_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
}

// ************************************************************


module stub (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {
  
  difference () {
    translate ([0,0,t_eurocent1]) weights (radius, bb_support_h, weight_margin);
    difference() {
      translate([-2*radius, -2*radius, 0]) cube(4*radius);
      fil1_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
      fil2_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    }
  }
  
}

// ************************************************************

module weights (radius, bb_support_h, weight_margin) {

  weight_r = radius-d_eurocent1/2-weight_margin; // radius of the circle of weigths
  weight_h = bb_support_h;
  periph = 2*PI*weight_r;
  nb_weight = floor(periph/(d_eurocent1+weight_margin)+1);
  
  for (weight_index = [1:nb_weight]) {
    x_pos = weight_r*cos(360/nb_weight*weight_index);
    y_pos = weight_r*sin(360/nb_weight*weight_index);
    translate ([x_pos, y_pos,0]) eurocent1 (h=weight_h);
  }
  
}

// ************************************************************

module pokeball (r_ball, h_ball, r_button) {
  difference () {
    scale([1,1,h_ball/r_ball/2]) sphere (r=r_ball, center = true);
    cylinder (h=2*h_ball, r=r_button, center=true);
  }
}

