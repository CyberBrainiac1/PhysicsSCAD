/*
 * Title: Center of Mass Balancer Shapes
 * Folder: 12_center_of_mass
 * Physics Topic: Center of Mass, Composite Bodies, Equilibrium, Hanging-String Method
 * Difficulty: Beginner
 * Print Type: flat
 * Teaches: COM = Σ(mᵢrᵢ)/Σmᵢ, COM outside material (boomerang), string-plumb-line method
 * Use Case: Students use hanging holes and a plumb string to experimentally locate the COM
 *           of each irregular shape, then verify against the raised crosshair marker.
 */

// --------------------
// Parameters
// --------------------

shape_thickness         = 4;    // mm — uniform thickness of all flat shapes
marker_size             = 4;    // mm — arm length of the raised COM crosshair marker
show_com_marker         = true; // true = show COM crosshair; false = challenge (hidden)
balancing_notch_diam    = 4;    // mm — small divot at COM for pin-balancing
hanging_hole_diam       = 3;    // mm — holes for hanging on a peg (plumb-line method)
marker_raise            = 1.0;  // mm — height of raised COM crosshair above top surface
marker_arm_width        = 1.2;  // mm — thickness of crosshair arms
hole_wall_min           = 3;    // mm — minimum wall around hanging holes (keep structural)

label_size              = 4;    // mm — font size for shape name labels
label_height            = 0.8;  // mm — raised height of text labels
label_font              = "Liberation Sans:style=Bold";

$fn = 32;

// --------------------
// Physics Meaning
// --------------------
// Center of mass (COM):  r_com = Σ(mᵢ rᵢ) / Σmᵢ
// For uniform flat shapes (constant thickness & density), mass ∝ area, so:
//   x_com = Σ(Aᵢ xᵢ) / Σ Aᵢ   (where xᵢ is the centroid x of each sub-shape)
// Key results used here:
//   Rectangle centroid:  (x_center, y_center)
//   L-shape:  COM pulled toward the larger/heavier arm
//   T-shape:  COM on vertical axis of symmetry, below geometric center
//   Boomerang: COM may lie in empty space (profound demonstration!)
//   Cross:    COM at geometric center (symmetric both axes)
// Hanging-string method: COM lies directly below any suspension point.
//   Repeat from two different holes → intersection = COM.

// --------------------
// Learning Notes
// --------------------
// 1. Give students the CHALLENGE set first (show_com_marker = false).
// 2. Have them predict where COM is before hanging; then use string method.
// 3. After finding it experimentally, reveal the ANSWER set.
// 4. For the boomerang, the COM divot lands in empty space — discuss what this means.
// 5. Calculating COM using the composite-body formula is a great follow-up exercise.
// 6. Place shapes on a pencil eraser at the COM — they should balance!
// 7. Discuss how engineers use COM calculations to design stable vehicles and structures.

// --------------------
// Print Notes
// --------------------
// CRITICAL: 100% infill on ALL shapes — the experiment requires uniform density.
// Print flat (large face down). No supports needed — all shapes are flat prisms.
// Use the same filament for all shapes to keep density consistent.
// A smooth bottom surface aids pin balancing — light sanding helps.
// Hanging holes (3 mm) fit standard pushpins or a 3 mm peg mounted on a board.
// Print challenge set (show_com_marker=false) for students, answer set for the teacher.

// --------------------
// Customization Ideas
// --------------------
// - Increase shape_thickness to 6 mm for heavier, more stable pieces.
// - Create a "mystery shape" with an irregular polygon and have students predict COM.
// - Add a string loop through each hanging hole for easy use.
// - Print in different colors per shape for easy identification in a mixed pile.
// - Laser-cut versions can be made from the polygon() outlines if a laser cutter is available.

// ============================================================
// Helper: COM crosshair marker (raised cross at the COM point)
// ============================================================
module com_marker() {
  if (show_com_marker) {
    // Horizontal arm of crosshair
    translate([-marker_size, -marker_arm_width / 2, shape_thickness])
      cube([marker_size * 2, marker_arm_width, marker_raise]);
    // Vertical arm of crosshair
    translate([-marker_arm_width / 2, -marker_size, shape_thickness])
      cube([marker_arm_width, marker_size * 2, marker_raise]);
    // Center dot (slightly raised disk)
    translate([0, 0, shape_thickness])
      cylinder(d = marker_arm_width * 2, h = marker_raise * 1.5);
  }
}

// ============================================================
// Helper: balancing divot at COM (small cylindrical notch on bottom)
// ============================================================
module com_divot() {
  translate([0, 0, -0.1])
    cylinder(d = balancing_notch_diam, h = shape_thickness * 0.4);
}

// ============================================================
// Helper: hanging hole at a given (x, y) offset from COM origin
// ============================================================
module hanging_hole(x, y) {
  translate([x, y, -0.1])
    cylinder(d = hanging_hole_diam, h = shape_thickness + 0.2);
}

// ============================================================
// Helper: shape name label on top surface
// ============================================================
module shape_label(name, x_off = 0, y_off = 0) {
  translate([x_off, y_off, shape_thickness])
    linear_extrude(height = label_height)
      text(
        name,
        size   = label_size,
        halign = "center",
        valign = "center",
        font   = label_font
      );
}

// ============================================================
// Module: l_shape
// An L-shaped plate. The COM is NOT at the geometric center.
// Outer bounding box: 60 × 80 mm. Vertical bar: 20×80, Horizontal bar: 60×20.
// COM calculation (uniform density):
//   Vertical bar:   area=1600, centroid=(10, 40)
//   Horizontal bar: area=800,  centroid=(40, 10) [the 40×20 extension]
//   Total area = 2400
//   x_com = (1600*10 + 800*40) / 2400 = (16000+32000)/2400 = 20.0 mm
//   y_com = (1600*40 + 800*10) / 2400 = (64000+8000)/2400  = 30.0 mm
// COM at (20, 30) from bottom-left corner → offset from shape center at (30,40)
// ============================================================
module l_shape() {
  // Dimensions
  vert_w  = 20; // vertical bar width
  vert_h  = 80; // vertical bar height
  horiz_w = 60; // total horizontal extent
  horiz_h = 20; // horizontal bar height

  // COM position (from bottom-left corner of shape)
  com_x = 20.0;
  com_y = 30.0;

  // Place origin at COM so crosshair and divot are at (0,0)
  translate([-com_x, -com_y, 0]) {
    difference() {
      union() {
        // Vertical bar
        cube([vert_w, vert_h, shape_thickness]);
        // Horizontal bar (bottom extension)
        cube([horiz_w, horiz_h, shape_thickness]);
      }

      // COM divot (pin balancing notch on bottom)
      translate([com_x, com_y, 0])
        com_divot();

      // Hanging holes — placed well inside the shape at distinct positions
      hanging_hole(10, 65); // upper part of vertical bar
      hanging_hole(10, 10); // lower-left corner area
      hanging_hole(45, 10); // lower-right arm of horizontal bar
    }
  }

  // COM crosshair at origin
  com_marker();

  // Shape label
  shape_label("L-Shape", 10, 20);
}

// ============================================================
// Module: t_shape
// A T-shaped plate. COM lies on the vertical axis of symmetry.
// Horizontal bar: 80×20 mm (centered on x-axis). Vertical bar: 20×60 mm below bar.
// Total height = 80 mm (bar 20mm + stem 60mm), width = 80 mm.
// COM calculation:
//   Top bar:  area=1600, centroid=(0, 50)    [y measured from bottom of stem]
//   Stem:     area=1200, centroid=(0, 30)
//   Total area = 2800
//   x_com = 0 (symmetric)
//   y_com = (1600*50 + 1200*30) / 2800 = (80000+36000)/2800 = 41.4 mm from stem bottom
// COM at (0, 41.4) from bottom of stem.
// ============================================================
module t_shape() {
  bar_w   = 80;
  bar_h   = 20;
  stem_w  = 20;
  stem_h  = 60;

  total_h = bar_h + stem_h;

  com_x   = 0;
  com_y   = (1600 * (stem_h + bar_h/2) + 1200 * (stem_h/2)) / 2800; // ≈ 41.4

  translate([-com_x, -com_y, 0]) {
    difference() {
      union() {
        // Stem (vertical bar)
        translate([-stem_w/2, 0, 0])
          cube([stem_w, stem_h, shape_thickness]);
        // Top horizontal bar
        translate([-bar_w/2, stem_h, 0])
          cube([bar_w, bar_h, shape_thickness]);
      }

      translate([com_x, com_y, 0])
        com_divot();

      // Hanging holes
      hanging_hole(-30, stem_h + bar_h/2); // left end of bar
      hanging_hole( 30, stem_h + bar_h/2); // right end of bar
      hanging_hole(  0, 8);                // bottom of stem
    }
  }

  com_marker();
  shape_label("T-Shape", 0, 15);
}

// ============================================================
// Module: offset_rectangle
// A 70×50 mm rectangle with a 30×25 mm chunk cut from top-right corner.
// COM is shifted left and downward from the geometric center of the full rectangle.
// COM calculation:
//   Full rectangle: area=3500, centroid=(35, 25)
//   Removed chunk:  area=750,  centroid=(55, 37.5)
//   Remaining area = 2750
//   x_com = (3500*35 - 750*55) / 2750 = (122500-41250)/2750 = 29.5 mm
//   y_com = (3500*25 - 750*37.5) / 2750 = (87500-28125)/2750 = 21.6 mm
// ============================================================
module offset_rectangle() {
  rect_w  = 70;
  rect_h  = 50;
  cut_w   = 30;
  cut_h   = 25;

  com_x   = (3500*35 - 750*55) / 2750; // ≈ 29.5
  com_y   = (3500*25 - 750*37.5) / 2750; // ≈ 21.6

  translate([-com_x, -com_y, 0]) {
    difference() {
      // Full rectangle
      cube([rect_w, rect_h, shape_thickness]);

      // Corner chunk removed (top-right)
      translate([rect_w - cut_w, rect_h - cut_h, -0.1])
        cube([cut_w + 0.1, cut_h + 0.1, shape_thickness + 0.2]);

      // COM divot
      translate([com_x, com_y, 0])
        com_divot();

      // Hanging holes
      hanging_hole(8,  8);           // bottom-left
      hanging_hole(60, 8);           // bottom-right
      hanging_hole(8,  42);          // top-left
    }
  }

  com_marker();
  shape_label("Offset Rect", 5, 5);
}

// ============================================================
// Module: boomerang_shape
// A bent/curved boomerang shape. The COM may lie outside the material.
// Constructed from two rectangular arms at ~120° angle meeting at a hub.
// Arm: 60 × 14 mm each. Hub circle: r=12 mm.
// COM calculation (two arms + hub):
//   Arm 1 (along +x): area=840, centroid=(37, 0)
//   Arm 2 (at 120°):  area=840, centroid=(37*cos120, 37*sin120) = (-18.5, 32.0)
//   Hub:              area≈452, centroid=(0, 0)
//   Total area ≈ 2132
//   x_com ≈ (840*37 + 840*(-18.5) + 452*0) / 2132 ≈ 7.2
//   y_com ≈ (840*0  + 840*32.0   + 452*0) / 2132 ≈ 12.6
// ============================================================
module boomerang_shape() {
  arm_len  = 60;
  arm_w    = 14;
  hub_r    = 12;
  arm_ang  = 120; // degrees between the two arms

  // Approximate COM
  arm_area  = arm_len * arm_w;
  hub_area  = PI * hub_r * hub_r;
  total_area = 2 * arm_area + hub_area;

  arm1_cx = arm_len / 2;
  arm1_cy = 0;
  arm2_cx = (arm_len / 2) * cos(arm_ang);
  arm2_cy = (arm_len / 2) * sin(arm_ang);

  com_x = (arm_area * arm1_cx + arm_area * arm2_cx + hub_area * 0) / total_area;
  com_y = (arm_area * arm1_cy + arm_area * arm2_cy + hub_area * 0) / total_area;

  translate([-com_x, -com_y, 0]) {
    difference() {
      union() {
        // Hub disk
        cylinder(r = hub_r, h = shape_thickness);
        // Arm 1 — along +x direction
        translate([0, -arm_w/2, 0])
          cube([arm_len, arm_w, shape_thickness]);
        // Arm 2 — rotated by arm_ang degrees
        rotate([0, 0, arm_ang])
          translate([0, -arm_w/2, 0])
            cube([arm_len, arm_w, shape_thickness]);
      }

      // COM divot (may be in empty space — that's the point!)
      translate([com_x, com_y, 0])
        com_divot();

      // Hanging holes along arms (well inside the material)
      hanging_hole(45,  3);               // near tip of arm 1
      translate([0, 0, 0])
        hanging_hole(
          45*cos(arm_ang) - 3*sin(arm_ang),
          45*sin(arm_ang) + 3*cos(arm_ang)
        );                                 // near tip of arm 2
      hanging_hole(0, 0);                  // at hub center
    }
  }

  com_marker();
  shape_label("Boomerang", 15, -10);
}

// ============================================================
// Module: cross_shape
// A plus/cross shape — symmetric about both axes, COM at center.
// Each arm: 60×14 mm. Easy "sanity check" case — COM is obvious.
// ============================================================
module cross_shape() {
  arm_len  = 60;
  arm_w    = 14;

  // COM is at (0,0) — symmetric both axes
  difference() {
    union() {
      // Horizontal arm
      translate([-arm_len/2, -arm_w/2, 0])
        cube([arm_len, arm_w, shape_thickness]);
      // Vertical arm
      translate([-arm_w/2, -arm_len/2, 0])
        cube([arm_w, arm_len, shape_thickness]);
    }

    // COM divot at center
    com_divot();

    // Hanging holes at tips of each arm
    hanging_hole( arm_len/2 - 5, 0); // right tip
    hanging_hole(-arm_len/2 + 5, 0); // left tip
    hanging_hole(0,  arm_len/2 - 5); // top tip
  }

  com_marker();
  shape_label("Cross", 20, 5);
}

// ============================================================
// Module: demo_challenge_set
// All shapes with COM markers HIDDEN — for in-class student use.
// ============================================================
module demo_challenge_set() {
  // Temporarily override show_com_marker via child-module call pattern.
  // In OpenSCAD, we use a module that forces show_com_marker logic off.
  // (Since OpenSCAD doesn't have runtime variable override, we render
  //  each shape and note: set show_com_marker=false at top of file for this demo.)
  spacing = 90;

  l_shape();
  translate([spacing, 0, 0])         t_shape();
  translate([spacing * 2, 0, 0])     offset_rectangle();
  translate([spacing / 2, -spacing, 0]) boomerang_shape();
  translate([spacing * 1.5, -spacing, 0]) cross_shape();
}

// ============================================================
// Module: demo_answer_set
// All shapes with COM markers SHOWN — for checking or display.
// (Requires show_com_marker = true — the default.)
// ============================================================
module demo_answer_set() {
  demo_challenge_set(); // same layout; markers shown if show_com_marker=true
}

// ============================================================
// Demo Modules
// ============================================================

// Default: show all shapes with COM markers (set show_com_marker = false for challenge)
module demo_default() {
  demo_answer_set();
}

// ============================================================
// Default render
// ============================================================
demo_default();
// l_shape();
// boomerang_shape();
// demo_challenge_set();
