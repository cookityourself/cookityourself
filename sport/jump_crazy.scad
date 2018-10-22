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

use <../common/cutterize.scad>
use <../common/ciy_logo.scad>

scale([1,1,1]) {
  $fn = 1000;
  //$fn = 30; // debug

  cutter_t = 1.8;     // cookie cutter thickness
  cutter_h = 20;  // cookie cutter height

  //mirror([1,0,0]) linear_extrude(10) jump_crazy1_shape ();
  jump_crazy_cutter(cutter_t, cutter_h);

}


module jump_crazy_shape () {
  import ("jump_crazy.dxf");
}

module jump_crazy_cutter (cutter_t, cutter_h) {
  cutterize_3d_fillet(thickness = cutter_t, height =cutter_h) jump_crazy_shape (); 
}