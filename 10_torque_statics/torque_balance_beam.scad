/*
Title: Torque Balance Beam
Folder: 10_torque_statics
Physics Topic: Torque and rotational equilibrium
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
beam_length = 220;
beam_width = 16;
beam_thickness = 6;
hole_spacing = 10;
hole_d = 4;

module beam(){
    difference(){
        cube([beam_length,beam_width,beam_thickness],center=true);
        for(x=[-beam_length/2+10:hole_spacing:beam_length/2-10])
            translate([x,0,0]) cylinder(h=beam_thickness+1,d=hole_d,$fn=28,center=true);
    }
}

module pivot(){
    cylinder(h=18,d=14,$fn=40);
    translate([0,0,18]) sphere(d=8,$fn=32);
}

module mass_token(d=18,t=6){ cylinder(h=t,d=d,$fn=40); }

// --------------------
// Physics Meaning
// --------------------
// Equal and opposite torques balance when sum(tau)=0.

// --------------------
// Learning Notes
// --------------------
// Compare heavy-close vs light-far balancing combinations.

// --------------------
// Print Notes
// --------------------
// Beam is long; print diagonal if slicer allows on smaller beds.

// --------------------
// Customization Ideas
// --------------------
// Add engraved distance numbers under holes.

beam();
translate([0,0,8]) pivot();
translate([-60,25,0]) mass_token();
translate([70,25,0]) mass_token(14,6);
