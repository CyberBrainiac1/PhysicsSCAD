module arrow_2d(length=40, shaft_width=3, head_length=10, head_width=8){
    union(){
        square([max(0.1,length-head_length), shaft_width], center=false);
        translate([length-head_length, shaft_width/2])
            polygon(points=[[0,-head_width/2],[head_length,0],[0,head_width/2]]);
    }
}

module arrow_3d(length=40, shaft_diameter=4, head_length=10, head_diameter=8){
    union(){
        cylinder(h=max(0.1,length-head_length), d=shaft_diameter, $fn=40);
        translate([0,0,length-head_length])
            cylinder(h=head_length, d1=head_diameter, d2=0.1, $fn=40);
    }
}
