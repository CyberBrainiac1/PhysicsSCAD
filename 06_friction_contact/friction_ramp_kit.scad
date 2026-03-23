/*
Title: Friction Ramp Kit
Folder: 06_friction_contact
Physics Topic: Inclines, normal force, and friction
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
ramp_length = 120;
ramp_width = 60;
ramp_height = 40;
angle_marks = [10,20,30,40];
block_size = [24,24,12];
texture_depth = 0.8;

module ramp(){
    polyhedron(
      points=[[0,0,0],[ramp_length,0,0],[ramp_length,ramp_width,0],[0,ramp_width,0],[0,0,ramp_height],[0,ramp_width,ramp_height]],
      faces=[[0,1,2,3],[0,1,4],[1,2,5,4],[2,3,5],[3,0,4,5],[0,3,2,1]]);
}

module block(textured=false){
    difference(){
        cube(block_size);
        if(textured)
            for(x=[2:4:block_size[0]-2]) translate([x,0,0]) cube([1,block_size[1],texture_depth]);
    }
}

module angle_strip(){
    cube([ramp_length,10,2]);
    for(a=angle_marks) translate([a*2.5,8,2]) cube([1,4,1]);
}

// --------------------
// Physics Meaning
// --------------------
// Angle changes normal force and friction threshold.

// --------------------
// Learning Notes
// --------------------
// Predict before testing which angle starts slipping.

// --------------------
// Print Notes
// --------------------
// Print ramp on base. Blocks print separately; no supports required.

// --------------------
// Customization Ideas
// --------------------
// Create multiple ramps with fixed heights for quick comparisons.

ramp();
translate([0,70,0]) block(false);
translate([30,70,0]) block(true);
translate([0,100,0]) angle_strip();
