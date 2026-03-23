/*
Title: Gear Ratio Visualizer Board
Folder: 17_robotics_applications
Physics Topic: Gear ratio and angular speed
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Input/output ratio and speed-torque tradeoffs for FTC drivetrains
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
gear_ds = [36,72,54];
thickness = 4;

module simple_gear(d=40, teeth=20){
    difference(){
        cylinder(h=thickness,d=d,$fn=teeth*2);
        cylinder(h=thickness+0.1,d=6,$fn=32);
    }
    for(a=[0:360/teeth:359])
        rotate([0,0,a]) translate([d/2,0,thickness/2]) cube([3,2,thickness],center=true);
}

simple_gear(gear_ds[0],18);
translate([58,0,0]) simple_gear(gear_ds[1],36);
translate([140,0,0]) simple_gear(gear_ds[2],27);
