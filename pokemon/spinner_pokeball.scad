d_eurocent1 = 16.25;  // official diameter in mm
t_eurocent1 = 1.67;   // official thickness in mm
d_eurocent2 = 18.75;  // official diameter in mm
t_eurocent2 = 1.67;   // official thickness in mm
d_eurocent5 = 21.25;  // official diameter in mm
t_eurocent5 = 1.67;   // official thickness in mm
d_margin = 0.05; // margin to apply on diameter to allow insertion
  
module eurocent1 (h=t_eurocent1, d=d_eurocent1+d_margin, center = false) {
  eurocent(h,d,center);
}

module eurocent2 (h=t_eurocent2, d=d_eurocent2+d_margin, center = false) {
  eurocent(h,d,center);
}

module eurocent5 (h=t_eurocent5, d=d_eurocent5+d_margin, center = false) {
  eurocent(h,d,center);
}

module eurocent(h,d,center=false) {
  color ("Sienna") cylinder(h=h, d=d, center = center);
}

scale([1/1,1/1,1/1]){
  $fn = 100;
  //$fn = 30; // debug
  
  r_adult = 45;
  r_child = 35;
  export_r = r_child;
  
  bb_int_d = 8; // internal diameter of the ball bearing
  bb_ext_d = 22; // external diameter of the ball bearing in mm
  bb_support_dout = bb_ext_d+2; // external diameter of the ball bearing support
  bb_support_h = 15; // height of the ball bearing support
  
  weight_margin = 4; // margin between weigths in mm

  black_center_h = export_r*0.2;
  
  spinner_pokeball(export_r, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);

}

module spinner_pokeball (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  fil1 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  fil2 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
  
  //stub (radius, bb_ext_d, bb_support_dout, bb_support_h/2, black_center_h, weight_margin);
}

module fil1 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  difference () {
    fil1_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([0,0,-t_eurocent1]) weights (radius, bb_support_h, weight_margin);
  }

}

module fil1_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  // pokeball red part
  color ("red") difference () {
    pokeball(radius, bb_support_h+3, bb_support_dout/2);
    translate([-2*radius, -4*radius+black_center_h/2, -2*radius]) cube(4*radius);
  }

}


module fil2 (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  // ballbearing hole
  translate ([0,0,-bb_support_h/2]) color ("black") linear_extrude (bb_support_h) 
    difference (){
      circle (d=bb_support_dout);
      circle (d=bb_ext_d);
    }

  difference () {
    fil2_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    translate ([0,0,-t_eurocent1]) weights (radius, bb_support_h, weight_margin);
  }

}

module fil2_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {

  // ballbearing hole
  translate ([0,0,-bb_support_h/2]) color ("black") linear_extrude (bb_support_h) 
    difference (){
      circle (d=bb_support_dout);
      circle (d=bb_ext_d);
    }

  // pokeball black part
  difference () {
    color ("black") pokeball(radius-0.5, bb_support_h+1, bb_support_dout/2);
    translate([-2*radius, black_center_h/2, -2*radius]) cube(4*radius);
  }
  
  
  // pokeball white part
  color ("white") difference () {
    pokeball(radius, bb_support_h+3, bb_support_dout/2);
    translate([-2*radius, -black_center_h/2, -2*radius]) cube(4*radius);
  }
}


module stub (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin) {
  
  difference () {
    translate ([0,0,t_eurocent1]) weights (radius, bb_support_h, weight_margin);
    difference() {
      translate([-2*radius, -2*radius, 0]) cube(4*radius);
      fil1_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
      fil2_full (radius, bb_ext_d, bb_support_dout, bb_support_h, black_center_h, weight_margin);
    }
  }
  
}


module weights (radius, bb_support_h, weight_margin) {

  weight_r = radius-d_eurocent1/2-weight_margin; // radius of the circle of weigths
  weight_h = bb_support_h;
  periph = 2*PI*weight_r;
  nb_weight = floor(periph/(d_eurocent1+weight_margin)+1);
  
  for (weight_index = [1:nb_weight]) {
    x_pos = weight_r*cos(360/nb_weight*weight_index);
    y_pos = weight_r*sin(360/nb_weight*weight_index);
    translate ([x_pos, y_pos,0]) eurocent1 (h=weight_h);
  }
  
}

module pokeball (r_ball, h_ball, r_button) {
  difference () {
    scale([1,1,h_ball/r_ball/2]) sphere (r=r_ball, center = true);
    cylinder (h=2*h_ball, r=r_button, center=true);
  }
}

