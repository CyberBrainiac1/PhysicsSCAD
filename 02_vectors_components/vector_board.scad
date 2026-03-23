/*
Title: Vector Board
Folder: 02_vectors_components
Physics Topic: Vectors and components
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Vector magnitude, direction, and component decomposition
Use Case: Classroom manipulative
*/


use <../common/axes.scad>;
use <../common/ticks.scad>;

// --------------------
// Parameters
// --------------------
board_size = 180;
board_thickness = 4;
grid_spacing = 10;
axis_thickness = 2;
show_grid = true;
show_quadrant_labels = true;
show_degree_markings = true;
show_component_guides = true;

module vector_board(){
    difference(){
        cube([board_size, board_size, board_thickness], center=true);
        if(show_grid)
            for (x=[-board_size/2+grid_spacing:grid_spacing:board_size/2-grid_spacing])
                translate([x,0,board_thickness/2-0.8]) cube([0.8,board_size,1],center=true);
        if(show_grid)
            for (y=[-board_size/2+grid_spacing:grid_spacing:board_size/2-grid_spacing])
                translate([0,y,board_thickness/2-0.8]) cube([board_size,0.8,1],center=true);
        if(show_component_guides)
            for (k=[-3:3]){
                translate([k*20,0,board_thickness/2-1]) cube([1.6,board_size,1.2], center=true);
                translate([0,k*20,board_thickness/2-1]) cube([board_size,1.6,1.2], center=true);
            }
    }

    linear_extrude(height=board_thickness)
        offset(r=axis_thickness/2)
            axis_2d(board_size*0.95, board_size*0.95, grid_spacing);

    if(show_degree_markings)
        translate([0,0,board_thickness]) radial_ticks(radius=board_size*0.45, spacing_deg=15, tick_len=4);
}

module demo_default(){ vector_board(); }

// --------------------
// Physics Meaning
// --------------------
// Arrow direction gives vector direction and arrow length corresponds to magnitude.
// The central origin supports decomposition into x and y components.

// --------------------
// Learning Notes
// --------------------
// Compare two vectors with same magnitude and different angle.
// Build resultant vectors physically with detachable arrows.

// --------------------
// Print Notes
// --------------------
// Print flat. For heavy use increase board_thickness to 5-6 mm.

// --------------------
// Customization Ideas
// --------------------
// Toggle grid/degree marks for different lesson complexity.

demo_default();
