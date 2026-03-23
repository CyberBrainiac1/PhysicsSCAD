// =============================================================================
// cutout_utils.scad — Cutout shape modules for PhysicsSCAD
// =============================================================================
// Negative-space (cutout) geometry modules intended for use inside
// difference() calls. Provides common slot, arrow, text, and mounting
// cutout shapes for physics educational model bases and labels.
//
// Usage:
//   include <../common/cutout_utils.scad>;
//
//   difference() {
//     cube([30, 20, 5]);
//     slot_cutout(slot_width=4, slot_length=14, depth=3);
//   }
//
// Modules:
//   oval_cutout    — elliptical slot cutout (hull of two cylinders)
//   arrow_cutout   — arrow-shaped cutout
//   text_cutout    — text-shaped cutout (negative text)
//   slot_cutout    — rounded rectangular slot
//   keyhole_cutout — keyhole shape for panel mounting / hanging
// =============================================================================

// -----------------------------------------------------------------------------
// oval_cutout
// Oval (stadium / discorectangle) shaped cutout formed by the convex hull of
// two cylinders. Long axis runs along X, centred on origin.
//
// Parameters:
//   width — total length of the oval along X (mm)
//   height — width of the oval in Y (mm)
//   depth  — cutout depth in Z (mm)
// -----------------------------------------------------------------------------
module oval_cutout(
  width  = 20,
  height = 10,
  depth  = 5
) {
  r = height / 2;
  offset_x = (width - height) / 2;  // distance from centre to each end cap

  hull() {
    translate([-offset_x, 0, 0])
      cylinder(h = depth, r = r, $fn = 32);
    translate([offset_x, 0, 0])
      cylinder(h = depth, r = r, $fn = 32);
  }
}

// -----------------------------------------------------------------------------
// arrow_cutout
// Arrow-shaped cutout pointing in the +X direction, centred on origin in XY.
// Use inside a difference() to cut an arrow hole into a plate.
//
// Parameters:
//   length      — total arrow length (mm)
//   shaft_width — shaft height in Y (mm)
//   head_length — arrowhead length in X (mm)
//   head_width  — arrowhead full width in Y (mm)
//   depth       — cutout depth in Z (mm)
// -----------------------------------------------------------------------------
module arrow_cutout(
  length      = 20,
  shaft_width = 3,
  head_length = 6,
  head_width  = 6,
  depth       = 3
) {
  shaft_length = length - head_length;

  linear_extrude(height = depth)
    union() {
      // Shaft rectangle
      translate([-length / 2, -shaft_width / 2])
        square([shaft_length, shaft_width]);

      // Arrowhead triangle
      translate([-length / 2 + shaft_length, 0])
        polygon(points = [
          [0,           -head_width / 2],
          [head_length,  0             ],
          [0,            head_width / 2]
        ]);
    }
}

// -----------------------------------------------------------------------------
// text_cutout
// Text-shaped cutout (the text forms recessed/through negative space).
// Use inside a difference() call. Text is centred on origin in XY.
//
// Parameters:
//   label_text — string to cut out
//   text_size  — character height (mm)
//   depth      — cutout depth in Z (mm)
// -----------------------------------------------------------------------------
module text_cutout(
  label_text = "F",
  text_size  = 6,
  depth      = 1.5
) {
  linear_extrude(height = depth)
    text(label_text, size = text_size,
         halign = "center", valign = "center",
         font = "Liberation Sans:style=Bold");
}

// -----------------------------------------------------------------------------
// slot_cutout
// Rounded rectangular slot cutout. Long axis runs along Y, centred on origin.
// Rounded ends are formed by the hull of two circles.
//
// Parameters:
//   slot_width    — width of the slot in X (mm)
//   slot_length   — total length of the slot in Y (mm)
//   depth         — cutout depth in Z (mm)
//   corner_radius — end cap radius; clamped to slot_width/2 (mm)
// -----------------------------------------------------------------------------
module slot_cutout(
  slot_width    = 3,
  slot_length   = 15,
  depth         = 3,
  corner_radius = 1
) {
  r = min(corner_radius, slot_width / 2);
  inner_length = slot_length - 2 * r;

  hull() {
    translate([0, -inner_length / 2, 0])
      cylinder(h = depth, r = r, $fn = 24);
    translate([0,  inner_length / 2, 0])
      cylinder(h = depth, r = r, $fn = 24);
  }
}

// -----------------------------------------------------------------------------
// keyhole_cutout
// Keyhole-shaped cutout: a circle on top joined to a narrow slot below.
// Used for panel mounting or hanging boards on a wall peg.
// Centred on origin with the circle at the top (positive Y).
//
// Parameters:
//   circle_diameter — diameter of the round part of the keyhole (mm)
//   slot_width      — width of the narrow slot (mm)
//   slot_length     — length of the slot below the circle (mm)
//   depth           — cutout depth in Z (mm)
// -----------------------------------------------------------------------------
module keyhole_cutout(
  circle_diameter = 8,
  slot_width      = 4,
  slot_length     = 12,
  depth           = 5
) {
  circle_r = circle_diameter / 2;
  // Position circle so its bottom edge meets the top of the slot
  circle_y = slot_length / 2;

  union() {
    // Circular head
    translate([0, circle_y, 0])
      cylinder(h = depth, r = circle_r, $fn = 32);

    // Narrow slot (rounded rectangle along Y)
    slot_cutout(
      slot_width  = slot_width,
      slot_length = slot_length,
      depth       = depth,
      corner_radius = slot_width / 2
    );
  }
}
