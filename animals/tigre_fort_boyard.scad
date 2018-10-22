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
// Model to create a cookie cutter for a crazy jump shape
// ************************************************************

use <../common/molderize.scad>
use <../common/ciy_logo.scad>

scale([1,1,1]) {
  $fn = 1000;
  //$fn = 30; // debug

  stamp_r = 35; // stamp radius
  stamp_t = 10; // stamp thickness
  stamp_depth = 2; // depth of the printing
  stamp_handle_h = 20; // stamp handle heigth
  stamp_handle_w = 10; // stamp handle width

  rounding_factor = 0.2;
  fillets_s = 20;

  tiger_stamp (stamp_r, stamp_t, stamp_depth, stamp_handle_h, stamp_handle_w, rounding_factor, fillets_s);


}


module tiger_shape () {
  import ("tigre_fort_boyard.dxf");
}

module resized_tiger_shape (new_max_size) {
  
  import_width = 300;
  import_height = 300;

  scale_factor = new_max_size/ max(import_width, import_height);
  scale ([scale_factor, scale_factor]) import ("tigre_fort_boyard.dxf");

}

module resized_inverted_tiger_shape (new_max_size) {
  
  import_width = 300;
  import_height = 300;

  scale_factor = new_max_size/ max(import_width, import_height);
  
  difference () {
    translate ([new_max_size/2, new_max_size/2, 0]) circle (r=new_max_size/2*sqrt(2));
    translate ([-1.5,-6,0]) scale ([scale_factor, scale_factor]) import ("tigre_fort_boyard.dxf");
  }
  
}


module tiger_stamp (stamp_r, stamp_t, stamp_depth, stamp_handle_h, stamp_handle_w, rounding_factor, fillets_s) {
  
  difference () {
    translate ([stamp_r/sqrt(2), stamp_r/sqrt(2), -stamp_t+stamp_depth]) color("blue") cylinder(r=stamp_r, h=stamp_t-1);
    
    
    translate ([-1.5,-6,stamp_depth*2]) mirror([0,0,1]) molderize_n_fillet(height =stamp_depth*2, radius=stamp_depth*rounding_factor, steps=fillets_s) mirror([0,0,1]) resized_tiger_shape (2*stamp_r/sqrt(2));

  }
  
  translate([0, 0, -stamp_t/2+stamp_depth] ) 
  color("red") molderize_n_fillet(height =stamp_t/2, radius=stamp_depth*rounding_factor, steps=fillets_s) resized_inverted_tiger_shape (2*stamp_r/sqrt(2));

}