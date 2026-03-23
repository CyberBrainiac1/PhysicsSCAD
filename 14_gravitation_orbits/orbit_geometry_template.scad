/*
 * Title: Orbit Geometry Template
 * Folder: 14_gravitation_orbits
 * Physics Topic: Kepler's Laws, Orbital Mechanics, Gravitational Direction
 * Difficulty: Intermediate
 * Print Type: flat
 * Teaches: Elliptical orbits, foci, periapsis/apoapsis, equal-area law, velocity variation
 * Use Case: Reference board for classroom discussion of Kepler's three laws
 */

// --------------------
// Parameters
// --------------------
board_size         = 150;   // mm — square board side length
board_thickness    = 3;     // mm
ellipse_a          = 65;    // mm — semi-major axis
ellipse_b          = 40;    // mm — semi-minor axis
show_foci          = true;
show_periapsis     = true;
show_apoapsis      = true;
show_velocity_arrows = true; // large at periapsis, small at apoapsis
show_area_sectors  = true;   // equal-area sectors for Kepler's second law
line_thickness     = 1.5;    // mm — raised orbit path width

// --------------------
// Physics Meaning
// --------------------
// Kepler's First Law: planets orbit in ellipses with the Sun at one focus.
// Kepler's Second Law: the line from Sun to planet sweeps equal areas in equal times.
//   → planet moves FASTER near periapsis (closest), SLOWER near apoapsis (farthest).
// Kepler's Third Law: T² ∝ a³  where a is the semi-major axis.
// Eccentricity: e = c/a where c = sqrt(a²-b²) is the focus distance from center.

// --------------------
// Learning Notes
// --------------------
// - The central body sits at ONE focus, not the center of the ellipse
// - At periapsis: r_min = a - c,  v_max (conservation of energy + angular momentum)
// - At apoapsis:  r_max = a + c,  v_min
// - Equal-area sectors: same area but very different arc lengths → different speeds
// - Circular orbit: special case where e=0, a=b, both foci coincide at center

// --------------------
// Print Notes
// --------------------
// - Print flat; no supports required
// - 0.2 mm layers for crisp raised lines
// - Consider a filament color swap at layer 2 to highlight orbit path

// --------------------
// Customization Ideas
// --------------------
// - Reduce ellipse_b to ~10 mm for a comet-like highly eccentric orbit
// - Increase board_size for larger display boards
// - Add a second (outer) ellipse for a two-planet comparison

$fn = 64;

// Derived values
ellipse_c      = sqrt(ellipse_a * ellipse_a - ellipse_b * ellipse_b); // focus offset
focus_x        = ellipse_c;  // central body at right focus; empty focus at left
orbit_segments = 120;
raised         = board_thickness;   // z base for raised features
feature_h      = 1.8;               // height of raised lines/dots above board
dot_d          = 5;                 // focus dot diameter

// --------------------
// Helper: ellipse polygon (outer)
// --------------------
function ellipse_pts(a, b, n=orbit_segments) =
  [for (i = [0 : n-1]) [a * cos(i * 360 / n), b * sin(i * 360 / n)]];

// --------------------
// Raised orbit ring (annulus approximated by polygon difference)
// --------------------
module orbit_ring() {
  linear_extrude(height = feature_h)
    difference() {
      polygon(ellipse_pts(ellipse_a + line_thickness/2, ellipse_b + line_thickness/2));
      polygon(ellipse_pts(ellipse_a - line_thickness/2, ellipse_b - line_thickness/2));
    }
}

// --------------------
// Board base
// --------------------
module board_base() {
  cube([board_size, board_size, board_thickness], center=true);
}

// --------------------
// Focus dots
// --------------------
module focus_dots() {
  // Central body at right focus
  translate([focus_x, 0, 0])
    cylinder(h=feature_h * 2, d=dot_d, center=false);
  // Empty focus at left
  translate([-focus_x, 0, 0])
    cylinder(h=feature_h, d=dot_d * 0.6, center=false);
}

// --------------------
// Periapsis marker
// --------------------
module periapsis_marker() {
  // Periapsis is at x = +(a), rightmost point of orbit (closest to right focus)
  r_min = ellipse_a - ellipse_c;
  translate([ellipse_a, 0, 0])
    cylinder(h=feature_h * 1.5, d=4, $fn=16);
  // Tick line from center body to periapsis
  translate([focus_x, -line_thickness/2, 0])
    cube([r_min, line_thickness, feature_h * 0.5]);
}

// --------------------
// Apoapsis marker
// --------------------
module apoapsis_marker() {
  r_max = ellipse_a + ellipse_c;
  translate([-ellipse_a, 0, 0])
    cylinder(h=feature_h * 1.5, d=4, $fn=16);
  // Tick line from center body to apoapsis
  translate([-ellipse_a, -line_thickness/2, 0])
    cube([r_max, line_thickness, feature_h * 0.5]);
}

// --------------------
// Velocity arrow at a given point and angle on the orbit
// --------------------
module orbit_velocity_arrow(pos_x, pos_y, direction_deg, arrow_len) {
  translate([pos_x, pos_y, 0])
    rotate([0, 0, direction_deg]) {
      // Shaft
      cube([arrow_len, line_thickness, feature_h]);
      // Head
      translate([arrow_len, 0, 0])
        linear_extrude(height=feature_h)
          polygon([[0,0],[0, line_thickness*2],
                   [line_thickness*2, line_thickness/2],
                   [0, -line_thickness]]);
    }
}

// --------------------
// Equal-area sectors (two sectors of same area, different arc span)
// --------------------
module area_sector(start_deg, end_deg) {
  n_pts = 30;
  sector_pts = concat(
    [[focus_x, 0]],
    [for (i = [0 : n_pts])
      let(ang = start_deg + i * (end_deg - start_deg) / n_pts)
      [ellipse_a * cos(ang), ellipse_b * sin(ang)]
    ]
  );
  linear_extrude(height = feature_h * 0.6)
    difference() {
      polygon(sector_pts);
      // hollow out inside to just show the outline
      offset(delta = -line_thickness) polygon(sector_pts);
    }
}

// --------------------
// orbit_geometry_template() — main model
// --------------------
module orbit_geometry_template() {
  union() {
    board_base();

    translate([0, 0, board_thickness/2]) {
      orbit_ring();

      if (show_foci)      focus_dots();
      if (show_periapsis) periapsis_marker();
      if (show_apoapsis)  apoapsis_marker();

      if (show_velocity_arrows) {
        // Large arrow at periapsis (fast) — tangential = upward (90°)
        orbit_velocity_arrow(ellipse_a - 2, 0, 90, 20);
        // Small arrow at apoapsis (slow) — tangential = downward (270°)
        orbit_velocity_arrow(-ellipse_a + 2, 0, 90, 8);
      }

      if (show_area_sectors) {
        // Sector near periapsis: small angular span, large speed
        area_sector(-20, 20);
        // Sector near apoapsis: large angular span, small speed — same area
        area_sector(145, 215);
      }
    }
  }
}

// --------------------
// demo_default()
// --------------------
module demo_default() {
  orbit_geometry_template();
}

// --------------------
// demo_circular_orbit() — special case a=b
// --------------------
module demo_circular_orbit() {
  r = (ellipse_a + ellipse_b) / 2;
  // Rebuild with a=b (circular)
  union() {
    board_base();
    translate([0, 0, board_thickness/2]) {
      // Circular orbit ring
      difference() {
        cylinder(h=feature_h, r=r + line_thickness/2);
        cylinder(h=feature_h + 1, r=r - line_thickness/2);
      }
      // Single focus at center
      cylinder(h=feature_h * 2, d=dot_d);
    }
  }
}

// Run default demo
demo_default();
