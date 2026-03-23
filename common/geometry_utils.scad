module circular_marker(radius=8, thickness=1.5){
    difference(){
        cylinder(h=thickness, r=radius, $fn=60);
        cylinder(h=thickness+0.1, r=radius*0.65, $fn=60);
    }
}

module center_mark(size=8, thickness=1.2){
    union(){
        cube([size,thickness,thickness], center=true);
        cube([thickness,size,thickness], center=true);
    }
}
