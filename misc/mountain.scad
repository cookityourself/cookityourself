// Note that rendering is very slow due to high use of minkowski()

use <../common/ciy_cookie_cutter_base.scad>
use <../common/cutterize.scad>
use <../common/round_edges.scad>


scale([1/1,1/1,1/1]){
  $fn = 30;
  
  mountains_cutter();

}

module mountains_cutter (cutter_height = 15, cutter_skin = 1.5, shape_height = 40, shape_width = 80) {


  base_height = 2;
  cutter_position_x = 0;
  cutter_position_y = -14;
  
  translate ([cutter_position_x, cutter_position_y, cutter_skin/2])
    cutterize_offset_round (cutter_skin/2) 
      linear_extrude (cutter_height-base_height) 
        mountains_shape(height = shape_height, width = shape_width);        
  translate ([cutter_position_x, cutter_position_y, 0])
    inset_shell_round (thickness = cutter_skin/2)
      linear_extrude (cutter_height-base_height+cutter_skin) 
        mountains_shape(height = shape_height, width = shape_width);


  difference () {
    circular_basis(
      base_height = 2,
      base_radius = 28,
      base_x_scale = 1.2, 
      base_y_scale = 0.9,
      logo_size = 6,
      plain_logo_angle_degree = -90,
      logo_from_edge = 1, 
      recycling_type = "PLA",
      recycling_angle_degree = 132,
      recycling_from_edge = 0.5,
      hollow_logo = false
    );
    translate ([cutter_position_x, cutter_position_y, -5]) 
      linear_extrude (10) 
        mountains_shape(height = shape_height, width = shape_width);
  }

}

module mountains_shape (height = 40, width = 80) {
  
  resize ([width, height, 0]) union () {
    translate ([-55, 0, 0])
      round_all (5) 
        polygon(points =[[-20, 0],[30, 0],[0, 20]]);     
    translate ([-40, 5, 0])
      round_all (10) 
        polygon(points =[[-20, 0],[30, 0],[0, 20]]); 
    translate ([-15, 10, 0])
      round_all (10) 
        polygon(points =[[-30, 0],[15, 0],[0, 20]]);     
    translate ([-13, 5, 0])
      round_all (10) 
        polygon(points =[[-25, 0],[20, 0],[0, 30]]); 
    translate ([0, 0, 0])
      round_all (5) 
        polygon(points =[[-40, 0],[50, 0],[0, 60]]); 
    translate ([7, 0, 0])
      round_all (5) 
        polygon(points =[[-40, 0],[40, 0],[0, 55]]); 
    translate ([40, -1, 0])
      round_all (4) 
        polygon(points =[[-50, 0],[30, 0],[0, 50]]);   
    translate ([51, 0, 0])
      round_all (5) 
        polygon(points =[[-10, 0],[15, 0],[0, 35]]);     

    rotate ([0, 0, -4]) translate ([22, 38, 0]) 
      round_all (3)
        difference () {
          square (15, 15, center = true);
          translate ([0, 10, 0]) circle (7, center = true);
        }
  }
  
}