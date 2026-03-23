/*
Title: Flywheel Energy Comparison Disks
Folder: 17_robotics_applications
Physics Topic: Flywheel inertia in shooters
Difficulty: Beginner-Intermediate
Print Type: FDM, single material
Teaches: Conceptual mechanics
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
od = 80;
t = 7;

module rim_heavy(){ difference(){ cylinder(h=t,d=od,$fn=120); cylinder(h=t+0.1,d=od*0.55,$fn=100);} }
module hub_heavy(){
    difference(){ cylinder(h=t,d=od,$fn=120); cylinder(h=t+0.1,d=od*0.8,$fn=120); }
    cylinder(h=t,d=od*0.35,$fn=80);
}
module spoke_light(){
    difference(){
      cylinder(h=t,d=od,$fn=120);
      cylinder(h=t+0.1,d=od*0.35,$fn=80);
      for(a=[0:45:315]) rotate([0,0,a]) translate([od*0.2,0,0]) cube([od*0.3,8,t+0.2],center=true);
    }
}
rim_heavy(); translate([95,0,0]) hub_heavy(); translate([190,0,0]) spoke_light();
