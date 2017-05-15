scale([1/1,1/1,1/1]){
    ariane5_cutter();
}


module ariane5_cutter () {
    cutter_skin = 2;
    rocket_diameter = 20;
    rocket_height = 100;

    ariane5_shape (diameter = rocket_diameter, height = rocket_height);

}

module ariane5_shape (diameter = 20, height = 100) {
    // ariane 5 ECA : heigth = 55m, diameter = 5.4m

    // body
    body_width = diameter;
    body_height = height*0.7;
    square([body_width,body_height], center = true);
    
    // head
    head_height = diameter * 1.5;
    head_width = diameter;
    ogive_radius = head_width;

    translate([-ogive_radius/3, body_height/2,0])  {
        resize ([head_width, head_height]) {
            minkowski() {
                difference () {
                    intersection () {
                        circle(ogive_radius);
                        translate([ogive_radius, 0,0]) circle(ogive_radius);
                    }
                    translate([0, -ogive_radius, 0]) square(ogive_radius);
                    }
                circle (5);
            }
        }
    }

    
    // Chamber and engine
    chamber_base = diameter;
    chamber_height = chamber_base*2/3;
    engine_width = diameter/2;
    engine_height = diameter*2/3;
    
        // chamber
    translate([0, -body_height/2,0])  {
        polygon(points = [[-chamber_base/2, 0],[+chamber_base/2, 0],[0, -chamber_height]], paths = [[0,1,2]]);
    }
        // engine
    translate([0, -(body_height/2+chamber_height+engine_height*0.25),0])  {
        polygon(points = [[-engine_width/2, 0],[+engine_width/2, 0],[0, engine_height]], paths = [[0,1,2]]);
    }

    
    // reactors
    reactors_width = diameter/2;
    reactors_height = height*0.6;
    reactors_x_pos = body_width/2+reactors_width/2+2;
    reactors_y_pos = -(chamber_height*1.1);
    
        // reactors
    translate([-reactors_x_pos, reactors_y_pos,0])  reactor (width = reactors_width, height = reactors_height);
    translate([+reactors_x_pos, reactors_y_pos,0])  reactor (width = reactors_width, height = reactors_height);
        // connectors
    //square([body_width+reactors_width, height*0.2], center = true);
    translate([0, -height*0.1,0])  square([body_width+reactors_width, height*0.4], center = true);
    
}

module reactor (width, height) {
    square([width,height], center = true);
    //translate([0, height*0.6, 0]) resize ([width, width/4]) circle (width/2);
    translate([0, height*0.47, 0]) circle (width/2);
    // engine
    engine_width = width*0.6;
    engine_height = height*0.25;
    translate([0, -height*0.63,0]) polygon(points = [[-engine_width, 0],[+engine_width, 0],[0, engine_height]], paths = [[0,1,2]]);
}