/*
Title: Projectile Motion — Fan-Out Angle Dial
Folder: 04_projectile_motion
Physics Topic: 2D kinematics and projectile motion
Difficulty: Beginner-Intermediate
Print Type: FDM, separate parts — assemble after printing
Teaches: Launch angle, range, complementary angles, R = v0²sin(2θ)/g
Use Case: Classroom manipulative — handheld rotating dial
*/

// ═══════════════════════════════════════════════════
// PRINT GUIDE
// Parts to print:
//   1 × base_plate()        — the circular dial base
//   1 × arch_arm(45)        — rotating trajectory arm (print the 45° shape)
//   1 × snap_pin()          — pivot post, press-fit into base
//   1 × detent_ring()       — bump ring glued/press-fit onto base
// Recommended filament: PLA, 0.2 mm layer height
// Supports: No supports needed for any part
// Assembly order:
//   1. Press snap_pin into base_plate centre hole
//   2. Slide detent_ring over pin and seat flush against base
//   3. Press arch_arm pivot hole over pin tip — should rotate freely
//   4. Rotate arm to feel detent clicks at 15°, 30°, 45°, 60°, 75°
// Tolerance note: adjust slide_tol / press_fit_tol if fit is off
// ═══════════════════════════════════════════════════

use <../common/ticks.scad>;

// --------------------
// Printer Tolerances
// --------------------
press_fit_tol = 0.15;  // mm — for press-fit joints (pivot pin into base hole)
slide_tol     = 0.30;  // mm — for sliding / rotating parts (arm over pin)
snap_tol      = 0.20;  // mm — for snap-fit clips

// --------------------
// Parameters
// --------------------
// Base plate
base_d        = 120;   // mm — diameter of circular base
base_t        = 3;     // mm — base thickness
tick_angles   = [0, 15, 30, 45, 60, 75, 90]; // degree markings

// Range arcs on base
range_arcs    = 3;     // number of concentric range grooves
arc_step      = 18;    // mm — radial spacing of range grooves

// Pivot pin
pin_shaft_d   = 6;     // mm — nominal pin diameter
pin_h         = 10;    // mm — total pin height
pin_head_d    = 8;     // mm — bulging head diameter (press-fit into arm)

// Arch arm
v0_scale      = 1.0;   // dimensionless — scales arch arm length proportionally
arm_t         = 3;     // mm — arm thickness
arm_w         = 6;     // mm — arm cross-section width
arm_length    = 55;    // mm — arch arm projected length

// Detent ring
detent_angles = [15, 30, 45, 60, 75]; // positions of detent clicks
bump_h        = 0.8;   // mm — bump height above ring face
bump_d        = 3;     // mm — bump diameter

// Layout
print_mode    = "assembly"; // "assembly" or "flat"
x_spacing     = 20;   // mm — spacing between parts in flat mode

// --------------------
// Helper: parabolic y at parameter x
// --------------------
// v0_mm_ms is the initial speed in mm/ms (≈ mm/s scale used here); 20 mm/ms
// gives trajectories that fit within the arm_length range at moderate angles.
v0_mm_ms = 20;  // mm/ms — initial launch speed (scales arch shape with v0_scale)
function py(x_val, angle) =
    tan(angle) * x_val - (9.81 / (2 * pow(v0_mm_ms * v0_scale, 2)))
        * (1 + pow(tan(angle), 2)) * pow(x_val, 2);

// --------------------
// Modules
// --------------------

// Circular base plate with angle markings and range arc grooves
module base_plate() {
    difference() {
        cylinder(h=base_t, d=base_d, $fn=120);

        // Range arc grooves (concentric) on top face
        for (i=[1:range_arcs]) {
            r_i = i * arc_step + 15;
            rotate_extrude($fn=120)
                translate([r_i, 0, 0])
                    square([1.2, 0.6], center=true);
        }

        // Degree-angle engraved lines from centre to edge
        for (a=tick_angles)
            rotate([0, 0, a])
                translate([0, -0.4, base_t - 0.6])
                    cube([base_d/2 - 4, 0.8, 0.8]);

        // Central hole for snap_pin (tight, press-fit)
        translate([0, 0, -0.1])
            cylinder(h=base_t + 0.2,
                     d=pin_shaft_d + press_fit_tol * 2,
                     $fn=36);

        // Equation engraved on base face
        translate([-28, -base_d/2 + 6, base_t - 0.6])
            linear_extrude(height=0.8)
                text("R=v0^2*sin(2t)/g", size=4, font="Liberation Mono:style=Bold");
    }

    // Launch-point marker bump at 9 o'clock (left of centre)
    translate([-base_d/4, 0, base_t])
        cylinder(h=1, d=3, $fn=20);
}

// Arch arm — parabolic trajectory piece that rotates on the pivot pin
module arch_arm(angle=45) {
    // Build arch from dot chain along parabolic path, hull each segment
    n_steps = 25;
    dx = arm_length / n_steps;

    union() {
        for (i=[0:n_steps-2]) {
            x0 = i * dx;
            x1 = (i + 1) * dx;
            y0 = max(0, py(x0, angle)) * v0_scale * 0.8;
            y1 = max(0, py(x1, angle)) * v0_scale * 0.8;
            hull() {
                translate([x0, y0, 0])
                    cube([arm_w, arm_w, arm_t], center=true);
                translate([x1, y1, 0])
                    cube([arm_w, arm_w, arm_t], center=true);
            }
        }

        // Thickened root block housing the pivot hole
        translate([0, 0, 0])
            difference() {
                cylinder(h=arm_t, d=pin_head_d + 4, $fn=36);
                // Pivot hole — loose fit so arm rotates (slide_tol)
                cylinder(h=arm_t + 0.2,
                         d=pin_shaft_d + slide_tol * 2,
                         $fn=36);
            }

        // Divot pockets on underside for detent bumps (cut into arm base)
        // placed on the ring of radius detent_r below the arm root
        detent_r = (base_d / 2) * 0.55;
        // One divot at angle=0 relative to arm orientation
        translate([0, -detent_r, -arm_t/2 + 0.5])
            cylinder(h=bump_h + 0.2, d=bump_d + 0.4, $fn=20);
    }
}

// Snap pin — press-fits into base; arm rotates over shaft
module snap_pin() {
    // Shaft — undersized for press-fit into base
    cylinder(h=pin_h - 2,
             d=pin_shaft_d - press_fit_tol * 2,
             $fn=36);
    // Bulging head — slightly oversized so arm is retained
    translate([0, 0, pin_h - 2])
        cylinder(h=2,
                 d1=pin_shaft_d - press_fit_tol * 2,
                 d2=pin_head_d,
                 $fn=36);
}

// Detent ring — thin ring with bumps that align with detent_angles
module detent_ring() {
    ring_r  = (base_d / 2) * 0.55;
    ring_t  = 1.5;
    ring_th = 4;   // ring cross-section width

    difference() {
        // Ring body
        rotate_extrude($fn=120)
            translate([ring_r, 0, 0])
                square([ring_th, ring_t], center=true);

        // Central cutout to clear the pin
        cylinder(h=ring_t + 0.2,
                 d=pin_shaft_d + slide_tol * 2,
                 $fn=36, center=true);
    }

    // Bumps at each detent angle
    for (a=detent_angles)
        rotate([0, 0, a])
            translate([ring_r, 0, ring_t / 2])
                cylinder(h=bump_h, d=bump_d, $fn=20);
}

// --------------------
// Demo / Print layouts
// --------------------
module demo_default() {
    if (print_mode == "assembly") {
        base_plate();
        // Pin seated in base
        translate([0, 0, base_t]) snap_pin();
        // Detent ring sitting on base around pin
        translate([0, 0, base_t]) detent_ring();
        // Arm at 45° (default detent position)
        rotate([0, 0, 45])
            translate([0, 0, base_t + 1.5]) arch_arm(45);
    } else {
        // Flat layout for printing
        base_plate();
        translate([base_d / 2 + x_spacing + 20, 0, 0]) arch_arm(45);
        translate([base_d / 2 + x_spacing * 2 + 40, 0, 0]) snap_pin();
        translate([base_d / 2 + x_spacing * 3 + 50, 0, 0]) detent_ring();
    }
}

module demo_compact() { demo_default(); }

module demo_classroom() {
    // Print four arch arms for different angle presets
    angles = [15, 30, 45, 60];
    for (i=[0:len(angles)-1])
        translate([i * (arm_length + x_spacing), 0, 0])
            arch_arm(angles[i]);
}

// --------------------
// Physics Meaning
// --------------------
// Rotating the arm changes launch angle θ. Range R = v0²sin(2θ)/g peaks at θ=45°.
// Complementary angles (e.g., 30° and 60°) produce equal ranges.

// --------------------
// Learning Notes
// --------------------
// 1. Rotate to 15° vs 75° — why do they feel "the same distance"?
// 2. Which click gives the longest arch? What equation predicts this?
// 3. Double v0_scale — how does the arch arm change shape?
// 4. Try removing the detent ring — how does precision of angle matter?
// 5. sin(2·45°) = 1 — explain why 45° is mathematically special.

// --------------------
// Print Notes
// --------------------
// Print all parts flat on build plate, no supports required.
// Use 4 perimeters / walls on arm for durability.
// Press snap_pin firmly into base — light hammer tap if needed.
// Arm should rotate freely; if stiff, increase slide_tol by 0.1 mm and reprint arm.

// --------------------
// Customization Ideas
// --------------------
// Change v0_scale to model faster/slower launches.
// Add more detent_angles for finer resolution.
// Print multiple arch arms at different angles for simultaneous comparison.

demo_default();
