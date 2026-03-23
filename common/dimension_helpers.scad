module dimension_line(len=50, thickness=1.5, arrow_size=4){
    union(){
        translate([arrow_size, -thickness/2]) square([len-2*arrow_size, thickness]);
        polygon(points=[[0,0],[arrow_size,arrow_size/2],[arrow_size,-arrow_size/2]]);
        translate([len,0]) mirror([1,0]) polygon(points=[[0,0],[arrow_size,arrow_size/2],[arrow_size,-arrow_size/2]]);
    }
}

module angle_arc(radius=40, angle_deg=60, thickness=1.5){
    rotate_extrude(angle=angle_deg,$fn=80)
        translate([radius,0,0]) square([thickness,thickness]);
}
