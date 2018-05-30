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
// Model to create the positive of a mold for a cake showing a 
// great fight between two legendary space knights.
// Choose the name of the part you want to export to create
// the files to slice and print.
// ************************************************************

use <../common/round_edges.scad>


linear_extrude(height = 40)  import(file = "meeple_space_knights_characters.dxf");
color("blue") linear_extrude(height = 20)  import(file = "meeple_space_knights_saber_left.dxf");
color("red") linear_extrude(height = 20)  import(file = "meeple_space_knights_saber_right.dxf");