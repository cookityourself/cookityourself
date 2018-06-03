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
// Choose the name of the part you want to export to create
// the files to slice and print.
// ************************************************************

file = "meeple.dxf";
height = 40;
chamfer = 2;
radius = 2;
steps = 1;

color("blue") translate([-200,0,0]) molderize (file, height);
//color("red") translate([-200,-200,0]) molderize_n_chamfer (file, height, chamfer);
molderize_n_fillet (file, height, radius, steps);


function filletDepth(radius, step_height, step) = radius * cos(asin(step_height * step / radius));

module molderize (file, height) {
  linear_extrude(height) import(file);
}

//module molderize_n_chamfer (file, height, chamfer) {
//  linear_extrude(height, scale = 0.5) import(file);
//}

module molderize_n_fillet (file, height, radius, steps) {
  linear_extrude(height-radius) import(file);
  d= radius/steps;
  
    for (i = [0:steps]) {
        x = filletDepth(radius, d, i);
        z = d * (i + 1);                  
        translate([0, 0, height-radius + z]) 
          linear_extrude(d) 
            offset(delta = -radius + x) import(file);
    }
  
}