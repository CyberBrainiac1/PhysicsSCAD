/*
Title: Rolling Motion Wheel Set
Folder: 13_rolling_motion
Physics Topic: Rolling without slipping
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
wheel_diameters = [40,60,80];
thickness = 8;
marker_depth = 1;

module wheel(d=60){
    difference(){
        cylinder(h=thickness,d=d,$fn=90);
        translate([d/2-3,0,thickness-marker_depth]) cylinder(h=marker_depth+0.1,d=4,$fn=24);
    }
}

for(i=[0:len(wheel_diameters)-1])
    translate([i*95,0,0]) wheel(wheel_diameters[i]);
