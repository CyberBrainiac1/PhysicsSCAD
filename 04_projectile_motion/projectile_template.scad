// =============================================================================
// Title:       Projectile Motion Template Board
// Folder:      04_projectile_motion
// Physics:     Projectile Motion — parabolic trajectories, range, and symmetry
// Difficulty:  Intermediate
// Print Type:  Display
// Teaches:     Parabola shape; complementary-angle equal-range symmetry; 45° max range
// Use Case:    AP Physics 1 | F=ma | FTC Robotics | All
// =============================================================================

// ============================================================
// projectile_template.scad
// PhysicsSCAD — 04_projectile_motion
// ============================================================
// Flat board with raised features:
//   • x-axis (horizontal range) along bottom
//   • y-axis (height) along left edge
//   • Three parabolic arc profiles at launch_angle_1/2/3
//   • Angle guide lines from origin at each launch angle
//   • "45°" label at the 45° arc peak
//   • Symmetry markers showing 30° and 60° share the same range
//   • Axis labels "x (range)" and "y (height)"
//
// Trajectory model (frictionless, flat ground, same v0):
//   x(t) = v0 * cos(angle) * t
//   y(t) = v0 * sin(angle) * t - 0.5 * g * t^2
// All three arcs are normalised so the 45° arc fits max_range_mm.
// ============================================================

// --------------------------------------------------------
// Physics Meaning
// --------------------------------------------------------
// Projectile motion separates into two independent 1-D problems:
//   Horizontal: constant velocity  vx = v0 cos(θ)
//   Vertical:   free fall          vy(t) = v0 sin(θ) − g t
//
// The trajectory equation (eliminating t):
//   y = x tan(θ) − g x² / (2 v0² cos²θ)   ← a downward parabola
//
// Range formula:
//   R(θ) = v0² sin(2θ) / g
//   Since sin(2·30°) = sin(60°) = sin(120°) = sin(2·60°),
//   the 30° and 60° launches land at the same point.
//
// Maximum range at θ = 45°  (sin 90° = 1).

// --------------------------------------------------------
// Learning Notes
// --------------------------------------------------------
// • At the peak, vy = 0; only vx remains → KE is purely horizontal.
// • Time to peak = v0 sin(θ) / g; total flight time = 2× that.
// • Increasing θ beyond 45° increases height but decreases range.
// • On other planets (different g), the shape scales but symmetry holds.

// --------------------------------------------------------
// Print Notes
// --------------------------------------------------------
// • Flat on bed, no supports needed.
// • Layer height 0.2 mm; 0.15 mm for smoother arc profiles.
// • Brim recommended (150 mm × 100 mm board can warp on some printers).
// • White or light grey PLA for best contrast.
// • Estimated time: 50–70 min at 60 mm/s.

// --------------------------------------------------------
// Customization Ideas
// --------------------------------------------------------
// • Change launch_angle_1/2/3 to explore non-classic angles.
// • Set max_range_mm = 200 and increase board_width for a wall-display version.
// • Set show_parabola = false for a blank angle-guide template (quiz mode).
// • Adjust board_thickness to 5 mm for a sturdier classroom demo piece.

$fn = 64;

// ------------------------------------------------------------
// Parameters
// ------------------------------------------------------------

board_width        = 150;  // mm — total board width (range axis)
board_height       = 100;  // mm — total board height (altitude axis)
board_thickness    = 3;    // mm — base plate thickness
launch_angle_1     = 30;   // degrees — first launch angle
launch_angle_2     = 45;   // degrees — second launch angle (max range)
launch_angle_3     = 60;   // degrees — third launch angle
show_parabola      = true; // render the parabolic arc profiles
show_angle_guides  = true; // render straight angle-guide lines from origin
show_axis_labels   = true; // render "x" and "y" axis labels
line_thickness     = 1.5;  // mm — raised line/arc width
axis_thickness     = 2.0;  // mm — raised axis bar width
max_range_mm       = 130;  // mm — range of 45° arc scaled to this width
feature_height     = 1.4;  // mm — raised height of all features

// Margins: launch point is at (margin_x, margin_y) in board coordinates
margin_x = 10;
margin_y = 8;

// Drawing area size
draw_w = board_width  - margin_x - 5;
draw_h = board_height - margin_y - 5;

// Number of polygon segments used for each parabola
arc_steps = 80;

// ============================================================
// Physics helpers
// ============================================================

// Normalisation:
// At θ = 45°, range = v0²/g. We want the 45° range to equal max_range_mm.
// So  v0² / g = max_range_mm  (in our unit system where 1 unit = 1 mm).
// Then for any angle:  range(θ) = max_range_mm * sin(2θ) / sin(90°)
//                                = max_range_mm * sin(2θ)
// Peak height(θ) = v0² sin²θ / (2g) = max_range_mm * sin²θ / 2

// Scale a trajectory to board coordinates.
// Returns [board_x, board_y] from normalised arc [nx, ny] in [0..1].
function arc_to_board(nx, ny, angle_deg) =
  let(range    = max_range_mm * sin(2 * angle_deg),
      peak_h   = max_range_mm * sin(angle_deg) * sin(angle_deg) / 2,
      bx = margin_x + nx * range,
      by = margin_y + ny / peak_h * draw_h * 0.85)
  [bx, by];

// Generate list of [board_x, board_y] points for a parabolic arc.
// t runs 0..1 (fraction of total flight time).
function parabola_pts(angle_deg) = [
  for (i = [0 : arc_steps])
    let(t    = i / arc_steps,
        // Normalised: x(t) = t * range,  y(t) = t*(1-t) * 4*peak  (parabola)
        range = max_range_mm * sin(2 * angle_deg),
        peak  = max_range_mm * sin(angle_deg) * sin(angle_deg) / 2,
        x_n   = t * range,
        y_n   = 4 * peak * t * (1 - t),
        // Map y to board: scale so 45° peak fills ~85% of draw_h
        bx    = margin_x + x_n,
        by    = margin_y + y_n * draw_h * 0.85 / (max_range_mm * 0.25))
    [bx, by]
];

// ============================================================
// Sub-modules
// ============================================================

// ------------------------------------------------------------
// board_base() — flat rectangular plate
// ------------------------------------------------------------
module board_base() {
  cube([board_width, board_height, board_thickness]);
}

// ------------------------------------------------------------
// axis_layer() — raised x-axis and y-axis
// ------------------------------------------------------------
module axis_layer() {
  // x-axis along bottom margin
  translate([margin_x - 2, margin_y - axis_thickness / 2, 0])
    cube([draw_w + 4, axis_thickness, feature_height]);

  // y-axis along left margin
  translate([margin_x - axis_thickness / 2, margin_y - 2, 0])
    cube([axis_thickness, draw_h + 4, feature_height]);

  // x-axis arrowhead
  translate([margin_x + draw_w + 3, margin_y, 0])
    linear_extrude(height = feature_height)
      polygon(points = [[0, -2.5], [0, 2.5], [5, 0]]);

  // y-axis arrowhead
  translate([margin_x, margin_y + draw_h + 3, 0])
    linear_extrude(height = feature_height)
      polygon(points = [[-2.5, 0], [2.5, 0], [0, 5]]);
}

// ------------------------------------------------------------
// axis_labels() — raised text labels on axes
// ------------------------------------------------------------
module axis_labels() {
  if (show_axis_labels) {
    // x-axis label
    translate([margin_x + draw_w / 2 - 14, 1, 0])
      linear_extrude(height = feature_height)
        text("x (range)", size = 4,
             font = "Liberation Sans:style=Bold Italic",
             halign = "left", valign = "bottom");

    // y-axis label (rotated)
    translate([2, margin_y + draw_h / 2 - 10, 0])
      rotate([0, 0, 90])
        linear_extrude(height = feature_height)
          text("y (height)", size = 4,
               font = "Liberation Sans:style=Bold Italic",
               halign = "left", valign = "bottom");
  }
}

// ------------------------------------------------------------
// raised_arc(angle_deg) — raised polyline tracing one parabola
// ------------------------------------------------------------
module raised_arc(angle_deg) {
  pts = parabola_pts(angle_deg);
  for (i = [0 : len(pts) - 2]) {
    p1 = pts[i];
    p2 = pts[i + 1];
    dx = p2[0] - p1[0];
    dy = p2[1] - p1[1];
    seg_len = sqrt(dx*dx + dy*dy);
    if (seg_len > 0.01) {
      angle = atan2(dy, dx);
      translate([p1[0], p1[1], 0])
        rotate([0, 0, angle])
          cube([seg_len + 0.1, line_thickness, feature_height]);
    }
  }
}

// ------------------------------------------------------------
// angle_guide_line(angle_deg)
// Straight line from origin in direction of launch angle.
// Length = 20 mm (just shows launch direction).
// ------------------------------------------------------------
module angle_guide_line(angle_deg) {
  guide_len = 22;  // mm
  translate([margin_x, margin_y, 0])
    rotate([0, 0, angle_deg])
      cube([guide_len, line_thickness * 0.8, feature_height * 0.8]);
}

// ------------------------------------------------------------
// angle_label(angle_deg, label_text, offset_x, offset_y)
// Raised text label near the launch-angle line.
// ------------------------------------------------------------
module angle_label(angle_deg, label_text) {
  guide_len = 24;
  lx = margin_x + guide_len * cos(angle_deg);
  ly = margin_y + guide_len * sin(angle_deg);
  translate([lx, ly, 0])
    linear_extrude(height = feature_height)
      text(label_text, size = 3.5,
           font = "Liberation Sans:style=Bold",
           halign = "center", valign = "bottom");
}

// ------------------------------------------------------------
// peak_label(angle_deg, label_text)
// Label placed at the peak of the arc.
// ------------------------------------------------------------
module peak_label(angle_deg, label_text) {
  pts     = parabola_pts(angle_deg);
  mid_idx = floor(len(pts) / 2);
  px = pts[mid_idx][0];
  py = pts[mid_idx][1] + 1.5;
  translate([px - 5, py, 0])
    linear_extrude(height = feature_height)
      text(label_text, size = 3.5,
           font = "Liberation Sans:style=Bold",
           halign = "left", valign = "bottom");
}

// ------------------------------------------------------------
// symmetry_marker()
// Raised bar connecting the landing points of the 30° and 60° arcs,
// showing they share the same range.
// ------------------------------------------------------------
module symmetry_marker() {
  range_30 = max_range_mm * sin(2 * 30);
  range_60 = max_range_mm * sin(2 * 60);
  // They are equal, but compute both for clarity
  x_land = margin_x + range_30;
  marker_h = 4;
  // Vertical tick at shared landing x
  translate([x_land - line_thickness / 2, margin_y, 0])
    cube([line_thickness * 0.8, marker_h, feature_height]);
  // Small "=" label
  translate([x_land + 1.5, margin_y, 0])
    linear_extrude(height = feature_height)
      text("30°=60°", size = 3,
           font = "Liberation Sans",
           halign = "left", valign = "bottom");
}

// ============================================================
// projectile_board() — main assembly
// ============================================================
module projectile_board() {
  board_base();

  translate([0, 0, board_thickness]) {
    // Axes
    axis_layer();
    axis_labels();

    // Parabolic arcs
    if (show_parabola) {
      raised_arc(launch_angle_1);
      raised_arc(launch_angle_2);
      raised_arc(launch_angle_3);
    }

    // Angle guide lines from origin
    if (show_angle_guides) {
      angle_guide_line(launch_angle_1);
      angle_guide_line(launch_angle_2);
      angle_guide_line(launch_angle_3);

      // Labels along guide lines
      angle_label(launch_angle_1, "30°");
      angle_label(launch_angle_2, "45°");
      angle_label(launch_angle_3, "60°");
    }

    // Peak label on the 45° arc
    peak_label(launch_angle_2, "max range");

    // Symmetry marker at 30°/60° shared landing point
    symmetry_marker();

    // "PhysicsSCAD" corner label
    translate([board_width - 48, 1, 0])
      linear_extrude(height = feature_height * 0.7)
        text("PhysicsSCAD", size = 3,
             font = "Liberation Sans",
             halign = "left", valign = "bottom");
  }
}

// ============================================================
// Demo modules
// ============================================================

// demo_default() — full board with all three angles
module demo_default() {
  projectile_board();
}

// demo_single_angle(angle_deg)
// Board showing only one arc at the specified angle.
// Useful for isolating one launch angle for discussion.
module demo_single_angle(angle_deg = 45) {
  board_base();
  translate([0, 0, board_thickness]) {
    axis_layer();
    axis_labels();
    raised_arc(angle_deg);
    if (show_angle_guides) {
      angle_guide_line(angle_deg);
      angle_label(angle_deg, str(angle_deg, "°"));
    }
  }
}

// ============================================================
// Render
// ============================================================
demo_default();
