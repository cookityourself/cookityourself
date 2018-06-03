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

use <../common/molderize.scad>

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
  margin = 0.2; // margin for assembly
  rounding = 5;
  fillets_s = 20; // fillet steps (see library)

  //----------------------------------------------------------

  if (export == "knights") {
    knights_assembly(knights_height, saber_height, margin, rounding, fillets_s);
  }
  else if (export == "saber") {
    saber ();
  }
  else if (export == "saber_left") {
    saber_left(saber_height, margin, rounding, fillets_s);
  }
  else if (export == "saber_right") {
    saber_right(saber_height, margin, rounding, fillets_s);
  }
  else {
    $fn = 30;
    knights_assembly(knights_height, saber_height, margin, rounding, fillets_s);
    saber_left(saber_height, 0, rounding, fillets_s);
    saber_right(saber_height, 0, rounding, fillets_s);
  }

}

// ************************************************************
// ************************************************************
// * Submodules
// ************************************************************
// ************************************************************


module saber(){
  color("green") rotate_extrude()  import(file = "meeple_space_knights_saber.dxf");
}

module saber_left(saber_height = 20, margin = 0, rounding = 2, fillets_s = 10){
  module shape () {
    import ("meeple_space_knights_saber_left.dxf");
  }
  color("blue") molderize_n_fillet(height =saber_height, radius=rounding, steps=fillets_s) offset(delta=margin) shape ();
}

module saber_right(saber_height = 20, margin = 0, rounding = 2, fillets_s = 10){
  module shape () {
    import ("meeple_space_knights_saber_right.dxf");
  }
  color("red") molderize_n_fillet(height =saber_height, radius=rounding, steps=fillets_s) offset(delta=margin) shape ();
}

module knights (knights_height = 40, rounding = 2, fillets_s = 10){
  module shape () {
    import ("meeple_space_knights_characters.dxf");
  }
  molderize_n_fillet(height =knights_height, radius=rounding, steps=fillets_s) shape (); 
}

module knights_assembly (knights_height = 40, saber_height = 20, margin = 0, rounding = 2, fillets_s = 10){
  difference () {
    knights(knights_height, rounding, fillets_s);
    saber_left(saber_height+margin, margin, rounding, fillets_s);
    saber_right(saber_height+margin, margin, rounding, fillets_s);
  }
}


