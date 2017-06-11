
use <../common/ciy_cookie_cutter_base.scad>
use <../common/cutterize.scad>


scale([1/1,1/1,1/1]){
  $fn = 30;
  
  tangram_cutter();

}

module tangram_cutter (cutter_height = 15, cutter_skin = 1, width = 100) {

  cutter_position_x = -width*0.195;
  cutter_position_y = -width*(1-0.195);
  
  translate ([cutter_position_x, cutter_position_y, 0])
    linear_extrude (cutter_height) {
      tangram_shape (width, cutter_skin);
    }
    
  difference () {
    rotate ([0, 0, 45])
      circular_basis(
          base_radius = width*0.3,
          base_x_scale = 1.2, 
          base_y_scale = 1,
          logo_size = 6,
          plain_logo_angle_degree = 145,
          logo_from_edge = 1.5, 
          recycling_type = "PLA",
          recycling_angle_degree = 40,
          recycling_from_edge = 1,
          hollow_logo = false
      );
    translate ([cutter_position_x, cutter_position_y, -5]) 
        linear_extrude (10) square(width, center = false); 
  }

}

module tangram_shape (width = 60, wall = 1) {
  
  od = wall*sqrt(2);  // offset in a diagonal
  ol = wall;  // offset in a line horizontal or vertical

  difference () {
    square(width, center = false); 
    union () {
      color ("blue") polygon(points =[[ol+od/2, width-ol],[width-ol-od/2, width-ol],[width/2, width/2+od/2]]);
      color ("grey") polygon(points =[[ol, ol+od/2],[ol, width-ol-od/2],[width/2-od/2, width/2]]);
      //polygon(points =[[od+od/2, od],[width-od-od/2, od],[width/2, width/2-od/2]]);
      color ("orange") polygon(points =[[ol+od/2, ol],[width/2-od, ol],[width/4, width/4-od/2]]);
      color ("purple") polygon(points =[[width/2, ol],[width/4+od/2, width/4],[width/2, width/2-od/2],[3*width/4-od/2, width/4]]);
      color ("black") polygon(points =[[width/2+od, ol],[width-ol, ol],[width-ol, width/2-ol-od/2]]);
      color ("yellow") polygon(points =[[width/2+od/2, width/2],[3*width/4, width/4+od/2],[3*width/4, 3*width/4-od/2]]);
      color ("pink") polygon(points =[[3*width/4+ol, width/4+ol+od/2],[3*width/4+ol, 3*width/4], [width-ol, width-ol-od/2],[width-ol, width/2-ol+od/2]]);
    }
  }
  // debug
  //translate ([0, width/2]) color ("red") square ([2*width, 2], center = false);
  //translate ([width/2, 0]) color ("green") square ([2,2*width], center = false);
  
}