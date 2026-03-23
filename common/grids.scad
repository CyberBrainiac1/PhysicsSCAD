module grid_plate(width=120, height=120, spacing=10, thickness=2, line_width=0.8){
    difference(){
        cube([width,height,thickness]);
        for(x=[spacing:spacing:width-spacing])
            translate([x-line_width/2,0,thickness-0.6]) cube([line_width,height,0.7]);
        for(y=[spacing:spacing:height-spacing])
            translate([0,y-line_width/2,thickness-0.6]) cube([width,line_width,0.7]);
    }
}
