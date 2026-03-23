/*
 * Title: Pressure with Depth Visualization Board
 * Folder: 15_fluids_pressure
 * Physics Topic: Fluid Pressure, P = ρgh, Pascal's Principle
 * Difficulty: Beginner
 * Print Type: flat
 * Teaches: Pressure increases linearly with depth, pressure acts in all directions
 * Use Case: Wall-mount or table-display board for pressure-depth demonstrations
 */

// --------------------
// Parameters
// --------------------
board_width          = 100;  // mm
board_height         = 120;  // mm
board_thickness      = 3;    // mm
water_column_width   = 30;   // mm — width of the fluid container outline
depth_tick_spacing   = 15;   // mm — vertical spacing between depth levels
show_pressure_arrows = true;
arrow_scale_factor   = 1.2;  // each deeper arrow is this times longer
depth_levels         = 5;    // number of depth increments

// --------------------
// Physics Meaning
// --------------------
// Pressure at depth h:  P = ρ · g · h
// ρ = fluid density (kg/m³), g = 9.8 m/s², h = depth below surface
// Pressure is isotropic (same in all directions at a given depth).
// The arrows grow longer with depth to show the linear relationship.

// --------------------
// Learning Notes
// --------------------
// - At the surface (h=0): P = 0 gauge pressure (just atmospheric)
// - Deeper arrows represent greater hydrostatic pressure
// - Arrows point INWARD from both sides — pressure acts from all directions
// - This linear relationship holds for incompressible fluids

// --------------------
// Print Notes
// --------------------
// - Print flat on bed; no supports needed
// - 0.2 mm layer height for readable raised labels
// - Consider filament color swap on layer 2 for contrast on arrows

// --------------------
// Customization Ideas
// --------------------
// - Increase arrow_scale_factor to 1.5 for more dramatic pressure difference
// - Add a curved pressure profile line connecting arrow tips
// - Increase depth_levels to 8 for a taller board

$fn = 32;

feature_h     = 1.5;   // mm raised above board surface
arrow_w       = 2;     // mm arrow shaft width
container_wall = 1.5;  // mm container outline wall thickness
container_x   = (board_width - water_column_width) / 2;  // left edge of container

// --------------------
// Board base
// --------------------
module board_base() {
  cube([board_width, board_height, board_thickness]);
}

// --------------------
// Fluid container outline (raised rectangle)
// --------------------
module container_outline() {
  container_h = depth_levels * depth_tick_spacing + 10;
  container_y = board_height - container_h - 15;

  translate([container_x, container_y, board_thickness])
    difference() {
      cube([water_column_width, container_h, feature_h]);
      translate([container_wall, container_wall, -1])
        cube([water_column_width - 2*container_wall,
              container_h - container_wall, feature_h + 2]);
    }
}

// --------------------
// Single pressure arrow (pointing inward from left or right)
// --------------------
module pressure_arrow(arrow_len, direction) {
  // direction: 1 = pointing right (from left wall), -1 = pointing left (from right wall)
  mirror(direction == -1 ? [1,0,0] : [0,0,0])
    union() {
      // Shaft
      cube([arrow_len, arrow_w, feature_h]);
      // Arrowhead
      translate([arrow_len, arrow_w/2, 0])
        linear_extrude(height=feature_h)
          polygon([[0, -arrow_w], [0, arrow_w], [arrow_w*1.2, 0]]);
    }
}

// --------------------
// All pressure arrows at each depth level
// --------------------
module all_pressure_arrows() {
  container_h  = depth_levels * depth_tick_spacing + 10;
  container_y  = board_height - container_h - 15;
  base_arrow_l = 6;  // mm — shortest arrow at shallowest depth

  for (level = [1 : depth_levels]) {
    depth_y     = container_y + container_h - level * depth_tick_spacing;
    arrow_len   = base_arrow_l * pow(arrow_scale_factor, level - 1);

    // Left arrow (pointing right, inward)
    translate([container_x - arrow_len, depth_y, board_thickness])
      pressure_arrow(arrow_len, 1);

    // Right arrow (pointing left, inward)
    translate([container_x + water_column_width, depth_y, board_thickness])
      pressure_arrow(arrow_len, -1);

    // Depth tick mark on left side of container
    translate([container_x - 1, depth_y + arrow_w/2, board_thickness])
      cube([1, 1, feature_h * 0.5]);
  }
}

// --------------------
// P = ρgh label strip at top
// --------------------
module equation_label() {
  // Raised bar as placeholder for equation label
  translate([board_width/2 - 20, board_height - 12, board_thickness])
    cube([40, 3, feature_h]);
  // Small raised dots spelling out label structure
  for (xi = [0:4]) {
    translate([board_width/2 - 18 + xi*9, board_height - 10, board_thickness])
      cylinder(h=feature_h, d=1.5, $fn=8);
  }
}

// --------------------
// pressure_depth_board() — main model
// --------------------
module pressure_depth_board() {
  union() {
    board_base();
    container_outline();
    if (show_pressure_arrows) all_pressure_arrows();
    equation_label();
  }
}

// --------------------
// demo_default()
// --------------------
module demo_default() {
  pressure_depth_board();
}

// Run default demo
demo_default();
