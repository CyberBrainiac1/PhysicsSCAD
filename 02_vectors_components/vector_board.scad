/*
Title: Vector Board — Rotating Arm + Shadow Projector
Folder: 02_vectors_components
Physics Topic: Vectors and components
Difficulty: Beginner-Intermediate
Print Type: FDM, separate parts — assemble after printing
Teaches: Vector magnitude, direction, component decomposition, |R|²=Rx²+Ry²
Use Case: Classroom manipulative — rotating arm with sliding component shadows
*/

// ═══════════════════════════════════════════════════
// PRINT GUIDE
// Parts to print:
//   1 × board()             — base board with channel grooves
//   1 × snap_pivot()        — pivot post, press-fit into board origin hole
//   1 × rotating_arm(80)    — main vector arm (primary)
//   1 × rotating_arm(60)    — second vector arm (secondary, optional)
//   1 × component_slider("x")  — horizontal component shadow arm
//   1 × component_slider("y")  — vertical component shadow arm
// Recommended filament: PLA, 0.2 mm layer height
// Supports: No supports needed
// Assembly order:
//   1. Press snap_pivot into board origin hole
//   2. Place rotating_arm pivot hole over snap_pivot shaft
//   3. Insert component_slider("x") into horizontal channel
//   4. Insert component_slider("y") into vertical channel
//   5. Rotate arm; slide each shadow arm to match component length
// Tolerance note: adjust slide_tol/press_fit_tol if fit is off
// ═══════════════════════════════════════════════════

use <../common/axes.scad>;
use <../common/ticks.scad>;

// --------------------
// Printer Tolerances
// --------------------
press_fit_tol = 0.15;  // mm — press-fit pivot pin into board hole
slide_tol     = 0.30;  // mm — slider bar in channel groove
snap_tol      = 0.20;  // mm — snap-fit clips

// --------------------
// Parameters
// --------------------
// Board
board_size      = 180;     // mm — square board side
board_thickness = 4;       // mm
grid_spacing    = 10;      // mm

// Channel grooves in board surface
channel_w       = 6;       // mm — channel width (fits slider bar)
channel_d       = 2;       // mm — channel depth

// Pivot pin
pivot_d         = 8;       // mm — pivot post diameter
pivot_h         = 12;      // mm — total height above board
pivot_shaft_d   = 6;       // mm — shaft diameter (arm rotates over this)

// Rotating arm
arm_length      = 80;      // mm — default arm length
arm_thickness   = 3;       // mm
arm_width       = 6;       // mm
arm_head_len    = 10;      // mm — arrowhead length
arm_head_w      = 10;      // mm — arrowhead width

// Display options
show_grid               = true;
show_quadrant_labels    = true;
show_degree_markings    = true;
show_component_guides   = true;

// Layout
print_mode  = "assembly"; // "assembly" or "flat"
x_spacing   = 20;

// --------------------
// Modules
// --------------------

// Base board with perpendicular channel grooves and grid
module board() {
    difference() {
        cube([board_size, board_size, board_thickness], center=true);

        // Grid lines engraved on top face
        if (show_grid) {
            for (x=[-board_size/2+grid_spacing : grid_spacing : board_size/2-grid_spacing])
                translate([x, 0, board_thickness/2 - 0.6])
                    cube([0.8, board_size, 0.8], center=true);
            for (y=[-board_size/2+grid_spacing : grid_spacing : board_size/2-grid_spacing])
                translate([0, y, board_thickness/2 - 0.6])
                    cube([board_size, 0.8, 0.8], center=true);
        }

        // Horizontal channel groove (x-component slider)
        translate([0, 0, board_thickness/2 - channel_d])
            cube([board_size, channel_w + slide_tol * 2, channel_d + 0.1], center=true);

        // Vertical channel groove (y-component slider)
        translate([0, 0, board_thickness/2 - channel_d])
            cube([channel_w + slide_tol * 2, board_size, channel_d + 0.1], center=true);

        // Pivot hole at centre — press-fit for snap_pivot post
        translate([0, 0, -board_thickness/2 - 0.1])
            cylinder(h=board_thickness + 0.2,
                     d=pivot_d + press_fit_tol * 2,
                     $fn=36);

        // Equation engraved on board face
        translate([-board_size/2 + 3, -board_size/2 + 4, board_thickness/2 - 0.6])
            linear_extrude(height=0.8)
                text("|R|^2=Rx^2+Ry^2", size=5, font="Liberation Mono:style=Bold");
    }

    // Raised axes
    linear_extrude(height=board_thickness)
        offset(r=1)
            axis_2d(board_size * 0.95, board_size * 0.95, grid_spacing);

    // Degree arc ticks
    if (show_degree_markings)
        translate([0, 0, board_thickness])
            radial_ticks(radius=board_size * 0.45, spacing_deg=15, tick_len=4);
}

// Snap pivot post — press-fits into board; arm rotates over shaft
module snap_pivot() {
    // Base flange
    cylinder(h=2, d=pivot_d + 4, $fn=36);
    // Shaft — undersized for press-fit into board hole
    cylinder(h=pivot_h,
             d=pivot_d - press_fit_tol * 2,
             $fn=36);
    // Retaining lip at top to keep arm on post
    translate([0, 0, pivot_h - 1])
        cylinder(h=1.5, d1=pivot_shaft_d, d2=pivot_d + 1, $fn=36);
}

// Rotating vector arm — flat arrow with pivot hole at tail
module rotating_arm(length=80, z_height=0) {
    translate([0, 0, z_height]) {
        difference() {
            union() {
                // Shaft
                translate([0, -arm_width/2, 0])
                    cube([length - arm_head_len, arm_width, arm_thickness]);
                // Arrowhead
                translate([length - arm_head_len, 0, 0])
                    linear_extrude(height=arm_thickness)
                        polygon([[0, -arm_head_w/2],
                                 [arm_head_len, 0],
                                 [0,  arm_head_w/2]]);
            }

            // Pivot hole — loose fit so arm rotates (slide_tol clearance)
            translate([0, 0, -0.1])
                cylinder(h=arm_thickness + 0.2,
                         d=pivot_d + slide_tol * 2,
                         $fn=36);

            // Magnitude tick marks engraved every 10 mm along shaft
            for (d=[10:10:length-arm_head_len-5])
                translate([d, -arm_width/2, arm_thickness - 0.5])
                    cube([0.8, 3, 0.7]);
        }
    }
}

// Component slider — short bar with flanged bottom pin that rides in channel
module component_slider(axis="x") {
    slider_len = arm_length * 0.6;  // default length; student trims mentally
    bar_h      = board_thickness + 1;
    bar_w      = channel_w - slide_tol * 2;

    // Body bar
    if (axis == "x")
        translate([-slider_len/2, -bar_w/2, 0])
            cube([slider_len, bar_w, bar_h]);
    else
        translate([-bar_w/2, -slider_len/2, 0])
            cube([bar_w, slider_len, bar_h]);

    // Arrowhead tip
    translate([axis == "x" ? slider_len/2 : 0,
               axis == "y" ? slider_len/2 : 0,
               bar_h - arm_thickness])
        cylinder(h=arm_thickness, d1=bar_w * 1.5, d2=0.1, $fn=20);
}

// --------------------
// Demo / Print Layouts
// --------------------
module demo_default() {
    if (print_mode == "assembly") {
        board();
        translate([0, 0, board_thickness/2]) snap_pivot();
        // Primary arm at 40° example
        rotate([0, 0, 40])
            translate([0, 0, board_thickness/2 + pivot_h - arm_thickness])
                rotating_arm(arm_length);
        // Component shadows
        translate([arm_length * cos(40) / 2, 0, board_thickness/2 - channel_d])
            component_slider("x");
        translate([0, arm_length * sin(40) / 2, board_thickness/2 - channel_d])
            component_slider("y");
    } else {
        board();
        translate([board_size/2 + x_spacing + 10, 0, 0])
            rotating_arm(arm_length);
        translate([board_size/2 + x_spacing + 10, arm_length + x_spacing, 0])
            rotating_arm(arm_length * 0.75);  // second arm
        translate([board_size/2 + x_spacing * 2 + arm_length + 10, 0, 0])
            component_slider("x");
        translate([board_size/2 + x_spacing * 2 + arm_length + 10, arm_length + x_spacing, 0])
            component_slider("y");
        translate([board_size/2 + x_spacing * 3 + arm_length + 20, 0, 0])
            snap_pivot();
    }
}

module demo_compact() { demo_default(); }

module demo_classroom() {
    // Show board with both a primary and secondary arm at different angles
    board();
    translate([0, 0, board_thickness/2]) snap_pivot();
    rotate([0, 0, 55])
        translate([0, 0, board_thickness/2 + pivot_h - arm_thickness])
            rotating_arm(arm_length);
    rotate([0, 0, 20])
        translate([0, 0, board_thickness/2 + pivot_h])
            rotating_arm(arm_length * 0.75);
}

// --------------------
// Physics Meaning
// --------------------
// Rotating the arm changes angle θ. Component sliders show Rx = |R|cos(θ) and
// Ry = |R|sin(θ). The board confirms |R|² = Rx² + Ry² via Pythagorean identity.

// --------------------
// Learning Notes
// --------------------
// 1. Set arm to 0° — how long is Ry? Why?
// 2. Set arm to 90° — how long is Rx? What does that mean?
// 3. Find an angle where Rx = Ry. What angle is that?
// 4. Add two arms head-to-tail; estimate the resultant magnitude.
// 5. |R|² = Rx² + Ry² — verify with a ruler on the printed model.

// --------------------
// Print Notes
// --------------------
// Print all parts flat, no supports needed.
// Increase board_thickness to 5-6 mm for heavy classroom use.
// If sliders bind, increase slide_tol by 0.1 mm.
// Arm pivot hole may need light sanding if pivot_d tolerance is tight.

// --------------------
// Customization Ideas
// --------------------
// Change arm_length for different scale vectors.
// Set show_grid=false for a clean minimalist board.
// Print two arm lengths to explore addition of non-equal vectors.

demo_default();
