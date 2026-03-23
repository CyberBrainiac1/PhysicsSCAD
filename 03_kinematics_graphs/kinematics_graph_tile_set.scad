/*
Title: Kinematics Graph Tile Set — Sliding Curve Insert System
Folder: 03_kinematics_graphs
Physics Topic: Motion graphs
Difficulty: Beginner-Intermediate
Print Type: FDM, separate parts — assemble after printing
Teaches: x-t slope=velocity; v-t slope=acceleration; v-t area=displacement
Use Case: Classroom manipulative — swappable curve inserts in reusable frame
*/

// ═══════════════════════════════════════════════════
// PRINT GUIDE
// Parts to print:
//   1 × frame()                 — base tile with channel rails (reusable)
//   1 × curve_insert("flat")    — Insert A: constant velocity (a=0)
//   1 × curve_insert("gentle")  — Insert B: gentle positive acceleration
//   1 × curve_insert("steep")   — Insert C: steep positive acceleration
//   1 × curve_insert("down")    — Insert D: deceleration
//   1 × curve_insert("parab")   — Insert E: thrown object (up then down)
//   1 × label_tab("x-t")        — axis label snap tile
//   1 × label_tab("v-t")        — axis label snap tile
//   1 × label_tab("a-t")        — axis label snap tile
// Recommended filament: PLA, 0.2 mm layer height
// Supports: No supports needed for any part
// Assembly order:
//   1. Print frame and all inserts flat
//   2. Slide a curve insert into the frame channel from the open side
//   3. Snap a label_tab into the label slot at the end of the frame
//   4. Swap inserts to compare motion types
// Tolerance note: adjust fit_tolerance if insert is too tight/loose
// ═══════════════════════════════════════════════════

use <../common/grids.scad>;

// --------------------
// Printer Tolerances
// --------------------
press_fit_tol = 0.15;  // mm — for press-fit joints
slide_tol     = 0.30;  // mm — for sliding parts (channel rails)
snap_tol      = 0.20;  // mm — for snap-fit label tab
fit_tolerance = 0.30;  // mm — subtracted from insert width for channel fit

// --------------------
// Parameters
// --------------------
// Frame / tile size
tile_w      = 80;    // mm — tile width (channel runs this direction)
tile_h      = 70;    // mm — tile height
tile_t      = 3;     // mm — base thickness

// Channel rails
rail_w      = 2.5;   // mm — rail width
rail_d      = 1.5;   // mm — rail depth (how far rail protrudes above base)
rail_gap    = tile_h - 14;  // mm — distance between inner faces of rails

// Curve insert
insert_w    = tile_w - 6;    // mm — insert length (fits between rails)
insert_t    = 2.0;           // mm — insert wafer thickness
curve_h     = 10;            // mm — max height of curve profile above wafer
insert_body_w = rail_gap - fit_tolerance * 2;  // mm — insert body width

// Label tab slot (end of frame)
tab_slot_w  = 12;   // mm — slot width
tab_slot_h  = 8;    // mm — slot height
tab_slot_d  = 2;    // mm — slot depth
tab_w       = tab_slot_w - snap_tol * 2;
tab_h       = tab_slot_h - snap_tol * 2;
tab_t       = 10;   // mm — label tab depth (how far it sticks out)

// Grid on frame
show_grid   = true;
grid_spacing = 10;

// Layout
print_mode  = "assembly"; // "assembly" or "flat"
x_spacing   = 20;

// --------------------
// Physics curve helpers
// --------------------
// All curves use normalised x in [0,1], output normalised y in [0,1]
function curve_flat(x)    = 0.4;                           // constant velocity
function curve_gentle(x)  = 0.08 + 0.84 * x * x;          // gentle +accel
function curve_steep(x)   = 0.05 + 0.95 * pow(x, 1.5);    // steep +accel
function curve_down(x)    = 0.95 - 0.87 * x * x;          // deceleration
function curve_parab(x)   = 4 * x * (1 - x);              // parabola up-down

function select_curve(name, x) =
    name == "flat"   ? curve_flat(x)   :
    name == "gentle" ? curve_gentle(x) :
    name == "steep"  ? curve_steep(x)  :
    name == "down"   ? curve_down(x)   :
                       curve_parab(x);  // "parab" default

// --------------------
// Modules
// --------------------

// Frame: base tile with two parallel channel rails and label slot at one end
module frame() {
    difference() {
        cube([tile_w, tile_h, tile_t]);

        // Grid lines engraved on base surface
        if (show_grid) {
            for (x=[grid_spacing : grid_spacing : tile_w - 1])
                translate([x, 0, tile_t - 0.6])
                    cube([0.6, tile_h, 0.8]);
            for (y=[grid_spacing : grid_spacing : tile_h - 1])
                translate([0, y, tile_t - 0.6])
                    cube([tile_w, 0.6, 0.8]);
        }

        // Label slot at right end of frame
        translate([tile_w - tab_slot_d, (tile_h - tab_slot_h) / 2, tile_t - 0.1])
            cube([tab_slot_d + 0.1, tab_slot_h, tab_slot_w]);

        // Axis label engraved on left end
        translate([2, (tile_h - 6) / 2, tile_t - 0.6])
            linear_extrude(height=0.8)
                text("pos", size=4, font="Liberation Mono:style=Bold");
    }

    // Bottom rail (y = 4 from bottom)
    translate([0, 4, tile_t])
        cube([tile_w - tab_slot_d, rail_w, rail_d]);

    // Top rail (y = tile_h - 4 - rail_w from bottom)
    translate([0, tile_h - 4 - rail_w, tile_t])
        cube([tile_w - tab_slot_d, rail_w, rail_d]);

    // Curve label on base between axes
    translate([3, tile_h - 10, tile_t - 0.6])
        linear_extrude(height=0.8)
            text("time", size=4, font="Liberation Mono:style=Bold");
}

// Curve insert: thin wafer with physics curve profile extruded on top
module curve_insert(curve_name="flat") {
    n_pts = 40;

    // Wafer body sized to slide in the channel
    cube([insert_w, insert_body_w, insert_t]);

    // Curve ridge on top of wafer — hull of cylinder chain
    for (i=[0:n_pts-2]) {
        x0 = i * insert_w / n_pts;
        x1 = (i + 1) * insert_w / n_pts;
        y0 = select_curve(curve_name, i / n_pts) * curve_h;
        y1 = select_curve(curve_name, (i + 1) / n_pts) * curve_h;
        hull() {
            translate([x0, insert_body_w / 2, insert_t + y0])
                cylinder(h=0.5, d=2.5, $fn=16);
            translate([x1, insert_body_w / 2, insert_t + y1])
                cylinder(h=0.5, d=2.5, $fn=16);
        }
    }

    // Insert type label engraved on wafer edge
    translate([2, insert_body_w - 6, insert_t - 0.5])
        linear_extrude(height=0.6)
            text(curve_name, size=3.5, font="Liberation Mono:style=Bold");
}

// Label tab: snap-in tile for axis type labels (x-t, v-t, a-t)
module label_tab(label_text="x-t") {
    difference() {
        cube([tab_t, tab_w, tab_h]);
        // Engraved label on front face
        translate([1, 1, tab_h/2 - 3])
            linear_extrude(height=0.8)
                text(label_text, size=5, font="Liberation Mono:style=Bold");
    }
    // Small snap bump on each side so it clicks into slot
    translate([tab_t - 2, tab_w/2 - 1, tab_h/2])
        cylinder(h=snap_tol + 0.5, d=2, $fn=16, center=true);
}

// --------------------
// Demo / Print Layouts
// --------------------
module demo_default() {
    if (print_mode == "assembly") {
        frame();
        // Show gentle curve insert slid into channel
        translate([3, 4 + rail_w, tile_t - insert_t / 2])
            curve_insert("gentle");
        // Label tab for x-t
        translate([tile_w - tab_slot_d + 0.2,
                   (tile_h - tab_w) / 2,
                   tile_t])
            label_tab("x-t");
    } else {
        // Lay all parts flat on build plate
        frame();
        translate([0, tile_h + x_spacing, 0]) curve_insert("flat");
        translate([0, tile_h + x_spacing * 2 + insert_body_w, 0])
            curve_insert("gentle");
        translate([0, tile_h + x_spacing * 3 + insert_body_w * 2, 0])
            curve_insert("steep");
        translate([insert_w + x_spacing, tile_h + x_spacing, 0])
            curve_insert("down");
        translate([insert_w + x_spacing, tile_h + x_spacing * 2 + insert_body_w, 0])
            curve_insert("parab");
        translate([insert_w + x_spacing * 2 + 20, tile_h + x_spacing, 0])
            label_tab("x-t");
        translate([insert_w + x_spacing * 2 + 20, tile_h + x_spacing * 2 + 20, 0])
            label_tab("v-t");
        translate([insert_w + x_spacing * 2 + 20, tile_h + x_spacing * 3 + 40, 0])
            label_tab("a-t");
    }
}

module demo_compact() { demo_default(); }

module demo_classroom() {
    // Three frames side by side showing x-t, v-t, a-t with matching inserts
    labels   = ["x-t", "v-t", "a-t"];
    curves   = ["gentle", "flat", "flat"];
    for (i=[0:2]) {
        translate([i * (tile_w + x_spacing), 0, 0]) {
            frame();
            translate([3, 4 + rail_w, tile_t - insert_t / 2])
                curve_insert(curves[i]);
            translate([tile_w - tab_slot_d + 0.2,
                       (tile_h - tab_w) / 2,
                       tile_t])
                label_tab(labels[i]);
        }
    }
}

// --------------------
// Physics Meaning
// --------------------
// x-t tile: slope of curve = instantaneous velocity.
// v-t tile: slope = acceleration; area under curve = displacement.
// a-t tile: flat line = constant acceleration (e.g., free fall).
// Swapping inserts while keeping the frame forces the student to reason about
// what shape the next graph must have.

// --------------------
// Learning Notes
// --------------------
// 1. What shape is the x-t graph for a stopped object? (flat line = Insert A)
// 2. If v-t is Insert B (gentle curve), what must a-t look like?
// 3. Swap Insert B for C on x-t — object is still speeding up, just faster!
// 4. Insert E (parabola) on x-t matches a thrown ball — what is v at the peak?
// 5. Can you make an x-t graph that means "going backwards"? (decrease curve)

// --------------------
// Print Notes
// --------------------
// Frame: any filament, 20% infill, print flat.
// Inserts: print flat, 4 walls, no supports needed.
// Tolerance: if insert too tight, increase fit_tolerance by 0.1 mm and reprint.
// Batch-print sets of 5 inserts per frame for full classroom kit.

// --------------------
// Customization Ideas
// --------------------
// Increase curve_h for more dramatic visual contrast between inserts.
// Add a piecewise insert by combining two curve functions at midpoint.
// Print inserts in different colours for easy identification.

demo_default();
