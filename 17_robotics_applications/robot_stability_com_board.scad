/*
Title: Robot Stability COM Board
Folder: 17_robotics_applications
Physics Topic: Tipping stability and COM envelope
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
base_w = 160;
base_h = 120;
thickness = 4;

module stability_board(){
    difference(){
        cube([base_w,base_h,thickness]);
        // wheelbase and tipping-edge markers
        translate([20,20,thickness-0.8]) cube([120,0.8,1]);
        translate([20,100,thickness-0.8]) cube([120,0.8,1]);
        translate([20,20,thickness-0.8]) cube([0.8,80,1]);
        translate([140,20,thickness-0.8]) cube([0.8,80,1]);
    }
    translate([80,60,thickness]) cylinder(h=1.2,d=6,$fn=30); // nominal COM
}
stability_board();
