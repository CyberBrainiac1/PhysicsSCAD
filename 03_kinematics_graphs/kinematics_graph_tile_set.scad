/*
Title: Kinematics Graph Tile Set
Folder: 03_kinematics_graphs
Physics Topic: Motion graphs
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


use <../common/grids.scad>;

// --------------------
// Parameters
// --------------------
tile_w = 70;
tile_h = 70;
tile_t = 3;
peg_d = 4;
peg_h = 3;
use_pegs = true;

module graph_tile(label="x-t", points=[[5,10],[25,20],[55,50]]){
    difference(){
        cube([tile_w,tile_h,tile_t]);
        for(i=[0:10:tile_w]) translate([i,0,tile_t-0.6]) cube([0.6,tile_h,0.8]);
        for(j=[0:10:tile_h]) translate([0,j,tile_t-0.6]) cube([tile_w,0.6,0.8]);
    }
    for(i=[0:len(points)-2])
        hull(){
            translate([points[i][0],points[i][1],tile_t]) cylinder(h=1,d=2.5,$fn=20);
            translate([points[i+1][0],points[i+1][1],tile_t]) cylinder(h=1,d=2.5,$fn=20);
        }
    if(use_pegs){
        translate([tile_w-8,8,tile_t]) cylinder(h=peg_h,d=peg_d,$fn=24);
    }
}

module demo_default(){
    graph_tile("x-t", [[8,12],[30,20],[55,55]]);
    translate([80,0,0]) graph_tile("v-t", [[8,20],[28,20],[55,35]]);
    translate([160,0,0]) graph_tile("a-t", [[8,25],[55,25]]);
}

// --------------------
// Physics Meaning
// --------------------
// x-t slope = velocity; v-t slope = acceleration; v-t area = displacement.

// --------------------
// Learning Notes
// --------------------
// Ask which tiles represent speeding up, slowing down, or rest.

// --------------------
// Print Notes
// --------------------
// Tiles are designed for no-support printing and quick classroom sets.

// --------------------
// Customization Ideas
// --------------------
// Build additional piecewise profiles for challenge cards.

demo_default();
