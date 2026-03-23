use <ticks.scad>;

module axis_2d(x_len=120, y_len=120, tick_spacing=10, thickness=2){
    union(){
        translate([-x_len/2,-thickness/2]) square([x_len,thickness]);
        translate([-thickness/2,-y_len/2]) square([thickness,y_len]);
        translate([-x_len/2,0]) linear_ticks_2d(x_len,tick_spacing,3,1);
        rotate(90) translate([-y_len/2,0]) linear_ticks_2d(y_len,tick_spacing,3,1);
    }
}

module axis_3d(x_len=100,y_len=100,z_len=100,d=3){
    union(){
        rotate([0,90,0]) cylinder(h=x_len,d=d,$fn=24);
        rotate([-90,0,0]) cylinder(h=y_len,d=d,$fn=24);
        cylinder(h=z_len,d=d,$fn=24);
    }
}
