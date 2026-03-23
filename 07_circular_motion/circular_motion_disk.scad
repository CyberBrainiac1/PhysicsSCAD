/*
Title: Circular Motion Disk
Folder: 07_circular_motion
Physics Topic: Uniform circular motion
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


use <../common/ticks.scad>;

// --------------------
// Parameters
// --------------------
disk_radius = 70;
disk_thickness = 3;
orbit_radii = [25,45,60];

module direction_marker(r=45){
    // tangential marker
    translate([r,0,disk_thickness]) cube([12,2,1],center=true);
    // centripetal marker
    translate([r/2,0,disk_thickness]) cube([10,2,1],center=true);
}

module circular_motion_disk(){
    difference(){
        cylinder(h=disk_thickness,r=disk_radius,$fn=120);
        for(r=orbit_radii) cylinder(h=disk_thickness+0.1,r=r-0.8,$fn=120);
    }
    radial_ticks(radius=disk_radius-5, spacing_deg=30, tick_len=4);
    for(r=orbit_radii) direction_marker(r);
    cylinder(h=disk_thickness+1,d=6,$fn=32);
}

// --------------------
// Physics Meaning
// --------------------
// Velocity is tangent; acceleration points inward toward center.

// --------------------
// Learning Notes
// --------------------
// Rotate a token around a ring and keep pointing acceleration inward.

// --------------------
// Print Notes
// --------------------
// Large flat print; use brim if needed for edge adhesion.

// --------------------
// Customization Ideas
// --------------------
// Add more orbit_radii for comparison exercises.

circular_motion_disk();
