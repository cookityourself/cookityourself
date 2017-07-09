

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
  color ("blue") translate ([wcan_nose_d*0.15,0,water_h]) rotate ([0,-30,0]) 
    cylinder (wcan_t, d=wcan_nose_d, center = true);

  // watering can support
  color ("grey") translate ([-wcan_low_d/2,0,water_h+wcan_low_h]) 
    scale ([1,0.5,1]) cylinder (wcan_t, d=wcan_low_d, center = true);
  color ("grey") translate ([-wcan_high_d*0.4,0,tower_h]) 
    cylinder (wcan_t, d=wcan_high_d, center = true);

  // debug pot cake
  #color ("brown") translate ([0,0,plate_h]) cylinder (60, d=120, center = false);
  
  // debug watering can cake
  #color ("red") translate ([-30,0,160]) rotate ([0,60,0]) cylinder (60, d=80, center = true);
  #color ("red") translate ([0,0,118]) rotate ([0,-30,0]) cylinder (25, d1=wcan_nose_d, d2 = 0, center = true);
  #color ("red") translate ([-5,0,120]) rotate ([0,-30,0]) cylinder (20, d1=20, d2 = 45, center = true);


}