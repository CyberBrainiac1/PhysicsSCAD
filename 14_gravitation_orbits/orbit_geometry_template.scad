/*
Title: Orbit Geometry Template
Folder: 14_gravitation_orbits
Physics Topic: Orbital geometry intuition
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
major_axis = 150;
minor_axis = 110;
plate_t = 3;

module orbit_template(){
    difference(){
        cube([180,140,plate_t]);
        translate([90,70,plate_t-0.8]) scale([major_axis/120,minor_axis/120,1]) cylinder(h=1,d=120,$fn=120);
    }
    translate([90-major_axis*0.25,70,plate_t]) cylinder(h=1.2,d=5,$fn=28);
    translate([90+major_axis*0.25,70,plate_t]) cylinder(h=1.2,d=5,$fn=28);
}
orbit_template();
