/*
 * Title: Torque Balance Beam
 * Folder: 10_torque_statics
 * Physics Topic: Torque, Rotational Equilibrium, Law of the Lever, Statics
 * Difficulty: Beginner
 * Print Type: assembly
 * Teaches: τ=rF, Στ=0 for equilibrium, mechanical advantage, law of the lever F₁d₁=F₂d₂
 * Use Case: Students hang mass tokens at measured positions on a beam resting on a pivot
 *           stand to explore how torque depends on force magnitude and distance from pivot.
 */

// --------------------
// Parameters
// --------------------

beam_length            = 160;  // mm — total beam length (symmetric about center)
beam_width             = 12;   // mm — beam cross-section width
beam_thickness         = 5;    // mm — beam cross-section height
tick_spacing           = 10;   // mm — distance between tick marks and peg positions
peg_diameter           = 3;    // mm — diameter of token-hanging pegs
peg_height             = 5;    // mm — how far pegs protrude above the beam top surface
peg_spacing            = 10;   // mm — matches tick_spacing (one peg per tick)
pivot_base_width       = 25;   // mm — base width of the triangular pivot stand
pivot_base_height      = 30;   // mm — height of the triangular pivot stand
pivot_base_thickness   = 12;   // mm — depth of pivot stand (into the page)
pivot_groove_width     = 4;    // mm — width of V-groove at top of pivot for beam
pivot_groove_depth     = 2;    // mm — depth of V-groove
mass_token_diameter    = 18;   // mm — diameter of hanging mass tokens
mass_token_thickness   = 6;    // mm — thickness (height) of mass tokens
mass_token_hole_diam   = 3.2;  // mm — through-hole to slide onto peg (slightly > peg_diameter)

label_height           = 0.8;  // mm — raised height of text labels
number_spacing         = 20;   // mm — spacing between distance numbers on beam
tick_raise             = 0.6;  // mm — raised height of tick marks on beam

$fn = 32;

// --------------------
// Physics Meaning
// --------------------
// Torque:          τ = r × F   (N⋅m; r = distance from pivot, F = force)
// Equilibrium:     Στ_clockwise = Στ_counter_clockwise
// Law of the lever: F₁ × d₁ = F₂ × d₂
// Weight force:    F = m × g   (N; each "1" token represents one unit of weight)
// Net torque ≠ 0 → beam tips toward the side with greater total torque.
// Key: doubling distance = same effect as doubling mass.

// --------------------
// Learning Notes
// --------------------
// 1. Start with one token on each side at equal distances → perfect balance.
// 2. Move one token farther from pivot → that side tips down.
// 3. Try: 2 tokens at position 3 vs. 1 token at position 6 → should balance.
// 4. Numbers on beam show distance from center in tick units.
// 5. Students calculate Στ before letting go of the beam — then verify.
// 6. Discuss how a small force far out can balance a large force close in.

// --------------------
// Print Notes
// --------------------
// Print beam flat on build plate — no supports needed.
// Print pivot stand with 40%+ infill for stability under repeated tipping.
// Print mass tokens with 100% infill so their weight is maximized and consistent.
// Multiple token sets in different colors (1=white, 2=blue, 3=red) are recommended.
// Peg diameter 3 mm with a 3.2 mm hole gives a loose slip fit — tokens slide on easily.

// --------------------
// Customization Ideas
// --------------------
// - Increase beam_length to 240 mm for more positions and larger torque differences.
// - Print two pivot stands at different heights to explore mechanical advantage.
// - Mark beam in cm instead of arbitrary units for SI-unit calculations.
// - Add a small bubble level to the beam for precise horizontal reference.
// - Use steel washers as mass tokens for very consistent weight units.

// ============================================================
// Helper: triangular prism (for pivot stand body)
// ============================================================
module triangular_prism(base, height, depth) {
  linear_extrude(height = depth)
    polygon(points = [
      [0,      0],
      [base,   0],
      [base/2, height]
    ]);
}

// ============================================================
// Module: balance_beam
// The main beam with tick marks, distance numbers, and pegs.
// A center notch on the bottom mates with the pivot V-groove.
// ============================================================
module balance_beam() {
  half_len = beam_length / 2;

  difference() {
    // Main beam body
    translate([-half_len, -beam_width / 2, 0])
      cube([beam_length, beam_width, beam_thickness]);

    // Center pivot notch on the bottom — a V-groove running across the beam width
    translate([-pivot_groove_width / 2, -beam_width / 2 - 0.1, -0.1])
      cube([pivot_groove_width, beam_width + 0.2, pivot_groove_depth + 0.1]);
  }

  // Raised tick marks on top of beam
  num_ticks = floor(half_len / tick_spacing);
  for (i = [1 : num_ticks]) {
    // Right-side ticks
    translate([i * tick_spacing - 0.5, -beam_width / 2, beam_thickness])
      cube([1, beam_width, tick_raise]);
    // Left-side ticks
    translate([-i * tick_spacing - 0.5, -beam_width / 2, beam_thickness])
      cube([1, beam_width, tick_raise]);
  }

  // Center tick (wider, to mark pivot position clearly)
  translate([-1, -beam_width / 2, beam_thickness])
    cube([2, beam_width, tick_raise * 2]);

  // Distance numbers every 20 mm on the top surface, right side
  num_labels = floor(half_len / number_spacing);
  for (i = [1 : num_labels]) {
    x_pos = i * number_spacing;
    translate([x_pos, 0, beam_thickness + tick_raise])
      linear_extrude(height = label_height)
        text(
          str(i * 2),
          size   = 4,
          halign = "center",
          valign = "center",
          font   = "Liberation Sans:style=Bold"
        );
    // Mirror on left side with negative sign indicator
    translate([-x_pos, 0, beam_thickness + tick_raise])
      linear_extrude(height = label_height)
        text(
          str(i * 2),
          size   = 4,
          halign = "center",
          valign = "center",
          font   = "Liberation Sans:style=Bold"
        );
  }

  // Pegs on top surface at every tick position
  for (i = [1 : num_ticks]) {
    // Right pegs
    translate([i * peg_spacing, 0, beam_thickness])
      cylinder(d = peg_diameter, h = peg_height);
    // Left pegs
    translate([-i * peg_spacing, 0, beam_thickness])
      cylinder(d = peg_diameter, h = peg_height);
  }
  // Center peg
  translate([0, 0, beam_thickness])
    cylinder(d = peg_diameter, h = peg_height);
}

// ============================================================
// Module: pivot_stand
// A triangular prism with a V-groove on top for the beam to rest on.
// ============================================================
module pivot_stand() {
  half_base = pivot_base_width / 2;

  difference() {
    // Triangular prism body (lies with base down, apex up)
    translate([-half_base, 0, 0])
      triangular_prism(pivot_base_width, pivot_base_height, pivot_base_thickness);

    // V-groove at the apex (knife-edge) for beam pivot notch
    translate([
      -pivot_groove_width / 2,
      pivot_base_height - pivot_groove_depth,
      -0.1
    ])
      cube([pivot_groove_width, pivot_groove_depth + 0.1, pivot_base_thickness + 0.2]);
  }

  // Base platform for stability (a flat pad under the triangle)
  translate([-pivot_base_width / 2 - 5, -4, 0])
    cube([pivot_base_width + 10, 4, pivot_base_thickness]);
}

// ============================================================
// Module: mass_token(label)
// A flat disk with a center hole for sliding onto beam pegs.
// label — "1", "2", or "3" (or any string)
// ============================================================
module mass_token(label = "1") {
  difference() {
    // Disk body
    cylinder(d = mass_token_diameter, h = mass_token_thickness);

    // Center hole for peg
    translate([0, 0, -0.1])
      cylinder(d = mass_token_hole_diam, h = mass_token_thickness + 0.2);
  }

  // Raised label on top
  translate([0, 0, mass_token_thickness])
    linear_extrude(height = label_height)
      text(
        label,
        size   = 7,
        halign = "center",
        valign = "center",
        font   = "Liberation Sans:style=Bold"
      );

  // Raised ring border on top for visual mass distinction
  translate([0, 0, mass_token_thickness])
    difference() {
      cylinder(d = mass_token_diameter, h = 0.8);
      cylinder(d = mass_token_diameter - 3, h = 0.9);
    }
}

// ============================================================
// Module: beam_assembly
// Combines beam + pivot stand in display position.
// ============================================================
module beam_assembly() {
  // Pivot stand positioned at center underneath the beam
  translate([0, -beam_width / 2, 0])
    rotate([0, 0, 0])
      pivot_stand();

  // Beam on top of pivot, resting in V-groove
  translate([0, 0, pivot_base_height])
    balance_beam();
}

// ============================================================
// Demo Modules
// ============================================================

// demo_default: beam + pivot assembled
module demo_default() {
  beam_assembly();
}

// demo_classroom: multiple token sets laid flat for batch printing
module demo_classroom() {
  gap = 5;

  // Six "1" tokens
  for (i = [0:2]) {
    for (j = [0:1]) {
      translate([
        i * (mass_token_diameter + gap),
        j * (mass_token_diameter + gap),
        0
      ])
        mass_token("1");
    }
  }

  // Three "2" tokens (offset to the right)
  for (k = [0:2]) {
    translate([
      (mass_token_diameter + gap) * 3 + k * (mass_token_diameter + gap),
      0,
      0
    ])
      mass_token("2");
  }

  // Two "3" tokens
  for (k = [0:1]) {
    translate([
      (mass_token_diameter + gap) * 3 + k * (mass_token_diameter + gap),
      mass_token_diameter + gap,
      0
    ])
      mass_token("3");
  }
}

// demo_example_balance: beam + pivot with tokens showing a balanced 2-force scenario.
// Left: one "2" token at position 3 (torque = 6 units)
// Right: one "1" token at position 6 (torque = 6 units) → balanced!
module demo_example_balance() {
  beam_assembly();

  peg_offset = peg_spacing; // 1 position unit = peg_spacing mm

  // Left side: "2" token at position 3 (x = -30 mm from center)
  translate([-3 * peg_offset, 0, pivot_base_height + beam_thickness + peg_height])
    rotate([0, 0, 0])
      mass_token("2");

  // Right side: "1" token at position 6 (x = +60 mm from center)
  translate([6 * peg_offset, 0, pivot_base_height + beam_thickness + peg_height])
    mass_token("1");
}

// ============================================================
// Default render — uncomment one demo to view it
// ============================================================
demo_default();
// demo_classroom();
// demo_example_balance();
