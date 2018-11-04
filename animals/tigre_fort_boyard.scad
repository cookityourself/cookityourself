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
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "stencil"; 

  // "stamp" : a stamp for cookies
  // "stencil" : a stencil for a cake

  //----------------------------------------------------------
  
  $fn = 1000;
  //$fn = 30; // debug

  // Printer Parameters : maximum printing area
  max_x = 250;
  max_y = 210;
  max_z = 200;

  // STAMP Parameters
  stamp_r = 35; // stamp radius
  stamp_t = 10; // stamp thickness
  stamp_depth = 2; // depth of the printing
  stamp_handle_h = 20; // stamp handle heigth
  stamp_handle_w = 10; // stamp handle width

  rounding_factor = 0.2;
  fillets_s = 20;

  // STENCIL Parameters
  stencil_r = 120; // stencil radius
  stencil_t = 3;  // stencil thickness

  if (export == "stamp") {
    tiger_stamp (stamp_r, stamp_t, stamp_depth, stamp_handle_h, stamp_handle_w, rounding_factor, fillets_s);
  }
  else {
    
    intersection () {
    cube([max_x,max_y,max_z]); // maximum printing size for Prusa


    translate ([stencil_r-stencil_r/sqrt(2), stencil_r-stencil_r/sqrt(2)-10, 0]) tiger_stencil (stencil_r, stencil_t);
    }
    
    // preview translate ([stencil_r/sqrt(2), stencil_r/sqrt(2), -10]) color("saddleBrown") cylinder(r=stencil_r, h=stencil_t);
  }


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

module tiger_stencil (stencil_r, stencil_t) {

  difference () {
    translate ([stencil_r/sqrt(2), stencil_r/sqrt(2), 0]) color("blue") cylinder(r=stencil_r, h=stencil_t);
    
    
   translate ([-5,-18,-stencil_t*2]) linear_extrude(stencil_t*4) resized_tiger_shape (2*stencil_r/sqrt(2));

  }

    // connectors
    translate([stencil_r/sqrt(2)+10, stencil_r/sqrt(2)+stencil_r/2-13, 0]) color("red") cube([stencil_t/2, 30, stencil_t]);
    translate([stencil_r/sqrt(2)-10, stencil_r/sqrt(2)+stencil_r/2-13, 0]) color("red") cube([stencil_t/2, 30, stencil_t]);

    translate([stencil_r/sqrt(2)+25, stencil_r/4+9, 0]) rotate ([0,0,0]) color("orange") cube([20, stencil_t/2, stencil_t]);
    translate([stencil_r/sqrt(2)-45, stencil_r/4+9, 0]) rotate ([0,0,0]) color("orange") cube([20, stencil_t/2, stencil_t]);

    translate([stencil_r/sqrt(2)+45, stencil_r/2+18, 0]) rotate ([0,0,0]) color("green") cube([20, stencil_t/2, stencil_t]);
    translate([stencil_r/sqrt(2)-60, stencil_r/2+18, 0]) rotate ([0,0,0]) color("green") cube([20, stencil_t/2, stencil_t]);

    translate([stencil_r/sqrt(2)+19, stencil_r*3/4+17, 0]) rotate ([0,0,0]) color("pink") cube([40, stencil_t/2, stencil_t]);
    translate([stencil_r/sqrt(2)-58, stencil_r*3/4+17, 0]) rotate ([0,0,0]) color("pink") cube([38, stencil_t/2, stencil_t]);

}