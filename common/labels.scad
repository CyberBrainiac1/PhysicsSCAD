module label_plate(text_value="Label", width=30, height=12, thickness=2, text_size=5){
    difference(){
        cube([width,height,thickness]);
        translate([2,height/2,thickness-0.8])
            linear_extrude(height=1)
                text(text_value,size=text_size,valign="center",halign="left");
    }
}
