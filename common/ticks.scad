module linear_ticks_2d(length=100, spacing=10, tick_len=4, tick_width=1){
    for (x=[0:spacing:length])
        translate([x,-tick_len/2]) square([tick_width,tick_len]);
}

module radial_ticks(radius=50, spacing_deg=15, tick_len=4, tick_width=1){
    for (a=[0:spacing_deg:359])
        rotate(a) translate([radius-tick_len, -tick_width/2]) square([tick_len,tick_width]);
}
