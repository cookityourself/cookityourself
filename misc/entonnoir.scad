$fn=100; 
wallThickness=0.8;
tubeRadius=2.4;
tube_height = 20;
coneRadius = 20;
cone_height = 35;
cone_z_pos = tube_height-3;

difference(){
  union () {
    scale ([1, 1.5, 1]) cylinder(tube_height,tubeRadius,tubeRadius);
    translate([0,0,cone_z_pos]){
      difference(){
        cylinder(cone_height,tubeRadius,coneRadius);
      }
    }  
  }
  scale ([1, 1.5, 1]) translate([0,0,-tube_height/2])cylinder(tube_height*2,tubeRadius-wallThickness,tubeRadius-wallThickness);
  translate([0,0,cone_z_pos])cylinder(cone_height,tubeRadius-wallThickness,coneRadius-wallThickness);
  translate([0,0,cone_z_pos+cone_height-0.05]) cylinder (cone_height, r=coneRadius-wallThickness);
}

