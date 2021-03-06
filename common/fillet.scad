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
// Generic functions to transform a 2D image file into a 3D
// extruded shape with fillets
// ************************************************************

// Preview
extrude_n_fillet_both(20, 5, 10) circle(10);

function filletDepth(radius, step_height, step) = radius * cos(asin(step_height * step / radius));


module extrude_n_fillet_top (height, radius, steps) {

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

module extrude_n_fillet_both (height, radius, steps) {

  d= radius/steps;
  for (i = [0:steps]) {
      x = filletDepth(radius, d, steps-i);
      z = d * i;                  
      delta = -radius + x;
      translate([0, 0, z]) 
        linear_extrude(d) 
          offset(delta = delta) children();
    //echo (i, d, x, z, delta);
  }
  translate([0, 0, radius])  linear_extrude(height-2*radius) children();
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