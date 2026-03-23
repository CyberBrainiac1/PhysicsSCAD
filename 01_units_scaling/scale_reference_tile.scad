// =============================================================================
// Title:       Scale Reference Tile
// Folder:      01_units_scaling
// Physics:     Units, Measurement, and Scale — SI length prefixes
// Difficulty:  Beginner
// Print Type:  Reference Board
// Teaches:     How mm and cm relate physically; ruler resolution vs precision
// Use Case:    AP Physics 1 | F=ma | FTC Robotics | All
// =============================================================================

// ============================================================
// scale_reference_tile.scad
// PhysicsSCAD — 01_units_scaling
// ============================================================
// Prints a flat rectangular tile with:
//   • A raised millimetre ruler along the bottom edge
//   • A raised centimetre ruler along the top edge
//   • A raised 1 cm × 1 cm tactile reference square
//   • Raised "1 cm" label for quick identification
//
// No supports needed. Print flat on the build plate.
// ============================================================

// --------------------------------------------------------
// Physics Meaning
// --------------------------------------------------------
// Every measurement in physics carries units. The metre is the
// SI base unit of length; millimetres and centimetres are the
// scales most common in lab work and robotics. This tile gives
// students a physical object that embodies those scales so that
// unit errors become viscerally obvious: "that answer is bigger
// than the tile — is that reasonable?"
//
// Ruler resolution ≈ 1 mm, illustrating that reported precision
// should not exceed instrument resolution.

// --------------------------------------------------------
// Learning Notes
// --------------------------------------------------------
// • 1 cm = 10 mm  (factor of 10, one order of magnitude)
// • 1 m  = 100 cm = 1000 mm
// • The 1 cm² raised square gives tactile reference for area.
// • Fermi estimation: a fingernail width ≈ 1 cm; a pencil
//   diameter ≈ 7 mm; a credit-card thickness ≈ 0.76 mm.
// • Dimensional analysis: if a formula gives metres and you
//   need cm, multiply by 100 — never just "move the decimal"
//   without understanding why.

// --------------------------------------------------------
// Print Notes
// --------------------------------------------------------
// • Layer height: 0.2 mm works well; 0.15 mm gives crisper text
// • Infill: 20–40 % (tile is decorative / reference, not structural)
// • No supports required — completely flat
// • Recommended filament: white or light grey so raised text
//   reads clearly; consider a contrasting top-layer colour change
//   at the raised-feature height for visual contrast.
// • Estimated print time: ~25 min at 60 mm/s

// --------------------------------------------------------
// Customization Ideas
// --------------------------------------------------------
// • Set tile_width = 150 to make a 15 cm ruler
// • Add show_inch_scale = true (TODO) for unit conversion context
// • Increase tile_thickness to 5 mm for a sturdier token
// • Laser-engrave instead of FDM: set ruler_thickness = -0.4
//   (negative extrusion becomes an engraved groove)

$fn = 32;

// ------------------------------------------------------------
// Parameters
// ------------------------------------------------------------

tile_width        = 100;  // mm — total tile length (also ruler length)
tile_height       = 60;   // mm — tile height (short axis)
tile_thickness    = 3;    // mm — base plate thickness
show_mm_scale     = true; // render mm ruler along bottom edge
show_cm_scale     = true; // render cm ruler along top edge
ruler_thickness   = 1.2;  // mm — height of raised ruler features above plate
ref_square_size   = 10;   // mm — side of the 1 cm tactile reference square
ref_square_height = 1.0;  // mm — raised height of the reference square
label_height      = 1.0;  // mm — raised height of text labels
border_wall       = 1.5;  // mm — thin raised border around tile edge

// ============================================================
// Sub-modules
// ============================================================

// ------------------------------------------------------------
// mm_ruler(length, thickness)
// Raised millimetre ruler starting at x=0, sitting at y=0.
// Tick marks: 1 mm ticks, taller 5 mm ticks, tallest 10 mm ticks.
// ------------------------------------------------------------
module mm_ruler(length, thickness) {
  tick_base_h   = thickness * 0.5;   // 1 mm tick height (half full)
  tick_5mm_h    = thickness * 0.75;  // 5 mm tick height
  tick_10mm_h   = thickness;         // 10 mm tick height (full)
  tick_width    = 0.6;               // mm — tick line width
  baseline_h    = 0.4;               // mm — thin baseline bar height

  // Baseline bar
  cube([length, tick_width, baseline_h]);

  // Tick marks
  for (i = [0 : length]) {
    tick_h = (i % 10 == 0) ? tick_10mm_h :
             (i %  5 == 0) ? tick_5mm_h  : tick_base_h;
    tick_len = (i % 10 == 0) ? 4.0 :
               (i %  5 == 0) ? 3.0 : 2.0;
    translate([i, 0, 0])
      cube([tick_width, tick_len, tick_h]);
  }
}

// ------------------------------------------------------------
// cm_ruler(length, thickness)
// Raised centimetre ruler — one tick per 10 mm, numbered.
// ------------------------------------------------------------
module cm_ruler(length, thickness) {
  tick_width  = 0.8;
  tick_len_cm = 5.0;  // mm — physical length of each cm tick mark
  baseline_h  = 0.4;
  num_cm      = floor(length / 10);

  // Baseline bar
  cube([length, tick_width, baseline_h]);

  for (i = [0 : num_cm]) {
    x_pos = i * 10;
    // Tick mark
    translate([x_pos, 0, 0])
      cube([tick_width, tick_len_cm, thickness]);
  }
}

// ------------------------------------------------------------
// reference_square(size, height)
// Raised square outline + filled square for tactile 1 cm ref.
// ------------------------------------------------------------
module reference_square(size, height) {
  wall = 0.8; // mm — wall thickness of the square outline
  // Outer square
  difference() {
    cube([size, size, height]);
    translate([wall, wall, -0.1])
      cube([size - 2*wall, size - 2*wall, height + 0.2]);
  }
}

// ------------------------------------------------------------
// tile_border()
// Thin raised border around the perimeter of the tile.
// ------------------------------------------------------------
module tile_border() {
  wall = border_wall;
  h    = ruler_thickness * 0.4;
  difference() {
    cube([tile_width, tile_height, h]);
    translate([wall, wall, -0.1])
      cube([tile_width - 2*wall, tile_height - 2*wall, h + 0.2]);
  }
}

// ============================================================
// scale_tile() — main assembly
// ============================================================
module scale_tile() {
  // Base plate
  cube([tile_width, tile_height, tile_thickness]);

  // Raised border
  translate([0, 0, tile_thickness])
    tile_border();

  // ---- mm ruler — bottom edge ----
  if (show_mm_scale) {
    translate([0, 2, tile_thickness])
      mm_ruler(tile_width, ruler_thickness);
  }

  // ---- cm ruler — top edge ----
  if (show_cm_scale) {
    // Flip ruler to hang from top edge inward
    translate([0, tile_height - 2, tile_thickness])
      mirror([0, 1, 0])
        cm_ruler(tile_width, ruler_thickness);
  }

  // ---- 1 cm tactile reference square — centre-left area ----
  sq_x = 8;
  sq_y = (tile_height - ref_square_size) / 2;
  translate([sq_x, sq_y, tile_thickness])
    reference_square(ref_square_size, ref_square_height);

  // ---- "1 cm" raised text label ----
  translate([sq_x + ref_square_size + 3, sq_y + 1, tile_thickness])
    linear_extrude(height = label_height)
      text("1 cm", size = 5, font = "Liberation Sans:style=Bold",
           halign = "left", valign = "bottom");

  // ---- "PhysicsSCAD" label — lower right area ----
  translate([tile_width - 4, 10, tile_thickness])
    rotate([0, 0, 90])
      linear_extrude(height = label_height * 0.8)
        text("PhysicsSCAD", size = 3.5,
             font = "Liberation Sans:style=Bold",
             halign = "left", valign = "bottom");

  // ---- "mm" label near bottom ruler ----
  translate([tile_width - 12, 4, tile_thickness])
    linear_extrude(height = label_height)
      text("mm", size = 4, font = "Liberation Sans",
           halign = "left", valign = "bottom");

  // ---- "cm" label near top ruler ----
  translate([tile_width - 12, tile_height - 10, tile_thickness])
    linear_extrude(height = label_height)
      text("cm", size = 4, font = "Liberation Sans",
           halign = "left", valign = "bottom");
}

// ============================================================
// Demo modules
// ============================================================

// demo_default() — single tile, standard parameters
module demo_default() {
  scale_tile();
}

// demo_classroom() — two tiles side by side for class sets
// (print one per student; costs ~15 g of filament each)
module demo_classroom() {
  scale_tile();
  translate([tile_width + 5, 0, 0])
    scale_tile();
}

// ============================================================
// Render
// ============================================================
demo_default();
