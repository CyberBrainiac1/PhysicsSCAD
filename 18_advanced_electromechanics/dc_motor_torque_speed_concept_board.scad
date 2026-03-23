/*
Title: DC Motor Torque-Speed Concept Board
Folder: 18_advanced_electromechanics
Physics Topic: Advanced: motor torque-speed relationship
Difficulty: Advanced
Print Type: FDM, single material
Teaches: Why increasing speed reduces available torque in a DC motor model
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
board_w = 150;
board_h = 100;
thickness = 3;

module motor_concept_board(){
    difference(){
        cube([board_w,board_h,thickness]);
        // linear torque-speed line groove
        hull(){
            translate([20,80,thickness-0.8]) cylinder(h=1,d=2,$fn=16);
            translate([130,20,thickness-0.8]) cylinder(h=1,d=2,$fn=16);
        }
    }
}
motor_concept_board();
