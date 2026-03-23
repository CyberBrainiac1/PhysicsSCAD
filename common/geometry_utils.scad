// =============================================================================
// geometry_utils.scad — General-purpose geometry modules for PhysicsSCAD
// =============================================================================
// Reusable 3D primitives and shapes used across multiple physics models:
// rounded plates, polygons, rings, sectors, parabolic profiles, and ramps.
//
// Usage:
//   include <../common/geometry_utils.scad>;
//
// Modules:
//   rounded_plate          — rectangular plate with rounded corners
//   hexagonal_prism        — regular hexagonal prism
//   regular_polygon_prism  — regular n-sided polygon prism
//   ring                   — hollow cylinder (annular ring)
//   sector                 — pie-slice sector prism
//   parabola_profile       — parabolic arc cross-section plate
//   isosceles_triangle_prism — triangular ramp prism
// =============================================================================

// -----------------------------------------------------------------------------
// rounded_plate
// Flat rectangular plate with uniformly rounded corners.
// Origin at the centre of the plate.
//
// Parameters:
//   width         — plate dimension in X (mm)
//   height        — plate dimension in Y (mm)
//   thickness     — plate thickness in Z (mm)
//   corner_radius — radius of the corner rounding (mm)
// -----------------------------------------------------------------------------
module rounded_plate(
  width         = 60,
  height        = 40,
  thickness     = 3,
  corner_radius = 3
) {
  r = min(corner_radius, width / 2, height / 2);

  linear_extrude(height = thickness) {
    // Hull of four corner circles produces a rounded rectangle
    hull() {
      for (sx = [-1, 1], sy = [-1, 1]) {
        translate([sx * (width / 2 - r), sy * (height / 2 - r)])
          circle(r = r, $fn = 32);
      }
    }
  }
}

// -----------------------------------------------------------------------------
// hexagonal_prism
// Regular hexagonal prism with flat sides (flat-to-flat orientation by default
// when circumradius is used as the vertex-to-centre distance).
// Origin at the centre of the bottom face.
//
// Parameters:
//   circumradius — distance from centre to each vertex (mm)
//   height       — prism height in Z (mm)
// -----------------------------------------------------------------------------
module hexagonal_prism(
  circumradius = 15,
  height       = 5
) {
  linear_extrude(height = height)
    circle(r = circumradius, $fn = 6);
}

// -----------------------------------------------------------------------------
// regular_polygon_prism
// Regular n-sided polygon prism. Useful for nuts, tokens, and symmetry models.
// Origin at the centre of the bottom face.
//
// Parameters:
//   sides        — number of polygon sides (minimum 3)
//   circumradius — circumscribed circle radius (vertex-to-centre) (mm)
//   height       — prism height in Z (mm)
// -----------------------------------------------------------------------------
module regular_polygon_prism(
  sides        = 6,
  circumradius = 15,
  height       = 5
) {
  n = max(3, sides);

  linear_extrude(height = height)
    circle(r = circumradius, $fn = n);
}

// -----------------------------------------------------------------------------
// ring
// Hollow cylinder (annular ring / washer shape).
// Origin at the centre of the bottom face.
//
// Parameters:
//   outer_radius — outer radius of the ring (mm)
//   inner_radius — inner radius (hole) of the ring (mm)
//   height       — ring height in Z (mm)
// -----------------------------------------------------------------------------
module ring(
  outer_radius = 20,
  inner_radius = 14,
  height       = 5
) {
  difference() {
    cylinder(h = height, r = outer_radius, $fn = 64);
    translate([0, 0, -0.1])
      cylinder(h = height + 0.2, r = inner_radius, $fn = 64);
  }
}

// -----------------------------------------------------------------------------
// sector
// Pie-slice sector prism sweeping from 0° to angle_deg in the XY plane.
// Origin at the apex (centre of the full circle) on the bottom face.
//
// Parameters:
//   radius    — radius of the sector (mm)
//   angle_deg — sweep angle (degrees)
//   height    — prism height in Z (mm)
// -----------------------------------------------------------------------------
module sector(
  radius    = 20,
  angle_deg = 60,
  height    = 5
) {
  resolution = max(3, floor(64 * angle_deg / 360));

  linear_extrude(height = height)
    polygon(points = concat(
      [[0, 0]],
      [for (i = [0 : resolution])
        let(a = i * angle_deg / resolution)
        [radius * cos(a), radius * sin(a)]]
    ));
}

// -----------------------------------------------------------------------------
// parabola_profile
// Flat plate whose top edge follows a parabolic curve, suitable for
// projectile trajectory cross-sections or potential-energy diagrams.
// The parabola opens upward; minimum is at x=0, maximum at x=±width/2.
// Origin at the bottom-left corner of the bounding box.
//
// Parameters:
//   width      — horizontal span of the plate (mm)
//   height     — maximum height of the parabola above the base (mm)
//   thickness  — plate extrusion depth in Z (mm)
//   resolution — number of polygon points along the curve
// -----------------------------------------------------------------------------
module parabola_profile(
  width      = 60,
  height     = 30,
  thickness  = 3,
  resolution = 50
) {
  // Parabola: y = height * (x / (width/2))^2, centred at x=width/2
  half_w = width / 2;

  linear_extrude(height = thickness)
    polygon(points = concat(
      // Bottom-left to bottom-right base
      [[0, 0], [width, 0]],
      // Right side up the parabola (x from width → 0)
      [for (i = [0 : resolution])
        let(
          x    = width - i * width / resolution,
          xc   = x - half_w,          // centre-relative x
          y    = height * (xc / half_w) * (xc / half_w)
        )
        [x, y]]
    ));
}

// -----------------------------------------------------------------------------
// isosceles_triangle_prism
// Triangular ramp prism: isosceles triangle cross-section extruded in Z.
// The triangle base sits on the XY plane, apex centred above the base.
// Useful for inclined-plane and ramp models.
// Origin at the bottom-left corner.
//
// Parameters:
//   base      — base width in X (mm)
//   height    — triangle height in Y (mm)
//   thickness — extrusion depth in Z (mm)
// -----------------------------------------------------------------------------
module isosceles_triangle_prism(
  base      = 30,
  height    = 25,
  thickness = 5
) {
  linear_extrude(height = thickness)
    polygon(points = [
      [0,        0     ],
      [base,     0     ],
      [base / 2, height]
    ]);
}
