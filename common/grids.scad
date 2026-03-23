// =============================================================================
// grids.scad — Grid and array base modules for PhysicsSCAD
// =============================================================================
// Reusable grid plates, dot arrays, slot arrays, and peg arrays used as base
// components for physics graphs, token boards, and interactive models.
//
// Usage:
//   include <../common/grids.scad>;
//
// Modules:
//   grid_plate              — flat plate with raised grid lines
//   grid_plate_with_border  — grid plate with a solid perimeter border
//   dot_grid                — plate with a regular dot / stud array
//   slot_array              — linear array of slots for tokens / arrows
//   peg_array               — linear array of pegs for hanging tokens
// =============================================================================

// -----------------------------------------------------------------------------
// grid_plate
// Flat base plate with raised orthogonal grid lines on the top face.
//
// Parameters:
//   width         — plate width in X (mm)
//   height        — plate depth in Y (mm)
//   spacing       — grid cell size (mm)
//   line_width    — width of each grid line (mm)
//   plate_thickness — thickness of the base plate (mm)
//   line_height   — how far grid lines protrude above the plate (mm)
// -----------------------------------------------------------------------------
module grid_plate(
  width           = 80,
  height          = 80,
  spacing         = 10,
  line_width      = 0.8,
  plate_thickness = 2,
  line_height     = 0.6
) {
  cols = floor(width  / spacing) + 1;
  rows = floor(height / spacing) + 1;

  union() {
    // Base plate, origin at bottom-left corner
    cube([width, height, plate_thickness]);

    // Vertical lines (parallel to Y)
    for (i = [0 : cols - 1]) {
      translate([i * spacing - line_width / 2, 0, plate_thickness])
        cube([line_width, height, line_height]);
    }

    // Horizontal lines (parallel to X)
    for (j = [0 : rows - 1]) {
      translate([0, j * spacing - line_width / 2, plate_thickness])
        cube([width, line_width, line_height]);
    }
  }
}

// -----------------------------------------------------------------------------
// grid_plate_with_border
// Grid plate as above, but with a solid raised border around the perimeter.
//
// Parameters:
//   width         — plate width in X (mm)
//   height        — plate depth in Y (mm)
//   spacing       — grid cell size (mm)
//   line_width    — width of interior grid lines (mm)
//   plate_thickness — thickness of the base plate (mm)
//   border_width  — width of the perimeter border wall (mm)
// -----------------------------------------------------------------------------
module grid_plate_with_border(
  width           = 80,
  height          = 80,
  spacing         = 10,
  line_width      = 0.8,
  plate_thickness = 2,
  border_width    = 2
) {
  border_height = 3;  // total height of border above base

  union() {
    // Interior grid (inset so lines stay inside the border)
    translate([border_width, border_width, 0])
      grid_plate(
        width           = width  - 2 * border_width,
        height          = height - 2 * border_width,
        spacing         = spacing,
        line_width      = line_width,
        plate_thickness = plate_thickness,
        line_height     = 0.6
      );

    // Border frame (hollow box)
    difference() {
      cube([width, height, border_height]);
      translate([border_width, border_width, -0.1])
        cube([
          width  - 2 * border_width,
          height - 2 * border_width,
          border_height + 0.2
        ]);
    }
  }
}

// -----------------------------------------------------------------------------
// dot_grid
// Flat plate with a regular array of raised dots instead of continuous lines.
// Useful as a pegboard or for displacement/vector exercises.
//
// Parameters:
//   width         — plate width in X (mm)
//   height        — plate depth in Y (mm)
//   spacing       — distance between dot centres (mm)
//   dot_diameter  — diameter of each dot (mm)
//   plate_thickness — base plate thickness (mm)
//   dot_height    — how far each dot protrudes above the plate (mm)
// -----------------------------------------------------------------------------
module dot_grid(
  width           = 80,
  height          = 80,
  spacing         = 10,
  dot_diameter    = 1.5,
  plate_thickness = 2,
  dot_height      = 1
) {
  cols = floor(width  / spacing) + 1;
  rows = floor(height / spacing) + 1;

  union() {
    cube([width, height, plate_thickness]);

    for (i = [0 : cols - 1]) {
      for (j = [0 : rows - 1]) {
        translate([i * spacing, j * spacing, plate_thickness])
          cylinder(h = dot_height, d = dot_diameter, $fn = 16);
      }
    }
  }
}

// -----------------------------------------------------------------------------
// slot_array
// Linear array of rectangular slots in a base plate for inserting flat tokens,
// arrow cards, or force indicators.
// Slots run parallel to Y (long axis), arrayed along X.
//
// Parameters:
//   count          — number of slots
//   spacing        — centre-to-centre distance between slots (mm)
//   slot_width     — slot opening width in X (mm)
//   slot_length    — slot opening length in Y (mm)
//   slot_depth     — depth of each slot cutout (mm)
//   base_thickness — overall thickness of the base block (mm)
// -----------------------------------------------------------------------------
module slot_array(
  count          = 5,
  spacing        = 15,
  slot_width     = 3,
  slot_length    = 12,
  slot_depth     = 2,
  base_thickness = 3
) {
  total_width = (count - 1) * spacing + slot_width * 3;
  base_depth  = slot_length + slot_width * 2;

  difference() {
    // Base block centred on origin
    translate([-total_width / 2, -base_depth / 2, 0])
      cube([total_width, base_depth, base_thickness]);

    // Slot cutouts
    for (i = [0 : count - 1]) {
      x = (i - (count - 1) / 2) * spacing;
      translate([x - slot_width / 2, -slot_length / 2,
                 base_thickness - slot_depth])
        cube([slot_width, slot_length, slot_depth + 0.1]);
    }
  }
}

// -----------------------------------------------------------------------------
// peg_array
// Linear array of cylindrical pegs on a base plate for hanging token cards.
// Pegs are arrayed along X, centred on origin.
//
// Parameters:
//   count          — number of pegs
//   spacing        — centre-to-centre distance between pegs (mm)
//   peg_diameter   — diameter of each peg (mm)
//   peg_height     — height each peg extends above the base (mm)
//   base_thickness — thickness of the base plate (mm)
// -----------------------------------------------------------------------------
module peg_array(
  count          = 5,
  spacing        = 15,
  peg_diameter   = 3,
  peg_height     = 5,
  base_thickness = 2
) {
  total_width = (count - 1) * spacing + peg_diameter * 3;
  base_depth  = peg_diameter * 3;

  union() {
    // Base plate
    translate([-total_width / 2, -base_depth / 2, 0])
      cube([total_width, base_depth, base_thickness]);

    // Pegs
    for (i = [0 : count - 1]) {
      x = (i - (count - 1) / 2) * spacing;
      translate([x, 0, base_thickness])
        cylinder(h = peg_height, d = peg_diameter, $fn = 24);
    }
  }
}
