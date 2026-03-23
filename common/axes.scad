// =============================================================================
// axes.scad — Coordinate axis modules for PhysicsSCAD
// =============================================================================
// Reusable axis and reference-frame geometry for physics educational models.
// Provides 2D and 3D axis sets, tick marks, and quadrant labels.
//
// Usage:
//   include <../common/axes.scad>;
//
// Modules:
//   axis_2d           — x-y axes with tick marks
//   axis_3d           — 3D xyz axes with end caps
//   axis_labels_2d    — thin plates for axis-end labels
//   quadrant_labels   — I / II / III / IV quadrant label plates
// =============================================================================

// -----------------------------------------------------------------------------
// axis_2d
// Flat x-y axis pair with evenly spaced tick marks, centered on origin.
//
// Parameters:
//   x_len        — total length of the x-axis (mm), centered; half each side
//   y_len        — total length of the y-axis (mm), centered
//   shaft_width  — width of the axis bars (mm)
//   tick_spacing — distance between tick marks (mm)
//   tick_length  — full length of each tick mark (mm)
//   thickness    — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module axis_2d(
  x_len        = 60,
  y_len        = 60,
  shaft_width  = 1.5,
  tick_spacing = 10,
  tick_length  = 4,
  thickness    = 2
) {
  linear_extrude(height = thickness) {
    // X axis bar
    translate([-x_len / 2, -shaft_width / 2])
      square([x_len, shaft_width]);

    // Y axis bar
    translate([-shaft_width / 2, -y_len / 2])
      square([shaft_width, y_len]);

    // Tick marks along +X and -X
    for (i = [1 : floor((x_len / 2) / tick_spacing)]) {
      for (sign = [-1, 1]) {
        translate([sign * i * tick_spacing, -tick_length / 2])
          square([shaft_width, tick_length]);
      }
    }

    // Tick marks along +Y and -Y
    for (i = [1 : floor((y_len / 2) / tick_spacing)]) {
      for (sign = [-1, 1]) {
        translate([-tick_length / 2, sign * i * tick_spacing])
          square([tick_length, shaft_width]);
      }
    }
  }
}

// -----------------------------------------------------------------------------
// axis_3d
// Three-dimensional xyz axis set with small sphere at origin and disk caps.
// X axis = red direction, Y axis = front, Z axis = up (by OpenSCAD convention).
// All axes share the same geometry; colour them in your scene as needed.
//
// Parameters:
//   x_len          — length of the x-axis arm (mm)
//   y_len          — length of the y-axis arm (mm)
//   z_len          — length of the z-axis arm (mm)
//   shaft_diameter — diameter of each axis cylinder (mm)
// -----------------------------------------------------------------------------
module axis_3d(
  x_len          = 40,
  y_len          = 40,
  z_len          = 40,
  shaft_diameter = 2
) {
  cap_d  = shaft_diameter * 2.2;
  cap_h  = shaft_diameter * 0.8;
  origin_r = shaft_diameter * 0.9;

  // Origin sphere
  sphere(r = origin_r, $fn = 32);

  // X axis
  rotate([0, 90, 0])
    cylinder(h = x_len, d = shaft_diameter, $fn = 24);
  translate([x_len, 0, 0])
    rotate([0, 90, 0])
      cylinder(h = cap_h, d = cap_d, $fn = 24);

  // Y axis
  rotate([-90, 0, 0])
    cylinder(h = y_len, d = shaft_diameter, $fn = 24);
  translate([0, y_len, 0])
    rotate([-90, 0, 0])
      cylinder(h = cap_h, d = cap_d, $fn = 24);

  // Z axis
  cylinder(h = z_len, d = shaft_diameter, $fn = 24);
  translate([0, 0, z_len])
    cylinder(h = cap_h, d = cap_d, $fn = 24);
}

// -----------------------------------------------------------------------------
// axis_labels_2d
// Thin raised plates positioned at the ends of each axis for labelling.
// Place in your scene, then colour or annotate as needed.
//
// Parameters:
//   x_len      — half-length of the x-axis (must match axis_2d x_len) (mm)
//   y_len      — half-length of the y-axis (mm)
//   label_size — text character height (mm)
//   thickness  — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module axis_labels_2d(
  x_len      = 60,
  y_len      = 60,
  label_size = 4,
  thickness  = 2
) {
  pad = label_size * 0.3;

  // +x label
  translate([x_len / 2 + pad, -label_size / 2, 0])
    linear_extrude(height = thickness)
      text("+x", size = label_size, valign = "center",
           font = "Liberation Sans:style=Bold");

  // -x label
  translate([-x_len / 2 - pad - label_size * 1.5, -label_size / 2, 0])
    linear_extrude(height = thickness)
      text("-x", size = label_size, valign = "center",
           font = "Liberation Sans:style=Bold");

  // +y label
  translate([-label_size / 2, y_len / 2 + pad, 0])
    linear_extrude(height = thickness)
      text("+y", size = label_size, valign = "center",
           font = "Liberation Sans:style=Bold");

  // -y label
  translate([-label_size / 2, -y_len / 2 - pad - label_size, 0])
    linear_extrude(height = thickness)
      text("-y", size = label_size, valign = "center",
           font = "Liberation Sans:style=Bold");
}

// -----------------------------------------------------------------------------
// quadrant_labels
// Raised Roman-numeral quadrant labels (I–IV) placed inside each quadrant.
//
// Parameters:
//   size       — half-span of the axis grid to set label positions (mm)
//   label_size — text character height (mm)
//   thickness  — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module quadrant_labels(
  size       = 60,
  label_size = 4,
  thickness  = 2
) {
  offset = size / 4;  // place label at quarter-span into each quadrant

  // Quadrant I (+x, +y)
  translate([offset, offset, 0])
    linear_extrude(height = thickness)
      text("I", size = label_size, halign = "center", valign = "center",
           font = "Liberation Sans:style=Bold");

  // Quadrant II (-x, +y)
  translate([-offset, offset, 0])
    linear_extrude(height = thickness)
      text("II", size = label_size, halign = "center", valign = "center",
           font = "Liberation Sans:style=Bold");

  // Quadrant III (-x, -y)
  translate([-offset, -offset, 0])
    linear_extrude(height = thickness)
      text("III", size = label_size, halign = "center", valign = "center",
           font = "Liberation Sans:style=Bold");

  // Quadrant IV (+x, -y)
  translate([offset, -offset, 0])
    linear_extrude(height = thickness)
      text("IV", size = label_size, halign = "center", valign = "center",
           font = "Liberation Sans:style=Bold");
}
