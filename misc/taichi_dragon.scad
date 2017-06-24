
use <../common/ciy_cookie_cutter_base.scad>

scale([1/1,1/1,1/1]){
  $fn = 30;
  
  taichi_dragon_cutter();

}

module taichi_dragon_cutter (cutter_height = 15, cutter_skin = 1.2, width = 80, height = 70) {
  
  
  cutter_position_x = 0;
  cutter_position_y = 0;
  
  translate ([cutter_position_x, cutter_position_y, 0])
    //linear_extrude (cutter_height) {
      taichi_dragon_shape (width, height);
    //}
    
//  difference () {
//    rotate ([0, 0, 45])
//      circular_basis(
//          base_radius = width*0.3,
//          base_x_scale = 1.2, 
//          base_y_scale = 1,
//          logo_size = 7,
//          plain_logo_angle_degree = 145,
//          logo_from_edge = 1, 
//          recycling_type = "PLA",
//          recycling_angle_degree = 40,
//          recycling_from_edge = 1,
//          hollow_logo = false
//      );
//    translate ([cutter_position_x, cutter_position_y, -5]) 
//        linear_extrude (10) square(width, center = false); 
//  }

}

module taichi_dragon_shape (width, height) {
  
  // head
  head_radius = width/6;
  translate ([0, height-head_radius, 0]) 
    circle (head_radius, center = true);
  
  // left arm
  left_arm_l = width/4; // left arm length
  left_arm_t = left_arm_l/2.5;// left arm thickness scale factor
  translate ([-left_arm_l,height-head_radius,0])
    mirror([0,1,0]) rotate([0,0,-105]) scale ([1.2,1.1])
      difference () {
        circle (left_arm_l, center = true);
        translate ([left_arm_t, left_arm_t,0])
          circle (left_arm_l, center = true);
      }
  
  // right arm
  right_arm_l = width/1.4; // right arm length
  right_arm_t = width*0.16;// right arm thickness scale factor
  translate ([right_arm_l/2.4,height-2*head_radius-right_arm_t/2,0])
    rotate ([0,0,-11])
      resize([right_arm_l, right_arm_t]) 
        circle (1, center = true);
  
  // left leg
  left_leg_l = width/4; // left leg length
  left_leg_t = left_leg_l/1.5;// left leg thickness scale factor
  translate ([-left_leg_l/2,left_leg_l/2.3,0])
    //mirror([0,1,0]) rotate([0,0,0]) scale ([1.4,1.2])    
      difference () {
      circle (left_leg_l, center = true);
      translate ([left_leg_t, -left_leg_t*0.5,0])
        circle (left_leg_l, center = true);
    }
  
  // right leg
//  right_leg_l = width*0.75; // right leg length
//  right_leg_t = right_leg_l/6;// right leg thickness scale factor
//  translate ([right_leg_l/3,right_leg_t,0])
//    rotate ([0,0,-30])
//      resize([right_leg_l, right_leg_t]) 
//        circle (1, center = true);

  right_leg_l = width*0.45; // right leg length
  right_leg_t = right_leg_l*0.35;// right leg thickness scale factor
  translate ([right_leg_l*0.9,right_leg_l*0.2,0])
    rotate ([0,0,-30])
      difference () {
        resize ([right_leg_l*2, right_leg_l/2]) 
          circle (right_leg_l, center = true);
        translate ([right_leg_t, -right_leg_t,0])
          resize ([right_leg_l*2, right_leg_l/2]) 
            circle (right_leg_l, center = true);
    }
  
  // belly
  belly_radius = width*0.13;
  translate ([0, height/2-belly_radius/3, 0]) 
    circle (belly_radius, center = true);
  
  
}