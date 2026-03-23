/*
 * Title: Pendulum Geometry Guide Board
 * Folder: 16_oscillations_shm
 * Physics Topic: Simple Pendulum, Restoring Force, Period vs Length
 * Difficulty: Beginner
 * Print Type: flat
 * Teaches: T=2π√(L/g), restoring force F=-mgsinθ, period independent of mass
 * Use Case: Classroom reference board; compare arc lengths for three pendulum lengths
 */

// --------------------
// Parameters
// --------------------
board_width          = 120;   // mm
board_height         = 130;   // mm
board_thickness      = 3;     // mm
pivot_height         = 110;   // mm from board bottom — pivot point y position
pendulum_lengths     = [40, 60, 80];  // mm — three pendulum lengths displayed
swing_angle          = 20;    // degrees — max swing angle from vertical
show_period_labels   = true;  // raised ratio markers "T∝√L"
show_force_components = true; // force decomposition arrows on longest pendulum
show_equilibrium_line = true; // vertical line from pivot downward

// --------------------
// Physics Meaning
// --------------------
// Period of a simple pendulum: T = 2π · √(L/g)
// T depends ONLY on length L and g — not on mass or amplitude (small angles).
// Restoring force: F_tang = −mg · sin(θ) ≈ −mg · θ  (small angle approximation)
// The tangential component of gravity pulls the bob back toward equilibrium.

// --------------------
// Learning Notes
// --------------------
// - Doubling L multiplies T by √2 ≈ 1.41
// - The three arcs show visually that longer pendulums swing through larger paths
// - Force components: gravity (down), tension (along string), restoring (tangential)
// - At equilibrium: restoring force = 0; at max angle: restoring force = max

// --------------------
// Print Notes
// --------------------
// - Print flat; no supports needed
// - 0.2 mm layer height for clean arc curves
// - PLA at 15% infill

// --------------------
// Customization Ideas
// --------------------
// - Change pendulum_lengths to [30, 60, 120] for a cleaner 1:√2:2 period ratio
// - Increase swing_angle to 35° to discuss small-angle approximation limits
// - Add a fourth pendulum for a double-length comparison

$fn = 64;

feature_h    = 1.5;   // mm raised features height
arc_w        = 1.5;   // mm arc line width
dot_d        = 6;     // mm pivot dot diameter
arrow_w      = 2;     // mm force arrow width
pivot_x      = board_width / 2;
pivot_y      = pivot_height;

// --------------------
// Board base
// --------------------
module board_base() {
  cube([board_width, board_height, board_thickness]);
}

// --------------------
// Pivot dot
// --------------------
module pivot_dot() {
  translate([pivot_x, pivot_y, board_thickness])
    cylinder(h=feature_h * 1.5, d=dot_d, $fn=32);
}

// --------------------
// Equilibrium line (vertical from pivot downward)
// --------------------
module equilibrium_line() {
  longest = pendulum_lengths[len(pendulum_lengths)-1];
  translate([pivot_x - arc_w/2, pivot_y - longest - 5, board_thickness])
    cube([arc_w, longest + 5, feature_h * 0.6]);
}

// --------------------
// Single pendulum arc
// --------------------
module pendulum_arc(length, label_id) {
  n_pts    = 40;
  half_pts = n_pts / 2;

  // Outer arc points
  outer_pts = [for (i = [0 : n_pts])
    let(ang = -swing_angle + i * (2 * swing_angle) / n_pts)
    [(pivot_x + (length + arc_w/2) * sin(ang)),
     (pivot_y - (length + arc_w/2) * cos(ang))]
  ];

  // Inner arc points (reversed for polygon winding)
  inner_pts = [for (i = [n_pts : -1 : 0])
    let(ang = -swing_angle + i * (2 * swing_angle) / n_pts)
    [(pivot_x + (length - arc_w/2) * sin(ang)),
     (pivot_y - (length - arc_w/2) * cos(ang))]
  ];

  all_pts = concat(outer_pts, inner_pts);

  translate([0, 0, board_thickness])
    linear_extrude(height = feature_h)
      polygon(all_pts);

  // Bob dot at center (equilibrium bottom)
  translate([pivot_x, pivot_y - length, board_thickness])
    cylinder(h=feature_h, d=4, $fn=16);

  // Label tick at left extreme of arc
  lx = pivot_x + length * sin(-swing_angle);
  ly = pivot_y - length * cos(swing_angle);
  translate([lx - 3, ly - 3, board_thickness])
    cylinder(h=feature_h, d=3, $fn=8);
}

// --------------------
// Force component arrows on the longest pendulum
// --------------------
module force_components() {
  length  = pendulum_lengths[len(pendulum_lengths)-1];
  ang     = swing_angle;
  bob_x   = pivot_x + length * sin(ang);
  bob_y   = pivot_y - length * cos(ang);
  g_len   = 15;  // gravity arrow length
  t_len   = 10;  // tangential component length

  translate([0, 0, board_thickness]) {
    // Gravity arrow (straight down)
    translate([bob_x - arrow_w/2, bob_y - g_len, 0])
      cube([arrow_w, g_len, feature_h]);
    // Tangential component (perpendicular to string, pointing toward equilibrium)
    rotate_about = [bob_x, bob_y, 0];
    translate([bob_x, bob_y, 0])
      rotate([0, 0, -(90 - ang)])
        translate([-arrow_w/2, -t_len, 0])
          cube([arrow_w, t_len, feature_h]);
  }
}

// --------------------
// Period ratio label bar
// --------------------
module period_label_bar() {
  // Raised horizontal bar as "T∝√L" placeholder label
  translate([5, 10, board_thickness])
    cube([30, 2, feature_h]);
  translate([5, 14, board_thickness])
    cube([20, 2, feature_h]);
}

// --------------------
// pendulum_guide() — main model
// --------------------
module pendulum_guide() {
  union() {
    board_base();
    pivot_dot();
    if (show_equilibrium_line) equilibrium_line();
    for (i = [0 : len(pendulum_lengths) - 1]) {
      pendulum_arc(pendulum_lengths[i], i);
    }
    if (show_force_components) force_components();
    if (show_period_labels)    period_label_bar();
  }
}

// --------------------
// demo_default()
// --------------------
module demo_default() {
  pendulum_guide();
}

// --------------------
// demo_single_pendulum(length_mm)
// --------------------
module demo_single_pendulum(length_mm=60) {
  board_base();
  pivot_dot();
  if (show_equilibrium_line) equilibrium_line();
  pendulum_arc(length_mm, 0);
}

// Run default demo
demo_default();
