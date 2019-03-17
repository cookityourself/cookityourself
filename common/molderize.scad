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
// Generic functions to transform a 2D image file into a positive
// to make a mold of the same shape.
// ************************************************************


preview();

module preview () {
  file = "meeple.dxf";
  height = 40;
  chamfer = 2;
  radius = 5;
  steps = 20;

  module shape () {
     import(file);
  }

  color("blue") translate([-200,0,0]) molderize (height) shape ();
  color("red") translate([-200,-200,0]) molderize_n_chamfer (height, chamfer) shape ();
  molderize_n_fillet (height, radius, steps) shape ();
}


function filletDepth(radius, step_height, step) = radius * cos(asin(step_height * step / radius));

module molderize (height) {
  linear_extrude(height) children();
}

module molderize_n_chamfer (height, chamfer, steps) {
  linear_extrude(height-chamfer) children();
  d= chamfer/steps;
  for (i = [0:steps]) {
      x = -d * i;
      z = d * i;                  
      translate([0, 0, height-chamfer + z]) 
        linear_extrude(d) 
          offset(delta = x) children();
    //echo (i, x, z);
  }
}

module molderize_n_fillet (height, radius, steps) {

  linear_extrude(height-radius) children();
  d= radius/steps;
  for (i = [0:steps]) {
      x = filletDepth(radius, d, i);
      z = d * i;                  
      delta = -radius + x;
      translate([0, 0, height-radius + z]) 
        linear_extrude(d) 
          offset(delta = delta) children();
    //echo (i, d, x, z, delta);
  }
}