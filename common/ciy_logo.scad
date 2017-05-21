ciy_logo(logo_size = 10, logo_height = 5);

module ciy_logo(logo_size = 5, logo_height) {
    scale ([logo_size/5, logo_size/5 , 1]) {
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
            translate([1,1.9,0]){
                circle(0.6,$fn=20);
            }
        }
    }
}