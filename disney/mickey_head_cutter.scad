use <../common/ciy_cookie_cutter_base.scad>

scale([1/1,1/1,1/1]){
    mickey_head_cutter(
        cutter_height = 25, 
        head_radius = 23, 
        ear_radius = 14, 
        skin = 1, 
        ear_extentricity_correction = 2
    );
}


module mickey_head_cutter (cutter_height, head_radius, ear_radius, skin, ear_extentricity_correction) {
    $fn = 60;
    
    cutter_position_x = 0;
    cutter_position_y = -4;
    
    translate ([cutter_position_x, cutter_position_y, 0])
        linear_extrude (cutter_height) {
            difference () {
                mickey_head_shape(head_radius, ear_radius, 0, ear_extentricity_correction);
                mickey_head_shape(head_radius, ear_radius, skin, ear_extentricity_correction);
            }
        }
    difference () {
        circular_basis(
            base_radius = 28,
            base_x_scale = 1.2, 
            base_y_scale = 1,
            logo_size = 6,
            logo_from_edge = 2, 
            recycling_type = "PLA",
            recycling_angle_degree = -2,
            recycling_from_edge = 2,
            hollow_logo = false
        );
        translate ([cutter_position_x, cutter_position_y, -5]) 
            linear_extrude (10) mickey_head_shape(head_radius, ear_radius, 0, ear_extentricity_correction);
    }
}

module mickey_head_shape (head_radius = 20, ear_radius = 12, skin = 0, ear_extentricity_correction = 0) {    
    // head
    circle(head_radius-skin, center = true);
    
    // ears
    translate ([-head_radius+ear_extentricity_correction, head_radius-ear_extentricity_correction, 0]) circle (ear_radius-skin, center = true);
    translate ([head_radius-ear_extentricity_correction, head_radius-ear_extentricity_correction, 0]) circle (ear_radius-skin, center = true);
    
    
 }

