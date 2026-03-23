// =============================================================================
// labels.scad — Label and annotation modules for PhysicsSCAD
// =============================================================================
// Reusable embossed/raised label plates and annotation geometry for attaching
// text identifiers to physics educational models.
//
// Usage:
//   include <../common/labels.scad>;
//
// Modules:
//   label_plate        — rectangular plate with embossed text
//   label_tag          — hanging label with a mounting hole
//   physics_unit_plate — two-line value + unit label plate
//   direction_label    — short arrow with an attached text label
// =============================================================================

// -----------------------------------------------------------------------------
// label_plate
// Flat rectangular plate with raised (embossed) text on the top face.
//
// Parameters:
//   label_text      — string to display
//   plate_width     — plate dimension in X (mm)
//   plate_height    — plate dimension in Y (mm)
//   plate_thickness — overall plate thickness in Z (mm)
//   text_size       — text character height (mm)
//   text_depth      — how far the text rises above the plate surface (mm)
// -----------------------------------------------------------------------------
module label_plate(
  label_text      = "Label",
  plate_width     = 20,
  plate_height    = 8,
  plate_thickness = 2,
  text_size       = 4,
  text_depth      = 0.5
) {
  union() {
    // Base plate, centred on origin in XY
    translate([-plate_width / 2, -plate_height / 2, 0])
      cube([plate_width, plate_height, plate_thickness]);

    // Raised text centred on top face
    translate([0, 0, plate_thickness])
      linear_extrude(height = text_depth)
        text(label_text, size = text_size,
             halign = "center", valign = "center",
             font = "Liberation Sans:style=Bold");
  }
}

// -----------------------------------------------------------------------------
// label_tag
// Small tag-shaped label with a hanging hole near the top edge.
// Designed to hang from a peg or wire.
//
// Parameters:
//   label_text   — string to display
//   tag_width    — tag dimension in X (mm)
//   tag_height   — tag dimension in Y (mm)
//   tag_thickness — overall thickness in Z (mm)
//   text_size    — text character height (mm)
//   hole_diameter — diameter of the hanging hole (mm)
// -----------------------------------------------------------------------------
module label_tag(
  label_text    = "Tag",
  tag_width     = 18,
  tag_height    = 7,
  tag_thickness = 1.5,
  text_size     = 3,
  hole_diameter = 2
) {
  hole_margin = hole_diameter * 1.2;  // distance from top edge to hole centre

  difference() {
    union() {
      // Base tag plate
      translate([-tag_width / 2, -tag_height / 2, 0])
        cube([tag_width, tag_height, tag_thickness]);

      // Raised text
      translate([0, -tag_height / 4, tag_thickness])
        linear_extrude(height = 0.4)
          text(label_text, size = text_size,
               halign = "center", valign = "center",
               font = "Liberation Sans:style=Bold");
    }

    // Hanging hole near the top edge
    translate([0, tag_height / 2 - hole_margin, -0.1])
      cylinder(h = tag_thickness + 0.2, d = hole_diameter, $fn = 24);
  }
}

// -----------------------------------------------------------------------------
// physics_unit_plate
// Two-line label plate: a numeric value on the top line and a unit on the
// bottom line, both centred on the plate face.
//
// Parameters:
//   value_text  — numeric value string (e.g. "9.8")
//   unit_text   — unit string (e.g. "m/s²")
//   plate_width — plate dimension in X (mm)
//   plate_height — plate dimension in Y (mm)
//   thickness   — overall plate thickness in Z (mm)
// -----------------------------------------------------------------------------
module physics_unit_plate(
  value_text   = "10",
  unit_text    = "N",
  plate_width  = 20,
  plate_height = 10,
  thickness    = 2
) {
  value_size = plate_height * 0.35;
  unit_size  = plate_height * 0.28;
  text_depth = 0.5;
  line_gap   = plate_height * 0.05;

  union() {
    // Base plate
    translate([-plate_width / 2, -plate_height / 2, 0])
      cube([plate_width, plate_height, thickness]);

    // Value text (upper half)
    translate([0, line_gap / 2, thickness])
      linear_extrude(height = text_depth)
        text(value_text, size = value_size,
             halign = "center", valign = "bottom",
             font = "Liberation Sans:style=Bold");

    // Unit text (lower half)
    translate([0, -line_gap / 2, thickness])
      linear_extrude(height = text_depth)
        text(unit_text, size = unit_size,
             halign = "center", valign = "top",
             font = "Liberation Sans");
  }
}

// -----------------------------------------------------------------------------
// direction_label
// A short arrow shaft with a text label at the tail end.
// The arrow points in the +X direction; rotate in your scene as needed.
//
// Parameters:
//   label_text  — label character or string
//   arrow_length — length of the arrow in X (mm)
//   text_size   — text character height (mm)
//   thickness   — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module direction_label(
  label_text  = "F",
  arrow_length = 10,
  text_size   = 4,
  thickness   = 2
) {
  shaft_width = text_size * 0.3;
  head_length = arrow_length * 0.3;
  head_width  = shaft_width * 2.5;

  union() {
    // Arrow
    linear_extrude(height = thickness) {
      union() {
        // Shaft
        translate([0, -shaft_width / 2])
          square([arrow_length - head_length, shaft_width]);

        // Arrowhead
        translate([arrow_length - head_length, 0])
          polygon(points = [
            [0,           -head_width / 2],
            [head_length,  0             ],
            [0,            head_width / 2]
          ]);
      }
    }

    // Label to the left of the arrow tail
    translate([-(text_size * 0.7), 0, 0])
      linear_extrude(height = thickness)
        text(label_text, size = text_size,
             halign = "right", valign = "center",
             font = "Liberation Sans:style=Bold");
  }
}
