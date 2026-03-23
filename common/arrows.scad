// =============================================================================
// arrows.scad — Arrow modules for PhysicsSCAD
// =============================================================================
// Reusable arrow geometries for representing vectors, forces, velocities, and
// other directed quantities in physics educational models.
//
// Usage:
//   include <../common/arrows.scad>;
//
// Modules:
//   arrow_2d            — flat extruded arrow, points in +X
//   arrow_3d            — cylindrical 3D arrow, points in +Z
//   double_arrow_2d     — double-headed arrow for dimension lines
//   curved_arrow_2d     — arc arrow for angular/rotational quantities
// =============================================================================

// -----------------------------------------------------------------------------
// arrow_2d
// Flat arrow pointing in the +X direction, shaft centered on the origin.
//
// Parameters:
//   length      — total length from tail to tip (mm)
//   shaft_width — width of the arrow shaft (mm)
//   head_length — length of the arrowhead triangle (mm)
//   head_width  — full width of the arrowhead base (mm)
//   thickness   — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module arrow_2d(
  length      = 20,
  shaft_width = 2,
  head_length = 5,
  head_width  = 5,
  thickness   = 2
) {
  shaft_length = length - head_length;

  linear_extrude(height = thickness) {
    union() {
      // Shaft: rectangle from x=0 to x=shaft_length, centered on y=0
      translate([0, -shaft_width / 2])
        square([shaft_length, shaft_width]);

      // Arrowhead: triangle at the tip
      translate([shaft_length, 0])
        polygon(points = [
          [0,            -head_width / 2],
          [head_length,   0             ],
          [0,             head_width / 2]
        ]);
    }
  }
}

// -----------------------------------------------------------------------------
// arrow_3d
// Cylindrical 3D arrow pointing along the +Z axis, base at origin.
//
// Parameters:
//   length         — total length from base to tip (mm)
//   shaft_diameter — diameter of the cylindrical shaft (mm)
//   head_length    — length of the conical head (mm)
//   head_diameter  — base diameter of the cone (mm)
// -----------------------------------------------------------------------------
module arrow_3d(
  length         = 30,
  shaft_diameter = 3,
  head_length    = 8,
  head_diameter  = 7
) {
  shaft_length = length - head_length;

  union() {
    // Shaft cylinder
    cylinder(h = shaft_length, d = shaft_diameter, $fn = 32);

    // Conical arrowhead on top of shaft
    translate([0, 0, shaft_length])
      cylinder(h = head_length, d1 = head_diameter, d2 = 0, $fn = 32);
  }
}

// -----------------------------------------------------------------------------
// double_arrow_2d
// Double-headed flat arrow for dimension lines, centered on origin along X.
//
// Parameters:
//   length      — total length tip-to-tip (mm)
//   shaft_width — width of the shaft (mm)
//   head_length — length of each arrowhead (mm)
//   head_width  — full width of each arrowhead base (mm)
//   thickness   — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module double_arrow_2d(
  length      = 20,
  shaft_width = 2,
  head_length = 5,
  head_width  = 5,
  thickness   = 2
) {
  shaft_length = length - 2 * head_length;
  shaft_start  = -length / 2 + head_length;

  linear_extrude(height = thickness) {
    union() {
      // Central shaft
      translate([shaft_start, -shaft_width / 2])
        square([shaft_length, shaft_width]);

      // Right arrowhead (pointing in +X)
      translate([length / 2 - head_length, 0])
        polygon(points = [
          [0,           -head_width / 2],
          [head_length,  0             ],
          [0,            head_width / 2]
        ]);

      // Left arrowhead (pointing in -X, mirrored)
      translate([-length / 2 + head_length, 0])
        mirror([1, 0])
          polygon(points = [
            [0,           -head_width / 2],
            [head_length,  0             ],
            [0,            head_width / 2]
          ]);
    }
  }
}

// -----------------------------------------------------------------------------
// curved_arrow_2d
// Arc-shaped arrow for representing angular/rotational quantities.
// The arc is centered on the origin in the XY plane, sweeping from 0° to
// angle_deg with the arrowhead at the leading edge.
//
// Parameters:
//   radius      — radius of the arc centerline (mm)
//   angle_deg   — sweep angle of the arc (degrees)
//   shaft_width — radial width of the arc shaft (mm)
//   head_length — chord length of the arrowhead (mm)
//   head_width  — radial width of the arrowhead base (mm)
//   thickness   — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module curved_arrow_2d(
  radius      = 15,
  angle_deg   = 90,
  shaft_width = 2,
  head_length = 5,
  head_width  = 5,
  thickness   = 2
) {
  // Approximate arc chord angle consumed by arrowhead so the shaft ends cleanly
  head_angle = (head_length / (2 * PI * radius)) * 360;
  arc_angle  = angle_deg - head_angle;

  r_inner = radius - shaft_width / 2;
  r_outer = radius + shaft_width / 2;

  linear_extrude(height = thickness) {
    union() {
      // Arc shaft using difference of two sectors
      difference() {
        // Outer sector
        intersection() {
          circle(r = r_outer, $fn = 64);
          polygon(points = concat(
            [[0, 0]],
            [for (a = [0 : 1 : arc_angle])
              [r_outer * cos(a), r_outer * sin(a)]]
          ));
        }
        // Inner cutout
        circle(r = r_inner, $fn = 64);
      }

      // Arrowhead at the leading edge of the arc
      rotate([0, 0, angle_deg])
        translate([radius, 0])
          rotate([0, 0, 90])
            polygon(points = [
              [-head_width / 2, 0           ],
              [ head_width / 2, 0           ],
              [ 0,              head_length ]
            ]);
    }
  }
}
