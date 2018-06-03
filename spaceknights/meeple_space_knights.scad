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
// Model to create the positive of a mold for a cake showing a 
// great fight between two legendary space knights.
// Choose the name of the part you want to export to create
// the files to slice and print.
// ************************************************************

// Note that rendering could be very slow due to high use of minkowski()
use <../common/round_edges.scad>

scale([1/1,1/1,1/1]){
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "preview"; 

  // "preview" : not designed for printing, final view of all the parts

  //----------------------------------------------------------
  
  //$fn = 1000;
  $fn = 30; // debug
  
  knights_height = 40;
  saber_height = 20;
  rounding = 5;

  //----------------------------------------------------------

  if (export == "knights") {
    knights(knights_height, rounding);
  }
  else if (export == "saber") {
    saber ();
  }
  else if (export == "saber_left") {
    saber_left(saber_height, rounding);

  }
  else {
    $fn = 30;
    knights(knights_height, rounding);
    saber_left(saber_height, rounding);
    saber_right(saber_height, rounding);
  }

}

// ************************************************************
// ************************************************************
// * Submodules
// ************************************************************
// ************************************************************


module knights (knights_height = 40, rounding = 2){
  linear_extrude(height = knights_height)  
    import(file = "meeple_space_knights_characters.dxf");
}

module saber(){
  color("green") rotate_extrude()  import(file = "meeple_space_knights_saber.dxf");
}

module saber_left(saber_height = 20, rounding = 2){
  color("blue") linear_extrude(height = saber_height)  
    import(file = "meeple_space_knights_saber_left.dxf");
}

module saber_right(saber_height = 20, rounding = 2){
  color("red") linear_extrude(height = saber_height)  
    import(file = "meeple_space_knights_saber_right.dxf");
}