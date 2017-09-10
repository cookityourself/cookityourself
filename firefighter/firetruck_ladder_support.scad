// ************************************************************
// * EN
// * This model is gracefully offered by cookityourself.
// * Feel free to do what you want with it.
// * Please just add a link to our website www.ciy.fr 
// * if you use some of our code in your own creations.
// ************************************************************
// * FR
// * Ce modèle vous est gracieusement offert par cookityourself.
// * Vous êtes libres de l'utiliser comme bon vous semble.
// * Nous vous demandons seulement de faire un lien vers notre 
// * site web www.ciy.fr si vous utilisez tout ou partie de ce 
// * code pour l'une de vos créations.
// ************************************************************
// Model for a fire truck cake support.
// Choose the name of the part you want to export to create
// the files to slice and print.
// ************************************************************

// Note that rendering is very slow due to high use of minkowski()
use <../common/round_edges.scad>


scale([1/1,1/1,1/1]){

  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "preview"; 

  // "preview" : not designed for printing, final view of the cake with its support
  
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  //----------------------------------------------------------

  $fn = 100;
  //$fn = 30; // debug

  cake_width=90;
  cake_depth=220;
  cake_height=70;
  rounding_radius = 20;
  
  plate_t = 2; // plate thickness
  
  ladder_angle = 15;
  ladder_pos = 0.75; // in percentage of the cake depth
  ladder_sup_w = (cake_width-2*rounding_radius)*0.5;
  ladder_sup_d = 15;
  
  wheel_r = cake_height*0.3;
  puzzle_d = cake_width/4;


  //----------------------------------------------------------

  if (export == "preview") {
    fire_truck_cake(cake_width, cake_depth, cake_height, rounding_radius, wheel_r, puzzle_d, plate_t, ladder_sup_w, ladder_sup_d, ladder_pos, ladder_angle);
  }

  
}


// ************************************************************
// * Submodules
// ************************************************************

// ************************************************************

module fire_truck_cake (cake_width, cake_depth, cake_height, rounding_radius, wheel_r, puzzle_d, plate_t, ladder_sup_w, ladder_sup_d, ladder_pos, ladder_angle) {

  // cake
  color ("red") translate([0,0,cake_height/2]) round_all_3d (rounding_radius) cube([cake_width-2*rounding_radius,cake_depth-2*rounding_radius, cake_height-2*rounding_radius], center = true);
  
  // ladder
  color ("Gainsboro") ladder (cake_width, cake_depth, cake_height, rounding_radius, wheel_r, plate_t, ladder_sup_w, ladder_sup_d, ladder_pos, ladder_angle);
  
  // rear support 
  color ("Firebrick") rear_support (cake_width, cake_depth, rounding_radius, wheel_r, puzzle_d, plate_t, ladder_sup_w, ladder_sup_d, ladder_pos);

  // front support
  color ("DarkRed") front_support (cake_width, cake_depth, rounding_radius, wheel_r, puzzle_d, plate_t);

}

// ************************************************************

module ladder (cake_width, cake_depth, cake_height, rounding_radius, wheel_r, plate_t, ladder_sup_w, ladder_sup_d,ladder_pos, ladder_angle) {
  
  // support
  translate ([-ladder_sup_w/2,cake_depth*(-0.5+ladder_pos),-wheel_r])
    cube([ladder_sup_w, ladder_sup_d, cake_height+wheel_r]);
  translate ([-ladder_sup_w/2,cake_depth*(-0.5+ladder_pos),cake_height])
    difference () {
      cube([ladder_sup_w, ladder_sup_d, ladder_sup_d*tan(ladder_angle)]);
      translate ([-ladder_sup_w/2,0,ladder_sup_d*tan(ladder_angle)]) rotate ([-ladder_angle,0,0]) cube([2*ladder_sup_w, 2*ladder_sup_d, ladder_sup_d*tan(ladder_angle)]);
    }
  
  
  // ladder
  ladder_w = (cake_width-2*rounding_radius)*0.75;
  ladder_d = cake_depth;
  translate ([-ladder_w/2,cake_depth*(-0.5+ladder_pos),cake_height+ladder_sup_d*tan(ladder_angle)]) 
    rotate ([-ladder_angle, 0, 0]) translate ([0,-ladder_d*3/4,0]) 
    cube([ladder_w, ladder_d, plate_t]);

}

// ************************************************************

module rear_support (cake_width, cake_depth, rounding_radius, wheel_r, puzzle_d, plate_t, ladder_sup_w, ladder_sup_d, ladder_pos) {

  plate_w = (cake_width-2*rounding_radius)*1.2;
  plate_d = (cake_depth-2*rounding_radius)/2;
  wheels_pos = cake_depth*(-0.5+0.7);
  margin = 0.4;


  difference () {
    union () {
      // plate
      translate ([0,plate_d/2,0]) cube ([plate_w, plate_d, plate_t], center = true);
      
      // wheels
      translate ([plate_w/2, wheels_pos, 0]) wheel (wheel_r, plate_t);
      translate ([-plate_w/2-plate_t, wheels_pos,  0]) wheel (wheel_r, plate_t);
      
      // ladder support container
      translate ([0,0,-wheel_r]) 
        translate ([-ladder_sup_w/2-plate_t,cake_depth*(-0.5+ladder_pos)-plate_t,0])
        cube([ladder_sup_w+2*plate_t, ladder_sup_d+2*plate_t, wheel_r]);
      
      // puzzle pieces
      translate([-puzzle_d/2+margin,-puzzle_d/2+margin,-wheel_r]) cube ([puzzle_d-2*margin, puzzle_d-2*margin, wheel_r+plate_t]);

    }
    // hole for ladder support
    translate ([-ladder_sup_w/2-margin,cake_depth*(-0.5+ladder_pos)-margin,-wheel_r*3/2])
      cube([ladder_sup_w+2*margin, ladder_sup_d+2*margin, 2*wheel_r]);
    
    // cut the upper part of the wheels to ease printing
    translate ([-plate_w,-plate_d/2,plate_t/2]) cube ([2*plate_w, 2*plate_d, 2*wheel_r]);
    }
}

// ************************************************************

module front_support (cake_width, cake_depth, rounding_radius, wheel_r, puzzle_d, plate_t) {

  plate_w = (cake_width-2*rounding_radius)*1.2;
  plate_d = (cake_depth-2*rounding_radius)/2;
  wheels_pos = cake_depth*(-0.5+0.23);


  difference () {
    union () {
      // plate
      translate ([0,-plate_d/2, 0]) cube ([plate_w, plate_d, plate_t], center = true);
      
      // wheels
      translate ([plate_w/2, wheels_pos, 0]) wheel (wheel_r, plate_t);
      translate ([-plate_w/2-plate_t, wheels_pos,  0]) wheel (wheel_r, plate_t);

      // puzzle pieces
      translate([-puzzle_d/2-plate_t,-puzzle_d/2-plate_t,-wheel_r]) cube ([puzzle_d+2*plate_t, puzzle_d+2*plate_t, wheel_r+plate_t]);

    }
    // hole for the puzzle pieces
    translate([-puzzle_d/2,-puzzle_d/2,-wheel_r*3/2]) cube ([puzzle_d, puzzle_d, wheel_r*2]);
    
    // cut the upper part of the wheels to ease printing
    translate ([-plate_w,-plate_d*3/2,plate_t/2]) cube ([2*plate_w, 2*plate_d, 2*wheel_r]);
    }
}

// ************************************************************

module wheel (wheel_r, plate_t) {
  rotate ([0,90,0]) cylinder(plate_t, r=wheel_r);
}


// ************************************************************
