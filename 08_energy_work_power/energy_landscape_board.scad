/*
Title: Energy Landscape Board
Folder: 08_energy_work_power
Physics Topic: Potential and kinetic energy exchange
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
track_length = 180;
track_width = 32;
base_thickness = 4;
profile = "hill_valley"; // hill_valley or double_hill

module profile_shape(){
    if(profile=="hill_valley")
        polygon(points=[[0,0],[20,10],[60,28],[100,8],[140,24],[180,0],[180,-8],[0,-8]]);
    else
        polygon(points=[[0,0],[30,20],[70,6],[110,22],[150,6],[180,0],[180,-8],[0,-8]]);
}

module energy_board(){
    linear_extrude(height=track_width)
        profile_shape();
    // height markers
    for(x=[0:30:track_length])
        translate([x,track_width+1,0]) cube([1,2,20]);
}

// --------------------
// Physics Meaning
// --------------------
// Higher positions correspond to higher gravitational potential energy.

// --------------------
// Learning Notes
// --------------------
// Predict where speed is largest, then test with a marble.

// --------------------
// Print Notes
// --------------------
// Print on side for smoother rolling surface or flat for speed.

// --------------------
// Customization Ideas
// --------------------
// Add roughness strips to discuss non-conservative losses.

energy_board();
