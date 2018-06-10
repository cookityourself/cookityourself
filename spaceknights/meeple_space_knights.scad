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
use <../common/cutterize.scad>
use <../common/ciy_logo.scad>

scale([1,1,1]){
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "pressing_support_part1"; 

  // "all" : not designed for printing, final view of all the parts
  // "knight_right" : center and export the knights at the right
  // "knight_left" : export the knights at the left
  // "sabers" : export the crossing sabers
  // "pressing_support_part1" : export the bottom of the pressing support

  //----------------------------------------------------------
  
  $fn = 1000;
  //$fn = 30; // debug
  
  thickness = 2;
  mold_width = 10;
  pressing_h = 3;
  cut_offset = 300;
  
  knights_h = 10;
  saber_h = 4;
  margin = 0.15; // margin for assembly
  rounding_factor = 0.5;
  fillets_s = 20; // fillet steps (see library)
  scaling = 0.2;

//  knights_h = 40;
//  saber_h = 20;
//  margin = 0.15; // margin for assembly
//  rounding_factor = 0.2;
//  fillets_s = 20; // fillet steps (see library)
//  scaling = 0.8;

  pressing_height = pressing_h+thickness;
  knights_height = knights_h+thickness;
  saber_height = saber_h+thickness;

  //----------------------------------------------------------

  if (export == "knights") {
    knights_assembly(knights_height, saber_height, margin, rounding_factor, fillets_s);
  }
  else if (export == "knight_right") {
    scale([scaling,scaling,1]) {
      translate([-200,0,0])  union () {
        pressing_support_part2(pressing_height, mold_width, thickness, cut_offset) ;
        difference () {
          knights_assembly(knights_height, saber_height, margin, rounding_factor, fillets_s, mold_width);
          translate([0,-1,-1])cube(200, center = false);
        }
      }
    }
  }
  else if (export == "knight_left") {
    scale([scaling,scaling,1]){
      pressing_support_part3(pressing_height, mold_width, thickness, cut_offset) ;
      difference () {
        knights_assembly(knights_height, saber_height, margin, rounding_factor, fillets_s);
        translate([200,-1,-1]) cube(200, center = false);
      }
    }
  }
  else if (export == "sabers") {
    scale([scaling,scaling,1]){
      saber_left(saber_height, 0, saber_height*rounding_factor, fillets_s);
      saber_right(saber_height, 0, saber_height*rounding_factor, fillets_s);
      pressing_support_part0(pressing_height, mold_width, thickness, rounding_factor, fillets_s, cut_offset) ;
    }
  }
  else if (export == "saber_left") {
    saber_left(saber_height, 0, saber_height*rounding_factor, fillets_s);
  }
  else if (export == "saber_right") {
    saber_right(saber_height, 0, saber_height*rounding_factor, fillets_s);
  }
  else if (export == "saber") {
    saber ();
  }
  else if (export == "pressing_support") {
    pressing_support(pressing_height, mold_width, thickness);
  }
  else if (export == "pressing_support_part01") {
    pressing_support_part01(pressing_height, mold_width, thickness, cut_offset) ;
  }
  else if (export == "pressing_support_part0") {
    pressing_support_part0(pressing_height, mold_width, thickness, rounding_factor, fillets_s, cut_offset) ;
  }
  else if (export == "pressing_support_part1") {
    scale([scaling,scaling,1]){
      pressing_support_part1(pressing_height, mold_width, thickness, rounding_factor, fillets_s, cut_offset) ;
    }
  }
  else if (export == "pressing_support_part2") {
    pressing_support_part2(pressing_height, mold_width, thickness, cut_offset) ;
  }
  else if (export == "pressing_support_part3") {
    pressing_support_part3(pressing_height, mold_width, thickness, cut_offset) ;
  }
  else if (export == "pressing_support_all") {
    pressing_support_part0(pressing_height, mold_width, thickness, rounding_factor, fillets_s, cut_offset) ;
    pressing_support_part1(pressing_height, mold_width, thickness, rounding_factor, fillets_s, cut_offset) ;
    pressing_support_part2(pressing_height, mold_width, thickness, cut_offset) ;
    pressing_support_part3(pressing_height, mold_width, thickness, cut_offset) ;
  }  
  else if (export == "one_piece") {
    margin = 0; // margin for assembly
    knights_assembly(knights_height, saber_height, margin, rounding_factor, fillets_s);
    saber_left(saber_height, 0, saber_height*rounding_factor, fillets_s);
    saber_right(saber_height, 0, saber_height*rounding_factor, fillets_s);
  }  
  else if (export == "all") {
    // knight right
    scale([scaling,scaling,1]) {
      translate([0,0,0])  union () {
        pressing_support_part2(pressing_height, mold_width, thickness, cut_offset) ;
        difference () {
          knights_assembly(knights_height, saber_height, margin, rounding_factor, fillets_s, mold_width);
          translate([0,-1,-1])cube(200, center = false);
        }
      }
    }
    // knight left
    scale([scaling,scaling,1]){
      pressing_support_part3(pressing_height, mold_width, thickness, cut_offset) ;
      difference () {
        knights_assembly(knights_height, saber_height, margin, rounding_factor, fillets_s);
        translate([200,-1,-1]) cube(200, center = false);
      }
    }
    // sabers
    scale([scaling,scaling,1]){
      saber_left(saber_height, 0, saber_height*rounding_factor, fillets_s);
      saber_right(saber_height, 0, saber_height*rounding_factor, fillets_s);
      pressing_support_part0(pressing_height, mold_width, thickness, rounding_factor, fillets_s, cut_offset) ;
    }    
    // support part 1
    scale([scaling,scaling,1]){
    pressing_support_part1(pressing_height, mold_width, thickness, rounding_factor, fillets_s, cut_offset) ;    
    }
  }  
  else {
    $fn = 30;
    pressing_support_part1(pressing_height, mold_width, thickness, rounding_factor, fillets_s) ;
    knights_assembly(knights_height, saber_height, margin, rounding_factor, fillets_s);
    saber_left(saber_height, 0, saber_height*rounding_factor, fillets_s);
    saber_right(saber_height, 0, saber_height*rounding_factor, fillets_s);
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

module knights (knights_height = 40, rounding = 2, fillets_s = 10, mold_width = 20){
  module shape () {
    import ("meeple_space_knights_characters.dxf");
  }
  molderize_n_fillet(height =knights_height, radius=rounding, steps=fillets_s) shape (); 
}

module knights_assembly (knights_height = 40, saber_height = 20, margin = 0, rounding_factor = 0.1, fillets_s = 10, mold_width = 20){
  difference () {
    knights(knights_height, knights_height*rounding_factor, fillets_s, mold_width);
    saber_left(saber_height+margin, margin, saber_height*rounding_factor, fillets_s);
    saber_right(saber_height+margin, margin, saber_height*rounding_factor, fillets_s);
  }
}

module pressing_support(pressing_height, mold_width, thickness) {
  module shape () {
    import ("meeple_space_knights_characters.dxf");
    import ("meeple_space_knights_saber_left.dxf");
    import ("meeple_space_knights_saber_right.dxf");  
}
  difference () {
    union () {
      color("linen") linear_extrude(thickness) offset (r = mold_width) hull() shape (); 
      color("linen") cutterize_3d_fillet(height =pressing_height, thickness=thickness) offset (r = mold_width) hull() shape (); 
    }
 }
}

module pressing_support_part01 (pressing_height, mold_width, thickness, cut_offset) {
  difference () {
    pressing_support (pressing_height, mold_width, thickness);
    translate ([0,0,-pressing_height]) union (){
      knights_assembly(pressing_height*4, pressing_height*4, 0, 0, 0);
      translate([cut_offset,-100,-1]) cube(400, center = false);
      translate([-cut_offset,-100,-1]) cube(400, center = false);
    }
  }
}

module pressing_support_part0 (pressing_height, mold_width, thickness, rounding_factor, fillets_s, cut_offset) {
  text_depth = pressing_height-thickness+0.3;
  difference () {
    pressing_support_part01 (pressing_height, mold_width, thickness, cut_offset);
    translate([0,-315,-1]) cube(400, center = false);
    translate([200,210,text_depth]) 
      color("teal") mirror([0,0,1]) 
        molderize_n_fillet(height =pressing_height, radius=pressing_height*0.8, steps=fillets_s) 
          mirror([1,0,0]) text("Happy 40", halign = "center", valign = "center", size = 15, font = "Cantarell:style=Bold");
    translate([200,190,text_depth]) 
      color("teal") mirror([0,0,1]) 
        molderize_n_fillet(height =pressing_height, radius=pressing_height*0.8, steps=fillets_s) 
          mirror([1,0,0]) text("Adrien", halign = "center", valign = "center", size = 15, font = "Cantarell:style=Bold");
    translate ([0,0,-pressing_height]) union (){
    }
  }
}

module pressing_support_part1 (pressing_height, mold_width, thickness, rounding_factor, fillets_s, cut_offset) {
  text_depth = pressing_height-thickness+0.3;
  difference () {
    pressing_support_part01 (pressing_height, mold_width, thickness, cut_offset);
    translate([0,85,-1]) cube(400, center = false);
    translate([200,20,text_depth]) 
      color("teal") mirror([0,0,1]) 
        molderize_n_fillet(height =pressing_height, radius=pressing_height*0.8, steps=fillets_s) 
          mirror([1,0,0]) ciy_logo_2d(logo_size = 20, logo_orientation = 0);
    translate([200,60,text_depth]) 
      color("teal") mirror([0,0,1]) 
        molderize_n_fillet(height =pressing_height, radius=pressing_height*0.8, steps=fillets_s) 
          mirror([1,0,0]) text("200°C max", halign = "center", valign = "center", size = 10, font = "Cantarell:style=Bold");
    translate([200,45,text_depth]) 
      color("teal") mirror([0,0,1]) 
        molderize_n_fillet(height =pressing_height, radius=pressing_height*0.8, steps=fillets_s) 
          mirror([1,0,0]) text("silicone", halign = "center", valign = "center", size = 10, font = "Cantarell:style=Bold"); 
    translate ([0,0,-pressing_height]) union (){
    }
  }
}

module pressing_support_part2 (pressing_height, mold_width, thickness, cut_offset) {
  difference () {
    pressing_support (pressing_height, mold_width, thickness);
    translate ([0,0,-pressing_height]) union (){
      scale([1,1,10]) pressing_support_part01 (pressing_height, mold_width, thickness, cut_offset);
      translate([-cut_offset,-100,-1]) cube(400, center = false);
      translate([-160,150,-100]) cube(400, center = false);
      difference () {
       knights_assembly(pressing_height*4, pressing_height*4, 0, 0, 0);
        translate([200,-100,-1]) cube(400, center = false);
      }
    }
  }
}

module pressing_support_part3 (pressing_height, mold_width, thickness, cut_offset) {
  difference () {
    pressing_support (pressing_height, mold_width, thickness);
    translate ([0,0,-pressing_height]) union (){
      scale([1,1,10]) pressing_support_part01 (pressing_height, mold_width, thickness, cut_offset);
      translate([cut_offset,-100,-1]) cube(400, center = false);
      translate([160,150,-100]) cube(400, center = false);
      difference () {
       knights_assembly(pressing_height*4, pressing_height*4, 0, 0, 0);
        translate([-200,-100,-1]) cube(400, center = false);
      }
    }
  }
}

