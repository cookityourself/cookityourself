// ************************************************************
// * EN
// * This model is offered free of charge by cookityourself.
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
// Model for cookie cutters to build a gingerbread house
// ************************************************************

use <../common/cutterize.scad>
use <../common/ciy_logo.scad>
use <../libs/recycling_symbol_library/recycling_symbol.scad>


scale([1,1,1]){
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "all"; 

  // "all": not designed for printing, final view of all the parts
  // "little pieces": all except walls and roof
  // "front_wall": cookie cutter for the front and back walls
  // "side_wall": cookie cutter for the two side walls
  // "roof": cookie cutter for the roof
  
  //----------------------------------------------------------
  
  $fn = 1000;
  //$fn = 30; // debug
  
  cutter_thickness = 1;
  cutter_height = 25;
  
  // walls
  wall_height = 80;
  sw_length = 145; // side wall length
  fw_top_height = 60;
  fw_length = 130;

  // door
  door_length = 32;
  door_height = 44;
  door_top = 16;
  
  // windows
  win_height = 30; // windows height
  fwin_length = 20; // front window length
  win_cross_t = 6;  // window cross thickness
  win_cross_l = 25; // window cross length
  up_win_radius = win_height/2;

  // roof
  roof_height = 100;
  roof_length = 170;

  // chimney
  chim_height = win_height;

  //----------------------------------------------------------

  if (export == "front_wall") {
    front_wall(cutter_thickness, cutter_height, wall_height, fw_length, fw_top_height);
  }
 
  else if (export == "side_wall") {
    square_cutter(cutter_thickness, cutter_height, wall_height, sw_length);
  }

   else if (export == "roof") {
    square_cutter(cutter_thickness, cutter_height, roof_height, roof_length);
  }
 

  
  else if (export == "little_pieces") {
    // side window
    translate ([45,50,0]) square_cutter(cutter_thickness, cutter_height, win_height, win_height);
    // front window
    translate ([0,50,0]) square_cutter(cutter_thickness, cutter_height, win_height, fwin_length);
    // door
    translate ([90,20,0]) door(cutter_thickness, cutter_height, door_height, door_length, door_top);
    // chimney
    translate ([0,15,0]) chimney(cutter_thickness, cutter_height, chim_height);
    // upper window
    translate ([20,100,0]) round_cutter(cutter_thickness, cutter_height, up_win_radius);
    // cross window
    translate ([60,30,0]) cross_window(cutter_thickness, cutter_height, win_cross_t, win_cross_l);    
  }


  else {
    $fn = 30;
    // side wall
    translate ([145,10,0]) square_cutter(cutter_thickness, cutter_height, wall_height, sw_length);
    // roof
    translate ([135,0,0]) square_cutter(cutter_thickness, cutter_height, roof_height, roof_length);
    // side window
    translate ([195,50,0]) square_cutter(cutter_thickness, cutter_height, win_height, win_height);
    // front window
    translate ([155,50,0]) square_cutter(cutter_thickness, cutter_height, win_height, fwin_length);
    // door
    translate ([240,20,0]) door(cutter_thickness, cutter_height, door_height, door_length, door_top);
    // chimney
    translate ([155,15,0]) chimney(cutter_thickness, cutter_height, chim_height);
    // front wall
    front_wall(cutter_thickness, cutter_height, wall_height, fw_length, fw_top_height);
    // upper window
    translate ([65,90,0]) round_cutter(cutter_thickness, cutter_height, up_win_radius);
    // cross window
    translate ([215,30,0]) cross_window(cutter_thickness, cutter_height, win_cross_t, win_cross_l);
    
  }

}

// ************************************************************
// ************************************************************
// * Submodules
// ************************************************************
// ************************************************************

module square_cutter(cutter_thickness, cutter_height, square_height, square_length){
  cutterize_3d_fillet(thickness = cutter_thickness, height =cutter_height) square([square_length, square_height]);
}

module round_cutter(cutter_thickness, cutter_height, circle_radius){
  cutterize_3d_fillet(thickness = cutter_thickness, height =cutter_height) circle(circle_radius);
}


module door(cutter_thickness, cutter_height, door_height, door_length, door_top){
  cutterize_3d_fillet(thickness = cutter_thickness, height =cutter_height) 
    union() {
      square([door_length, door_height]);
      translate([door_top, door_height, 0]) circle(door_top);
    }
}

module chimney(cutter_thickness, cutter_height, chim_height){
  cutterize_3d_fillet(thickness = cutter_thickness, height =cutter_height) 
    difference() {
      square(chim_height);
      translate([chim_height/2, -chim_height*sqrt(2)/6, 0]) rotate([0,0,45]) translate([-chim_height/2, -chim_height/2, 0]) square(chim_height);
    }
}


module front_wall(cutter_thickness, cutter_height, front_wall_height, front_wall_length, front_wall_top) {
  cutterize_3d_fillet(thickness = cutter_thickness, height =cutter_height) 
    union() {
      square([front_wall_length, front_wall_height]);
      translate([front_wall_length/2, front_wall_height, 0]) resize([front_wall_length, 2*front_wall_top]) rotate([0,0,45]) translate([-5, -5, 0]) square(10);
    }
}

module cross_window(cutter_thickness, cutter_height, win_cross_t, win_cross_l) {
  cutterize_3d_fillet(thickness = cutter_thickness, height =cutter_height) 
    union() {
      square([win_cross_l, win_cross_t], center = true);
      square([win_cross_t, win_cross_l], center = true);
    }
}