// =============================================================================
// dimension_helpers.scad — Dimension and annotation modules for PhysicsSCAD
// =============================================================================
// Technical drawing annotation helpers: dimension lines, angle indicators,
// right-angle marks, centre marks, and circular markers.
//
// Usage:
//   include <../common/dimension_helpers.scad>;
//
// Modules:
//   dimension_line    — horizontal dimension line with end ticks
//   angle_indicator   — arc with end marks showing an angle
//   right_angle_mark  — small square corner mark
//   center_mark       — crosshair centre indicator
//   circular_marker   — ring/circle highlight marker
// =============================================================================

// -----------------------------------------------------------------------------
// dimension_line
// A horizontal dimension line of a given length, centred on origin, with
// perpendicular end ticks. Used to annotate distances on models.
//
// Parameters:
//   len            — total dimension line length (mm)
//   thickness      — line bar width (mm)
//   end_tick_height — height of the perpendicular end ticks (mm)
//   line_thickness — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module dimension_line(
  len             = 30,
  thickness       = 1.2,
  end_tick_height = 4,
  line_thickness  = 2
) {
  linear_extrude(height = line_thickness) {
    // Horizontal bar
    translate([-len / 2, -thickness / 2])
      square([len, thickness]);

    // Left end tick
    translate([-len / 2 - thickness / 2, -end_tick_height / 2])
      square([thickness, end_tick_height]);

    // Right end tick
    translate([len / 2 - thickness / 2, -end_tick_height / 2])
      square([thickness, end_tick_height]);
  }
}

// -----------------------------------------------------------------------------
// angle_indicator
// Arc from 0° to angle_deg with small radial end marks, used to label angles
// in diagrams (e.g. the angle of a ramp or between two vectors).
//
// Parameters:
//   radius    — radius of the arc centreline (mm)
//   angle_deg — sweep of the arc (degrees)
//   arc_width — radial thickness of the arc ring (mm)
//   thickness — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module angle_indicator(
  radius    = 15,
  angle_deg = 30,
  arc_width = 1.5,
  thickness = 2
) {
  r_inner   = radius - arc_width / 2;
  r_outer   = radius + arc_width / 2;
  tick_len  = arc_width * 2.5;  // radial tick length at each arc end

  linear_extrude(height = thickness) {
    union() {
      // Arc ring
      difference() {
        intersection() {
          circle(r = r_outer, $fn = 64);
          polygon(points = concat(
            [[0, 0]],
            [for (i = [0 : 64])
              let(a = i * angle_deg / 64)
              [r_outer * cos(a), r_outer * sin(a)]]
          ));
        }
        circle(r = r_inner, $fn = 64);
      }

      // Start end tick (at 0°, along +X)
      translate([r_inner - tick_len / 4, -arc_width / 4])
        square([tick_len, arc_width / 2]);

      // End tick (at angle_deg)
      rotate([0, 0, angle_deg])
        translate([r_inner - tick_len / 4, -arc_width / 4])
          square([tick_len, arc_width / 2]);
    }
  }
}

// -----------------------------------------------------------------------------
// right_angle_mark
// Small square corner mark placed at the origin, indicating a 90° angle.
// The mark occupies the first quadrant (+X, +Y). Rotate for other corners.
//
// Parameters:
//   size       — leg length of the square mark (mm)
//   line_width — width of the mark lines (mm)
//   thickness  — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module right_angle_mark(
  size       = 5,
  line_width = 1.2,
  thickness  = 2
) {
  linear_extrude(height = thickness) {
    union() {
      // Horizontal leg
      square([size, line_width]);

      // Vertical leg
      square([line_width, size]);

      // Corner fill square to close the mark neatly
      translate([size - line_width, size - line_width])
        square([line_width, line_width]);
    }
  }
}

// -----------------------------------------------------------------------------
// center_mark
// Crosshair centre indicator: two perpendicular bars crossing at the origin.
//
// Parameters:
//   size       — half-span of each crosshair arm (mm)
//   line_width — width of the crosshair bars (mm)
//   thickness  — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module center_mark(
  size       = 6,
  line_width = 1.2,
  thickness  = 2
) {
  linear_extrude(height = thickness) {
    union() {
      // Horizontal bar
      translate([-size, -line_width / 2])
        square([size * 2, line_width]);

      // Vertical bar
      translate([-line_width / 2, -size])
        square([line_width, size * 2]);
    }
  }
}

// -----------------------------------------------------------------------------
// circular_marker
// A thin ring used to highlight a point, circle boundary, or reference radius.
//
// Parameters:
//   radius     — mean radius of the ring (mm)
//   ring_width — radial width of the ring wall (mm)
//   thickness  — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module circular_marker(
  radius     = 10,
  ring_width = 1.5,
  thickness  = 2
) {
  linear_extrude(height = thickness) {
    difference() {
      circle(r = radius + ring_width / 2, $fn = 64);
      circle(r = radius - ring_width / 2, $fn = 64);
    }
  }
}
