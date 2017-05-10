scale([1/1,1/1,1/1]){
    circular_basis();
}



module circular_basis(){
    
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
                    logo_ciy(logo_height=hollow_logo_height);
                }
            }
        }
    }

    // plain logo "CIY" on the inner face
    translate([0,logo_excentricity,0]){
        resize([0, logo_size ,0], auto=false){
            logo_ciy(logo_height=base_height+1);
        }
    }
}

module logo_ciy(logo_height) {
    linear_extrude(height= logo_height, center = false){
        translate([-3,0,0]){
            text("C", halign = "center", valign = "center", size = 4.5, $fn = 40);
        }
        translate([-0.1, -0.2,0]){
            rotate([0,0,-25]){
                text("i", halign = "center", valign = "center", size = 4.5);
            }
        }
        translate([2,0,0]){
            rotate([0,0,11]){
                text("Y", halign = "center", valign = "center", size = 5);
            }
        }
        translate([0.9,1.8,0]){
            circle(0.5,$fn=20);
        }
    }
}