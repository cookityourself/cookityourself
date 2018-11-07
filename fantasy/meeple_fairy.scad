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
// Model to create the positive of a mold for a meeple fairy cake
// Choose the name of the part you want to export to create
// the files to slice and print.
// ************************************************************

use <../common/molderize.scad>
use <../common/cutterize.scad>
use <../common/ciy_logo.scad>

scale([1,1,1]){
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "fairy_simple"; 

  // "all" : not designed for printing, final view of all the parts
  // "fairy_simple" : the fairy form with a rectangular support

  //----------------------------------------------------------
  
  $fn = 1000;
  //$fn = 30; // debug
  
  thickness = 2;
  mold_width = 80;
  
  fairy_h = 25;
  rounding_factor = 0.2;
  fillets_s = 30; // fillet steps (see library)
  scaling = 0.14;

  fairy_height = fairy_h+thickness;

  //----------------------------------------------------------

  if (export == "fairy_simple") {
    translate ([-5,35,0]) rotate([0,0,-45]) 
    scale([scaling,scaling,1]) {
      fairy(fairy_height, rounding_factor, fillets_s);
    }
    translate([0,0,0]) color("purple")cube([80,80, thickness], center = false);
    
  }
  else {
    $fn = 30;
  }

}

// ************************************************************
// ************************************************************
// * Submodules
// ************************************************************
// ************************************************************

module fairy_shape(){
  import(file = "meeple_fairy.dxf");
}

module fairy(fairy_height, rounding_factor, fillets_s){
  color("lightpink") molderize_n_fillet(height =fairy_height, radius=fairy_height*rounding_factor, steps=fillets_s) fairy_shape();
}
