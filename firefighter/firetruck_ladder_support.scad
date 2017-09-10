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
  
  plate_t = 3; // plate thickness
  
  ladder_angle = 15;
  ladder_pos = 0.75; // in percentage of the cake depth


  //----------------------------------------------------------

  if (export == "preview") {
    fire_truck_cake(cake_width, cake_depth, cake_height, rounding_radius, plate_t, ladder_pos, ladder_angle);
  }

  
}


// ************************************************************
// * Submodules
// ************************************************************

// ************************************************************

module fire_truck_cake (cake_width, cake_depth, cake_height, rounding_radius, plate_t, ladder_pos, ladder_angle) {

  // cake
  *translate([0,0,cake_height/2]) round_all_3d (rounding_radius) cube([cake_width-2*rounding_radius,cake_depth-2*rounding_radius, cake_height-2*rounding_radius], center = true);
  
  // ladder
  ladder (cake_width, cake_depth, cake_height, rounding_radius, plate_t, ladder_pos, ladder_angle);

}

// ************************************************************

module ladder (cake_width, cake_depth, cake_height, rounding_radius, plate_t, ladder_pos, ladder_angle) {
  
  // plate
  plate_w = (cake_width-2*rounding_radius)*1.2;
  plate_d = (cake_depth-2*rounding_radius)/2;
  translate ([0,plate_d/2,0]) cube ([plate_w, plate_d, plate_t], center = true);
  
  // support
  support_w = (cake_width-2*rounding_radius)*0.75;
  support_d = 15;
  translate ([-support_w/2,cake_depth*(-0.5+ladder_pos),0])
    cube([support_w, support_d, cake_height]);
  translate ([-support_w/2,cake_depth*(-0.5+ladder_pos),cake_height])
    difference () {
      cube([support_w, support_d, support_d*tan(ladder_angle)]);
      translate ([-support_w/2,0,support_d*tan(ladder_angle)]) rotate ([-ladder_angle,0,0]) cube([2*support_w, 2*support_d, support_d*tan(ladder_angle)]);
    }
  
  
  // ladder
  ladder_w = (cake_width-2*rounding_radius)*0.75;
  ladder_d = cake_depth;
  translate ([-ladder_w/2,cake_depth*(-0.5+ladder_pos),cake_height+support_d*tan(ladder_angle)]) 
    rotate ([-ladder_angle, 0, 0]) translate ([0,-ladder_d*3/4,0]) 
    cube([ladder_w, ladder_d, plate_t]);

}

// ************************************************************
// ************************************************************
// ************************************************************
// ************************************************************
