// =============================================================================
// Title:       Vector Arrow Kit
// Folder:      02_vectors_components
// Physics:     Vectors — Magnitude, Direction, and Component Decomposition
// Difficulty:  Beginner
// Print Type:  Manipulative
// Teaches:     Encoding magnitude in arrow length; tip-to-tail addition; right-triangle components
// Use Case:    AP Physics 1 | F=ma | FTC Robotics | All
// =============================================================================

// ============================================================
// vector_arrow_kit.scad
// PhysicsSCAD — 02_vectors_components
// ============================================================
// Three arrow sizes (short / medium / long) plus a right-triangle
// component piece. Arrows have a peg base that inserts into the
// vector_board slot. Use print_set() to export all pieces on
// one build plate.
//
// Arrow orientation: shaft along +X, head pointing in +X direction.
// Rotate to desired angle before placing on board.
// ============================================================

// --------------------------------------------------------
// Physics Meaning
// --------------------------------------------------------
// Arrow LENGTH encodes vector magnitude; arrow DIRECTION encodes
// the direction in 2-D space. The three lengths give a concrete,
// visual scale: short ≈ 1 unit, medium ≈ 2 units, long ≈ 3.5 units
// (exact ratios can be set via parameters).
//
// The component triangle shows how one vector splits into two
// perpendicular components:
//   vx = |v| cos(θ)    vy = |v| sin(θ)
// The triangle's hypotenuse *is* the vector; its legs are the components.

// --------------------------------------------------------
// Learning Notes
// --------------------------------------------------------
// • Arrows add tip-to-tail: place the tail of B at the tip of A
//   to find A + B (resultant runs from A's tail to B's tip).
// • Multiplying a vector by a scalar only changes its length,
//   not its direction — represented by choosing a different arrow size.
// • The peg lets arrows stand upright on the board for 3-D demos too.

// --------------------------------------------------------
// Print Notes
// --------------------------------------------------------
// • Use print_set() for a single-plate print of all pieces
// • Flat on bed, no supports required
// • Layer height 0.15 mm for sharp peg and label features
// • 40 % infill recommended for peg durability
// • Print multiple colour-coded sets per lab group (one colour per
//   arrow length helps students keep magnitudes distinct)
// • Peg tolerance: if pegs are too tight, increase base_peg_diameter
//   by 0.1 mm increments; if too loose, decrease by 0.1 mm

// --------------------------------------------------------
// Customization Ideas
// --------------------------------------------------------
// • Change short/medium/long lengths to match a specific problem's
//   force magnitudes (e.g., 30 N, 40 N, 50 N → Pythagorean triple)
// • Set label_tab = false for a cleaner look without letter tabs
// • Print the triangle in a different filament colour for clarity
// • Add a curved arrow variant (see common/arrows.scad curved_arrow_2d)

$fn = 32;

// ------------------------------------------------------------
// Parameters
// ------------------------------------------------------------

shaft_thickness    = 3;    // mm — shaft width (square cross-section)
head_width         = 6;    // mm — arrowhead base width
head_length        = 7;    // mm — arrowhead depth (point to base)
arrow_thickness    = 4;    // mm — z-height of the arrow body
short_length       = 20;   // mm — total short arrow length (shaft+head)
medium_length      = 40;   // mm — total medium arrow length
long_length        = 70;   // mm — total long arrow length
base_peg_diameter  = 2.8;  // mm — cylindrical peg diameter
base_peg_height    = 2.5;  // mm — peg height below arrow (inserts into slot)
label_tab          = true; // include raised letter tab on shaft (S/M/L)
label_height       = 1.0;  // mm — raised height of the letter tab

// Component triangle defaults
triangle_base      = 40;   // mm — horizontal leg
triangle_height_mm = 30;   // mm — vertical leg  (renamed to avoid conflict)
triangle_thickness = 3;    // mm — z height of triangle

// ============================================================
// Sub-modules
// ============================================================

// ------------------------------------------------------------
// arrow_head_2d() — flat 2-D arrowhead profile (equilateral-ish)
// Origin at the base centre of the head; tip points in +X.
// ------------------------------------------------------------
module arrow_head_2d() {
  polygon(points = [
    [0,              -head_width / 2],
    [0,               head_width / 2],
    [head_length,     0]
  ]);
}

// ------------------------------------------------------------
// arrow_shaft_2d(shaft_len)
// Flat 2-D shaft rectangle; origin at tail-left, extends in +X.
// ------------------------------------------------------------
module arrow_shaft_2d(shaft_len) {
  square([shaft_len, shaft_thickness]);
}

// ------------------------------------------------------------
// arrow_profile_2d(total_length)
// Combined 2-D profile: shaft from x=0 to shaft_len,
// head from shaft_len to total_length.
// ------------------------------------------------------------
module arrow_profile_2d(total_length) {
  shaft_len = total_length - head_length;
  // Shaft
  translate([0, -shaft_thickness / 2])
    arrow_shaft_2d(shaft_len);
  // Head (base at x = shaft_len)
  translate([shaft_len, 0])
    arrow_head_2d();
}

// ------------------------------------------------------------
// peg(diameter, peg_h)
// Cylindrical peg protruding downward from bottom of arrow.
// Placed at the tail (x=0) centred on y.
// ------------------------------------------------------------
module peg(diameter, peg_h) {
  translate([0, 0, -peg_h])
    cylinder(d = diameter, h = peg_h);
}

// ------------------------------------------------------------
// label_tab_module(letter)
// Raised letter on the shaft for easy identification.
// ------------------------------------------------------------
module label_tab_module(letter) {
  translate([0, 0, arrow_thickness])
    linear_extrude(height = label_height)
      text(letter, size = shaft_thickness * 0.9,
           font = "Liberation Sans:style=Bold",
           halign = "left", valign = "bottom");
}

// ------------------------------------------------------------
// generic_arrow(total_length, label_letter)
// Full arrow: extruded 2-D profile + peg + optional label.
// Arrow lies flat in XY plane; tail at origin.
// ------------------------------------------------------------
module generic_arrow(total_length, label_letter) {
  // Extruded body
  linear_extrude(height = arrow_thickness)
    arrow_profile_2d(total_length);

  // Base peg at tail, centred on y
  translate([shaft_thickness / 2, 0, 0])
    peg(base_peg_diameter, base_peg_height);

  // Optional label tab
  if (label_tab) {
    translate([shaft_thickness / 2 + 1, -shaft_thickness / 2, 0])
      label_tab_module(label_letter);
  }
}

// ============================================================
// Named arrow modules
// ============================================================

// short_arrow() — small vector, labelled "S"
module short_arrow() {
  generic_arrow(short_length, "S");
}

// medium_arrow() — medium vector, labelled "M"
module medium_arrow() {
  generic_arrow(medium_length, "M");
}

// long_arrow() — large vector, labelled "L"
module long_arrow() {
  generic_arrow(long_length, "L");
}

// ============================================================
// component_triangle(base, height)
// Right triangle to illustrate x/y component decomposition.
// Right-angle corner at origin; base along +X, height along +Y.
// ============================================================
module component_triangle(base = triangle_base,
                           height = triangle_height_mm) {
  wall = 1.0;  // mm — wall thickness for hollow interior (keeps it light)

  // Solid filled triangle
  linear_extrude(height = triangle_thickness)
    polygon(points = [
      [0,    0],
      [base, 0],
      [0,    height]
    ]);

  // Raised "vx" label along base leg
  translate([base * 0.3, -shaft_thickness - 1, triangle_thickness])
    linear_extrude(height = label_height)
      text("vx", size = 3.5, font = "Liberation Sans:style=Bold Italic",
           halign = "left", valign = "top");

  // Raised "vy" label along height leg
  translate([-shaft_thickness - 1, height * 0.3, triangle_thickness])
    rotate([0, 0, 90])
      linear_extrude(height = label_height)
        text("vy", size = 3.5, font = "Liberation Sans:style=Bold Italic",
             halign = "left", valign = "top");

  // Right-angle mark at origin corner
  ra_size = 4;
  translate([0, 0, triangle_thickness])
    linear_extrude(height = label_height * 0.5) {
      translate([0, 0]) square([ra_size, 0.8]);
      translate([0, 0]) square([0.8, ra_size]);
    }
}

// ============================================================
// print_set() — all pieces arranged on a single build plate
// ============================================================
module print_set() {
  // Short arrow — top-left
  translate([5, 60, 0])
    short_arrow();

  // Medium arrow — middle-left
  translate([5, 40, 0])
    medium_arrow();

  // Long arrow — bottom
  translate([5, 15, 0])
    long_arrow();

  // Component triangle — right side
  translate([85, 20, 0])
    component_triangle();

  // Second short arrow (pairs useful for addition demos)
  translate([5, 80, 0])
    short_arrow();

  // Second medium arrow
  translate([5, 98, 0])
    medium_arrow();
}

// ============================================================
// Demo modules
// ============================================================

// demo_default() — full print set ready for export
module demo_default() {
  print_set();
}

// demo_single() — single medium arrow for visualisation
module demo_single() {
  medium_arrow();
}

// demo_classroom() — side-by-side two print sets (two groups)
module demo_classroom() {
  print_set();
  translate([120, 0, 0])
    print_set();
}

// ============================================================
// Render
// ============================================================
demo_default();
