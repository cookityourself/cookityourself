// ************************************************************
// * This model is gracefully offered by cookityourself
// * Feel free to do what you want with it
// * Please just add a link to our github if you use some of
// * our code in your own creations
// ************************************************************
// Model for a support to make a Gravity Cake in the form of 
// a plant pot and its watering cake.
// Choose "preview = true" to see the support parts together 
// and what your cake could look like.
// Choose "preview = false" and the name of the part you want
// to export for slicing.
// ************************************************************

scale([1,1,1]){
  $fn = 100;
  //$fn = 30; // debug

  preview = true; // true for preview, false for export
  export = ""; // can be either "plate" / "wcan_nose" / "wcan_low" / "wcan_high"

  plate_d = 160;
  plate_h = 5; // thick plate for a heavy basis

  pot_h = 70;
  
  water_h = 1.5*pot_h;
  
  plate_tube_h = water_h-plate_h;
  tube_d = 12;  // compromise between aesthetic and strength
  tube_t = 3;
  tube_margin_d = 0.6;
  
  wcan_t = 2;
  wcan_nose_d = 50;
  water_tube_h = 40;
//  wcan_t = 2;
//  wcan_nose_d = 20;
  //water_tube_h = 15;
  wcan_nose_angle = 30;
  
  wcan_low_d = 50;
  wcan_low_h = 25;
  
  wcan_high_d = 85;
  wcan_high_h = 58;
  
  wcan_low_tube_d = tube_d-tube_t-tube_margin_d-tube_t-tube_margin_d;
  wcan_low_tube_l = (wcan_low_h+water_tube_h/2) + (wcan_high_h-wcan_low_h);
  wcan_low_tube_h = (wcan_low_h+water_tube_h/2);    
  
  wcan_high_tube_d = wcan_low_tube_d+tube_t+tube_margin_d;
  wcan_high_tube_l = wcan_high_h-wcan_low_h;

  if (preview) {
    watering_can_cake_support(plate_d, plate_h, pot_h, water_h, tube_d, plate_tube_h, tube_t, tube_margin_d,
      wcan_t, wcan_nose_d, water_tube_h, wcan_nose_angle, wcan_low_d, wcan_low_h, wcan_low_tube_d, wcan_low_tube_l, wcan_low_tube_h, 
      wcan_high_d, wcan_high_h, wcan_high_tube_d, wcan_high_tube_l);
  }
  else {
    if (export == "plate") {
      // export plate and its tube
      plate (plate_d, plate_h, tube_d, plate_tube_h);
    }
    else if (export == "wcan_nose") {
      // export watering can nose and its water drops
      translate ([0,0,-1.5]) mirror ([0,0,1]) rotate ([0,30,0]) water (water_h, wcan_nose_d, wcan_nose_angle, wcan_t, tube_d-tube_t, water_tube_h, tube_t, tube_margin_d, water_tube_h/2);
    }
    else if (export == "wcan_low") {
      // export for the watering can low support
      translate ([0,0,wcan_low_d/2+wcan_low_tube_d/2]) rotate ([90,90,0]) watering_can_support_low (wcan_t, wcan_low_d, wcan_low_tube_d, wcan_low_tube_l, wcan_low_tube_h);
    }
    else if (export == "wcan_high") {
      translate ([0,0,wcan_t/2]) rotate ([180,0,0])    watering_can_support_high (wcan_t, wcan_high_d, wcan_high_tube_d, wcan_high_tube_l, tube_t);
    }
    else {
      cylinder (wcan_low_tube_l/4, d=wcan_low_tube_d);
      translate ([0,0,wcan_low_tube_l/4]) difference () {
        cylinder (wcan_low_tube_l/2, d=wcan_low_tube_d+tube_t+tube_margin_d);
        translate ([0,0,tube_t]) cylinder (wcan_low_tube_l, d=wcan_low_tube_d+tube_margin_d);
      }
    }
  }
  
  // debug 
    // test for the watering can low support
//   translate ([0,0,20/2+wcan_low_tube_d/2]) rotate ([90,90,0]) watering_can_support_low (wcan_t, 20, wcan_low_tube_d, 25, 10);

  // new plate tube  
//  cylinder(10, d=10-2-0.2);
//  translate ([0,0,10]) difference() {
//    cylinder(plate_tube_h-10, d=tube_d);
//    #translate ([0,0,plate_tube_h-10-water_tube_h-10])cylinder(plate_tube_h, d=tube_d-tube_t);
//  }

}

module watering_can_cake_support (plate_d, plate_h, pot_h, water_h, tube_d, plate_tube_h,tube_t, tube_margin_d, wcan_t, wcan_nose_d, water_tube_h, wcan_nose_angle, wcan_low_d, wcan_low_h, wcan_low_tube_d, wcan_low_tube_l, wcan_low_tube_h,  
    wcan_high_d, wcan_high_h, wcan_high_tube_d, wcan_high_tube_l) {


  // plate
  plate (plate_d, plate_h, tube_d, plate_tube_h, tube_t);
  
  // water
  water_tube_d = tube_d-tube_t;
  translate ([0,0,water_h+wcan_t]) water (water_h, wcan_nose_d, wcan_nose_angle, wcan_t,  water_tube_d, water_tube_h, tube_t, tube_margin_d, water_tube_h/2);

  // watering can low support
  color ("grey") translate ([-wcan_low_d/2,0,water_h+wcan_low_h])
    watering_can_support_low (wcan_t, wcan_low_d, wcan_low_tube_d, wcan_low_tube_l, wcan_low_tube_h);

  // watering can high support
  color ("green") translate ([-wcan_high_d*0.4+wcan_high_tube_d*0.8,0, water_h+wcan_high_h]) 
    watering_can_support_high (wcan_t, wcan_high_d, wcan_high_tube_d, wcan_high_tube_l, tube_t);

  union () {
  // preview of the pot cake
  #color ("brown") translate ([0,0,plate_h]) cylinder (65, d=127, center = false);
  
  // preview of the watering can cake
  #color ("red") translate ([-31,0,170]) rotate ([0,60,0]) cylinder (76, d=102, center = true);
  #color ("red") translate ([1,0,118]) rotate ([0,-30,0]) cylinder (25, d1=wcan_nose_d, d2 = 0, center = true);
  #color ("red") translate ([-7,0,119]) rotate ([0,-30,0]) cylinder (20, d1=20, d2 = 40, center = true);
  }
}


module plate (plate_d, plate_h, tube_d, tube_h, tube_t) {
  difference () {
    union () {
      // base
      cylinder (plate_h, d=plate_d, center = true);
      color("orange") translate ([0,0,plate_h]) difference () {
        cylinder (plate_h, d=plate_d, center = true);
        cylinder (plate_h*2, d=plate_d-2, center = true);
      }
    // tube
      color ("gold") cylinder (tube_h, d=tube_d, center = false);
    }
    color ("gold") cylinder (tube_h*3, d=(tube_d-tube_t), center = true);
  }
}


module water (water_h, wcan_nose_d, wcan_nose_angle, wcan_t, tube_d, tube_h, tube_t,tube_margin_d, tube_stop_h) {
  
  drops_r = 3;
  drops_h = 68;
  drops_circle_r = wcan_nose_d*0.75 *sin(wcan_nose_angle) ;
  drops_num = 3;
//  drops_h = 30;
//  drops_circle_r = wcan_nose_d*0.1 *sin(wcan_nose_angle) ;
//  drops_num = 1;

  drops_random = [14,15,11,
                  13,20,23,30,17,27,
                  16,19,29,23,24,25,13,20,33];
  
  tube_outer_d = tube_d-tube_margin_d;
  tube_inner_d = tube_d-tube_margin_d-tube_t;
  
  
  difference () {
    union () {
    // watering can nose
    color ("purple") translate ([wcan_nose_d*0.15,0,0]) rotate ([0,-wcan_nose_angle,0]) 
      cylinder (wcan_t, d=wcan_nose_d, center = true);

    difference () {
      union () {
        // tube for support
        translate ([0,0,-tube_h/2]) color ("blue") cylinder (tube_h, d=tube_outer_d, center = true);
        // water drops
        difference () {
          // drops
//          translate ([8, 0, 0]) 
          translate ([8, 0, 20]) 
            water_drops (drops_r, drops_h, drops_circle_r, drops_num, drops_random, wcan_nose_angle);
          // space for the plate tube in which the water tube should fit:
          translate ([0,0,-tube_h/2]) color ("grey") cylinder (tube_h*10, d=tube_d+tube_t, center = true);
        }
      }
      // piece to cut the part of the tube that goes higher than the nose, to be able to print the nose flat
      translate ([wcan_nose_d*0.15,0,0]) rotate ([0,-wcan_nose_angle,0]) 
        cylinder (100, d=wcan_nose_d*2, center = false);
      }
    }
    // hole to create a tube for assembling parts
    color ("blue") cylinder (tube_h*10, d=tube_inner_d, center = true);
  }
  
  // stop for the next inner tube
  translate ([0,0,-tube_h]) cylinder (tube_h-tube_stop_h, d=tube_inner_d, center = false);
}

module water_drops (drops_r, drops_h, drops_circle_r, drops_num, drops_random, wcan_nose_angle) {

  for (drop_circle = [1:3]) {
    drops_circle_radius = drops_circle_r * drop_circle/3;
    drops_number = drops_num*drop_circle;
    for (drop_index = [1:drops_number]) {
      // colors to help debug
      //r = drop_circle == 1 ? drop_index/drops_number : 0;
      //g = drop_circle == 2 ? drop_index/drops_number : 0;
      //b = drop_circle == 3 ? drop_index/drops_number : 0;
      drops_random_index = drop_circle == 1 ? drop_index-1 : drop_circle == 2 ? drops_num+drop_index-1 : (1+2)*drops_num+drop_index-1;
      drop_x = drops_circle_radius*cos(360/drops_number*drop_index);
      drop_y = drops_circle_radius*sin(360/drops_number*drop_index);
      drop_z = -drops_h
        +drops_circle_radius*cos(360/drops_number*drop_index)*tan(wcan_nose_angle)
        +drops_random[drops_random_index];
      translate ([drop_x,drop_y,drop_z]) 
         //color([r,g,b]) 
          water_drop (drops_r, drops_h-drops_random[drops_random_index]);
    }
  }

}

module water_drop (radius, height) {
  color ("LightBlue") cylinder (height, r1=radius, r2=radius*0.4, center = false);
  color ("LightBlue") sphere (radius, center = false);
}

module watering_can_support_low (wcan_t, wcan_low_d, wcan_low_tube_d, wcan_low_tube_l, wcan_low_tube_h) {
  cylinder (wcan_t, d=wcan_low_d, center = true);
  translate ([wcan_low_d/2,0,-wcan_low_tube_h]) cylinder (wcan_low_tube_l, d = wcan_low_tube_d, center = false);
}

module watering_can_support_high (wcan_t, wcan_high_d, wcan_high_tube_d, wcan_high_tube_l, wcan_high_tube_t) {
  excentricity = wcan_high_d*0.4-wcan_high_tube_d*0.8;
  difference () {
    union () {
      cylinder (wcan_t, d=wcan_high_d, center = true);
      translate ([excentricity,0,-wcan_high_tube_l])
        cylinder (wcan_high_tube_l, d = wcan_high_tube_d, center = false);  
    }
    translate ([excentricity,0,-2*wcan_high_tube_l]) cylinder (4*wcan_high_tube_l, d = wcan_high_tube_d-wcan_high_tube_t, center = false);
  }
}

