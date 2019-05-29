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
// Model for cooking tools in the shape of a Dark Space Knight Meeple:
// - cookie cutter
// - positive shape to create a mold
// ************************************************************

use <../common/molderize.scad>
use <../common/cutterize.scad>
use <../common/ciy_logo.scad>
use <../libs/recycling_symbol_library/recycling_symbol.scad>


scale([1,1,1]){
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "mold"; 

  // "all": not designed for printing, final view of all the parts
  // "cookie_cutter": cookie cutter in the shape of a Dark Space Knight meeple
  // "mold" : the positive shape to create a mold of a Dark Space Knight meeple
  // "cookie_petg": cookie cutter with recycling logo "PETG"
  
  //----------------------------------------------------------
  
  $fa = 6;
  $fs = 0.2;
  $fn = 0;
  //$fn = 1000;
  //$fn = 30; // debug
  
  original_size = 175; // size of the imported dxf in mm
  
  // cookie cutter parameters
  cutter_height = 15;
  cutter_thickness = 1;
  cutter_size = 70; // size of the cutter in mm
  cutter_color = "black";
  
  cutter_scale = cutter_size/original_size;

  // mold parameters

  mold_height = 20;
  mold_size = 85; // size of the mold in mm
  mold_rounding_factor = 0.3;
  mold_fillet_steps = 50; // fillet steps (see library)
  mold_thickness = 1; // thickness of the plate
  mold_color = "grey";
  
  mold_scale = mold_size/original_size;

  //----------------------------------------------------------

  if (export == "cookie_cutter") {
    meeple_vador_cookie_cutter(cutter_scale, cutter_height, cutter_thickness, cutter_color);
    
  }
  else if (export == "cookie_petg") {
    meeple_vador_cookie_cutter(cutter_scale, cutter_height, cutter_thickness, cutter_color, "PETG");
    
  }
  else if (export == "mold") {
    rotate([0,0,0]) scale([mold_scale,mold_scale,1]) {
      meeple_vador_mold(mold_height, mold_height*mold_rounding_factor, mold_fillet_steps, mold_color);
    }
    //translate([-5,-1,0]) color("black")cube([80,80, mold_thickness], center = false);
  } 

  else {
    $fn = 30;
    meeple_vador_cookie_cutter(cutter_scale, cutter_height, cutter_thickness);
  }

}

// ************************************************************
// ************************************************************
// * Submodules
// ************************************************************
// ************************************************************

module meeple_vador_shape(){
  difference () {
    translate([-223,0,0]) import(file = "../spaceknights/meeple_space_knights_characters.dxf");
    translate([-270,-10]) square(250);
  }
}

module meeple_vador_cookie_cutter(cutter_scale, cutter_height, cutter_thickness, cutter_color, filament="PLA"){
  difference() {
    color(cutter_color) cutterize_3d_offset(thickness = cutter_thickness, height =cutter_height) scale(cutter_scale) meeple_vador_shape();
    union () {
      translate ([40*cutter_scale,-cutter_thickness+0.2,cutter_height/2]) rotate([90,0,0]) ciy_logo(logo_size = cutter_height/2, logo_height = cutter_thickness, logo_orientation = 0);
      translate ([124*cutter_scale,-cutter_thickness+0.2,cutter_height/2+1]) rotate([90,0,0]) recycling_symbol(filament, cutter_height/2, cutter_thickness, [0,0,0]);
    }
  }
}

module meeple_vador_mold(mold_height, mold_radius, mold_fillet_steps, mold_color){
  color(mold_color) molderize_n_fillet(height =mold_height, radius=mold_radius, steps=mold_fillet_steps) meeple_vador_shape (); 
}

