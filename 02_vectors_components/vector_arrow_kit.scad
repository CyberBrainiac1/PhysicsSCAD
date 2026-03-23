/*
Title: Vector Arrow Kit
Folder: 02_vectors_components
Physics Topic: Vector representation
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


use <../common/arrows.scad>;

// --------------------
// Parameters
// --------------------
arrow_lengths = [40, 60, 90];
shaft_width = 4;
head_length = 12;
head_width = 10;
arrow_spacing = 20;
show_label_tab = true;
style = "classic"; // classic or slim

module arrow_piece(length=60){
    linear_extrude(height=3)
        arrow_2d(length=length, shaft_width=(style=="slim"?3:shaft_width), head_length=head_length, head_width=head_width);
    if(show_label_tab)
        translate([length*0.4,-8,0]) cube([16,8,3]);
}

module component_triangle(a=30,b=40){
    linear_extrude(height=2.5)
        polygon(points=[[0,0],[a,0],[a,b]]);
}

module demo_classroom(){
    for(i=[0:len(arrow_lengths)-1])
        translate([0,i*arrow_spacing,0]) arrow_piece(arrow_lengths[i]);
    translate([120,0,0]) component_triangle(30,40);
    translate([120,30,0]) component_triangle(20,20);
}

// --------------------
// Physics Meaning
// --------------------
// Different arrow lengths encode vector magnitude.

// --------------------
// Learning Notes
// --------------------
// Have students build sum vectors then verify components on the board.

// --------------------
// Print Notes
// --------------------
// Print many arrows in one batch; orient flat for strength.

// --------------------
// Customization Ideas
// --------------------
// Add length-specific labels on tabs for quick sorting.

demo_classroom();
