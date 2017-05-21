use <ciy_logo.scad>
use <../libs/recycling_symbol_library/recycling_symbol.scad>

scale([1/1,1/1,1/1]){
    circular_basis(
        base_radius = 30,
        logo_size = 5,
        recycling_type = "PLA", 
        recycling_angle_degree=45
    );
}



module circular_basis(base_radius = 30, logo_size = 5, recycling_type = "", recycling_angle_degree = 0){
    
    base_height = 2;
    
    letters_height = base_height+1;
    logo_excentricity = base_radius-logo_size/2-1;
    
    min_hlogo_size = 8; // minimum size of the hollow logo required for correct printing
    min_rlogo_size = 12; // minimum size of the recycling logo required for correct printing

    hollow_logo_size = logo_size < min_hlogo_size? min_hlogo_size:logo_size;
    recycling_logo_size = logo_size < min_rlogo_size? min_rlogo_size:logo_size;
    
    difference (){
        // base
        linear_extrude(height= base_height){
            circle(base_radius, $fn = 180);
        }
        
        // hollow logo "CIY" on the external face
        mirror ([180,0,0]){
            hollow_logo_height = base_height*2+2;
            hollow_logo_excentricity = base_radius-hollow_logo_size/2-1;

// debug:   translate([0,0,-hollow_logo_height/2]){
            translate([0,-hollow_logo_excentricity,-hollow_logo_height/2]){
            ciy_logo(logo_size = hollow_logo_size, logo_height=hollow_logo_height);
            }
        }
    }

    // plain logo "CIY" on the inner face
    translate([0,logo_excentricity,0]){
        rotate ([0, 0, -6])
        ciy_logo(logo_size = logo_size, logo_height=base_height+1);
    }
    
    // plain recycling logo
    echo ("Recycling type is ",recycling_type);
    if (recycling_type == "") {}
    else {
        recycling_logo_excentricity = base_radius-recycling_logo_size/2-1;
        recycling_symbol(recycling_type, recycling_logo_size, base_height+1, [recycling_logo_excentricity*cos(recycling_angle_degree),recycling_logo_excentricity*sin(recycling_angle_degree),0]);
    }
}

