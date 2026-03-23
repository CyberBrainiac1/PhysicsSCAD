/*
Title: Center of Mass Balancer
Folder: 12_center_of_mass
Physics Topic: Center of mass and stability
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
thickness = 5;
show_com_marker = true;

module irregular_shape_a(){
    linear_extrude(height=thickness)
      polygon(points=[[0,0],[55,5],[70,25],[35,48],[10,35]]);
}
module irregular_shape_b(){
    linear_extrude(height=thickness)
      polygon(points=[[0,0],[50,0],[62,20],[40,45],[0,35]]);
}
module balance_notch(){
    translate([30,-3,0]) cube([6,6,thickness]);
}

module balancer_set(){
    difference(){ irregular_shape_a(); balance_notch(); }
    if(show_com_marker) translate([34,23,thickness]) cylinder(h=1.2,d=4,$fn=24);
    translate([90,0,0]) difference(){ irregular_shape_b(); balance_notch(); }
}

// --------------------
// Physics Meaning
// --------------------
// Object balances when support point lies directly below COM projection.

// --------------------
// Learning Notes
// --------------------
// Hide COM marker variant and challenge prediction before testing.

// --------------------
// Print Notes
// --------------------
// Print flat. Notch edges may need slight deburring.

// --------------------
// Customization Ideas
// --------------------
// Add hanging-hole version for plumb-line COM method.

balancer_set();
