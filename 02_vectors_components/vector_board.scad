// =============================================================================
// Title:       Vector Board
// Folder:      02_vectors_components
// Physics:     Vectors, Components, and Coordinate Systems
// Difficulty:  Beginner
// Print Type:  Reference Board
// Teaches:     Vector direction, quadrants, standard-position angles, decomposition
// Use Case:    AP Physics 1 | F=ma | FTC Robotics | All
// =============================================================================

// ============================================================
// vector_board.scad
// PhysicsSCAD — 02_vectors_components
// ============================================================
// Flat square board with:
//   • Raised grid lines (grid_spacing apart)
//   • Raised x-axis and y-axis (thicker) through centre
//   • Quadrant labels I, II, III, IV
//   • Radial tick marks at 15° intervals and angle labels
//     at 0°, 30°, 45°, 60°, 90° (and reflections)
//   • Optional row of arrow-storage slots along the bottom
//   • Solid raised border
//
// Pair with vector_arrow_kit.scad for full lesson set.
// ============================================================

use <../common/arrows.scad>;

// --------------------------------------------------------
// Physics Meaning
// --------------------------------------------------------
// The coordinate plane is the universal language of 2-D mechanics.
// Every vector has a tail (starting point) and a head (arrowhead).
// Angle θ is measured counter-clockwise from the positive x-axis
// in standard position. The components are:
//   vx = |v| · cos(θ)    vy = |v| · sin(θ)
// Reading the board: the grid allows magnitude estimation; the
// degree marks allow angle reading without a protractor.

// --------------------------------------------------------
// Learning Notes
// --------------------------------------------------------
// • Quadrant signs: (Q1: +,+) (Q2: −,+) (Q3: −,−) (Q4: +,−)
// • 30°–60°–90° triangle ratios: 1 : √3 : 2
// • 45°–45°–90° triangle ratios: 1 : 1 : √2
// • Adding vectors: tip-to-tail, then draw resultant tail-to-tip
// • Dot product: A · B = |A||B|cos(θ) — angle between them matters

// --------------------------------------------------------
// Print Notes
// --------------------------------------------------------
// • Flat on bed, no supports
// • White/light grey PLA recommended for legible grid
// • Layer height 0.2 mm; increase infill to 25% for rigidity
// • The board is large (120 mm) — ensure bed is level across full area
// • Raised text may need 0.15 mm layer height for crispness

// --------------------------------------------------------
// Customization Ideas
// --------------------------------------------------------
// • Set board_size = 180 for an A5-sized class demo board
// • Set grid_spacing = 5 for a finer resolution grid
// • Adjust slot_width to match your arrow kit's peg diameter
// • Set show_degree_marks = false for a simpler beginners' version

$fn = 32;

// ------------------------------------------------------------
// Parameters
// ------------------------------------------------------------

board_size           = 120;  // mm — square board side length
grid_spacing         = 10;   // mm — spacing between grid lines
axis_thickness       = 1.5;  // mm — width of raised x/y axes
grid_line_thickness  = 0.6;  // mm — width of raised grid lines
plate_thickness      = 3;    // mm — base plate thickness
feature_height       = 1.2;  // mm — raised height of grid, axes, text
show_grid            = true; // render background grid
show_quadrant_labels = true; // render I, II, III, IV labels
show_degree_marks    = true; // render radial tick marks and angle labels
slot_width           = 3;    // mm — arrow-peg slot width
slot_depth           = 2;    // mm — arrow-peg slot depth into plate
border_width         = 4;    // mm — solid border width around board
degree_radius        = 45;   // mm — radial distance from centre to tick marks
label_size           = 5;    // mm — font size for axis / quadrant labels
angle_label_size     = 3.2;  // mm — font size for degree labels

// Derived
half = board_size / 2;
cx   = half;  // centre x (also = half since origin is at corner)
cy   = half;  // centre y

// ============================================================
// Sub-modules
// ============================================================

// ------------------------------------------------------------
// grid_layer() — raised background grid lines
// ------------------------------------------------------------
module grid_layer() {
  num_lines = floor(board_size / grid_spacing);
  line_h    = feature_height * 0.5;  // grid lines slightly lower than axes

  for (i = [1 : num_lines - 1]) {
    x = i * grid_spacing;
    // Vertical grid line
    translate([x, 0, 0])
      cube([grid_line_thickness, board_size, line_h]);
    // Horizontal grid line
    translate([0, x, 0])
      cube([board_size, grid_line_thickness, line_h]);
  }
}

// ------------------------------------------------------------
// axis_layer() — raised x and y axes through board centre
// ------------------------------------------------------------
module axis_layer() {
  // x-axis — horizontal bar through cy
  translate([0, cy - axis_thickness/2, 0])
    cube([board_size, axis_thickness, feature_height]);
  // y-axis — vertical bar through cx
  translate([cx - axis_thickness/2, 0, 0])
    cube([axis_thickness, board_size, feature_height]);
}

// ------------------------------------------------------------
// quadrant_label_layer() — I, II, III, IV text in each quadrant
// ------------------------------------------------------------
module quadrant_label_layer() {
  offset = 15;  // mm from centre to label position
  labels = [["I",   cx + offset, cy + offset],
            ["II",  cx - offset, cy + offset],
            ["III", cx - offset, cy - offset],
            ["IV",  cx + offset, cy - offset]];

  for (lbl = labels) {
    translate([lbl[1] - label_size * 0.7, lbl[2] - label_size * 0.6, 0])
      linear_extrude(height = feature_height)
        text(lbl[0], size = label_size,
             font = "Liberation Sans:style=Bold",
             halign = "center", valign = "center");
  }
}

// ------------------------------------------------------------
// angle_mark_layer() — radial ticks every 15° plus labels
// ------------------------------------------------------------
module angle_mark_layer() {
  tick_w    = 0.8;     // mm — tick width
  tick_len  = 3.5;     // mm — tick length (radial)
  major_angles = [0, 30, 45, 60, 90, 120, 135, 150,
                  180, 210, 225, 240, 270, 300, 315, 330];
  labeled_angles = [0, 30, 45, 60, 90, 135, 150, 180,
                    210, 225, 240, 270, 315, 330];

  for (deg = [0, 15, 30, 45, 60, 75, 90, 105, 120, 135,
              150, 165, 180, 195, 210, 225, 240, 255,
              270, 285, 300, 315, 330, 345]) {
    is_major = (deg % 30 == 0) || (deg % 45 == 0);
    t_len    = is_major ? tick_len : tick_len * 0.6;
    r_inner  = degree_radius;
    r_outer  = degree_radius + t_len;

    translate([cx, cy, 0])
    rotate([0, 0, deg])
      translate([r_inner, -tick_w/2, 0])
        cube([r_outer - r_inner, tick_w, feature_height]);
  }

  // Angle labels at key angles
  key_labels = [[0,   "0°"],
                [30,  "30°"],
                [45,  "45°"],
                [60,  "60°"],
                [90,  "90°"],
                [120, "120°"],
                [150, "150°"],
                [180, "180°"],
                [270, "270°"]];

  label_r = degree_radius + 6;
  for (entry = key_labels) {
    a = entry[0];
    lbl = entry[1];
    lx = cx + label_r * cos(a) - angle_label_size * 0.9;
    ly = cy + label_r * sin(a) - angle_label_size * 0.5;
    translate([lx, ly, 0])
      linear_extrude(height = feature_height * 0.8)
        text(lbl, size = angle_label_size,
             font = "Liberation Sans",
             halign = "center", valign = "center");
  }
}

// ------------------------------------------------------------
// arrow_slots() — storage slots along bottom exterior edge
// Slots allow arrow pegs to slide in for storage.
// ------------------------------------------------------------
module arrow_slots() {
  num_slots  = 6;
  slot_gap   = (board_size - border_width * 2) / (num_slots + 1);
  slot_h     = slot_depth;
  slot_len   = 8;  // mm — slot length (direction along bottom edge)

  for (i = [1 : num_slots]) {
    sx = border_width + i * slot_gap - slot_width / 2;
    // Recess into plate (subtract — must be applied in vector_board difference)
    translate([sx, border_width / 2 - slot_len / 2, plate_thickness - slot_h])
      cube([slot_width, slot_len, slot_h + 0.1]);
  }
}

// ------------------------------------------------------------
// border_frame() — solid raised border around board perimeter
// ------------------------------------------------------------
module border_frame() {
  bh = feature_height * 0.6;
  difference() {
    cube([board_size, board_size, bh]);
    translate([border_width, border_width, -0.1])
      cube([board_size - 2*border_width,
            board_size - 2*border_width,
            bh + 0.2]);
  }
}

// ============================================================
// vector_board() — main assembly
// ============================================================
module vector_board() {
  difference() {
    union() {
      // Base plate
      cube([board_size, board_size, plate_thickness]);

      // Raised border
      translate([0, 0, plate_thickness])
        border_frame();

      // Grid
      if (show_grid) {
        translate([0, 0, plate_thickness])
          grid_layer();
      }

      // Axes
      translate([0, 0, plate_thickness])
        axis_layer();

      // Quadrant labels
      if (show_quadrant_labels) {
        translate([0, 0, plate_thickness])
          quadrant_label_layer();
      }

      // Degree marks and labels
      if (show_degree_marks) {
        translate([0, 0, plate_thickness])
          angle_mark_layer();
      }

      // "x" axis label — right side
      translate([board_size - border_width - 7, cy + 2, plate_thickness])
        linear_extrude(height = feature_height)
          text("x", size = label_size,
               font = "Liberation Sans:style=Bold Italic");

      // "y" axis label — top
      translate([cx + 2, board_size - border_width - 7, plate_thickness])
        linear_extrude(height = feature_height)
          text("y", size = label_size,
               font = "Liberation Sans:style=Bold Italic");
    }

    // Cut arrow storage slots into base plate
    arrow_slots();
  }
}

// ============================================================
// Demo modules
// ============================================================

// demo_default() — single board, all features on
module demo_default() {
  vector_board();
}

// demo_classroom() — two boards side by side (paired activity)
module demo_classroom() {
  vector_board();
  translate([board_size + 8, 0, 0])
    vector_board();
}

// ============================================================
// Render
// ============================================================
demo_default();
