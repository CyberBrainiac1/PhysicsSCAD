/*
 * Title: Buoyancy Comparison Block Set
 * Folder: 15_fluids_pressure
 * Physics Topic: Buoyancy, Archimedes' Principle, Density and Flotation
 * Difficulty: Beginner
 * Print Type: token/assembly
 * Teaches: F_buoy = ρ_fluid·V·g, density determines sink/float, displaced volume
 * Use Case: Weigh blocks in air and water; compare buoyancy forces; observe float/sink
 */

// --------------------
// Parameters
// --------------------
block_size           = 30;   // mm — cube side length (all blocks same outer size)
block_thickness      = 20;   // mm — depth of block (front-to-back)
show_density_label   = true;
hanging_hole_diameter = 3;   // mm — hole at top for string in water experiment
show_waterline_mark  = true; // raised line showing float waterline level

// --------------------
// Physics Meaning
// --------------------
// Archimedes' Principle: F_buoyancy = ρ_fluid · V_displaced · g
// All blocks have the same outer volume → same max buoyancy force if fully submerged.
// Whether a block floats depends on its AVERAGE DENSITY vs. fluid density.
// dense_block:    ρ_avg > ρ_water  → sinks
// hollow_block:   ρ_avg < ρ_water  → floats (large air volume reduces average density)
// foam_block:     ρ_avg << ρ_water → floats high (many air pockets)
// waterline_block: ρ_avg = ρ_water at a specific submersion depth

// --------------------
// Learning Notes
// --------------------
// - Use a spring scale: weight_in_air - weight_in_water = buoyancy force
// - The hollow and foam blocks displace the same water volume when submerged
//   as the solid block, but weigh less → net upward force → they float
// - The waterline mark shows the equilibrium submersion depth

// --------------------
// Print Notes
// --------------------
// - dense_block:    print at 80%+ infill in PLA (heavy)
// - hollow_block:   print at 0% infill, 2 perimeters (shell only)
// - foam_block:     print normally; cylindrical holes are part of geometry
// - waterline_block: print at ~50% infill
// - All blocks: orient with hole at top for clean bridging

// --------------------
// Customization Ideas
// --------------------
// - Change block_size to 40 mm for easier handling
// - Add more cutout rows to foam_block to reduce its density further
// - Adjust waterline_mark height to match a specific wood density (~0.6 g/cm³)

$fn = 32;

hole_y = block_size - hanging_hole_diameter - 3;  // y position of hanging hole
label_h = 1.2;   // raised label height
wall_t  = 3;     // hollow block shell wall thickness

// --------------------
// Hanging hole
// --------------------
module hanging_hole() {
  translate([block_size/2, hole_y, -1])
    cylinder(h=block_thickness + 2, d=hanging_hole_diameter);
}

// --------------------
// Waterline mark (raised ridge on side)
// --------------------
module waterline_mark(float_fraction=0.5) {
  // float_fraction: fraction of block submerged at equilibrium
  waterline_z = block_thickness * (1 - float_fraction);
  translate([-0.5, 0, waterline_z])
    cube([1.5, block_size, 1.2]);
}

// --------------------
// Label ridge (simple raised bar as label placeholder)
// --------------------
module side_label(label_index) {
  // Three small raised bars as a label identifier on the front face
  for (i = [0:2]) {
    w = (label_index == 0) ? 8 :
        (label_index == 1) ? 6 :
        (label_index == 2) ? 4 : 7;
    translate([block_size/2 - w/2, 5 + i*5, block_thickness])
      cube([w, 2, label_h]);
  }
}

// --------------------
// dense_block() — solid, high infill, sinks
// --------------------
module dense_block() {
  difference() {
    cube([block_size, block_size, block_thickness]);
    hanging_hole();
  }
  if (show_density_label) side_label(0);
  // "Dense" indicator: wide raised band
  translate([2, 2, block_thickness])
    cube([block_size - 4, 3, label_h]);
}

// --------------------
// hollow_block() — shell only, floats
// --------------------
module hollow_block() {
  difference() {
    cube([block_size, block_size, block_thickness]);
    // Large internal cavity
    translate([wall_t, wall_t, wall_t])
      cube([block_size - 2*wall_t, block_size - 2*wall_t, block_thickness - wall_t + 1]);
    hanging_hole();
  }
  if (show_density_label) side_label(1);
  if (show_waterline_mark) waterline_mark(0.25);  // floats 25% submerged
}

// --------------------
// foam_block() — grid of cylindrical cutouts, very low average density
// --------------------
module foam_block() {
  hole_d      = 6;    // mm — cutout cylinder diameter
  hole_rows   = 3;
  hole_cols   = 3;
  hole_margin = (block_size - hole_cols * hole_d) / (hole_cols + 1);

  difference() {
    cube([block_size, block_size, block_thickness]);
    // Grid of vertical cylindrical cutouts
    for (row = [0 : hole_rows - 1]) {
      for (col = [0 : hole_cols - 1]) {
        cx = hole_margin + col * (hole_d + hole_margin) + hole_d/2;
        cy = hole_margin + row * (hole_d + hole_margin) + hole_d/2;
        translate([cx, cy, -1])
          cylinder(h=block_thickness + 2, d=hole_d);
      }
    }
    hanging_hole();
  }
  if (show_density_label) side_label(2);
  if (show_waterline_mark) waterline_mark(0.1);  // floats very high
}

// --------------------
// waterline_block() — shows equilibrium float level explicitly
// --------------------
module waterline_block() {
  float_frac = 0.5;  // floats half submerged
  difference() {
    cube([block_size, block_size, block_thickness]);
    hanging_hole();
  }
  if (show_density_label) side_label(3);
  if (show_waterline_mark) {
    // Raised waterline ridge on all four vertical faces
    waterline_mark(float_frac);
    translate([block_size - 1, 0, block_thickness * (1 - float_frac)])
      cube([1.5, block_size, 1.2]);
    translate([0, -0.5, block_thickness * (1 - float_frac)])
      cube([block_size, 1.5, 1.2]);
    translate([0, block_size - 1, block_thickness * (1 - float_frac)])
      cube([block_size, 1.5, 1.2]);
  }
}

// --------------------
// demo_block_set() — all four blocks side by side
// --------------------
module demo_block_set() {
  spacing = block_size + 10;
  dense_block();
  translate([spacing, 0, 0])   hollow_block();
  translate([spacing*2, 0, 0]) foam_block();
  translate([spacing*3, 0, 0]) waterline_block();
}

// --------------------
// demo_default()
// --------------------
module demo_default() {
  demo_block_set();
}

// Run default demo
demo_default();
