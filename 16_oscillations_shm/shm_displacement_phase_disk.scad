/*
Title: SHM Displacement Phase Disk
Folder: 16_oscillations_shm
Physics Topic: Simple harmonic motion phase
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
r = 60;
t = 3;

module phase_disk(){
    difference(){
        cylinder(h=t,r=r,$fn=100);
        for(a=[0:30:330]) rotate([0,0,a]) translate([r-6,0,t-0.6]) cube([5,1.2,0.8],center=true);
    }
    translate([0,0,t]) cube([r,2,1],center=true);
    translate([0,0,t]) cube([2,r,1],center=true);
}
phase_disk();
