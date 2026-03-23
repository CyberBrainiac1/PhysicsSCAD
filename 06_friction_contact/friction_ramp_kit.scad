/*
 * Title: Friction Ramp Kit
 * Folder: 06_friction_contact
 * Physics Topic: Friction, Normal Force, Inclined Planes, Newton's Second Law
 * Difficulty: Beginner
 * Print Type: freestanding
 * Teaches: Static and kinetic friction, coefficient of friction, weight components
 *          on an incline, critical angle, Newton's Second Law on a slope
 * Use Case: Students place the sliding block on the ramp and investigate at what
 *           angle the block begins to slide, connecting the angle to μ_s.
 */

// Parameters
ramp_base_length    = 100;   // mm — horizontal base length of the ramp
ramp_width          = 40;    // mm — ramp width (into the page)
ramp_angle          = 20;    // degrees — incline angle of the ramp surface
ramp_thickness      = 4;     // mm — thickness of the ramp surface slab
show_angle_label    = true;  // render a small arc showing the ramp angle
show_component_guide = false; // show weight-component construction lines on the surface
block_length        = 25;    // mm — length of the sliding block
block_width         = 20;    // mm — width of the sliding block
block_height        = 12;    // mm — height of the sliding block
block_base_flat     = true;  // true = smooth base; false = bumped (rough) base

// Derived geometry
$fn              = 32;
ramp_height      = ramp_base_length * tan(ramp_angle); // vertical rise
hypotenuse       = ramp_base_length / cos(ramp_angle); // slope face length
bump_diameter    = 2.0;  // mm — diameter of texture bumps on rough block base
bump_height      = 0.8;  // mm — height of texture bumps
bump_spacing     = 4.0;  // mm — spacing between bump centers

// Physics Meaning
// The ramp angle θ determines how weight splits into components:
//   Parallel to ramp (causes sliding):    W_parallel = mg·sin(θ)
//   Perpendicular to ramp (normal force): N = mg·cos(θ)
// Friction force opposing motion:         f = μ·N = μ·mg·cos(θ)
// At the critical angle θ_c:  mg·sin(θ_c) = μ_s·mg·cos(θ_c)
//   → tan(θ_c) = μ_s  →  θ_c = arctan(μ_s)
// Measuring θ_c gives the static coefficient of friction directly!
// Net acceleration on the slope: a = g·(sin(θ) − μ_k·cos(θ))

// Learning Notes
// Key question: does the mass of the block affect whether it slides? (No! μ is mass-independent)
// The texture bumps on the rough block variant increase the interlocking of surface asperities.
// Comparing smooth vs. rough base blocks at the same angle shows the effect of surface texture.
// Timing the block sliding a known distance lets students calculate acceleration and then μ_k.
// Ramp family (15°, 25°, 35°) helps students see how acceleration increases with angle.

// Print Notes
// Print the ramp flat on the bed (base face down) — no supports needed.
// Print the block with the flat/bumped face down for best surface quality.
// For repeatable friction experiments, lightly sand the ramp surface after printing.
// The angle arc label prints as a raised feature on the ramp base — ensure layer height ≤ 0.2 mm.
// For the ramp_family(), print all three ramps in one bed for a direct comparison set.

// Customization Ideas
// - Try ramp_angle = 30, 35 to find the critical angle for PLA-on-PLA
// - Set block_base_flat = false for a high-friction rough surface
// - Set show_component_guide = true to add weight-decomposition lines on the slope
// - Scale ramp_base_length = 150 for a longer runway and slower, measurable slides
// - Print multiple blocks with different masses (fill different infill %) and test if angle differs

// ─────────────────────────────────────────────────────────────────────────────
// Modules
// ─────────────────────────────────────────────────────────────────────────────

// Wedge-shaped ramp — triangular cross-section extruded along the width axis
module ramp(angle      = ramp_angle,
            base_len   = ramp_base_length,
            width      = ramp_width,
            thickness  = ramp_thickness) {
  h = base_len * tan(angle);
  // Cross-section polygon: base triangle + ramp surface thickness
  // Points listed counter-clockwise: bottom-left, bottom-right, apex
  profile_pts = [
    [0,         0        ],
    [base_len,  0        ],
    [base_len,  thickness],
    [0,         h + thickness]
  ];
  rotate([90, 0, 0])
    translate([0, 0, -width * 0.5])
      linear_extrude(height = width)
        polygon(points = profile_pts);
  // Raised back wall (structural support and keeps block on ramp)
  translate([0, -width * 0.5, 0])
    cube([thickness, width, h + thickness]);
}

// Small protractor arc showing the ramp angle at the base corner
module angle_label_arc(angle = ramp_angle, arc_radius = 18) {
  arc_thickness = 1.2;
  arc_h         = 1.5;
  // Arc sweep from 0° to angle using a ring sector
  translate([0, -ramp_width * 0.5 - 0.1, 0])
    rotate([90, 0, 0]) {
      // Draw arc as a difference of cylinders with a masking cube
      difference() {
        linear_extrude(height = arc_h)
          difference() {
            circle(r = arc_radius);
            circle(r = arc_radius - arc_thickness);
            // Mask out everything above the angle sweep
            polygon(points = [
              [0, 0],
              [arc_radius * 2 * cos(angle + 90), arc_radius * 2 * sin(angle + 90)],
              [-arc_radius * 2, arc_radius * 2],
              [-arc_radius * 2, -arc_radius * 2],
              [arc_radius * 2, -arc_radius * 2]
            ]);
          }
      }
      // Angle value text near the arc
      if (show_angle_label) {
        translate([arc_radius * 0.55 * cos(angle * 0.5),
                   arc_radius * 0.55 * sin(angle * 0.5), arc_h])
          linear_extrude(height = 1.2)
            text(str(angle, "°"),
                 size    = 4,
                 halign  = "center",
                 valign  = "center",
                 font    = "Liberation Sans:style=Bold");
      }
    }
}

// Weight component guide lines on the ramp surface (for teaching force decomposition)
module component_guide_lines() {
  if (show_component_guide) {
    // Position near the center of the ramp surface
    cx = ramp_base_length * 0.5;
    cy = 0;
    cz = cx * tan(ramp_angle) + ramp_thickness + 1;
    // Line parallel to ramp surface (W_parallel component)
    translate([cx, cy, cz])
      rotate([0, -ramp_angle, 0])
        rotate([90, 0, 0])
          cylinder(d = 1.0, h = ramp_width, center = true);
    // Line perpendicular to ramp surface (Normal / W_perp component)
    translate([cx, cy, cz])
      rotate([0, -(ramp_angle + 90), 0])
        rotate([90, 0, 0])
          cylinder(d = 1.0, h = ramp_width * 0.6, center = true);
  }
}

// Sliding block — rectangular block with optional textured base
module sliding_block(len    = block_length,
                     wid    = block_width,
                     ht     = block_height,
                     flat   = block_base_flat) {
  difference() {
    cube([len, wid, ht], center = true);
    // Texture bumps cut from the bottom face (rough variant)
    if (!flat) {
      n_x = floor(len / bump_spacing) - 1;
      n_y = floor(wid / bump_spacing) - 1;
      for (ix = [0 : n_x]) {
        for (iy = [0 : n_y]) {
          x = -len * 0.5 + bump_spacing + ix * bump_spacing;
          y = -wid * 0.5 + bump_spacing + iy * bump_spacing;
          translate([x, y, -ht * 0.5 - bump_height * 0.5 + 0.01])
            sphere(d = bump_diameter);
        }
      }
    }
  }
  // Label on top face
  translate([0, 0, ht * 0.5])
    linear_extrude(height = 0.8)
      text(flat ? "smooth" : "rough",
           size   = 4,
           halign = "center",
           valign = "center",
           font   = "Liberation Sans");
}

// Position the block sitting on the ramp surface
module ramp_and_block() {
  ramp();
  if (show_angle_label) angle_label_arc();
  component_guide_lines();
  // Place block on ramp surface at mid-point along the slope
  mid_x = ramp_base_length * 0.5;
  mid_z = mid_x * tan(ramp_angle) + ramp_thickness + block_height * 0.5 * cos(ramp_angle);
  block_x = mid_x - block_height * 0.5 * sin(ramp_angle);
  translate([block_x, 0, mid_z])
    rotate([0, -ramp_angle, 0])
      sliding_block();
}

// Three ramps at different angles for comparison printing
module ramp_family() {
  angles   = [15, 25, 35];
  spacing  = ramp_base_length + 20;
  for (i = [0 : 2]) {
    translate([i * spacing, 0, 0]) {
      // Temporarily override ramp_angle by passing parameter
      h_i = ramp_base_length * tan(angles[i]);
      profile_pts_i = [
        [0,               0               ],
        [ramp_base_length, 0              ],
        [ramp_base_length, ramp_thickness ],
        [0,               h_i + ramp_thickness]
      ];
      rotate([90, 0, 0])
        translate([0, 0, -ramp_width * 0.5])
          linear_extrude(height = ramp_width)
            polygon(points = profile_pts_i);
      // Back wall
      translate([0, -ramp_width * 0.5, 0])
        cube([ramp_thickness, ramp_width, h_i + ramp_thickness]);
      // Angle arc
      translate([0, 0, 0])
        angle_label_arc(angle = angles[i]);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Demo modules
// ─────────────────────────────────────────────────────────────────────────────

// Default: ramp with block on the slope
module demo_default() {
  ramp_and_block();
}

// Ramp family: three ramps at 15°, 25°, 35° for comparison
module demo_ramp_family() {
  ramp_family();
}

// ─────────────────────────────────────────────────────────────────────────────
// Render
// ─────────────────────────────────────────────────────────────────────────────

demo_default();
// Uncomment to preview the comparison family:
// demo_ramp_family();
