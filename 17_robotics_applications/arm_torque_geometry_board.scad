/*
Title: Arm Torque Geometry Board
Folder: 17_robotics_applications
Physics Topic: Lever arms in robot mechanisms
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
board_w = 200;
board_h = 100;
thickness = 4;
arm_lengths = [40,70,100,130];

module arm_torque_board(){
    difference(){
        cube([board_w,board_h,thickness]);
        for(l=arm_lengths) translate([20+l,board_h/2,0]) cylinder(h=thickness+0.1,d=4,$fn=24);
    }
    translate([20,board_h/2,thickness]) cylinder(h=2,d=8,$fn=30); // pivot
    translate([board_w-20,10,thickness]) cube([2,80,1]); // gravity direction marker line
}
arm_torque_board();
