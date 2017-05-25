use <ciy_logo.scad>
use <../libs/recycling_symbol_library/recycling_symbol.scad>

scale([1/1,1/1,1/1]){
    circular_basis(
        base_radius = 30,
        base_x_scale = 1.2,
        logo_size = 5,
        plain_logo_angle_degree = 180,
        recycling_type = "PLA", 
        recycling_angle_degree=45,
        hollow_logo = true
    );
}



module circular_basis(base_height = 2, base_radius = 30, base_x_scale = 1, base_y_scale = 1, logo_size = 5, plain_logo_angle_degree = 90, logo_from_edge = 1, recycling_type = "", recycling_angle_degree = 0, recycling_from_edge = 0, hollow_logo = true, hollow_logo_angle_degree = -90){
    
    
    
    letters_height = base_height+0.5;
    logo_excentricity = base_y_scale*base_radius-logo_size/2-logo_from_edge;
    
    min_hlogo_size = 8; // minimum size of the hollow logo required for correct printing
    min_rlogo_size = 9; // minimum size of the recycling logo required for correct printing

    hollow_logo_size = logo_size < min_hlogo_size? min_hlogo_size:logo_size;
    recycling_logo_size = logo_size < min_rlogo_size? min_rlogo_size:logo_size;
    
    difference (){
        // base
        linear_extrude(height= base_height){
            scale ([base_x_scale, base_y_scale, 0]) circle(base_radius, $fn = 180);
        }
        
        if (hollow_logo) {
            // hollow logo "CIY" on the external face
            mirror ([180,0,0]){
                hollow_logo_height = base_height*2+2;
                hollow_logo_excentricity = base_y_scale*base_radius-hollow_logo_size/2-logo_from_edge;

    // debug:   translate([0,0,-hollow_logo_height/2]){
                translate([hollow_logo_excentricity*cos(hollow_logo_angle_degree),hollow_logo_excentricity*sin(hollow_logo_angle_degree),-hollow_logo_height/2]){
                ciy_logo(logo_size = hollow_logo_size, logo_height=hollow_logo_height);
                }
            }
        }
    }

    // plain logo "CIY" on the inner face
    translate([logo_excentricity*cos(plain_logo_angle_degree),logo_excentricity*sin(plain_logo_angle_degree),0]){
        rotate ([0, 0, -6])
        ciy_logo(logo_size = logo_size, logo_height=letters_height);
    }
    
    // plain recycling logo
    echo ("Recycling type is ",recycling_type);
    if (recycling_type == "") {}
    else {
        recycling_logo_x = base_x_scale*base_radius-recycling_logo_size/2-recycling_from_edge;
        recycling_logo_y = base_y_scale*base_radius-recycling_logo_size/2-recycling_from_edge;        recycling_symbol(recycling_type, recycling_logo_size, letters_height, [recycling_logo_x*cos(recycling_angle_degree),recycling_logo_y*sin(recycling_angle_degree),0]);
    }
}

