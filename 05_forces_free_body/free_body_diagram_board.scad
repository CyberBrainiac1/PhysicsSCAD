/*
 * Title: Free Body Diagram Board
 * Folder: 05_forces_free_body
 * Physics Topic: Newton's Laws, Force Analysis, Free Body Diagrams
 * Difficulty: Beginner
 * Print Type: flat
 * Teaches: Identifying forces on an object, direction of forces, equilibrium,
 *          Newton's First and Second Laws, standard FBD notation
 * Use Case: Students physically assemble force arrows into slots around a central
 *           object to practice constructing correct free body diagrams.
 */

// Parameters
board_size      = 120;    // mm — overall square board side length
board_thickness = 3;      // mm — base plate thickness
object_style    = "block"; // "block", "circle", or "puck"
object_size     = 25;     // mm — diameter or side length of central object
slot_count      = 8;      // number of arrow slots around the object (4 or 8)
slot_width      = 3.2;    // mm — slot width (sized for arrow peg stem)
slot_depth      = 2.5;    // mm — how deep the slot is cut into the raised ring
slot_length     = 12;     // mm — radial length of each slot
show_labels     = true;   // render raised force-name labels near each slot
incline_angle   = 0;      // degrees — tilt whole board (0 = flat/horizontal surface)

// Derived values
$fn             = 32;
slot_ring_radius = object_size * 0.5 + slot_length * 0.6; // ring on which slots sit
label_ring_radius = slot_ring_radius + slot_length * 0.85; // labels sit outside slots
border_inset    = 4;      // mm — board border raised lip width
object_raise    = 2;      // mm — how much the central object rises above board
ground_line_y   = -(board_size * 0.5 - border_inset - 6); // y position of ground line

// Physics Meaning
// The board represents the environment around a single object (the block/circle).
// Each slot corresponds to one possible force direction:
//   Slot 0 (up, 90°)    → Normal force N
//   Slot 1 (45°)        → Tension T at an angle
//   Slot 2 (right, 0°)  → Applied force F_app
//   Slot 3 (315°/-45°)  → Applied force at downward angle
//   Slot 4 (down, 270°) → Weight / Gravity W
//   Slot 5 (225°)       → (reserved for diagonal friction)
//   Slot 6 (left, 180°) → Friction f
//   Slot 7 (135°)       → Tension at angle
// Arrow pegs (from vector_arrow_kit.scad) are inserted into these slots.

// Learning Notes
// A free body diagram isolates ONE object and shows ALL forces acting ON it.
// Forces are drawn as arrows pointing AWAY from the object's center.
// The object itself is treated as a point mass — shape and size do not matter.
// Equilibrium: if ΣF = 0, the object is not accelerating (Newton's 1st Law).
// Net force: if ΣF ≠ 0, the object accelerates in the direction of ΣF (Newton's 2nd).
// Common mistakes:
//   - Drawing the reaction force (e.g., force the book exerts ON the table)
//   - Forgetting that friction opposes MOTION, not the applied force
//   - Assuming normal force always equals weight (only true on flat surfaces)

// Print Notes
// Print flat (board face up). No supports needed.
// Use brim for better adhesion of the large flat base.
// Slot openings print cleanly at 0.2 mm layer height.
// Arrow pegs from vector_arrow_kit.scad should fit snugly into the slots.
// Consider printing labels in a different filament color using pause-at-layer.

// Customization Ideas
// - Set incline_angle = 30 to show a ramp scenario (rotate axes accordingly)
// - Set slot_count = 4 for beginners (cardinal directions only)
// - Set show_labels = false for a quiz/assessment version
// - Increase board_size to 180 for a large classroom display piece
// - Pair with the friction_ramp_kit.scad for an incline scenario

// ─────────────────────────────────────────────────────────────────────────────
// Modules
// ─────────────────────────────────────────────────────────────────────────────

// Base board with raised border lip
module fbd_board() {
  difference() {
    // Solid base plate
    cube([board_size, board_size, board_thickness], center = true);
    // Inset recess so border stands proud (visual border effect)
    translate([0, 0, board_thickness * 0.25])
      cube([board_size - border_inset * 2,
            board_size - border_inset * 2,
            board_thickness], center = true);
  }
  // Raised border lip (four walls)
  difference() {
    cube([board_size, board_size, board_thickness + 1.2], center = true);
    cube([board_size - border_inset * 2,
          board_size - border_inset * 2,
          board_thickness + 2], center = true);
  }
}

// Central object (the body being analyzed)
module central_object(style = object_style, size = object_size) {
  raise = board_thickness * 0.5 + object_raise;
  translate([0, 0, raise]) {
    if (style == "block") {
      cube([size, size, object_raise * 1.5], center = true);
    } else if (style == "circle") {
      cylinder(r = size * 0.5, h = object_raise * 1.5, center = true);
    } else if (style == "puck") {
      cylinder(r = size * 0.55, h = object_raise * 0.8, center = true);
    }
  }
}

// Ground line — raised bar below the object representing the surface
module ground_line() {
  ground_y = -(object_size * 0.5 + 14);
  translate([0, ground_y, board_thickness * 0.5])
    cube([board_size - border_inset * 4, 2, 1.5], center = true);
  // Cross-hatch marks below ground line (surface indicator)
  for (i = [-4:1:4]) {
    translate([i * 10, ground_y - 4, board_thickness * 0.5])
      rotate([0, 0, -45])
        cube([1, 8, 1], center = true);
  }
}

// Single arrow slot at a given angle around the object
module single_arrow_slot(angle_deg) {
  rotate([0, 0, angle_deg]) {
    translate([slot_ring_radius, 0, board_thickness * 0.5 + object_raise * 0.5]) {
      // Raised guide channel
      cube([slot_length, slot_width + 2, object_raise], center = true);
      // Slot cut — the arrow peg stem fits here
      translate([0, 0, 0.5])
        cube([slot_length + 1, slot_width, slot_depth], center = true);
    }
  }
}

// Ring of arrow slots around the central object
module arrow_slot_ring(count = slot_count,
                       ring_r = slot_ring_radius,
                       s_w = slot_width,
                       s_l = slot_length,
                       s_d = slot_depth) {
  angle_step = 360 / count;
  for (i = [0 : count - 1]) {
    single_arrow_slot(i * angle_step);
  }
}

// Raised text label near a slot position
module force_label(label_text, angle_deg) {
  lx = label_ring_radius * cos(angle_deg);
  ly = label_ring_radius * sin(angle_deg);
  translate([lx, ly, board_thickness * 0.5 + 1.0])
    rotate([0, 0, 0])
      linear_extrude(height = 1.2)
        text(label_text,
             size = 5,
             halign = "center",
             valign = "center",
             font = "Liberation Sans:style=Bold");
}

// Place all direction labels around the board
module all_force_labels() {
  if (show_labels) {
    angle_step = 360 / slot_count;
    // Label map: index → label string based on 8-slot layout (0° = right/East)
    label_map = ["F_app", "T", "N", "T", "W", "f", "f", "T"];
    for (i = [0 : slot_count - 1]) {
      a = i * angle_step;
      force_label(label_map[i], a);
    }
  }
}

// Axis indicator arrows (x/y) for incline mode
module axis_indicator() {
  z = board_thickness * 0.5 + 1;
  cx = board_size * 0.5 - border_inset - 14;
  cy = board_size * 0.5 - border_inset - 14;
  translate([cx, cy, z]) {
    // x-axis arrow
    hull() {
      cube([14, 1.2, 1], center = true);
      translate([7, 0, 0]) cube([1, 3, 1], center = true);
    }
    // y-axis arrow
    hull() {
      cube([1.2, 14, 1], center = true);
      translate([0, 7, 0]) cube([3, 1, 1], center = true);
    }
    translate([9, -4, 0])
      linear_extrude(1.2) text("x", size = 4, halign = "center");
    translate([-4, 9, 0])
      linear_extrude(1.2) text("y", size = 4, halign = "center");
  }
}

// Complete FBD board assembly
module fbd_board_assembly() {
  fbd_board();
  central_object();
  ground_line();
  arrow_slot_ring();
  all_force_labels();
  axis_indicator();
}

// ─────────────────────────────────────────────────────────────────────────────
// Demo modules
// ─────────────────────────────────────────────────────────────────────────────

// Default demo — flat board, block object, 8 slots with labels
module demo_default() {
  fbd_board_assembly();
}

// Incline demo — tilt the board and add incline angle label
module demo_incline() {
  tilt = 25; // degrees for demonstration
  rotate([0, tilt, 0]) {
    fbd_board_assembly();
  }
  // Flat base wedge so the tilted board can sit on a table
  color("gray", 0.4)
    translate([board_size * 0.3, 0, -board_size * 0.5 * sin(tilt) * 0.5])
      cube([board_size * 0.5, board_size - border_inset * 2,
            board_size * sin(tilt)], center = true);
}

// ─────────────────────────────────────────────────────────────────────────────
// Render
// ─────────────────────────────────────────────────────────────────────────────

demo_default();
// Uncomment to preview incline mode:
// demo_incline();
