module engraved_text(text_value="x", size=6, depth=0.8){
    linear_extrude(height=depth)
        text(text_value,size=size,halign="center",valign="center");
}
