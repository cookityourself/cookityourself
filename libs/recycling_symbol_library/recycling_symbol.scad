/*parameters*/
// preview[view:south, tilt:top diagonal]
/* [Global] */
// Demo mode
demo=1; //[0:No,1:Yes]
// Material type
type="ABS"; //[ABS,PLA,PS,PP,OTHER]
// Width of the symbol
size=20; //[1:50]
// Thickness of the symbol
T=1; //[1:10]
/* [Hidden] */
use <../writescad/Write.scad>

if(demo)
color("SteelBlue")
{
	recycling_symbol("ABS", 30, 2, [-25,45,0]);
	recycling_symbol("PLA", 30, 2, [25,45,0]);
	recycling_symbol("PP", 20, 2, [-35,0,0]);
	recycling_symbol("PS", 20, 2, [0,0,0]);
	recycling_symbol("OTHER", 20, 2, [35,0,0]);
}
else
	color("SteelBlue") recycling_symbol(type, size, T, $fn=40);


module recycling_symbol(type="ABS", size=10, h=1, pos=[], rot=[],$fn=40)
{
	code=(type=="ABS"?"9":type=="PS"?"6":type=="PP"?"5":"7");
	translate(pos) rotate(rot)
	scale([size/10,size/10,h])
	union()
	{
		for(i=[0,120,240])
			rotate(a=[0,0,i])
			__r_s_arrow();
//		translate([0,0,0.5])
//			write(code, t=1, h=4, center=true);
//		translate([0.5,-7,0.5])
//			write(type, t=1, h=4, space=1, center=true);
         linear_extrude (1) {
            translate([0,0,0.5])
                text(code, halign = "center", valign = "center", size = 4.5, font = "Cantarell:style=Bold");
            translate([0.5,-6,0.5])
                text(type, halign = "center", valign = "center", size = 4, spacing = 0.9, font = "Cantarell:style=Bold");
         }
	}
}

module __r_s_arrow()
{
	width=1.2;
	y=sqrt(3)/3*6;
	arr_y=-y/2-2+width/2;
	linear_extrude(height=1)
	union()
	{
		difference()
		{
			__r_s_rounded_triangle(y,2,1);
			__r_s_rounded_triangle(y,2-width);
			translate([0,-5,0])
				square([6,12]);
			rotate([0,0,60])
			translate([-1.5,0,0])
				square([6,7]);
		}
		polygon(points=[[0.5,arr_y],[1.8,arr_y-1.1],[1.8,arr_y+1.1]]);
	}
}

module __r_s_rounded_triangle(y,r)
{
	hull()
	for(i=[0,120,240])
		rotate(a=[0,0,i])
		translate([0,y,0])
			circle(r=r);
}