use <../common/ciy_cookie_cutter_base.scad>

scale([1/1,1/1,1/1]){
    mickey_head_cutter();
}


module mickey_head_cutter (cutter_height = 25, head_radius = 20, ear_radius = 13, skin = 1.5) {
    $fn = 60;
    linear_extrude (cutter_height) {
        difference () {
            mickey_head_shape(head_radius, ear_radius, 0);
            mickey_head_shape(head_radius, ear_radius, skin);
        }
    }
    difference () {
        circular_basis(recycling_type = "PLA", recycling_angle_degree = 0);
        translate ([0, 0, -5]) linear_extrude (10) mickey_head_shape(head_radius, ear_radius, 0);
    }
}

module mickey_head_shape (head_radius = 20, ear_radius = 12, skin = 0) {    
    // head
    circle(head_radius-skin, center = true);
    
    // ears
    translate ([-head_radius, head_radius, 0]) circle (ear_radius-skin, center = true);
    translate ([head_radius, head_radius, 0]) circle (ear_radius-skin, center = true);
    
    
 }

