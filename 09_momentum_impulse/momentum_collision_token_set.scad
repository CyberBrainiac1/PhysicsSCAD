/*
Title: Momentum Collision Token Set
Folder: 09_momentum_impulse
Physics Topic: Momentum and collisions
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
token_d = 28;
token_t = 6;
mass_labels = ["1m","2m","3m"];
lane_length = 180;
lane_width = 70;

module mass_token(label="1m", notch=false){
    difference(){
        cylinder(h=token_t,d=token_d,$fn=60);
        if(notch) translate([0,token_d/2-3,token_t/2]) cube([8,4,3],center=true);
    }
}

module collision_lane(){
    difference(){
        cube([lane_length,lane_width,3]);
        translate([0,lane_width/2-12,2.3]) cube([lane_length,2,1]);
        translate([0,lane_width/2+12,2.3]) cube([lane_length,2,1]);
    }
}

// --------------------
// Physics Meaning
// --------------------
// Momentum depends on both mass and velocity direction.

// --------------------
// Learning Notes
// --------------------
// Use arrows to mark pre/post-collision states.

// --------------------
// Print Notes
// --------------------
// Tokens print best in grouped batches.

// --------------------
// Customization Ideas
// --------------------
// Create additional token diameters for rotational collision demos.

collision_lane();
translate([20,80,0]) mass_token("1m",false);
translate([55,80,0]) mass_token("2m",true);
translate([90,80,0]) mass_token("3m",true);
