/*
 * Title: Momentum & Collision Tokens
 * Folder: 09_momentum_impulse
 * Physics Topic: Conservation of Momentum, Impulse, Elastic & Inelastic Collisions
 * Difficulty: Beginner
 * Print Type: token/flat
 * Teaches: p=mv, conservation of momentum, elastic vs. inelastic collisions, impulse J=FΔt
 * Use Case: Students slide mass tokens along a lane board to observe 1D collisions and
 *           verify momentum conservation before and after impact.
 */

// --------------------
// Parameters
// --------------------

token_thickness        = 6;    // mm — height of each puck token
light_token_diameter   = 30;   // mm — diameter of the "1m" mass token
heavy_token_diameter   = 40;   // mm — diameter of the "2m" mass token (larger = heavier)
velocity_slot_width    = 3;    // mm — width of side slot for velocity arrow card
velocity_slot_depth    = 2;    // mm — how deep the slot cuts into the token side
velocity_slot_length   = 14;   // mm — arc length of the slot
show_mass_label        = true; // render raised mass label on top of token

lane_board_width       = 180;  // mm — total board length along the collision direction
lane_board_height      = 60;   // mm — board width (perpendicular to collision direction)
lane_board_thickness   = 3;    // mm — flat board thickness

lane_width             = 20;   // mm — width of each sliding channel
lane_depth             = 1.5;  // mm — groove depth for token sliding guide
tick_spacing           = 10;   // mm — spacing between position tick marks on the lane
tick_height            = 0.8;  // mm — raised height of tick marks
tick_width             = 1;    // mm — width of each tick mark line
center_mark_width      = 3;    // mm — width of the center collision divider mark

label_height           = 0.8;  // mm — raised height of text labels
label_size             = 6;    // mm — font size for token mass labels

$fn = 32;

// --------------------
// Physics Meaning
// --------------------
// Linear momentum:   p = m * v          (kg⋅m/s)
// Conservation law:  p_total_before = p_total_after  (in a closed system)
// Impulse:           J = F * Δt = Δp    (same units as momentum)
// Elastic collision: both momentum AND kinetic energy conserved
// Inelastic:         only momentum conserved; KE lost to heat/sound/deformation
// For equal masses elastic collision: the moving token stops, the stationary one moves.
// Key insight: mass token diameter is proportional — heavier tokens are bigger pucks.

// --------------------
// Learning Notes
// --------------------
// 1. Have students predict post-collision velocities BEFORE sliding tokens.
// 2. Use tick marks to estimate sliding distance as a proxy for velocity magnitude.
// 3. Compare 1m→1m, 1m→2m, and 2m→1m scenarios — results differ dramatically.
// 4. Sticky-putty between tokens demonstrates perfectly inelastic collisions.
// 5. The velocity slot accepts a paper arrow card for direction/speed visualization.
// 6. The center mark on the lane shows the collision point for reproducibility.

// --------------------
// Print Notes
// --------------------
// Print tokens flat (circular face down). No supports needed.
// Use different filament colors per mass class for instant visual identification.
// Lane board prints flat. Scale width down if build plate is smaller than 200 mm.
// 100% infill on tokens makes them heavier and more realistic for the experiment.

// --------------------
// Customization Ideas
// --------------------
// - Add a "3m" token with even larger diameter for three-body scenarios.
// - Scale token_thickness to 10 mm and add infill for more mass contrast.
// - Print lane_board in a contrasting color from the tokens.
// - Add a protractor arc to the 2D board for angle measurements.
// - Replace raised labels with inset labels for a smoother sliding surface on top.

// ============================================================
// Helper: rounded slot on the side of a cylinder
// ============================================================
module velocity_slot_cutout(token_radius, slot_length, slot_width, slot_depth) {
  // Place a box-shaped slot tangent to the side of the cylinder
  translate([token_radius - slot_depth, -slot_length / 2, -0.1])
    cube([slot_depth + 1, slot_length, token_thickness + 0.2]);
}

// ============================================================
// Module: mass_token
// mass_label  — string to raise on top, e.g. "1m", "2m", "3m"
// diameter    — outer diameter of the puck
// thickness   — height of the puck
// ============================================================
module mass_token(mass_label = "1m", diameter = 30, thickness = 6) {
  token_radius = diameter / 2;

  difference() {
    // Main puck cylinder
    cylinder(d = diameter, h = thickness);

    // Velocity-arrow slot cut into the side
    velocity_slot_cutout(token_radius, velocity_slot_length, velocity_slot_width, velocity_slot_depth);
  }

  // Raised border ring on top for grip and aesthetics
  translate([0, 0, thickness])
    difference() {
      cylinder(d = diameter, h = 1.0);
      cylinder(d = diameter - 3, h = 1.1);
    }

  // Raised mass label on top surface
  if (show_mass_label) {
    translate([0, 0, thickness])
      linear_extrude(height = label_height)
        text(
          mass_label,
          size   = label_size,
          halign = "center",
          valign = "center",
          font   = "Liberation Sans:style=Bold"
        );
  }
}

// ============================================================
// Module: collision_lane_board
// A flat board with two parallel sliding channels, tick marks,
// a center divider mark, and lane labels.
// ============================================================
module collision_lane_board() {
  half_w   = lane_board_width  / 2;
  half_h   = lane_board_height / 2;
  lane_y1  =  lane_board_height / 4;   // center y of upper lane
  lane_y2  = -lane_board_height / 4;   // center y of lower lane

  difference() {
    // Base board
    translate([-half_w, -half_h, 0])
      cube([lane_board_width, lane_board_height, lane_board_thickness]);

    // Upper lane groove
    translate([-half_w, lane_y1 - lane_width / 2, lane_board_thickness - lane_depth])
      cube([lane_board_width, lane_width, lane_depth + 0.1]);

    // Lower lane groove
    translate([-half_w, lane_y2 - lane_width / 2, lane_board_thickness - lane_depth])
      cube([lane_board_width, lane_width, lane_depth + 0.1]);
  }

  // Tick marks along upper lane (raised on board top)
  num_ticks = floor(lane_board_width / tick_spacing);
  for (i = [0 : num_ticks]) {
    tick_x = -half_w + i * tick_spacing;
    // Upper lane ticks
    translate([tick_x - tick_width / 2, lane_y1 - lane_width / 2 - 4, lane_board_thickness])
      cube([tick_width, 3, tick_height]);
    // Lower lane ticks
    translate([tick_x - tick_width / 2, lane_y2 + lane_width / 2 + 1, lane_board_thickness])
      cube([tick_width, 3, tick_height]);
  }

  // Center collision marker — a raised bar across full board height
  translate([-center_mark_width / 2, -half_h, lane_board_thickness])
    cube([center_mark_width, lane_board_height, tick_height * 1.5]);

  // "COLLISION POINT" label at center top
  translate([0, half_h - 8, lane_board_thickness + tick_height * 1.5])
    rotate([0, 0, 0])
      linear_extrude(height = label_height)
        text(
          "COLLISION",
          size   = 4,
          halign = "center",
          valign = "center",
          font   = "Liberation Sans:style=Bold"
        );

  // Lane labels
  translate([-half_w + 5, lane_y1 + lane_width / 2 + 2, lane_board_thickness])
    linear_extrude(height = label_height)
      text("LANE A", size = 3, halign = "left", valign = "bottom");

  translate([-half_w + 5, lane_y2 - lane_width / 2 - 6, lane_board_thickness])
    linear_extrude(height = label_height)
      text("LANE B", size = 3, halign = "left", valign = "bottom");

  // Position number labels every 20 mm along upper lane
  for (i = [0 : 2 : num_ticks]) {
    tick_x    = -half_w + i * tick_spacing;
    pos_label = str(i);
    translate([tick_x, lane_y1 - lane_width / 2 - 9, lane_board_thickness])
      linear_extrude(height = label_height)
        text(pos_label, size = 3, halign = "center", valign = "bottom");
  }
}

// ============================================================
// Module: token_set
// Arranges 4 tokens (2×"1m", 1×"2m", 1×"3m") for a single print.
// ============================================================
module token_set() {
  spacing = 5; // gap between tokens

  // Two "1m" tokens
  translate([0, 0, 0])
    mass_token("1m", light_token_diameter, token_thickness);

  translate([light_token_diameter + spacing, 0, 0])
    mass_token("1m", light_token_diameter, token_thickness);

  // One "2m" token
  translate([0, -(heavy_token_diameter + spacing), 0])
    mass_token("2m", heavy_token_diameter, token_thickness);

  // One "3m" token — diameter scaled by cube-root of mass ratio relative to 1m
  three_m_diameter = light_token_diameter * pow(3, 1/3);
  translate([heavy_token_diameter + spacing, -(three_m_diameter + spacing), 0])
    mass_token("3m", three_m_diameter, token_thickness);
}

// ============================================================
// Module: demo_2d_board
// A larger square board with direction marks for 2D collision
// exploration. Includes angle lines at 30° increments.
// ============================================================
module demo_2d_board() {
  board_size      = 200;
  board_thickness = 3;
  grid_spacing    = 20;
  num_lines       = floor(board_size / grid_spacing);

  difference() {
    // Square base board
    translate([-board_size / 2, -board_size / 2, 0])
      cube([board_size, board_size, board_thickness]);

    // Center hole for pivot pin reference
    cylinder(d = 4, h = board_thickness + 0.1);
  }

  // Grid lines (raised, shallow) — horizontal
  for (i = [-num_lines / 2 : num_lines / 2]) {
    translate([-board_size / 2, i * grid_spacing - 0.5, board_thickness])
      cube([board_size, 1, 0.5]);
  }
  // Grid lines — vertical
  for (j = [-num_lines / 2 : num_lines / 2]) {
    translate([j * grid_spacing - 0.5, -board_size / 2, board_thickness])
      cube([1, board_size, 0.5]);
  }

  // Angle reference lines at 30°, 60°, 90°, 120°, 150° from center
  for (angle = [0, 30, 60, 90, 120, 150]) {
    rotate([0, 0, angle])
      translate([-board_size / 2, -0.5, board_thickness])
        cube([board_size, 1, 0.8]);
  }

  // Center crosshair raised marker
  translate([-50, 0.5, board_thickness])
    cube([100, 1, 1.2]);
  translate([-0.5, -50, board_thickness])
    cube([1, 100, 1.2]);

  // "2D COLLISION BOARD" label
  translate([0, -board_size / 2 + 5, board_thickness])
    linear_extrude(height = label_height)
      text("2D COLLISION BOARD", size = 5, halign = "center", valign = "bottom");
}

// ============================================================
// Demo Modules
// ============================================================

// demo_default: lane board with one token on each lane for display
module demo_default() {
  collision_lane_board();

  // Show a 1m token on upper lane, positioned at left
  translate([-lane_board_width / 2 + 20, lane_board_height / 4, lane_board_thickness])
    mass_token("1m", light_token_diameter, token_thickness);

  // Show a 2m token on upper lane at center (collision point)
  translate([0, lane_board_height / 4, lane_board_thickness])
    mass_token("2m", heavy_token_diameter, token_thickness);
}

// demo_token_set: just the token set, laid out flat for printing
module demo_token_set() {
  token_set();
}

// demo_2d_board: the square 2D collision exploration board
module demo_2d_board_render() {
  demo_2d_board();
}

// ============================================================
// Default render — change this to see different demos
// ============================================================
demo_default();
// demo_token_set();
// demo_2d_board_render();
