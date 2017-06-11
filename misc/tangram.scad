
use <../common/ciy_cookie_cutter_base.scad>
use <../common/cutterize.scad>


scale([1/1,1/1,1/1]){
  $fn = 30;
  
  tangram_cutter(
    cutter_height = 15, 
    cutter_skin = 1, 
    width = 60
  );

}

module tangram_cutter (cutter_height = 15, cutter_skin = 1, width = 60) {

  tangram_shape (width, cutter_skin);
}

module tangram_shape (width = 60, wall = 1) {
  
  od = wall*sqrt(2);  // offset in a diagonal
  ol = wall;  // offset in a line horizontal or vertical

  difference () {
    square(width, center = false); 
    union () {
      color ("blue") polygon(points =[[od+od/2, width-od],[width-od-od/2, width-od],[width/2, width/2+od/2]]);
      color ("grey") polygon(points =[[od, od+od/2],[od, width-od-od/2],[width/2-od/2, width/2]]);
      //polygon(points =[[od+od/2, od],[width-od-od/2, od],[width/2, width/2-od/2]]);
      color ("orange") polygon(points =[[od+od/2, od],[width/2-od, od],[width/4, width/4-od/2]]);
      color ("purple") polygon(points =[[width/2, od],[width/4+od/2, width/4],[width/2, width/2-od/2],[3*width/4-od/2, width/4]]);
      color ("black") polygon(points =[[width/2+od, od],[width-od, od],[width-od, width/2-od-od/2]]);
      color ("yellow") polygon(points =[[width/2+od/2, width/2],[3*width/4, width/4+od/2],[3*width/4, 3*width/4-od/2]]);
      color ("pink") polygon(points =[[3*width/4+ol, width/4+od+od/2],[3*width/4+ol, 3*width/4], [width-od, width-od-od/2],[width-od, width/2-od+od/2]]);
    }
  }
  // debug
  //translate ([0, width/2]) color ("red") square ([2*width, 2], center = false);
  //translate ([width/2, 0]) color ("green") square ([2,2*width], center = false);
  
}