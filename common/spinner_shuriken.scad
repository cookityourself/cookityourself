use <../common/round_edges.scad>


scale([1/1,1/1,1/1]){
  $fn = 100;
  //$fn = 30; // debug
  
  r_adult = 45;
  r_child = 35;
  
  spinner_shuriken(radius = r_child);

}

module spinner_shuriken (radius) {

  // ballbearing hole
  bbearing_d = 22;
  bbearing_h = 7;

  color ("blue") linear_extrude (bbearing_h) 
    difference (){
      circle (d=bbearing_d+2);
      circle (d=bbearing_d);
    }

  // attach
  //color ("green") 
    difference () {
      linear_extrude (bbearing_h) difference (){
        circle (d=bbearing_d+8);
        circle (d=bbearing_d+2);
      }
      cube_size = bbearing_h+bbearing_d;
      translate ([-cube_size/2,+6,-cube_size/2]) cube (cube_size, center = false);
      translate ([-cube_size/2,-cube_size-6,-cube_size/2]) cube (cube_size, center = false);
    }
    
  // branches
  shuriken_branch (radius, bbearing_h);
  rotate ([0,0,180]) shuriken_branch (radius, bbearing_h);

}

module shuriken_branch (radius, center_high) {
  
  difference () {
    translate ([0,0, center_high/2])
      resize ([2*radius, 0.7*2*radius, center_high]) sphere (radius);
    translate ([radius*0.4, 0, 0]) rotate ([0,0,-10])
      resize ([0.8*2*radius, 0.62*2*radius, 2*radius]) sphere (radius); 
    pink = radius/7;
    color ("pink") translate ([-radius*0.8,radius*0.25,center_high/2])
      resize ([2*pink, 2*pink, 2*pink]) sphere (pink);    
    color ("pink") translate ([-radius*0.55,-radius*0.43,center_high/2])
      resize ([2*pink, 2*pink, 2*pink]) sphere (pink);    
    red = 5;
//    #color ("red") translate ([-radius*0.25,-radius*0.35,center_high/2])
//    color ("red") translate ([-radius*0.25,-radius*0.3,center_high/2])
//      resize ([2*red, 2*red, 2*red]) sphere (red);    
    orange = 9;
    //color ("orange") translate ([-radius*0.4,-radius*0.55,center_high/2])
    color ("orange") translate ([-radius*0.19,-radius*0.37,center_high/2])
      resize ([2*orange, 2*orange, 2*orange]) sphere (orange);    
    grey = 20;
    color ("grey") translate ([-radius*0.15,-radius*0.9,center_high/2])
      resize ([2*grey, 2*grey, 2*grey]) sphere (grey);    
  }
}

module ninja_kanji () {
  
  
  
}