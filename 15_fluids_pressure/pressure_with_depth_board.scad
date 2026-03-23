/*
Title: Pressure with Depth Board
Folder: 15_fluids_pressure
Physics Topic: Hydrostatic pressure
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
board_w = 80;
board_h = 180;
thickness = 4;
port_diams = [2,3,4,5,6];

module pressure_board(){
    difference(){
        cube([board_w,board_h,thickness]);
        for(i=[0:len(port_diams)-1])
            translate([board_w/2,30+i*28,0]) cylinder(h=thickness+0.1,d=port_diams[i],$fn=30);
    }
}
pressure_board();
