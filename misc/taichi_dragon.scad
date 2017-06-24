
use <../common/ciy_cookie_cutter_base.scad>
use <../common/round_edges.scad>


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
  
  // arms
  arm_l = width;
  arm_t = width/5;
  translate ([width*0.08,height-head_radius*0.8,0])
  round_all (3) rotate ([0,0, 10])
    resize ([arm_l, arm_l/2]) comma (arm_l, arm_t);

  // legs
  leg_l = width;
  leg_t = width/10;
  translate ([width*0.3,-height*0.18,0])
  round_all (5) rotate ([0,0, -33]) mirror ([0,1])
    resize ([leg_l, leg_l*0.6]) comma (leg_l, leg_t);
  
  // belly
  belly_radius = width*0.13;
  translate ([0, height/2-belly_radius*0.5, 0]) 
    circle (belly_radius, center = true);
  
  
}

module comma (l, t) {
  difference () {
    circle (l, center = true);
    translate ([t, t,0])
      circle (l, center = true);
  }
}