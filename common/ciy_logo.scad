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
// Module for the CIY (Cook It Yourself) logo
// ************************************************************


ciy_logo(logo_size = 10, logo_height = 5, logo_orientation = 10);
translate([10,10,0])color("green")ciy_logo_2d(logo_size = 10, logo_orientation = 10);

module ciy_logo_2d(logo_size = 5, logo_orientation = 0) {
  rotate ([0, 0, logo_orientation])
    scale ([logo_size/5, logo_size/5 , 1]) {
          translate([-3.5,0,0]){
                text("C", halign = "center", valign = "center", size = 4.5, $fn = 40, font = "Cantarell:style=Bold");
            }
            translate([-0.3, -0.2,0]){
                rotate([0,0,-25]){
                    text("i", halign = "center", valign = "center", size = 4.6, font = "Cantarell:style=Bold");
                }
            }
            translate([2,0,0]){
                rotate([0,0,12]){
                    text("Y", halign = "center", valign = "center", size = 5, font = "Cantarell:style=Bold");
                }
            }
            translate([1,2.2,0]){
                circle(0.8,$fn=20);
            }
    }
}

module ciy_logo(logo_size = 5, logo_height, logo_orientation = 0) {
  linear_extrude(height= logo_height, center = false){
    ciy_logo_2d(logo_size = logo_size, logo_orientation = logo_orientation) ;  
  }
}
