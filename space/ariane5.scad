scale([1/1,1/1,1/1]){
    ariane5_cutter();
}


module ariane5_cutter () {
    cutter_skin = 2;
    rocket_diameter = 20;

    ariane5_shape (rocket_diameter = rocket_diameter);

}

module ariane5_shape (rocket_diameter = 20) {
    // ariane 5 ECA : heigth = 55m, diameter = 5.4m

    // body
    body_width = rocket_diameter;
    body_height = 70;
    square([body_width,body_height], center = true);
    
    // head
    head_height = rocket_diameter * 1.5;
    head_width = rocket_diameter;
    ogive_radius = head_width;

    translate([-ogive_radius/2, body_height/2,0])  {
        resize ([head_width, head_height]) {
            difference () {
                intersection () {
                    circle(ogive_radius);
                    translate([ogive_radius, 0,0]) circle(ogive_radius);
            }
                translate([0, -ogive_radius, 0]) square(ogive_radius);
            }
        }
    }

    
    // engine
    //polygon();

}
