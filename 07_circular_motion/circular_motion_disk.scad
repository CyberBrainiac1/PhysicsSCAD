/*
 * Title: Circular Motion Disk
 * Folder: 07_circular_motion
 * Physics Topic: Uniform Circular Motion, Centripetal Force, Tangential Velocity
 * Difficulty: Intermediate
 * Print Type: flat
 * Teaches: Centripetal acceleration direction, tangential velocity direction,
 *          perpendicularity of v and a_c, why centripetal force points inward,
 *          relationship between radius, speed, and centripetal force
 * Use Case: A physical reference disk showing centripetal and tangential arrows
 *           at multiple orbit positions; used in class discussion and lab prep.
 */

// Parameters
disk_radius            = 55;   // mm — overall disk radius
disk_thickness         = 3;    // mm — base disk thickness
orbit_radius           = 40;   // mm — radius of the circular orbit path
hub_radius             = 5;    // mm — central hub (bullseye) radius
hub_height             = 2;    // mm — how much the hub rises above the disk
radius_arrow_thickness = 2;    // mm — thickness of centripetal arrow shaft
show_tangent_arrows    = true; // render raised tangential velocity arrows
show_centripetal_arrows = true; // render raised centripetal force/accel arrows
show_angle_marks       = true; // render tick marks around the orbit
tick_angle_spacing     = 30;   // degrees — spacing between tick marks
number_of_positions    = 4;    // positions around orbit where arrows are shown

// Derived values
$fn               = 64;
arrow_head_length = 6;    // mm — arrowhead triangle length
arrow_head_width  = 4;    // mm — arrowhead triangle base width
arrow_raise       = disk_thickness * 0.5 + 1.0; // z above disk center
centripetal_len   = orbit_radius - hub_radius - 2; // shaft length inward
tangent_len       = 18;   // mm — tangential arrow shaft length
tick_height       = 1.5;  // mm — height of tick marks above disk
tick_length       = 4;    // mm — radial length of each tick mark
tick_width        = 1.2;  // mm — width of tick marks
orbit_ring_width  = 2.0;  // mm — width of the raised orbit ring
orbit_ring_height = 1.2;  // mm — height of the raised orbit ring above disk
label_offset      = 4;    // mm — outward offset of labels from arrow tips

// Physics Meaning
// Uniform circular motion: speed is constant, but velocity direction changes continuously.
// Centripetal acceleration: a_c = v²/r, always pointing toward the center.
// Centripetal force: F_c = ma_c = mv²/r — provided by tension, gravity, normal force, etc.
// Tangential velocity: always perpendicular to the radius at any point on the circle.
// Angular velocity: ω = v/r, relates linear and angular quantities.
// Period: T = 2πr/v = 2π/ω.
// No "centrifugal force" in the inertial frame — it is a fictitious force in the rotating frame.

// Learning Notes
// Key insight: the object IS accelerating even at constant speed — acceleration is a change
//   in velocity VECTOR, not just speed.
// The centripetal force is not a new type of force — it is always provided by an existing force:
//   - String → tension
//   - Gravity → gravitational force (satellites, planets)
//   - Road surface → normal force or friction (car on banked/flat curve)
// When the centripetal force disappears (string breaks), the object travels in a straight line
//   TANGENT to the circle at the release point — not outward radially.
// The four arrow positions at 0°, 90°, 180°, 270° show that the arrow directions rotate
//   with the object's position — v and a_c are always perpendicular, always local.

// Print Notes
// Print flat on bed, face up. No supports required.
// Use brim for adhesion — the disk has a large flat footprint.
// Ensure layer height ≤ 0.2 mm so raised arrow features print cleanly.
// The orbit ring and tick marks are thin features — use 2+ perimeters.
// Consider two-color printing: disk in one color, raised features paused for filament swap.

// Customization Ideas
// - Change orbit_radius to show how F_c scales with r at constant v
// - Set number_of_positions = 6 or 8 for more arrow positions
// - Set show_tangent_arrows = false for a centripetal-only quiz version
// - Set show_centripetal_arrows = false to show only velocity directions
// - Add a second orbit ring at a different radius using demo_multi_radius()
// - Increase disk_radius for a large classroom display model

// ─────────────────────────────────────────────────────────────────────────────
// Modules
// ─────────────────────────────────────────────────────────────────────────────

// Flat disk base
module orbit_disk() {
  cylinder(r = disk_radius, h = disk_thickness, center = true);
}

// Raised center hub (bullseye mark)
module hub_mark() {
  translate([0, 0, disk_thickness * 0.5]) {
    // Raised hub cylinder
    cylinder(r = hub_radius, h = hub_height);
    // Small center dot
    cylinder(r = hub_radius * 0.35, h = hub_height + 0.8);
  }
}

// Raised orbit ring showing the circular path
module orbit_ring(orb_r = orbit_radius) {
  translate([0, 0, disk_thickness * 0.5])
    difference() {
      cylinder(r = orb_r + orbit_ring_width * 0.5, h = orbit_ring_height);
      translate([0, 0, -0.1])
        cylinder(r = orb_r - orbit_ring_width * 0.5, h = orbit_ring_height + 0.2);
    }
}

// Arrowhead shape (flat triangle, extruded)
module arrowhead_2d(len = arrow_head_length, wid = arrow_head_width) {
  polygon(points = [
    [0,         0        ],
    [-len,       wid * 0.5],
    [-len,      -wid * 0.5]
  ]);
}

// Centripetal arrow: shaft + head pointing inward from orbit to hub
module centripetal_arrow(angle_deg) {
  if (show_centripetal_arrows) {
    shaft_len = centripetal_len - arrow_head_length;
    translate([0, 0, arrow_raise])
      rotate([0, 0, angle_deg]) {
        // Arrow shaft (pointing inward from orbit edge toward center)
        translate([hub_radius + arrow_head_length + 1, 0, 0])
          rotate([0, 90, 0])
            rotate([0, 0, 90])
              linear_extrude(height = shaft_len)
                square([radius_arrow_thickness, 1.5], center = true);
        // Arrowhead at the tip (pointing toward center, so head at inner end)
        translate([hub_radius + 1, 0, 0])
          rotate([0, 0, 180])
            linear_extrude(height = 1.5)
              arrowhead_2d();
        // Label "F_c" near the arrow midpoint
        mid_r = hub_radius + centripetal_len * 0.5;
        translate([mid_r, radius_arrow_thickness * 1.8, 1.5])
          linear_extrude(height = 1.2)
            text("F_c",
                 size   = 4,
                 halign = "center",
                 valign = "bottom",
                 font   = "Liberation Sans:style=Bold");
      }
  }
}

// Tangential arrow: perpendicular to radius, in direction of travel (CCW)
module tangent_arrow(angle_deg) {
  if (show_tangent_arrows) {
    translate([0, 0, arrow_raise])
      rotate([0, 0, angle_deg]) {
        // Position arrow at orbit radius, pointing 90° CCW from radial direction
        translate([orbit_radius, 0, 0])
          rotate([0, 0, 90]) {
            // Arrow shaft
            translate([0, -(tangent_len - arrow_head_length) * 0.5, 0])
              linear_extrude(height = 1.5)
                square([radius_arrow_thickness, tangent_len - arrow_head_length],
                       center = true);
            // Arrowhead at tip (CCW direction → positive y)
            translate([0, tangent_len * 0.5 - arrow_head_length, 0])
              rotate([0, 0, 90])
                linear_extrude(height = 1.5)
                  arrowhead_2d(len = arrow_head_length, wid = arrow_head_width);
            // Label "v" at the arrow tip
            translate([radius_arrow_thickness * 2.0, tangent_len * 0.5 + label_offset, 1.5])
              linear_extrude(height = 1.2)
                text("v",
                     size   = 5,
                     halign = "center",
                     valign = "bottom",
                     font   = "Liberation Sans:style=BoldItalic");
          }
      }
  }
}

// Tick marks around the orbit at regular angle intervals
module angle_tick_marks() {
  if (show_angle_marks) {
    for (a = [0 : tick_angle_spacing : 359]) {
      rotate([0, 0, a])
        translate([orbit_radius, 0, disk_thickness * 0.5])
          cube([tick_length, tick_width, tick_height], center = true);
    }
  }
}

// Angle labels at the four cardinal positions outside the orbit
module cardinal_angle_labels() {
  label_r = orbit_radius + tick_length + 6;
  angles  = [0, 90, 180, 270];
  labels  = ["0°", "90°", "180°", "270°"];
  for (i = [0 : 3]) {
    a  = angles[i];
    lx = label_r * cos(a);
    ly = label_r * sin(a);
    translate([lx, ly, disk_thickness * 0.5 + orbit_ring_height])
      linear_extrude(height = 1.2)
        text(labels[i],
             size   = 4,
             halign = "center",
             valign = "center",
             font   = "Liberation Sans");
  }
}

// Full disk assembly
module full_disk(orb_r = orbit_radius) {
  orbit_disk();
  hub_mark();
  orbit_ring(orb_r);
  angle_tick_marks();
  cardinal_angle_labels();
  angle_step = 360 / number_of_positions;
  for (i = [0 : number_of_positions - 1]) {
    a = i * angle_step;
    centripetal_arrow(a);
    tangent_arrow(a);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Demo modules
// ─────────────────────────────────────────────────────────────────────────────

// Default: single disk with all features enabled
module demo_default() {
  full_disk();
}

// Multi-radius: two concentric orbits showing how F_c scales with r
module demo_multi_radius() {
  full_disk(orb_r = orbit_radius);
  // Second orbit ring at smaller radius, no arrows (just the ring)
  orbit_ring(orb_r = orbit_radius * 0.55);
  // Label the second orbit
  translate([orbit_radius * 0.55 + 5, 3, disk_thickness * 0.5 + orbit_ring_height])
    linear_extrude(height = 1.2)
      text("r/2", size = 4, font = "Liberation Sans");
}

// ─────────────────────────────────────────────────────────────────────────────
// Render
// ─────────────────────────────────────────────────────────────────────────────

demo_default();
// Uncomment to preview multi-radius variant:
// demo_multi_radius();
