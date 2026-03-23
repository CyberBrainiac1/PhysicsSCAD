// =============================================================================
// Title:       Kinematics Graph Tiles
// Folder:      03_kinematics_graphs
// Physics:     Kinematics — position, velocity, and acceleration graphs
// Difficulty:  Beginner
// Print Type:  Token Set
// Teaches:     x-t/v-t/a-t graph shapes; slope = rate of change; graph continuity
// Use Case:    AP Physics 1 | F=ma | All
// =============================================================================

// ============================================================
// kinematics_graph_tiles.scad
// PhysicsSCAD — 03_kinematics_graphs
// ============================================================
// Tile types:
//   tile_constant()       — horizontal line (zero slope)
//   tile_positive_slope() — straight line, up-right (+slope)
//   tile_negative_slope() — straight line, down-right (−slope)
//   tile_concave_up()     — curve bending upward (increasing slope)
//   tile_concave_down()   — curve bending downward (decreasing slope)
//   tile_zero_line()      — flat line at y = 0 baseline
//
// Snap system:
//   Left edge → raised peg (snap_peg)
//   Right edge → recessed hole (snap_hole)
//   Tiles connect left-to-right in time order.
//
// Assemble with demo_xt_story(), demo_vt_story(), or demo_print_all().
// ============================================================

// --------------------------------------------------------
// Physics Meaning
// --------------------------------------------------------
// Each tile represents ONE segment of a motion graph.
// The key relationships:
//   slope of x-t  = instantaneous velocity (v)
//   slope of v-t  = instantaneous acceleration (a)
//   area  of v-t  = displacement (Δx)
//   area  of a-t  = change in velocity (Δv)
//
// A horizontal tile on a v-t graph → constant velocity → zero acceleration
//   → flat a-t tile at a = 0 (tile_zero_line on the a-t graph).
//
// A positive-slope tile on a v-t graph → constant acceleration →
//   → flat a-t tile at positive value, AND concave-up x-t tile.

// --------------------------------------------------------
// Learning Notes
// --------------------------------------------------------
// • The snap system enforces time-ordering: tiles must read left-to-right.
// • Continuity: the curve value at the RIGHT edge of tile N must equal
//   the curve value at the LEFT edge of tile N+1.
// • Concave up  (∪) → slope is *increasing* → positive acceleration.
// • Concave down (∩) → slope is *decreasing* → negative acceleration (decel).
// • Flat at zero (zero_line) → quantity = 0 for entire segment.

// --------------------------------------------------------
// Print Notes
// --------------------------------------------------------
// • Print all 6 using demo_print_all() — one plate, ~90 min.
// • Flat on bed, no supports required.
// • Layer height 0.2 mm; 0.15 mm for crisper curve profiles.
// • Peg-hole tolerance: 0.2 mm gap (snap_hole_diameter > snap_peg_diameter).
// • Infill 20 % is sufficient.

// --------------------------------------------------------
// Customization Ideas
// --------------------------------------------------------
// • Increase tile_width to 70 mm for more graph resolution.
// • Change line_thickness for bolder or finer curves.
// • Set show_labels = false for a blank-tile quiz version.
// • Print concave_up and positive_slope tiles in different colours
//   so students can sort by graph-segment type.

$fn = 48;

// ------------------------------------------------------------
// Parameters
// ------------------------------------------------------------

tile_width           = 50;   // mm — tile width (time axis)
tile_height          = 50;   // mm — tile height (value axis)
tile_thickness       = 3;    // mm — base plate thickness
line_thickness       = 1.5;  // mm — raised curve/line width
axis_thickness       = 1.8;  // mm — raised axis bar width
feature_height       = 1.4;  // mm — height of raised graph lines above plate
snap_peg_diameter    = 3.0;  // mm — snap peg outer diameter
snap_hole_diameter   = 3.2;  // mm — snap hole inner diameter (slightly larger)
snap_peg_height      = 2.0;  // mm — peg protrusion height
show_labels          = true; // render tile-type labels

// Curve resolution
curve_steps = 32;  // number of polygon points for smooth curves

// Margins inside tile where graph is drawn
margin_x = 3;  // mm — left/right margin
margin_y = 3;  // mm — bottom/top margin

// Inner drawing area
inner_w = tile_width  - 2 * margin_x;
inner_h = tile_height - 2 * margin_y;

// ============================================================
// Utility: snap features
// ============================================================

// snap_peg() — raised cylindrical peg on the left edge (centred vertically)
module snap_peg() {
  translate([-snap_peg_height, tile_height / 2, tile_thickness / 2])
    rotate([0, 90, 0])
      cylinder(d = snap_peg_diameter, h = snap_peg_height + 0.1);
}

// snap_hole() — recessed hole in the right edge (centred vertically)
// Applied as a subtraction from the base plate.
module snap_hole() {
  translate([tile_width - 0.1, tile_height / 2, tile_thickness / 2])
    rotate([0, 90, 0])
      cylinder(d = snap_hole_diameter, h = snap_peg_height + 0.2);
}

// ============================================================
// Utility: axis bars
// ============================================================
module tile_axes() {
  // x-axis along bottom margin
  translate([margin_x, margin_y - axis_thickness / 2, 0])
    cube([inner_w, axis_thickness, feature_height]);
  // y-axis along left margin
  translate([margin_x - axis_thickness / 2, margin_y, 0])
    cube([axis_thickness, inner_h, feature_height]);
}

// ============================================================
// Utility: raised polyline from point list
// Each segment is a thin rectangular slab.
// pts: list of [x, y] in tile drawing-area coordinates.
// ============================================================
module raised_polyline(pts) {
  for (i = [0 : len(pts) - 2]) {
    p1 = pts[i];
    p2 = pts[i + 1];
    dx = p2[0] - p1[0];
    dy = p2[1] - p1[1];
    seg_len = sqrt(dx*dx + dy*dy);
    angle   = atan2(dy, dx);
    translate([p1[0] + margin_x, p1[1] + margin_y, 0])
      rotate([0, 0, angle])
        cube([seg_len, line_thickness, feature_height]);
  }
}

// ============================================================
// Utility: tile base with snap features
// ============================================================
module tile_base() {
  difference() {
    cube([tile_width, tile_height, tile_thickness]);
    // Snap hole on right edge
    snap_hole();
  }
  // Snap peg on left edge
  snap_peg();
}

// ============================================================
// Utility: optional tile label
// ============================================================
module tile_label(label_text) {
  if (show_labels) {
    translate([margin_x + 1, tile_height - margin_y - 5, tile_thickness])
      linear_extrude(height = feature_height * 0.7)
        text(label_text, size = 3.5,
             font = "Liberation Sans",
             halign = "left", valign = "bottom");
  }
}

// ============================================================
// Tile modules
// ============================================================

// ------------------------------------------------------------
// tile_constant()
// Horizontal line at mid-height — represents constant value.
// x-t: constant position (stopped)
// v-t: constant velocity
// a-t: constant (non-zero) acceleration
// ------------------------------------------------------------
module tile_constant() {
  y_mid = inner_h / 2;
  pts = [[0, y_mid], [inner_w, y_mid]];

  tile_base();
  translate([0, 0, tile_thickness]) {
    tile_axes();
    raised_polyline(pts);
    tile_label("const");
  }
}

// ------------------------------------------------------------
// tile_positive_slope()
// Straight line going from bottom-left to top-right.
// v-t: constant positive acceleration
// x-t: constant positive velocity (moving forward)
// ------------------------------------------------------------
module tile_positive_slope() {
  pts = [[0, 0], [inner_w, inner_h]];

  tile_base();
  translate([0, 0, tile_thickness]) {
    tile_axes();
    raised_polyline(pts);
    tile_label("+slope");
  }
}

// ------------------------------------------------------------
// tile_negative_slope()
// Straight line going from top-left to bottom-right.
// v-t: constant negative acceleration (decelerating in +x)
// x-t: constant negative velocity (moving backward)
// ------------------------------------------------------------
module tile_negative_slope() {
  pts = [[0, inner_h], [inner_w, 0]];

  tile_base();
  translate([0, 0, tile_thickness]) {
    tile_axes();
    raised_polyline(pts);
    tile_label("-slope");
  }
}

// ------------------------------------------------------------
// tile_concave_up()
// Curve bending upward: slope increases left to right.
// v-t: speed increasing (positive acceleration from slow start)
// x-t: position curving away (accelerating object)
// Modelled as a parabola: y = (x/inner_w)^2 * inner_h
// ------------------------------------------------------------
module tile_concave_up() {
  pts = [for (i = [0 : curve_steps])
    let(t = i / curve_steps,
        x = t * inner_w,
        y = t * t * inner_h)
    [x, y]
  ];

  tile_base();
  translate([0, 0, tile_thickness]) {
    tile_axes();
    raised_polyline(pts);
    tile_label("accel");
  }
}

// ------------------------------------------------------------
// tile_concave_down()
// Curve bending downward: slope decreases left to right.
// v-t: speed decreasing (deceleration to a stop)
// x-t: position curve flattening (decelerating object)
// Modelled as: y = (1 - (1-x/inner_w)^2) * inner_h
// ------------------------------------------------------------
module tile_concave_down() {
  pts = [for (i = [0 : curve_steps])
    let(t = i / curve_steps,
        x = t * inner_w,
        y = (1 - (1 - t) * (1 - t)) * inner_h)
    [x, y]
  ];

  tile_base();
  translate([0, 0, tile_thickness]) {
    tile_axes();
    raised_polyline(pts);
    tile_label("decel");
  }
}

// ------------------------------------------------------------
// tile_zero_line()
// Flat line at y = 0 (along the x-axis).
// a-t: zero acceleration (constant velocity segment)
// v-t: zero velocity (object at rest)
// ------------------------------------------------------------
module tile_zero_line() {
  y_zero = 0;
  pts = [[0, y_zero + line_thickness / 2],
         [inner_w, y_zero + line_thickness / 2]];

  tile_base();
  translate([0, 0, tile_thickness]) {
    tile_axes();
    raised_polyline(pts);
    tile_label("a=0");
  }
}

// ============================================================
// Demo modules
// ============================================================

// demo_xt_story()
// Three tiles showing a position-time story:
//   1. Object accelerates from rest (concave up x-t)
//   2. Moves at constant velocity (positive slope x-t)
//   3. Decelerates to stop (concave down x-t)
module demo_xt_story() {
  tile_concave_up();
  translate([tile_width, 0, 0])
    tile_positive_slope();
  translate([tile_width * 2, 0, 0])
    tile_concave_down();
}

// demo_vt_story()
// Three tiles showing a velocity-time story:
//   1. Constant acceleration (positive slope v-t)
//   2. Constant velocity (horizontal v-t)
//   3. Deceleration to zero (negative slope v-t)
module demo_vt_story() {
  tile_positive_slope();
  translate([tile_width, 0, 0])
    tile_constant();
  translate([tile_width * 2, 0, 0])
    tile_negative_slope();
}

// demo_print_all()
// All 6 tile types laid out for a single print run.
module demo_print_all() {
  gap = 5;  // mm between tiles
  row_h = tile_height + gap;
  col_w = tile_width  + gap;

  // Row 1
  tile_constant();
  translate([col_w, 0, 0])
    tile_positive_slope();
  translate([col_w * 2, 0, 0])
    tile_negative_slope();

  // Row 2
  translate([0, row_h, 0])
    tile_concave_up();
  translate([col_w, row_h, 0])
    tile_concave_down();
  translate([col_w * 2, row_h, 0])
    tile_zero_line();
}

// ============================================================
// Render
// ============================================================
demo_print_all();
