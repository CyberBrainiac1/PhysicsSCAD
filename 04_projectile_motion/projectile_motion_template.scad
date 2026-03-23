/*
Title: Projectile Motion Template
Folder: 04_projectile_motion
Physics Topic: 2D kinematics and projectile motion
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


use <../common/ticks.scad>;

// --------------------
// Parameters
// --------------------
board_w = 190;
board_h = 130;
thickness = 3;
launch_angles = [15,30,45,60,75];
show_range_markers = true;

module parabola_path(angle=45, speed_scale=1){
    for (x=[0:4:board_w-20]){
        y = tan(angle)*x*0.35 - 0.0022*x*x*speed_scale;
        if(y>=0 && y<board_h-10)
            translate([x+10,y+10,thickness]) cylinder(h=1,d=1.8,$fn=12);
    }
}

module projectile_template(){
    difference(){
        cube([board_w,board_h,thickness]);
        for(a=launch_angles)
            rotate([0,0,a]) translate([10,-0.5,thickness-0.6]) cube([90,1,0.8]);
    }
    for(a=launch_angles) parabola_path(a);
    if(show_range_markers)
        for(x=[20:20:board_w-10]) translate([x,4,thickness]) cube([1,6,1]);
}

module demo_default(){ projectile_template(); }

// --------------------
// Physics Meaning
// --------------------
// Same launch speed but changing angle creates different trajectories and ranges.

// --------------------
// Learning Notes
// --------------------
// Compare complementary angles and discuss similar range.

// --------------------
// Print Notes
// --------------------
// Best printed flat; use high-contrast filament for engraved cues.

// --------------------
// Customization Ideas
// --------------------
// Adjust launch_angles to match classroom problem sets.

demo_default();
