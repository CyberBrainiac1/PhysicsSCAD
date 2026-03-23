/*
Title: Free Body Diagram Board
Folder: 05_forces_free_body
Physics Topic: Newton's laws and force modeling
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


use <../common/cutout_utils.scad>;

// --------------------
// Parameters
// --------------------
board_size = 150;
thickness = 4;
center_shape = "block"; // block, crate, puck
include_incline = true;
slot_len = 14;
slot_w = 3.2;

module center_object(){
    if(center_shape=="block") cube([30,30,2],center=true);
    else if(center_shape=="crate") cube([36,28,2],center=true);
    else cylinder(h=2,d=30,$fn=40);
}

module force_slots(){
    for(a=[0:45:315]) rotate([0,0,a]) translate([35,0,0]) cube([slot_len,slot_w,3],center=true);
}

module free_body_board(){
    difference(){
        cube([board_size,board_size,thickness],center=true);
        force_slots();
        if(include_incline) rotate([0,0,20]) translate([0,-48,thickness/2-0.7]) cube([90,1.4,1]);
    }
    translate([0,0,thickness/2]) center_object();
}

// --------------------
// Physics Meaning
// --------------------
// Slots around the center object enforce explicit force direction choices.

// --------------------
// Learning Notes
// --------------------
// Add only real forces; avoid adding velocity as a force arrow.

// --------------------
// Print Notes
// --------------------
// Print board flat with 20% infill.

// --------------------
// Customization Ideas
// --------------------
// Expand slot ring radius for larger detachable arrows.

free_body_board();
