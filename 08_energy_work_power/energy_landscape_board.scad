/*
 * Title: Energy Landscape Board
 * Folder: 08_energy_work_power
 * Physics Topic: Conservation of Energy, Kinetic Energy, Potential Energy, Work
 * Difficulty: Intermediate
 * Print Type: flat
 * Teaches: Conservation of mechanical energy (KE + PE = constant), potential energy
 *          depends on height, kinetic energy is maximum at lowest points,
 *          work-energy theorem, effect of friction on total mechanical energy
 * Use Case: Students trace a marble along the raised landscape profile, predicting
 *           speed at each labeled position using energy conservation arguments.
 */

// Parameters
board_width          = 160;  // mm — total board width (x direction)
board_height         = 80;   // mm — total board height (y direction, = depth of extrusion)
board_thickness      = 3;    // mm — flat base plate thickness
profile_height_scale = 1.0;  // scale factor for hill/valley heights (try 0.7–1.5)
show_height_markers  = true; // render raised vertical reference lines at key positions
show_position_markers = true; // render raised A/B/C/D/E labels at key positions
line_thickness       = 1.5;  // mm — thickness of the raised profile ridge on the board

// Derived values
$fn             = 32;
profile_raise   = board_thickness * 0.5;  // z at which profile sits on board top face
marker_height   = 18;  // mm — height of the vertical position markers
marker_width    = 1.2; // mm — width of vertical position marker lines
label_size      = 6;   // mm — font size for position labels
border_wall     = 2.5; // mm — raised border around the board edge

// Profile definition — [x, height] pairs as a fraction of board dimensions.
// x is a fraction of board_width (0.0 = left, 1.0 = right).
// height is in mm and will be scaled by profile_height_scale.
// The profile represents a roller-coaster-style cross-section:
//   A (start): left edge, height 0
//   B (peak1): first hill — the highest point
//   C (valley): lowest point in the middle
//   D (peak2): second, lower hill
//   E (end): right edge, levels off
//
// Raw profile [x_fraction, height_mm] — will be scaled to board coordinates
raw_profile = [
  [0.00,  0.0],   // A: start, ground level
  [0.05,  0.0],   // run-up shelf
  [0.18, 32.0],   // approach to B
  [0.28, 38.0],   // B: peak 1 (highest point — most PE, least KE)
  [0.38, 12.0],   // descent toward C
  [0.48,  6.0],   // C: valley (lowest — most KE, least PE)
  [0.60, 24.0],   // D: peak 2 (lower than B — marble can clear it from A)
  [0.72, 12.0],   // descent from D
  [0.85,  8.0],   // E: right shelf (levels off)
  [1.00,  8.0]    // right edge
];

// Key positions for markers: [x_fraction, label_string]
marker_positions = [
  [0.00, "A"],   // start
  [0.28, "B"],   // peak 1
  [0.48, "C"],   // valley
  [0.60, "D"],   // peak 2
  [0.85, "E"]    // right plateau
];

// Physics Meaning
// Conservation of mechanical energy (no friction):
//   KE_A + PE_A = KE_B + PE_B = constant for all positions
//   ½mv²_A + mgh_A = ½mv²_B + mgh_B
// Simplifies to: v_B = sqrt(v_A² + 2g(h_A - h_B))
// At the bottom of a valley (C), all PE converts to KE → maximum speed.
// At the top of a hill (B), KE is minimum (may be zero if released from rest at same height).
// If h_D < h_A, the marble can reach D. If h_D > h_A, it cannot (energy insufficient).
// With friction: total mechanical energy decreases; final height is always lower than start height.
// Work-energy theorem: W_net = ΔKE — net work equals change in kinetic energy.

// Learning Notes
// The profile shape is an "energy diagram" — the height IS the potential energy (∝ mgh).
// A marble released from A with no friction will:
//   - Speed up going downhill (PE→KE)
//   - Slow down going uphill (KE→PE)
//   - Just barely reach any point at or below its starting height
// With friction, energy is dissipated as heat; the marble cannot return to its starting height.
// The labeled positions (A–E) allow quantitative prediction: given h_A and any h_x, find v_x.
// This diagram is analogous to a chemistry reaction energy diagram (activation energy = peak height).

// Print Notes
// Print flat on the bed with the profile face up. No supports needed.
// Use brim for adhesion — the board is wide and flat.
// Layer height 0.2 mm is sufficient; the profile ridge is a thin raised feature.
// The vertical marker lines are 1.2 mm wide — use at least 2 perimeters.
// Consider using a marble or ball bearing to demonstrate rolling along the landscape.
// To simulate friction, add a strip of sandpaper between positions C and D.

// Customization Ideas
// - Set profile_height_scale = 1.5 for more dramatic hills and valleys
// - Set profile_height_scale = 0.6 for a flatter, "nearly frictionless" landscape
// - Modify raw_profile to create your own custom landscape for a quiz scenario
// - Set show_height_markers = false for a student-prediction worksheet activity
// - Set show_position_markers = false for a blank identification exercise
// - Increase board_width = 200 for more positions and a longer landscape

// ─────────────────────────────────────────────────────────────────────────────
// Helper functions
// ─────────────────────────────────────────────────────────────────────────────

// Convert a raw profile x-fraction to board x coordinate
// Board x ranges from 0 to board_width; board is centered, so offset by -board_width/2
function profile_x(frac) = frac * board_width - board_width * 0.5;

// Scale raw height by profile_height_scale
function profile_y(raw_h) = raw_h * profile_height_scale;

// ─────────────────────────────────────────────────────────────────────────────
// Modules
// ─────────────────────────────────────────────────────────────────────────────

// Flat base board with raised border wall
module base_board() {
  // Base plate
  cube([board_width, board_height, board_thickness], center = true);
  // Raised border walls
  translate([0, 0, board_thickness * 0.5])
    difference() {
      cube([board_width, board_height, border_wall], center = true);
      cube([board_width - border_wall * 2,
            board_height - border_wall * 2,
            border_wall + 0.2], center = true);
    }
}

// Energy profile — the landscape cross-section extruded along board_height
module energy_profile() {
  // Build the profile polygon:
  // Top edge follows the landscape; bottom edge is at board surface level.
  // We build a closed polygon: go along the profile top, then return along the bottom.
  n = len(raw_profile);

  // Top profile points (scaled)
  top_pts = [for (i = [0 : n - 1])
    [profile_x(raw_profile[i][0]),
     profile_y(raw_profile[i][1]) + line_thickness]
  ];

  // Bottom profile points (flat line at z=0, reversed for closed polygon)
  bot_pts = [for (i = [n - 1 : -1 : 0])
    [profile_x(raw_profile[i][0]), 0]
  ];

  // Concatenate top and bottom to form a closed polygon
  all_pts = concat(top_pts, bot_pts);

  translate([0, -board_height * 0.5, profile_raise])
    rotate([90, 0, 0])
      linear_extrude(height = board_height)
        polygon(points = all_pts);
}

// Vertical height marker line at a given x position, with a label
module height_marker(x_frac, label_text) {
  raw_h  = [for (p = raw_profile) if (abs(p[0] - x_frac) < 0.001) p[1]][0];
  h_mm   = profile_y(raw_h);
  x_pos  = profile_x(x_frac);

  translate([x_pos, 0, profile_raise]) {
    // Vertical dashed marker line from board surface up to profile height
    cube([marker_width, board_height, h_mm > 0 ? h_mm : 1], center = false);
    // Position label above the profile
    if (show_position_markers) {
      translate([-label_size * 0.5, board_height * 0.5, h_mm + 2])
        linear_extrude(height = 1.5)
          text(label_text,
               size   = label_size,
               halign = "center",
               valign = "bottom",
               font   = "Liberation Sans:style=Bold");
    }
    // Small horizontal tick at the profile height (shows the reference level)
    translate([-4, board_height * 0.5, h_mm])
      cube([8, 1.2, 1.2], center = true);
  }
}

// All height markers and position labels
module all_markers() {
  if (show_height_markers) {
    for (mp = marker_positions) {
      height_marker(mp[0], mp[1]);
    }
  } else if (show_position_markers) {
    // Labels only, no marker lines
    for (mp = marker_positions) {
      raw_h = [for (p = raw_profile) if (abs(p[0] - mp[0]) < 0.001) p[1]][0];
      h_mm  = profile_y(raw_h);
      x_pos = profile_x(mp[0]);
      translate([x_pos, 0, profile_raise + h_mm + 2])
        linear_extrude(height = 1.5)
          text(mp[1],
               size   = label_size,
               halign = "center",
               valign = "bottom",
               font   = "Liberation Sans:style=Bold");
    }
  }
}

// "Energy" axis label on the left side of the board
module energy_axis_label() {
  translate([-board_width * 0.5 + 1, 0, profile_raise + marker_height * 0.3])
    rotate([0, 0, 90])
      linear_extrude(height = 1.2)
        text("Height (PE)",
             size   = 4.5,
             halign = "center",
             valign = "center",
             font   = "Liberation Sans");
}

// "Position" axis label along the bottom of the board
module position_axis_label() {
  translate([0, board_height * 0.5 - 8, profile_raise])
    linear_extrude(height = 1.2)
      text("Position \u2192",
           size   = 5,
           halign = "center",
           valign = "bottom",
           font   = "Liberation Sans");
}

// Complete energy landscape board assembly
module energy_landscape_board() {
  base_board();
  energy_profile();
  all_markers();
  energy_axis_label();
  position_axis_label();
}

// ─────────────────────────────────────────────────────────────────────────────
// Demo modules
// ─────────────────────────────────────────────────────────────────────────────

// Default: full-size board with all labels and markers
module demo_default() {
  energy_landscape_board();
}

// Compact: smaller board, reduced height scale — fits a smaller print bed
module demo_compact() {
  // Use scaled-down parameters inline via a child wrapper
  scale([0.75, 0.75, 0.75])
    energy_landscape_board();
}

// ─────────────────────────────────────────────────────────────────────────────
// Render
// ─────────────────────────────────────────────────────────────────────────────

demo_default();
// Uncomment to preview compact version:
// demo_compact();
