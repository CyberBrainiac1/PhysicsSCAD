/*
Title: Adjustable Pendulum Stand + Phase Dial
Folder: 16_oscillations_shm
Physics Topic: Simple harmonic motion — pendulum period and phase portrait
Difficulty: Beginner-Intermediate
Print Type: FDM, separate parts — assemble after printing
Teaches: T = 2π√(L/g), phase portrait x = Acos(φ), v = −Aωsin(φ)
Use Case: Classroom manipulative — sliding clamp changes pendulum length
*/

// ═══════════════════════════════════════════════════
// PRINT GUIDE
// Parts to print:
//   1 × mast(200)         — vertical post with T-slot channel
//   1 × sliding_clamp()   — U-shaped clip that grips the mast T-slot
//   1 × bob()             — pendulum bob with string hole
//   1 × phase_dial(30,1)  — ellipse phase portrait dial
//   1 × bead()            — small peg that rides the ellipse groove
// Recommended filament: PLA, 0.2 mm layer height
// Supports: mast may need supports for T-slot overhang; all others no supports
// Assembly order:
//   1. Slide clamp onto mast T-slot from the top — should grip with friction
//   2. Thread string/cord through clamp hook and tie to bob
//   3. Set clamp at desired height (L = 50, 100, 150, or 200 mm marks)
//   4. Swing bob and count oscillations to measure period
//   5. Place bead in phase_dial ellipse groove and rotate around
// Tolerance note: adjust slide_tol/press_fit_tol if fit is off
// ═══════════════════════════════════════════════════

use <../common/ticks.scad>;

// --------------------
// Printer Tolerances
// --------------------
press_fit_tol = 0.15;  // mm — for press-fit joints
slide_tol     = 0.30;  // mm — for T-slot clamp sliding
snap_tol      = 0.20;  // mm — for snap-fit clips

// --------------------
// Parameters
// --------------------
// Mast
mast_h      = 200;  // mm — total mast height
mast_w      = 18;   // mm — mast cross-section width
mast_d      = 12;   // mm — mast cross-section depth
slot_w      = 8;    // mm — T-slot opening width
slot_d      = 5;    // mm — T-slot depth (top opening)
slot_flange = 3;    // mm — T-slot flange width each side (wider than slot_w)
tick_L      = [50, 100, 150, 200]; // mm — engraved period label heights

// Clamp
clamp_h     = 20;   // mm — clamp body height
clamp_th    = 3;    // mm — clamp wall thickness
hook_r      = 3;    // mm — hook radius for string attachment

// Phase dial
dial_d      = 100;  // mm — dial diameter
dial_t      = 4;    // mm — dial thickness
amplitude_A = 30;   // mm — SHM amplitude (x-axis semi-axis on dial)
omega       = 1.0;  // rad/s — angular frequency (scales v-axis: a_v = A*omega)
groove_w    = 3.5;  // mm — ellipse groove width
groove_d    = 2.5;  // mm — ellipse groove depth

// Bob
bob_d       = 18;   // mm — bob diameter
bob_h       = 18;   // mm — bob height
string_hole = 3;    // mm — hole diameter for string/cord

// Layout
print_mode  = "assembly"; // "assembly" or "flat"
x_spacing   = 20;

// --------------------
// Physics helpers
// --------------------
// Period at each length:  T = 2*pi*sqrt(L/9810)  (L in mm, g in mm/s²)
pi = 3.14159265358979;
function shm_period(L_mm) = 2 * pi * sqrt(L_mm / 9810);

// --------------------
// Modules
// --------------------

// Vertical mast with T-slot channel running full length and period tick marks
module mast(height=200) {
    difference() {
        // Main rectangular post
        cube([mast_w, mast_d, height]);

        // T-slot channel on front face
        // Narrow opening
        translate([mast_w/2 - slot_w/2 - slide_tol,
                   -0.1,
                   -0.1])
            cube([slot_w + slide_tol * 2, slot_d + 0.1, height + 0.2]);
        // Wide flange pocket
        translate([mast_w/2 - (slot_w + slot_flange * 2)/2 - slide_tol,
                   -0.1,
                   -0.1])
            cube([slot_w + slot_flange * 2 + slide_tol * 2,
                  slot_d - 1.5,
                  height + 0.2]);

        // Period tick marks on side face at L = 50, 100, 150, 200 mm
        for (L=tick_L) {
            // Engraved horizontal line
            translate([mast_w - 0.1, mast_d/2, L])
                rotate([0, 90, 0])
                    cube([0.8, 8, 1.5], center=true);
        }

        // Equation engraved on back face
        translate([2, mast_d - 0.6, mast_h * 0.35])
            rotate([90, 0, 0])
                linear_extrude(height=0.8)
                    rotate([0, 0, 90])
                        text("T=2pi*sqrt(L/g)", size=5,
                             font="Liberation Mono:style=Bold");
    }

    // Base foot for stability
    translate([-10, -5, 0])
        cube([mast_w + 20, mast_d + 10, 4]);
}

// U-shaped clamp that grips the T-slot via friction
module sliding_clamp() {
    tab_w = slot_w - slide_tol * 2;
    tab_d = slot_d - 0.5;
    flange_w = slot_w + slot_flange * 2 - slide_tol * 2;
    flange_d = slot_d - 1.5 - 0.3;

    difference() {
        // Clamp body
        cube([mast_w + clamp_th * 2, mast_d + clamp_th, clamp_h]);

        // Clearance for mast body (loose)
        translate([clamp_th, clamp_th, -0.1])
            cube([mast_w, mast_d + 0.1, clamp_h + 0.2]);

        // T-slot tab cutout matches the T-slot profile
        translate([clamp_th + mast_w/2 - tab_w/2, -0.1, -0.1])
            cube([tab_w, tab_d + 0.1, clamp_h + 0.2]);
        translate([clamp_th + mast_w/2 - flange_w/2, -0.1, -0.1])
            cube([flange_w, flange_d + 0.1, clamp_h + 0.2]);
    }

    // Hook on front face for string attachment
    translate([mast_w/2 + clamp_th, -(hook_r + 2), clamp_h/2])
        rotate([90, 0, 0]) {
            difference() {
                cylinder(h=3, r=hook_r + 2, $fn=30);
                cylinder(h=3, r=hook_r, $fn=30);
                // Cut bottom half to make open hook
                translate([-(hook_r + 2) - 0.1, 0, -0.1])
                    cube([(hook_r + 2) * 2 + 0.2, hook_r + 3, 3.2]);
            }
        }
}

// Pendulum bob with string hole at top
module bob() {
    difference() {
        cylinder(h=bob_h, d=bob_d, $fn=40);
        translate([0, 0, bob_h - string_hole * 2])
            cylinder(h=string_hole * 2 + 0.1, d=string_hole, $fn=20);
    }
}

// Phase portrait dial with ellipse groove
// x-axis: x = A*cos(phi),  v-axis: v = -A*omega*sin(phi)
module phase_dial(A=30, w=1.0) {
    a_x = A;               // semi-axis along x
    a_v = A * w;           // semi-axis along v

    difference() {
        // Dial body
        cylinder(h=dial_t, d=dial_d, $fn=120);

        // Ellipse groove (approximated as hull of many small cylinders)
        n_pts = 60;
        for (i=[0:n_pts-1]) {
            phi0 = i * 360 / n_pts;
            phi1 = (i + 1) * 360 / n_pts;
            hull() {
                translate([a_x * cos(phi0), a_v * sin(phi0),
                           dial_t - groove_d])
                    cylinder(h=groove_d + 0.1, d=groove_w, $fn=16);
                translate([a_x * cos(phi1), a_v * sin(phi1),
                           dial_t - groove_d])
                    cylinder(h=groove_d + 0.1, d=groove_w, $fn=16);
            }
        }

        // Degree markings around edge
        for (a=[0:30:330])
            rotate([0, 0, a])
                translate([dial_d/2 - 5, 0, dial_t - 0.6])
                    cube([4, 0.8, 0.8], center=true);

        // x-axis label
        translate([-16, -dial_d/2 + 5, dial_t - 0.6])
            linear_extrude(height=0.8)
                text("x=Acos(phi)", size=4, font="Liberation Mono:style=Bold");

        // v-axis label
        translate([-dial_d/2 + 3, -8, dial_t - 0.6])
            linear_extrude(height=0.8)
                rotate([0, 0, 90])
                    text("v=-Aw*sin(phi)", size=4, font="Liberation Mono:style=Bold");
    }

    // Raised axis lines
    translate([0, 0, dial_t])
        cube([dial_d * 0.85, 1, 0.5], center=true);
    translate([0, 0, dial_t])
        cube([1, dial_d * 0.85, 0.5], center=true);
}

// Small bead that rides in the ellipse groove
module bead() {
    cylinder(h=groove_d - 0.4, d=groove_w - 0.4 - slide_tol * 2, $fn=20);
    translate([0, 0, groove_d - 0.4])
        sphere(d=groove_w * 0.8, $fn=20);
}

// --------------------
// Demo / Print Layouts
// --------------------
module demo_default() {
    if (print_mode == "assembly") {
        mast(mast_h);
        // Clamp positioned at L=100 mm mark
        translate([-(clamp_th), -clamp_th, 100 - clamp_h/2])
            sliding_clamp();
        // Bob hanging below clamp (illustrative position)
        translate([mast_w/2, -(mast_d + 120), 0])
            bob();
        // Phase dial next to mast
        translate([mast_w + 30, mast_d/2, 0])
            phase_dial(amplitude_A, omega);
        // Bead on dial at phi=45°
        translate([mast_w + 30 + amplitude_A * cos(45),
                   mast_d/2 + amplitude_A * omega * sin(45),
                   dial_t - groove_d])
            bead();
    } else {
        mast(mast_h);
        translate([mast_w + x_spacing, 0, 0]) sliding_clamp();
        translate([mast_w + x_spacing * 2 + 30, 0, 0]) bob();
        translate([mast_w + x_spacing * 3 + 60, dial_d/2, 0])
            phase_dial(amplitude_A, omega);
        translate([mast_w + x_spacing * 4 + 60 + dial_d, 0, 0])
            bead();
    }
}

module demo_compact() { demo_default(); }

module demo_classroom() {
    // Show two phase dials with different omega to compare ellipse shapes
    phase_dial(amplitude_A, 1.0);
    translate([dial_d + x_spacing, 0, 0]) phase_dial(amplitude_A, 2.0);
    translate([0, dial_d + x_spacing, 0]) phase_dial(amplitude_A, 0.5);
}

// --------------------
// Physics Meaning
// --------------------
// Pendulum period T = 2π√(L/g). Sliding the clamp changes L — students feel
// T change as they time their swings. Mast labels pre-compute T at 50/100/150/200 mm.
// Phase dial: x = Acos(φ), v = −Aωsin(φ). Rotating the bead around the ellipse
// groove traces the phase portrait for SHM.

// --------------------
// Learning Notes
// --------------------
// 1. Double the pendulum length — does the period double? (It doesn't; T∝√L)
// 2. At φ=0 on the dial, x=A and v=0. What does that mean physically?
// 3. At φ=90° on the dial, x=0 and v=−Aω. Maximum speed at equilibrium!
// 4. How does changing omega on the dial (reprinting) widen or narrow the ellipse?
// 5. Count oscillations at L=50 vs L=200 — ratio should be ≈ √(200/50) = 2.

// --------------------
// Print Notes
// --------------------
// Mast: print upright, enable supports for T-slot overhang.
// Clamp: print flat (C-shape up), no supports needed.
// Bob: print upright, no supports.
// Phase dial: print flat, no supports.
// Bead: print flat side down.

// --------------------
// Customization Ideas
// --------------------
// Change amplitude_A to match different problem amplitudes.
// Change omega to generate different ellipse aspect ratios.
// Print multiple clamps for different classroom lab stations.

demo_default();
