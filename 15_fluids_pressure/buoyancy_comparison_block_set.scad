/*
Title: Buoyancy Comparison Block Set
Folder: 15_fluids_pressure
Physics Topic: Density and buoyancy
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
block_size = 24;
void_ratio = [0.0,0.2,0.4];

module buoyancy_block(v=0.2){
    difference(){
        cube([block_size,block_size,block_size]);
        if(v>0) translate([4,4,4]) cube([block_size*v*2,block_size*v*2,block_size*v*2]);
    }
}
for(i=[0:len(void_ratio)-1]) translate([i*35,0,0]) buoyancy_block(void_ratio[i]);
