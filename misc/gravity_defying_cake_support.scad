// ************************************************************
// * EN
// * This model is gracefully offered by cookityourself
// * Feel free to do what you want with it
// * Please just add a link to our github if you use some of
// * our code in your own creations:
// * https://github.com/cookityourself/cookityourself
// ************************************************************
// * FR
// * Ce modèle vous est gracieusement offert par cookityourself.
// * Vous êtes libres de l'utiliser comme bon vous semble.
// * Nous vous demandons seulement de faire un lien vers notre 
// * github si vous utilisez tout ou partie de ce 
// * code pour l'une de vos créations :
// * https://github.com/cookityourself/cookityourself
// ************************************************************
// Model for a support to make any Gravity Defying Cake 
// centered around a vertical axis
// This model assumes you have a heavy plate with a center
// axis of diameter 6 mm. It can be a piece of wood with an
// aluminium stick.
// ************************************************************

use <../common/ciy_logo.scad>
use <../libs/recycling_symbol_library/recycling_symbol.scad>

scale([1,1,1]){
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "big_plate"; 

  // "all": not designed for printing, final view of all the parts
  // "tube": single tube to adjust the position of the plates
  // "small_plate": a small plate with a tube for stabilization
  // "big_plate": a small plate with a tube for stabilization
  
  //----------------------------------------------------------
  
  $fn = 1000;
  //$fn = 30; // debug
  
  // wood support parameters
  axis_d = 6; // axis external diameter
  
  // tube parameters
  //t_h = 10; // tube height
  t_h = 45; // tube height
  t_d = axis_d+0.4;  // tube internal diameter
  t_t = 1;  // tube thickness
  
  // small plate parameters
  sp_t = 2; // small plate thickness
  sp_d = 64; // small plate external diameter
  spt_h = 33; // small plate's tube height

  // big plate parameters
  bp_t = 2; // big plate thickness
  bp_d = 160; // big plate external diameter
  bpt_h = 36; // big plate's tube height

  //----------------------------------------------------------

  if (export == "tube") {
    color("indigo") tube(t_h, t_d, t_t);
    
  }
  
  else if (export == "small_plate") {
    color("blue") plate(sp_t, sp_d, spt_h, t_d, t_t);
  }
 
  else if (export == "big_plate") {
    color("green") plate(bp_t, bp_d, bpt_h, t_d, t_t);
  }
  //else if (export == "") {
  ///}
 

  else {
    $fn = 30;
    // tube
    color("indigo") tube(t_h, t_d, t_t);
    // small plate
    color("blue") translate([0,0,t_h+sp_t+spt_h]) rotate([180,0,0]) plate(sp_t, sp_d, spt_h, t_d, t_t);
    // big plate
    color("green") translate([0,0,t_h+spt_h+sp_t+bpt_h+bp_t]) rotate([180,0,0]) plate(bp_t, bp_d, bpt_h, t_d, t_t);
    
  }

}

// ************************************************************
// ************************************************************
// * Submodules
// ************************************************************
// ************************************************************

module tube(t_h, t_d, t_t) {
  difference() {
    cylinder(t_h, d=t_d+2*t_t);
    translate([0,0,-t_h/2]) cylinder(2*t_h,d= t_d);
  }
}

module plate(p_t, p_d, pt_h, t_d, t_t) {
  l_d = 0.15; // logos depth
  l_s = 12; // logos size
  
  difference() {
    union () {
      cylinder(p_t, d=p_d); // plate
      translate([0,0,p_t])cylinder(pt_h, d=t_d+2*t_t); // tube
    }
    hole_h = p_t+pt_h;
    translate([0,0,-hole_h/2]) cylinder(2*hole_h,d= t_d);
    translate([0,l_s+5,-p_t+l_d]) mirror([1,0,0]) ciy_logo(logo_size = l_s, logo_height = p_t, logo_orientation = 0);
    translate([0,-l_s-5,-p_t+l_d]) mirror([1,0,0]) recycling_symbol("PLA", l_s, p_t, [0,0,0]);  
  }
}
