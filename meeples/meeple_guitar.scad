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
// Model for cooking tools in the shape of a Rock'n Roll guitarist meeple:
// - cookie cutter
// ************************************************************

use <../common/cutterize.scad>
use <../common/ciy_logo.scad>
use <../libs/recycling_symbol_library/recycling_symbol.scad>


scale([1,1,1]){
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "cookie_cutter"; 

  // "all": not designed for printing, final view of all the parts
  // "cookie_cutter": cookie cutter in the shape of a guitarist meeple
  
  //----------------------------------------------------------
  
  $fn = 1000;
  //$fn = 30; // debug
  
  original_size = 200; // size of the imported dxf in mm
  
  // cookie cutter parameters
  cutter_height = 15;
  cutter_thickness = 1;
  cutter_size = 70; // size of the cutter in mm
  
  cutter_scale = cutter_size/original_size;

  //----------------------------------------------------------

  if (export == "cookie_cutter") {
    meeple_guitarist_cookie_cutter(cutter_scale, cutter_height, cutter_thickness);
    
  }
 
  //else if (export == "") {
  ///}
 

  else {
    $fn = 30;
    meeple_guitarist_cookie_cutter(cutter_scale, cutter_height, cutter_thickness);
  }

}

// ************************************************************
// ************************************************************
// * Submodules
// ************************************************************
// ************************************************************

module meeple_guitar_shape(){
  import(file = "meeple_guitar.dxf");
}

module meeple_guitarist_cookie_cutter(cutter_scale, cutter_height, cutter_thickness){
  difference() {
    color("red") cutterize_3d_fillet(thickness = cutter_thickness, height =cutter_height) scale(cutter_scale) meeple_guitar_shape();
    union () {
      translate ([40*cutter_scale,-cutter_thickness+0.2,cutter_height/2]) rotate([90,0,0]) ciy_logo(logo_size = cutter_height/2, logo_height = cutter_thickness, logo_orientation = 0);
      translate ([130*cutter_scale,-cutter_thickness+0.2,cutter_height/2+1]) rotate([90,0,0]) recycling_symbol("PLA", cutter_height/2, cutter_thickness, [0,0,0]);
    }
  }
}
