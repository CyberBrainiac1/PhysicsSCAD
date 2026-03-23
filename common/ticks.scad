// =============================================================================
// ticks.scad — Tick mark and angle arc modules for PhysicsSCAD
// =============================================================================
// Reusable tick mark sets and arc indicators for graphs, rulers, protractors,
// and other measurement references in physics educational models.
//
// Usage:
//   include <../common/ticks.scad>;
//
// Modules:
//   tick_marks_linear    — evenly spaced ticks along the x-axis
//   numbered_tick_marks  — ticks with small numeric text labels
//   radial_ticks         — tick marks distributed around a circle
//   angle_arc            — filled arc sector showing an angle
// =============================================================================

// -----------------------------------------------------------------------------
// tick_marks_linear
// Row of evenly spaced tick marks along the positive X axis, centred in Y.
//
// Parameters:
//   length     — total span along x (mm)
//   spacing    — distance between tick centres (mm)
//   tick_length — full tick height in Y (mm)
//   tick_width — tick bar width in X (mm)
//   thickness  — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module tick_marks_linear(
  length      = 60,
  spacing     = 10,
  tick_length = 4,
  tick_width  = 1.2,
  thickness   = 2
) {
  count = floor(length / spacing);

  linear_extrude(height = thickness) {
    for (i = [0 : count]) {
      translate([i * spacing - tick_width / 2, -tick_length / 2])
        square([tick_width, tick_length]);
    }
  }
}

// -----------------------------------------------------------------------------
// numbered_tick_marks
// Tick marks with raised numeric labels beneath each tick.
//
// Parameters:
//   count       — number of ticks (intervals = count - 1)
//   spacing     — distance between ticks (mm)
//   tick_length — tick bar height (mm)
//   tick_width  — tick bar width (mm)
//   number_size — text character height (mm)
//   thickness   — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module numbered_tick_marks(
  count       = 6,
  spacing     = 10,
  tick_length = 4,
  tick_width  = 1.2,
  number_size = 3,
  thickness   = 2
) {
  linear_extrude(height = thickness) {
    for (i = [0 : count - 1]) {
      x = i * spacing;

      // Tick bar
      translate([x - tick_width / 2, 0])
        square([tick_width, tick_length]);

      // Numeric label below the tick
      translate([x, -(number_size * 1.8)])
        text(str(i), size = number_size, halign = "center", valign = "top",
             font = "Liberation Sans");
    }
  }
}

// -----------------------------------------------------------------------------
// radial_ticks
// Tick marks equally spaced around a full circle (like a protractor or clock).
// Each tick points outward from the given radius.
//
// Parameters:
//   radius      — radial distance to the inner end of each tick (mm)
//   spacing_deg — angular spacing between ticks (degrees)
//   tick_length — radial length of each tick bar (mm)
//   tick_width  — circumferential width of each tick bar (mm)
//   thickness   — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module radial_ticks(
  radius      = 30,
  spacing_deg = 15,
  tick_length = 3,
  tick_width  = 1.2,
  thickness   = 2
) {
  count = floor(360 / spacing_deg);

  linear_extrude(height = thickness) {
    for (i = [0 : count - 1]) {
      rotate([0, 0, i * spacing_deg])
        translate([radius, -tick_width / 2])
          square([tick_length, tick_width]);
    }
  }
}

// -----------------------------------------------------------------------------
// angle_arc
// Filled arc sector (pie-slice) from 0° to angle_deg, useful as an angle
// indicator or background for angle labels.
//
// Parameters:
//   radius    — outer radius of the arc sector (mm)
//   angle_deg — sweep angle (degrees)
//   shaft_width — radial thickness of the arc ring (0 = filled sector) (mm)
//   thickness — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module angle_arc(
  radius      = 20,
  angle_deg   = 45,
  shaft_width = 1.5,
  thickness   = 2
) {
  r_outer = radius;
  r_inner = max(0, radius - shaft_width);

  // Build arc as a polygon approximation
  resolution = max(3, floor(64 * angle_deg / 360));

  linear_extrude(height = thickness) {
    difference() {
      // Outer sector
      intersection() {
        circle(r = r_outer, $fn = 64);
        polygon(points = concat(
          [[0, 0]],
          [for (i = [0 : resolution])
            let(a = i * angle_deg / resolution)
            [r_outer * cos(a), r_outer * sin(a)]]
        ));
      }
      // Inner cutout to make a ring arc (skip if shaft_width covers full radius)
      if (r_inner > 0)
        circle(r = r_inner, $fn = 64);
    }
  }
}
