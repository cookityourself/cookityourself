use <ciy_logo.scad>
use <../libs/recycling_symbol_library/recycling_symbol.scad>

scale([1/1,1/1,1/1]){
    circular_basis(recycling_type = "PLA", recycling_angle_degree=45);
}



module circular_basis(recycling_type = "PLA", recycling_angle_degree = 0){
    
    base_height = 2;
    base_radius = 30;
    
    letters_height = base_height+1;
    logo_size = 5;
    logo_excentricity = base_radius-logo_size+1;
    
    difference (){
        // base
        linear_extrude(height= base_height){
            circle(base_radius, $fn = 180);
        }
        
        // hollow logo "CIY" on the external face
        mirror ([180,0,0]){
            hollow_logo_height = base_height*2+2;
            translate([0,-logo_excentricity,-hollow_logo_height/2]){
// debug:           translate([0,0,-hollow_logo_height/2]){
                resize([0, logo_size ,0], auto=false){
                    ciy_logo(logo_height=hollow_logo_height);
                }
            }
        }
    }

    // plain logo "CIY" on the inner face
    translate([0,logo_excentricity,0]){
        resize([0, logo_size ,0], auto=false){
            ciy_logo(logo_height=base_height+1);
        }
    }
    
    // plain recycling logo
    recycling_symbol("PLA", logo_size, base_height+1, [logo_excentricity*cos(recycling_angle_degree),logo_excentricity*sin(recycling_angle_degree),0]);
}

