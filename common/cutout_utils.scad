module slot_array(count=5, spacing=12, slot_width=3, slot_length=10, thickness=4){
    for(i=[0:count-1])
        translate([i*spacing,0,0])
            cube([slot_length,slot_width,thickness],center=true);
}

module peg_array(count=5, spacing=12, peg_diameter=4, peg_height=6){
    for(i=[0:count-1])
        translate([i*spacing,0,0])
            cylinder(h=peg_height,d=peg_diameter,$fn=30);
}
