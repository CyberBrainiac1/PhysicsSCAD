/*
Title: Magnetic Field Line Plate
Folder: 18_advanced_electromechanics
Physics Topic: Advanced conceptual magnetism
Difficulty: Advanced
Print Type: FDM, single material
Teaches: Field-line density as a qualitative representation only
Use Case: Classroom manipulative
*/


// --------------------
// Parameters
// --------------------
plate_w = 150;
plate_h = 100;
t = 3;

module field_line_plate(){
    difference(){
        cube([plate_w,plate_h,t]);
        // stylized loop grooves
        for(r=[14:12:44])
            translate([50,50,t-0.6]) scale([r/20,1,1]) cylinder(h=0.8,d=20,$fn=80);
        for(r=[14:12:44])
            translate([100,50,t-0.6]) scale([r/20,1,1]) cylinder(h=0.8,d=20,$fn=80);
    }
}
field_line_plate();
