/*
Title: Moment of Inertia Comparison Set
Folder: 11_rotational_dynamics
Physics Topic: Rotational inertia
Difficulty: Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
od = 70;
thickness = 6;
bore_d = 8;

module solid_disk(){ difference(){ cylinder(h=thickness,d=od,$fn=120); cylinder(h=thickness+0.2,d=bore_d,$fn=40);} }
module ring(){ difference(){ cylinder(h=thickness,d=od,$fn=120); cylinder(h=thickness+0.2,d=od*0.65,$fn=120);} }
module spoked_wheel(){
    difference(){
        cylinder(h=thickness,d=od,$fn=120);
        cylinder(h=thickness+0.2,d=od*0.45,$fn=100);
        for(a=[0:60:300]) rotate([0,0,a]) translate([0,-4,-0.1]) cube([od/2,8,thickness+0.3]);
    }
}
module cutout_disk(){
    difference(){
        solid_disk();
        for(a=[0:45:315]) rotate([0,0,a]) translate([od*0.25,0,thickness/2]) cylinder(h=thickness+0.2,d=8,center=true,$fn=24);
    }
}

// --------------------
// Physics Meaning
// --------------------
// Same outer size but different mass distribution changes rotational inertia.

// --------------------
// Learning Notes
// --------------------
// Spin each on same axle and compare acceleration response.

// --------------------
// Print Notes
// --------------------
// Use higher perimeters for rugged classroom handling.

// --------------------
// Customization Ideas
// --------------------
// Keep od constant while sweeping inner cutout diameter.

solid_disk();
translate([85,0,0]) ring();
translate([170,0,0]) spoked_wheel();
translate([255,0,0]) cutout_disk();
