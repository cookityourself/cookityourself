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
// Model for cooking tools in the shape of a Princess Leia Meeple:
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
  // "cookie_cutter": cookie cutter in the shape of a Princess Leia meeple
  // "mold" : the positive shape to create a mold of a Princess Leia meeple
  // "cookie_petg": cookie cutter with recycling logo "PETG"
  
  //----------------------------------------------------------
  
  $fn = 1000;
  //$fn = 30; // debug
  
  original_size = 175; // size of the imported dxf in mm
  
  // cookie cutter parameters
  cutter_height = 15;
  cutter_thickness = 1;
  cutter_size = 70; // size of the cutter in mm
  cutter_color = "white";
  
  cutter_scale = cutter_size/original_size;

  // mold parameters

  mold_thickness = 1; // thickness of the plate
  mold_height = 20;
  mold_size = 85; // size of the mold in mm
  mold_rounding_factor = 0.3;
  mold_fillet_steps = 50; // fillet steps (see library)
  mold_color = cutter_color;
  
  mold_scale = mold_size/original_size;

  //----------------------------------------------------------

  if (export == "cookie_cutter") {
    meeple_leia_cookie_cutter(cutter_scale, cutter_height, cutter_thickness, cutter_color);
    
  }
  else if (export == "cookie_petg") {
    meeple_leia_cookie_cutter(cutter_scale, cutter_height, cutter_thickness, cutter_color, "PETG");
    
  }
  else if (export == "mold") {
    rotate([0,0,0]) scale([mold_scale,mold_scale,1]) {
      meeple_leia_mold(mold_height, mold_height*mold_rounding_factor, mold_fillet_steps, mold_color);
    }
    //translate([-4,-4,0]) color("black")cube([mold_size+6,mold_size+6, mold_thickness], center = false);
  } 

  else {
    $fn = 30;
    meeple_leia_cookie_cutter(cutter_scale, cutter_height, cutter_thickness);
  }

}

// ************************************************************
// ************************************************************
// * Submodules
// ************************************************************
// ************************************************************

module meeple_leia_shape(){
    import(file = "meeple_leia.dxf");
}

module meeple_leia_cookie_cutter(cutter_scale, cutter_height, cutter_thickness, cutter_color, filament="PLA"){
  difference() {
    color(cutter_color) cutterize_3d_offset(thickness = cutter_thickness, height =cutter_height) scale(cutter_scale) meeple_leia_shape();
    union () {
      translate ([23*cutter_scale,-cutter_thickness,cutter_height/2]) rotate([90,0,0]) ciy_logo(logo_size = cutter_height/3, logo_height = cutter_thickness, logo_orientation = 0);
      translate ([146*cutter_scale,-cutter_thickness-0.1,cutter_height/2+1]) rotate([90,0,0]) recycling_symbol(filament, cutter_height/3, cutter_thickness, [0,0,0]);
    }
  }
}

module meeple_leia_mold(mold_height, mold_radius, mold_fillet_steps, mold_color){
  color(mold_color) molderize_n_fillet(height =mold_height, radius=mold_radius, steps=mold_fillet_steps) meeple_leia_shape (); 
}

