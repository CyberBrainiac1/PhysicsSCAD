/*
Title: Pendulum Geometry Guide
Folder: 16_oscillations_shm
Physics Topic: Pendulum angle and arc geometry
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


use <../common/ticks.scad>;
// --------------------
// Parameters
// --------------------
radius = 90;
plate_t = 3;

module pendulum_guide(){
    difference(){
        cylinder(h=plate_t,r=radius,$fn=120);
        cylinder(h=plate_t+0.1,r=radius-8,$fn=120);
    }
    radial_ticks(radius=radius-4,spacing_deg=10,tick_len=4);
    translate([0,0,plate_t]) cylinder(h=2,d=5,$fn=24);
}
pendulum_guide();
