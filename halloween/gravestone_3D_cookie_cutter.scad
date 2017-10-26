// ************************************************************
// * EN
// * This model is gracefully offered by cookityourself.
// * Feel free to do what you want with it.
// * Please just add a link to our website www.ciy.fr 
// * if you use some of our code in your own creations.
// ************************************************************
// * FR
// * Ce modèle vous est gracieusement offert par cookityourself.
// * Vous êtes libres de l'utiliser comme bon vous semble.
// * Nous vous demandons seulement de faire un lien vers notre 
// * site web www.ciy.fr si vous utilisez tout ou partie de ce 
// * code pour l'une de vos créations.
// ************************************************************
// Model for a Gravestone 3D cookie cutter.
// Choose the name of the part you want to export to create
// the files to slice and print.
// ************************************************************

use<../common/cutterize.scad>


// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// Choose here what you want to export:

export = "base"; 

// "preview" : view of all parts, not designed for printing.
// "topStone" : stone with "RIP" engraving
// "base" : support for the gravestone to stand up

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//----------------------------------------------------------

$fn=500;
wallThickness=0.8;

stoneThickness=7;
stoneWidth=30;
baseThickness=10;
tabsWidth=stoneWidth/3;
barThickness=1;


if (export == "topStone") {
  translate([0,0,stoneThickness/2+wallThickness]) rotate([0,180,0]) topStone();
}
else if (export == "base") {
  translate([0,0,baseThickness/2+wallThickness]) rotate([0,180,0])base();
}
else {
  $fn = 30;
  translate([0,23,-42])rotate([-90,0,0]) 
    topStone();
  base();
}


module topStone(){
cutterize_offset_round(wallThickness) 
	stone();
rip();
}

module stone(){
	stoneHeight=50;
		
	cylinder(d=stoneWidth, stoneThickness, center=true);
	cubeHeight=(stoneHeight-stoneWidth/2);
	translate([0,-cubeHeight/2,0]){
		cube([stoneWidth,cubeHeight, stoneThickness], center=true);
		//tabs
		tabHeight=0.8*baseThickness;
		translate([(stoneWidth-tabsWidth)/2,-(cubeHeight+tabHeight)/2,0])cube([tabsWidth,tabHeight,stoneThickness], center=true);
		mirror([-1,0,0])translate([(stoneWidth-tabsWidth)/2,-(cubeHeight+tabHeight)/2,0])cube([tabsWidth,tabHeight,stoneThickness], center=true);
	}
}

module rip(){
	textThickness=stoneThickness-3;
	translate([-11,-5,stoneThickness/2-textThickness+wallThickness])linear_extrude(height = textThickness) text("RIP");

	translate([0,-3,(stoneThickness-barThickness)/2+wallThickness])cube([stoneWidth,5,barThickness], center=true);
		translate([0,4,(stoneThickness-barThickness)/2+wallThickness])cube([29,1,barThickness], center=true);
}

module base(){
	tolerance=1.3;
	stoneOffset=10;
	holeHeight=stoneThickness*tolerance;
	baseLength=stoneOffset*2+holeHeight;
	baseWidth=stoneWidth*1.5;
	echo(baseWidth,baseLength);
	cutterize_offset_round(wallThickness) 
		cube([baseWidth,baseLength,baseThickness], center=true);
	
	translate([(stoneWidth-tabsWidth)/2,((baseLength-holeHeight)/2)-stoneOffset,0])
	cutterize_offset_round(wallThickness)
		cube([tabsWidth*tolerance,holeHeight,baseThickness], center=true);
	mirror([1,0,0])translate([(stoneWidth-tabsWidth)/2,((baseLength-holeHeight)/2)-stoneOffset,0])
		cutterize_offset_round(wallThickness)
		cube([tabsWidth*tolerance,holeHeight,baseThickness], center=true);
	
	//supportBars
	translate([0,0,(baseThickness-barThickness)/2+wallThickness]){
	sideBarWidth=(baseWidth-stoneWidth)/2-wallThickness;
	barHeight=holeHeight+2*wallThickness;
	translate([(baseWidth-sideBarWidth)/2+wallThickness,0,0])cube([sideBarWidth,barHeight,barThickness], center=true);
		mirror(1,0,0)
				translate([(baseWidth-sideBarWidth)/2+wallThickness,0,0])cube([sideBarWidth,holeHeight,barThickness], center=true);
		cube([sideBarWidth,barHeight,barThickness], center=true);
	}
}