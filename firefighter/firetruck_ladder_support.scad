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
// Model for a fire truck cake support.
// Choose the name of the part you want to export to create
// the files to slice and print.
// ************************************************************

// Note that rendering is very slow due to high use of minkowski()
use <../common/ciy_cookie_cutter_base.scad>
use <../common/cutterize.scad>
use <../common/round_edges.scad>
use <../common/ciy_logo.scad>
use <../libs/recycling_symbol_library/recycling_symbol.scad>


scale([1/1,1/1,1/1]){

  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  // Choose here what you want to export:

  export = "doors_texture"; 

  // "preview" : not designed for printing, final view of the cake with its support
  // "rear_support" : rear half of the support of the firetruck cake
  // "front_support" : front half of the support of the firetruck cake
  // "ladder" : support of the ladder cake
  // "siren" : a piece to fit a Lego Duplo Siren reference #52189c02
  // "siren_top" : a piece to cover the Lego Duplo Siren when put in the siren piece
  // "wheel_cutter" : a cookie cutter to extract the wheels from your cake
  // "mudguard_cutter" : a cookie cutter to make the firetruck's mudguards
  // "windshield_cutter" : a cookie cutter to cut the windshield from fondant
  // "eyes_cutter"
  // "doors_cutter" : a cookie cutter to cut the doors from fondant
  // "doors_texture" : a stamp to apply a texture of roller shutters on your fondant
  // "ladder_support_cutter" : a cookie cutter to make room for the ladder support
  // "rounding_cutter"
  // "hose_support" : a support for a hose made of licorice rolls
  
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  //----------------------------------------------------------

  $fn = 1000;
  //$fn = 30; // debug

  margin = 0.4;
  
  cake_width=90;
  cake_depth=220;
  cake_height=70;
  rounding_radius = 20;
  
  plate_w = (cake_width-2*rounding_radius)*1.2;
  plate_d = (cake_depth-2*rounding_radius)/2;
  plate_t = 2; // plate thickness

  ladder_d = 200;
  ladder_angle = 15;
  ladder_pos = 0.75; // in percentage of the cake depth
  ladder_sup_w = (cake_width-2*rounding_radius)*0.5;
  ladder_sup_d = 15;

  wheel_r = cake_height*0.3;
  
  puzzle_d = cake_width/4;
  
  // dimensions of Lego Duplo Siren reference #52189c02
  siren_w = 63;
  siren_d = 16;
  siren_h = 25;

  // dimensions for the cutter set
  cutter_t = 0.4*3;
  cake_cutter_h = 30;
  fondant_cutter_h = 10;
  
    
  windshield_w = (cake_width-0*rounding_radius);
  windshield_h = cake_height*0.4;
  
  doors_big_h = cake_height-1.5*rounding_radius;
  doors_small_h = doors_big_h*0.7;
  doors_w = doors_big_h*2/3;
  

  //----------------------------------------------------------

  if (export == "ladder") {
    mirror ([0,0,1]) translate ([0,0,-plate_t])
    rotate ([ladder_angle, 0, 0]) translate ([0,0,-cake_height-(cake_depth*(-0.5+ladder_pos)+ladder_sup_d)*tan(ladder_angle)])
      ladder (cake_width, cake_depth, cake_height, rounding_radius, wheel_r, plate_t, margin, ladder_sup_w, ladder_sup_d, ladder_d, ladder_pos, ladder_angle);
  }
  else if (export == "rear_support") {
    mirror ([0,0,1]) translate ([0,0,-plate_t/2])
      rear_support (cake_depth, wheel_r, puzzle_d, plate_w, plate_d, plate_t, margin, ladder_sup_w, ladder_sup_d, ladder_pos);
  }
  else if (export == "front_support") {
    mirror ([0,0,1]) translate ([0,0,-plate_t/2])
      front_support (cake_depth, wheel_r, puzzle_d, plate_w, plate_d, plate_t, margin);
  }
  else if (export == "siren") {
    siren (siren_w, siren_d, siren_h, plate_t, margin) ;
  }
  else if (export == "siren_top") {
    siren_top (siren_w, siren_d, plate_t, margin) ;
  }
  else if (export == "ladder_support_cutter") {
    ladder_support_cutter (cake_height, wheel_r, cutter_t, ladder_sup_w, ladder_sup_d);
  }
  else if (export == "wheel_cutter") {
    wheel_cutter (wheel_r, cutter_t, cake_cutter_h);
  }
  else if (export == "mudguard_cutter") {
    mudguard_cutter (wheel_r, cutter_t, cake_cutter_h);
  }
  else if (export == "windshield_cutter") {
    windshield_cutter (windshield_w, windshield_h, cutter_t, fondant_cutter_h);
  }
  else if (export == "doors_cutter") {
    doors_cutter (doors_big_h, doors_w, cutter_t, fondant_cutter_h);
  }
  else if (export == "doors_texture") {
    doors_texture (doors_big_h, doors_w, cutter_t, plate_t);
  }
  else {
    $fn = 30;
    fire_truck_cake(cake_width, cake_depth, cake_height, rounding_radius, wheel_r, puzzle_d, plate_w, plate_d, plate_t, margin, ladder_sup_w, ladder_sup_d, ladder_d, ladder_pos, ladder_angle, siren_w, siren_d, siren_h, windshield_w, windshield_h, cutter_t, cake_cutter_h, fondant_cutter_h, doors_w, doors_big_h, doors_small_h);
  }

  
}


// ************************************************************
// * Submodules
// ************************************************************

// ************************************************************

module fire_truck_cake (
  cake_width, cake_depth, cake_height, rounding_radius, 
  wheel_r, puzzle_d, 
  plate_w, plate_d, plate_t, margin, 
  ladder_sup_w, ladder_sup_d, 
  ladder_d, ladder_pos, ladder_angle, 
  siren_w, siren_d, siren_h,
  windshield_w, windshield_h, 
  cutter_t, cake_cutter_h, fondant_cutter_h,
  doors_w, doors_big_h, doors_small_h) {

  // ---------------------------------------
  // cake (to cook)
  // ---------------------------------------
    
    // main cake
  color ("red") translate([0,0,cake_height/2]) round_all_3d (rounding_radius) cube([cake_width-2*rounding_radius,cake_depth-2*rounding_radius, cake_height-2*rounding_radius], center = true);
    // wheels cakes
  wheels_h = 15;
  color ("black") translate ([plate_w/2, cake_depth*(-0.5+0.7), 0]) rotate ([0,90,0]) cylinder (wheels_h, r=wheel_r);
  color ("black") translate ([-plate_w/2, cake_depth*(-0.5+0.7), 0]) mirror ([1,0,0]) rotate ([0,90,0]) cylinder (wheels_h, r=wheel_r);
  color ("black") translate ([plate_w/2, cake_depth*(-0.5+0.23), 0]) rotate ([0,90,0]) cylinder (wheels_h, r=wheel_r);
  color ("black") translate ([-plate_w/2, cake_depth*(-0.5+0.23), 0]) mirror ([1,0,0]) rotate ([0,90,0]) cylinder (wheels_h, r=wheel_r);
    // ladder cake
  color ("Gainsboro") translate ([-(cake_width-2*rounding_radius)*0.75/2, -ladder_d/2+10, cake_height+wheel_r+24]) rotate ([-ladder_angle, 0, 0]) cube ([(cake_width-2*rounding_radius)*0.75, ladder_d, 20]);
    // eyes
  color ("White") translate ([0, -cake_depth/2+4, cake_height*0.67]) rotate ([90,0,0]) hull () {
      translate ([-windshield_w/2+windshield_h/2, 0, 0]) cylinder (5, d= windshield_h);
      translate ([windshield_w/2-windshield_h/2, 0, 0]) cylinder (5, d= windshield_h);
  }  
  translate ([11, -cake_depth/2, cake_height*0.61]) rotate ([90,0,0]) {
    color ("Black") cylinder (5, d=10);
    translate ([-2.5,2,0.1]) color ("White") cylinder (5, d=2);
  }
  translate ([-11, -cake_depth/2, cake_height*0.61]) rotate ([90,0,0]) {
    color ("Black") cylinder (5, d=10);
    translate ([-2.5,2,0.1]) color ("White") cylinder (5, d=2);
  }  
    // nose
  color ("Gainsboro") translate ([0, -cake_depth/2, cake_height*0.4]) rotate ([0,45,0]) cube (5, center = true);
    // smile
  color ("White") translate ([0, -cake_depth/2+3, cake_height*0.3]) rotate ([90,0,0])  difference () {
    resize ([cake_width/4, 10, 5]) cylinder(1);
    resize ([cake_width/4-1, 10-6, 20]) cylinder(1, d= 1, center = true);
    translate([-cake_width/2, 0, -5]) cube([cake_width, 20, 20]);
  }
  
  // bumper
  color ("Gainsboro") translate ([0, -cake_depth/2+rounding_radius/2, 5]) 
    round_all_3d (rounding_radius/4) cube([cake_width-rounding_radius,10, 1], center = true);
  
  // decorations
  *color ("Gold") translate ([cake_width/2+fondant_t, -cake_depth/2+rounding_radius, cake_height/2-10]) rotate ([90, 0, 90]) cube ([cake_depth-2*rounding_radius, 5, fondant_t]);
  color ("Gold") translate ([-cake_width/2-fondant_t, -cake_depth/2+rounding_radius, cake_height/2-10]) rotate ([90, 0, 90]) cube ([cake_depth-2*rounding_radius, 5, fondant_t]);
  
  // doors
  fondant_t = 2;
  color ("Gold") translate ([cake_width/2, cake_depth*(-0.5+0.64), cake_height/2-doors_big_h/2+(doors_big_h-doors_small_h)]) rotate ([90, 0, 90]) cube ([doors_w, doors_small_h, fondant_t]);
  color ("Gold") translate ([cake_width/2, cake_depth*(-0.5+0.64)-doors_w-10, cake_height/2-doors_big_h/2]) rotate ([90, 0, 90]) cube ([doors_w, doors_big_h, fondant_t]);
  color ("Gold") translate ([cake_width/2, cake_depth*(-0.5+0.64)-doors_w-10-doors_w-4, cake_height/2-doors_big_h/2]) rotate ([90, 0, 90]) cube ([doors_w, doors_big_h, fondant_t]);
  
  
  // ---------------------------------------
  // pieces to print
  // ---------------------------------------
  
  // ladder
  color ("Gainsboro") ladder (cake_width, cake_depth, cake_height, rounding_radius, wheel_r, plate_t, margin, ladder_sup_w, ladder_sup_d, ladder_d, ladder_pos, ladder_angle);
  
  // rear support 
  color ("Snow", 0.8) rear_support (cake_depth, wheel_r, puzzle_d, plate_w, plate_d, plate_t, margin, ladder_sup_w, ladder_sup_d, ladder_pos);

  // front support
  color ("AntiqueWhite", 0.8) front_support (cake_depth, wheel_r, puzzle_d, plate_w, plate_d, plate_t, margin);

  // siren
  color ("Blue", 0.7) translate ([-(cake_width-rounding_radius)/2, -cake_depth/2+rounding_radius, cake_height-siren_h/2]) siren (siren_w, siren_d, siren_h, plate_t, margin);
  color ("Blue", 0.7) translate ([0, -cake_depth/2+rounding_radius, cake_height+siren_h*0.7]) rotate ([0,180,0]) siren_top (siren_w, siren_d, plate_t, margin) ;

  // wheel cutter
  color ("SlateBlue") translate ([plate_w, cake_depth*(-0.5+0.7), 0]) rotate ([0,90,0]) wheel_cutter (wheel_r, cutter_t, cake_cutter_h);
  
  // mudguard cutter
  color ("SlateBlue") translate ([plate_w/2+cake_cutter_h/2, cake_depth*(-0.5+0.23), 0]) rotate ([0,90,0]) mudguard_cutter (wheel_r, cutter_t, cake_cutter_h);
  
  // windshield_cutter
  *color ("SlateBlue") translate ([0, -cake_depth/2, cake_height*0.65]) rotate ([90,0,0]) windshield_cutter (windshield_w, windshield_h, cutter_t, fondant_cutter_h);
  
  // cutter for the hole for the ladder support
  color ("SlateBlue") translate ([-ladder_sup_w/2,cake_depth*(-0.5+ladder_pos),-(cake_height+10+wheel_r)-5]) ladder_support_cutter (cake_height, wheel_r, cutter_t, ladder_sup_w, ladder_sup_d);
  
  // cutter for the big doors
  color ("SlateBlue") translate ([plate_w/2+30, -7, 15-cutter_t]) rotate ([0,-90,0]) doors_cutter (doors_big_h, doors_w, cutter_t, fondant_cutter_h);
  
}

// ************************************************************

module ladder (cake_width, cake_depth, cake_height, rounding_radius, wheel_r, plate_t, margin, ladder_sup_w, ladder_sup_d, ladder_d, ladder_pos, ladder_angle) {
  
  logo_t = 0.5;
  ladder_w = (cake_width-2*rounding_radius)*0.75;
  
  // support
  translate ([-ladder_sup_w/2,cake_depth*(-0.5+ladder_pos),-wheel_r])
      cube([ladder_sup_w, ladder_sup_d, cake_height+wheel_r]);  
  translate ([-ladder_sup_w/2,cake_depth*(-0.5+ladder_pos),cake_height])
    difference () {
      cube([ladder_sup_w, ladder_sup_d, ladder_sup_d*tan(ladder_angle)]);
      translate ([-ladder_sup_w/2,0,ladder_sup_d*tan(ladder_angle)]) rotate ([-ladder_angle,0,0]) cube([2*ladder_sup_w, 2*ladder_sup_d, ladder_sup_d*tan(ladder_angle)]);
    }
  
  
  // ladder
  translate ([-ladder_w/2,cake_depth*(-0.5+ladder_pos),cake_height+ladder_sup_d*tan(ladder_angle)]) 
    rotate ([-ladder_angle, 0, 0]) translate ([0,-ladder_d*3/4,0]) 
    cube([ladder_w, ladder_d, plate_t]);


  // CIY logo
  translate ([2,cake_depth*(-0.5+ladder_pos)+ladder_sup_d/2,-wheel_r-logo_t]) ciy_logo(logo_size = 10, logo_height=logo_t, logo_orientation = 0);
    
  // recycling symbol
  translate ([0, cake_depth*(-0.5+ladder_pos)-ladder_sup_d/2+7, cake_height-10]) rotate ([-90,0,0]) recycling_symbol("PLA", 10, logo_t);

}

module ladder_support_cutter (cake_height, wheel_r, plate_t, ladder_sup_w, ladder_sup_d) {

  difference () {
    cube([ladder_sup_w, ladder_sup_d, cake_height+10]);  
    translate ([plate_t, plate_t, -(cake_height+10)/2]) cube([ladder_sup_w-2*plate_t, ladder_sup_d-2*plate_t, 2*(cake_height+10)]);  
  }
  
}

// ************************************************************

module rear_support (cake_depth, wheel_r, puzzle_d, plate_w, plate_d, plate_t, margin, ladder_sup_w, ladder_sup_d, ladder_pos) {

  wheels_pos = cake_depth*(-0.5+0.7);
  letters_height = 0.2;

  difference () {
    union () {
      // plate
      translate ([0,plate_d/2,0]) cube ([plate_w, plate_d, plate_t], center = true);
      
      // wheels
      translate ([plate_w/2, wheels_pos, 0]) wheel (wheel_r, plate_t);
      translate ([-plate_w/2, wheels_pos,  0]) mirror([1,0,0]) wheel (wheel_r, plate_t);
      
      // ladder support container
      translate ([0,0,-wheel_r]) 
        translate ([-ladder_sup_w/2-plate_t,cake_depth*(-0.5+ladder_pos)-plate_t,0])
        cube([ladder_sup_w+2*plate_t, ladder_sup_d+2*plate_t, wheel_r]);
      
      // puzzle pieces
      translate([-puzzle_d/2+margin,-puzzle_d/2+margin,-wheel_r]) cube ([puzzle_d-2*margin, puzzle_d-2*margin, wheel_r+plate_t]);

    }
    // hole for ladder support
    translate ([-ladder_sup_w/2-margin,cake_depth*(-0.5+ladder_pos)-margin,-wheel_r*3/2])
      cube([ladder_sup_w+2*margin, ladder_sup_d+2*margin, 2*wheel_r]);
    
    // cut the upper part of the wheels to ease printing
    translate ([-plate_w,-plate_d/2,plate_t/2]) cube ([2*plate_w, 2*plate_d, 2*wheel_r]);
    }
    
  // CIY logo
  translate ([0, plate_d*0.4, -plate_t/2-letters_height]) ciy_logo(logo_size = 15, logo_height=letters_height, logo_orientation = 0);
    
  // recycling symbol
  translate ([0, cake_depth*(-0.5+ladder_pos)-plate_t-letters_height, -10]) rotate ([-90,0,0]) recycling_symbol("PLA", 10, letters_height);
}

// ************************************************************

module front_support (cake_depth, wheel_r, puzzle_d, plate_w, plate_d, plate_t, margin) {

  wheels_pos = cake_depth*(-0.5+0.23);
  letters_height = 0.2;

  difference () {
    union () {
      // plate
      translate ([0,-plate_d/2, 0]) cube ([plate_w, plate_d, plate_t], center = true);
      
      // wheels
      translate ([plate_w/2, wheels_pos, 0]) wheel (wheel_r, plate_t);
      translate ([-plate_w/2, wheels_pos,  0]) mirror([1,0,0]) wheel (wheel_r, plate_t);

      // puzzle pieces
      translate([-puzzle_d/2-plate_t,-puzzle_d/2-plate_t,-wheel_r]) cube ([puzzle_d+2*plate_t, puzzle_d+2*plate_t, wheel_r+plate_t]);

    }
    // hole for the puzzle pieces
    translate([-puzzle_d/2,-puzzle_d/2,-wheel_r*3/2]) cube ([puzzle_d, puzzle_d, wheel_r*2]);
    
    // cut the upper part of the wheels to ease printing
    translate ([-plate_w,-plate_d*3/2,plate_t/2]) cube ([2*plate_w, 2*plate_d, 2*wheel_r]);
    }
    
  // CIY logo
  translate ([0, -plate_d*0.6, -plate_t/2-letters_height]) ciy_logo(logo_size = 15, logo_height=letters_height, logo_orientation = 0);
    
  // recycling symbol
  translate ([0, -plate_d*0.25, -plate_t/2-letters_height]) recycling_symbol("PLA", 15, letters_height);
}

// ************************************************************

module wheel (wheel_r, plate_t) {
  rotate ([0,90,0]) {
    cylinder(plate_t, r=wheel_r);
    cylinder (5*plate_t, d=plate_t);
    translate ([0,wheel_r/2,0]) cylinder (5*plate_t, d=plate_t);
    translate ([0,-wheel_r/2,0]) cylinder (5*plate_t, d=plate_t);
  }
}

module wheel_cutter (wheel_r, cutter_t, cutter_h) {
  difference () {
    cylinder(cutter_h, r=wheel_r+cutter_t, center = true);
    cylinder(2*cutter_h, r=wheel_r, center = true);
  }
}

module mudguard_cutter (wheel_r, cutter_t, cutter_h) {
  
  mudguard_space = 3;
  
  difference () {
    cylinder(cutter_h, r=wheel_r+mudguard_space, center = true);
    cylinder(2*cutter_h, r=wheel_r+mudguard_space-cutter_t, center = true);
  }  
} 

// ************************************************************

module siren (siren_w, siren_d, siren_h, plate_t, margin) {
  
  difference () {
    cube ([siren_w+2*(plate_t+margin), siren_d+2*(plate_t+margin), siren_h+2*(plate_t+margin)]);
    translate ([plate_t, plate_t, plate_t]) cube ([siren_w+2*margin, siren_d+2*margin, 2*siren_h]);
  }
}

module siren_top (siren_w, siren_d, plate_t, margin) {
  
  top_w = 30;
  top_d = siren_d+margin;
  
  translate ([-top_w/2, 0, 0]) cube ([top_w, top_d, plate_t]);
  translate ([-2.5, 0, 0]) cube ([5, top_d, 5+plate_t]);
  translate ([-top_w/2, 0, 0]) cube ([2, top_d, 6+plate_t]);
  translate ([top_w/2, 0, 0]) cube ([2, top_d, 6+plate_t]);
}

// ************************************************************
// Cookie Cutters for Decorations

module windshield_cutter (windshield_w, windshield_h, cutter_t, cutter_h) {
  
  cutterize_offset_round (cutter_t) hull () {
    translate ([-windshield_w/2+windshield_h/2, 0, 0]) cylinder (cutter_h, d= windshield_h);
    translate ([windshield_w/2-windshield_h/2, 0, 0]) cylinder (cutter_h, d= windshield_h);
  }
}

module doors_cutter (doors_h, doors_w, cutter_t, fondant_cutter_h) {

  
  difference () {
    cube ([doors_h+2*cutter_t, doors_w+2*cutter_t, fondant_cutter_h]);
    translate ([cutter_t, cutter_t, -fondant_cutter_h/2]) cube ([doors_h, doors_w, 2*fondant_cutter_h]);
  }
}

module doors_texture (doors_h, doors_w, cutter_t, plate_t) {
  
  plate_x = doors_h+2*cutter_t;
  plate_y = 2*doors_w+4*cutter_t;
  plate_z = plate_t/2;
  
  slice_w = 4;
  slice_d = 0.8;
  slice_h = 0.8;
  
  cube ([plate_x, plate_y, plate_z]);
  for (i = [0:doors_h/(slice_w+slice_d)]) {
    translate ([1.5+i*(slice_w+slice_d), 0, plate_z]) resize ([slice_d, plate_y, 2*slice_h]) rotate([0,45,0]) cube ([slice_d, plate_y, slice_d]);
  }
  
}

module eyes_cutter () {
}

// ************************************************************


// ************************************************************


// ************************************************************
