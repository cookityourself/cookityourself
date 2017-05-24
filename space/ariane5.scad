// Note that rendering is very slow due to high use of minkowski()

use <../common/ciy_cookie_cutter_base.scad>
use <../common/cutterize.scad>
use <../common/round_edges.scad>



scale([1/1,1/1,1/1]){
    $fn = 30;
    
    ariane5_cutter();

}


module ariane5_cutter (cutter_height = 15, cutter_skin = 1, rocket_diameter = 20, rocket_height = 100*0.8) {
    
    base_height = 2;
    cutter_position_x = 0;
    cutter_position_y = 0;
    
    translate ([cutter_position_x, cutter_position_y, cutter_skin/2])
        cutterize_offset_round (cutter_skin/2) 
            linear_extrude (cutter_height-base_height) 
                ariane5_shape (diameter = rocket_diameter, height = rocket_height);        
    translate ([cutter_position_x, cutter_position_y, 0])
        inset_shell_round (thickness = cutter_skin/2)
            linear_extrude (cutter_height-base_height+cutter_skin) 
                ariane5_shape (diameter = rocket_diameter, height = rocket_height);

    difference () {
        circular_basis(
            base_height = 2,
            base_radius = 28,
            base_x_scale = 1.2, 
            base_y_scale = 0.8,
            logo_size = 5,
            plain_logo_angle_degree = 180,
            logo_from_edge = -7, 
            recycling_type = "PLA",
            recycling_angle_degree = 15,
            recycling_from_edge = 1,
            hollow_logo = false
        );
        translate ([cutter_position_x, cutter_position_y, -5]) 
            linear_extrude (10) ariane5_shape (diameter = rocket_diameter, height = rocket_height);
    }


}

module ariane5_shape (diameter = 20, height = 100) {
  // ariane 5 ECA : heigth = 55m, diameter = 5.4m

  // body
  body_width = diameter;
  body_height = height*0.6;
  square([body_width,body_height], center = true);
  
  // head
  head_height = diameter * 1.5;
  head_width = diameter;
  ogive_radius = head_width;
  rounding_radius = diameter/4;

  translate([-head_width/3, body_height/2,0])  {
    resize ([head_width, head_height]) {
      minkowski() {
        difference () {
          intersection () {
            circle(ogive_radius);
            translate([ogive_radius, 0,0]) circle(ogive_radius);
          }
          translate([0, -ogive_radius, 0]) square(ogive_radius);
          }
        circle (rounding_radius);
      }
    }
  }

  
  // Chamber and engine
  chamber_base = diameter;
  chamber_height = chamber_base*0.5;
  engine_width = diameter*0.4;
  engine_height = diameter*0.5;
  engine_rr = engine_width*0.1;
  
      // chamber
  translate([0, -body_height/2,0]) 
    polygon(points = [[-chamber_base/2, 0],[+chamber_base/2, 0],[0, -chamber_height]], paths = [[0,1,2]]);
      // engine
  translate([0, -(body_height/2+chamber_height+engine_height*0.25),0])  
    round_all(engine_rr) 
      polygon(points = [[-engine_width/2, 0],[+engine_width/2, 0],[0, engine_height]], paths = [[0,1,2]]);

  
  // reactors
  reactors_width = diameter*0.6;
  reactors_height = height*0.6;
  reactors_x_pos = body_width/2+reactors_width/2;
  reactors_y_pos = -(chamber_height*1.2);
  
      // reactors
  translate([-reactors_x_pos, reactors_y_pos,0])  reactor (width = reactors_width, height = reactors_height);
  translate([+reactors_x_pos, reactors_y_pos,0])  mirror () reactor (width = reactors_width, height = reactors_height);
  
      // connectors
  translate([0, -body_height*0.05, 0])  square([body_width+reactors_width, body_height*0.95], center = true);
  //translate([0, 0, 0])  scale ([1, 1.1]) circle(d=body_width+2*reactors_width, center = true);
  
}

module reactor (width, height) {
  // reactor body
  reactor_body_rr = width*0.1;
  round_all(reactor_body_rr) 
    square([width-2*reactor_body_rr,height-reactor_body_rr], center = true);
  
  // reactor head
  translate([0, height/2, 0]) {
    circle_radius = width/8*1.3;
    hull () {
      polygon (points = [[-width/2, 0], [width/2, width], [width/2, 0]]);
      translate ([width/2-circle_radius, width, 0]) circle (circle_radius, center = true);
    }
  }
  
  // engine
  engine_width = width*0.4;
  engine_height = height*0.25;
  engine_rounding_radius = engine_width/4;
  translate([0, -height*0.63,0]) 
    round_all(engine_rounding_radius) 
      polygon(points = [[-engine_width+engine_rounding_radius, 0],[+engine_width-engine_rounding_radius, 0],[0, engine_height-engine_rounding_radius]], paths = [[0,1,2]]);
}

