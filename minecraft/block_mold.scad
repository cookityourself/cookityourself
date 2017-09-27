// ************************************************************
// * This model is gracefully offered by cookityourself
// * Feel free to do what you want with it
// * Please just add a link to our website www.ciy.fr 
// * if you use some of our code in your own creations
// ************************************************************
// * Ce modèle vous est gracieusement offert par cookityourself
// * Vous êtes libres de l'utiliser comme bon vous semble
// * Nous vous demandons seulement de faire un lien vers notre 
// * site web www.ciy.fr si vous l'utilisez pour l'une de vos
// * créations
// ************************************************************
// Model for a mold or cutter for a set of minecraft blocks
// ************************************************************

scale([1/1,1/1,1/1]){

  block_e = 25; // edge of each block
  nb_by_line = 4; // generate a mold of nb_by_line * nb_by_line blocks
  walls_t = 2; // wall thickness, should be a multiple of the noze diameter 

  block_mold(block_e, nb_by_line, walls_t);
  
}


// ************************************************************
// * Submodules
// ************************************************************

module block_mold(block_e, nb_by_line, walls_t) {
  
  center_xy = (nb_by_line/2 - 1/2)*block_e;
  
  translate ([-center_xy, -center_xy, 0]) for (i_line = [0:nb_by_line-1]) {
    for (i_col = [0:nb_by_line-1]) {
      translate ([i_line*block_e, i_col*block_e, 0]) block(block_e, block_e, walls_t);
    }
  }
  block(nb_by_line*block_e+walls_t/2, block_e, walls_t);
}

module block(block_e, block_h, walls_t) {
  
  hole_e = block_e-walls_t/2;
  hole_h = 2*block_h;
  
  difference () {
    cube ([block_e, block_e, block_h], center = true);
    cube ([hole_e, hole_e, hole_h], center = true);
  }
}
