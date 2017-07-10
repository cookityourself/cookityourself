

scale([1/1,1/1,1/1]){
  $fn = 100;
  //$fn = 30; // debug

  plate_d = 160;
  plate_h = 5; // thick plate for a heavy basis

  pot_h = 70;
  
  water_h = 1.5*pot_h;
  water_tube_h = 50;
  
  plate_tube_h = water_h-plate_h;
  tube_d = 10;  // compromise between aesthetic and strength
  tube_t = 2;
  
  wcan_t = 5;
  wcan_nose_d = 50;
  wcan_nose_angle = 30;
  wcan_low_d = 38;
  wcan_low_h = 15;
  wcan_high_d = 65;
  wcan_high_h = 48;

  tower_h = water_h + wcan_high_h;
  tower_d = tube_d; // compromise between aesthetic and strength
  
//  watering_can_cake_support(plate_d, plate_h, pot_h, water_h, tube_d, plate_tube_h, tube_t,
//    wcan_t, wcan_nose_d, wcan_nose_angle, wcan_low_d, wcan_low_h, 
//    wcan_high_d, wcan_high_h, water_tube_h, tower_d, tower_h);
  
  // debug and export
  //plate (plate_d, plate_h, tube_d, plate_tube_h);
  //tube_stop (tube_t, tube_d);
  translate ([0,0,-1.5]) mirror ([0,0,1]) rotate ([0,30,0]) water (water_h, wcan_nose_d, wcan_nose_angle, wcan_t, tube_d-tube_t, water_tube_h, tube_t, water_tube_h/2);

}

module watering_can_cake_support (plate_d, plate_h, pot_h, water_h, tube_d, plate_tube_h,tube_t, wcan_t, wcan_nose_d, wcan_nose_angle, wcan_low_d, wcan_low_h, 
    wcan_high_d, wcan_high_h, water_tube_h, tower_d, tower_h) {


  // plate
  //plate (plate_d, plate_h, tube_d, plate_tube_h, tube_t);
  
  // water
  water_tube_d = tube_d-tube_t;
  translate ([0,0,water_h]) water (water_h, wcan_nose_d, wcan_nose_angle, wcan_t,  water_tube_d, water_tube_h, tube_t, water_tube_h/2);

  // watering can support
        //color ("MediumBlue") cylinder (tube_up_h, d=tube_d, center = false);
  color ("grey") translate ([-wcan_low_d/2,0,water_h+wcan_low_h]) 
    scale ([1,0.5,1]) cylinder (wcan_t, d=wcan_low_d, center = true);
  color ("grey") translate ([-wcan_high_d*0.4,0,tower_h]) 
    cylinder (wcan_t, d=wcan_high_d, center = true);

//  // debug pot cake
//  #color ("brown") translate ([0,0,plate_h]) cylinder (60, d=120, center = false);
//  
//  // debug watering can cake
//  #color ("red") translate ([-30,0,160]) rotate ([0,60,0]) cylinder (60, d=80, center = true);
//  #color ("red") translate ([0,0,118]) rotate ([0,-30,0]) cylinder (25, d1=wcan_nose_d, d2 = 0, center = true);
//  #color ("red") translate ([-7,0,119]) rotate ([0,-30,0]) cylinder (20, d1=20, d2 = 40, center = true);


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


module water (water_h, wcan_nose_d, wcan_nose_angle, wcan_t, tube_d, tube_h, tube_t, tube_stop_h) {
  
    drops_r = 3;
    drops_h = 50;
    drops_circle_r = wcan_nose_d*0.75 *sin(wcan_nose_angle) ;
    drops_num = 3;
    drops_random = [14,15,11,
                    13,20,23,30,17,27,
                    16,19,29,23,24,25,13,10,14];
  
  difference () {
    union () {
    // watering can nose
    color ("purple") translate ([wcan_nose_d*0.15,0,0]) rotate ([0,-wcan_nose_angle,0]) 
      cylinder (wcan_t, d=wcan_nose_d, center = true);

    difference () {
      union () {
        // tube for support
        translate ([0,0,-tube_h/2]) color ("blue") cylinder (tube_h, d=tube_d, center = true);
        // water drops
        difference () {
          // drops
          translate ([8, 0, 0]) 
            water_drops (drops_r, drops_h, drops_circle_r, drops_num, drops_random, wcan_nose_angle);
          // space for the plate tube in which the water tube should fit:
          translate ([0,0,-tube_h/2]) color ("grey") cylinder (tube_h*10, d=tube_d+tube_t, center = true);
        }
      }
      // piece to cut the part of the tube that goes higher than the nose, to be able to print the nose flat
      translate ([wcan_nose_d*0.15,0,0]) rotate ([0,-wcan_nose_angle,0]) 
        cylinder (100, d=wcan_nose_d, center = false);
      }
    }
    // hole to create a tube for assembling parts
    color ("blue") cylinder (tube_h*10, d=tube_d-tube_t, center = true);
  }
  
  // stop for the next inner tube
  translate ([0,0,-tube_stop_h]) tube_stop (tube_t, tube_d-tube_t);
}

module water_drops (drops_r, drops_h, drops_circle_r, drops_num, drops_random, wcan_nose_angle) {

  for (drop_circle = [1:3]) {
    drops_circle_radius = drops_circle_r * drop_circle/3;
    drops_number = drops_num*drop_circle;
    for (drop_index = [1:drops_number]) {
      //r = drop_circle == 1 ? drop_index/drops_number : 0;
      //g = drop_circle == 2 ? drop_index/drops_number : 0;
      //b = drop_circle == 3 ? drop_index/drops_number : 0;
      drops_random_index = drop_circle == 1 ? drop_index-1 : drop_circle == 2 ? 3+drop_index-1 : 9+drop_index-1;
      //echo (drop_index, drops_random_index, drops_random[drops_random_index])
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

module tube_stop (tube_t, tube_d) {
  difference () {
    color ("Magenta") cylinder (tube_t, d=tube_d, center = true);
    ratio = 3;
    translate ([0,0,tube_t-0.1]) color ("Magenta") cylinder (ratio*tube_t, d1=tube_d, d2=0, center = true);
    translate ([0,0,-tube_t+0.1]) color ("Magenta") cylinder (ratio*tube_t, d1=0, d2=tube_d, center = true);
  }
}