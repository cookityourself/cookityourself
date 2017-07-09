

scale([1/1,1/1,1/1]){
  $fn = 100;
  //$fn = 30; // debug
  
  watering_can_cake_support();

}

module watering_can_cake_support (plate_d = 160) {

  plate_h = 5; // thick plate for a heavy basis
  pot_h = 70;
  
  water_h = 1.5*pot_h;
  
  wcan_t = 5;
  wcan_nose_d = 50;
  wcan_nose_angle = 30;
  wcan_low_d = 38;
  wcan_low_h = 15;
  wcan_high_d = 65;
  wcan_high_h = 48;

  tower_h = water_h + wcan_high_h;
  tower_d = 10; // compromise between aesthetic and strength

  // plate
  cylinder (plate_h, d=plate_d, center = true);
  color("orange") translate ([0,0,plate_h]) difference () {
    cylinder (plate_h, d=plate_d, center = true);
    cylinder (plate_h+10, d=plate_d-2, center = true);
  }
  
  // water
  color ("blue") cylinder (tower_h, d=tower_d, center = false);
  color ("purple") translate ([wcan_nose_d*0.15,0,water_h]) rotate ([0,-wcan_nose_angle,0]) 
    cylinder (wcan_t, d=wcan_nose_d, center = true);

  // watering can support
  color ("grey") translate ([-wcan_low_d/2,0,water_h+wcan_low_h]) 
    scale ([1,0.5,1]) cylinder (wcan_t, d=wcan_low_d, center = true);
  color ("grey") translate ([-wcan_high_d*0.4,0,tower_h]) 
    cylinder (wcan_t, d=wcan_high_d, center = true);

  // water drops
  drops_r = 3;
  drops_h = 50;
  drops_num = 3;
  drops_random = [0,3,0,
                  10,7,0,15,5,18,
                  15,7,3,1,4,2,13,10,30];
  difference () {
    translate ([8, 0, pot_h-2])
      for (drop_circle = [1:3]) {
        drops_circle_radius = wcan_nose_d*0.75 *sin(wcan_nose_angle) * drop_circle/3;
        drops_number = drops_num*drop_circle;
        for (drop_index = [1:drops_number]) {
          r = drop_circle == 1 ? drop_index/drops_number : 0;
          g = drop_circle == 2 ? drop_index/drops_number : 0;
          b = drop_circle == 3 ? drop_index/drops_number : 0;
          drops_random_index = drop_circle == 1 ? drop_index-1 : drop_circle == 2 ? 3+drop_index-1 : 9+drop_index-1;
          //echo (drop_index, drops_random_index, drops_random[drops_random_index])
          translate ([
            drops_circle_radius*cos(360/drops_number*drop_index),
            drops_circle_radius*sin(360/drops_number*drop_index),
            drops_random[drops_random_index]]) 
             //color([r,g,b]) 
              water_drop (drops_r, drops_h-drops_random[drops_random_index]);
        }
      }
    translate ([wcan_nose_d*0.15,0,water_h]) rotate ([0,-wcan_nose_angle,0]) 
      cylinder (100, d=wcan_nose_d, center = false);
    translate ([-50,-50,water_h+wcan_nose_d/2*sin(wcan_nose_angle)]) cube (100);
  }

  // debug pot cake
  #color ("brown") translate ([0,0,plate_h]) cylinder (60, d=120, center = false);
  
  // debug watering can cake
  #color ("red") translate ([-30,0,160]) rotate ([0,60,0]) cylinder (60, d=80, center = true);
  #color ("red") translate ([0,0,118]) rotate ([0,-30,0]) cylinder (25, d1=wcan_nose_d, d2 = 0, center = true);
  #color ("red") translate ([-7,0,119]) rotate ([0,-30,0]) cylinder (20, d1=20, d2 = 40, center = true);


}

module water_drop (radius, height) {
//  color ("blue") cylinder (height, r=radius, center = false);
  color ("LightBlue") cylinder (height, r1=radius, r2=radius*0.4, center = false);
  translate ([0,0,0]) color ("LightBlue") sphere (radius, center = false);
}