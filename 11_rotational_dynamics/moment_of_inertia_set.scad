/*
 * Title: Moment of Inertia Comparison Set
 * Folder: 11_rotational_dynamics
 * Physics Topic: Rotational Inertia, Rolling Motion, Angular Acceleration
 * Difficulty: Intermediate
 * Print Type: freestanding
 * Teaches: I=Σmr², rolling KE=½mv²+½Iω², mass distribution vs. rotational resistance
 * Use Case: Roll the five disks down a ramp to directly compare rotational inertia;
 *           the disk with lowest I (most mass near center) reaches the bottom first.
 */

// --------------------
// Parameters
// --------------------

outer_diameter    = 80;   // mm — all disks share this outer diameter
disk_thickness    = 8;    // mm — thickness (height) of every disk
center_bore_diam  = 8;    // mm — axle bore hole (fits 8 mm wooden dowel or M8 rod)
label_depth       = 0.8;  // mm — depth of recessed label (negative = raised below surface)

// Derived values (do not change these — they are computed from parameters above)
outer_radius      = outer_diameter / 2;
bore_radius       = center_bore_diam / 2;

// Ring disk inner radius (fraction of outer)
ring_inner_frac   = 0.70; // ring inner radius = outer_radius * ring_inner_frac

// Spoked disk parameters
num_spokes        = 6;    // number of spokes in the spoked disk
spoke_width       = 5;    // mm — width of each spoke
ring_rim_width    = 6;    // mm — thickness of outer rim on spoked disk

// Cutout disk parameters
num_cutouts       = 6;    // number of circular cutouts in the cutout disk
cutout_radius     = 10;   // mm — radius of each cutout circle
cutout_ring_frac  = 0.60; // cutouts centered at this fraction of outer_radius

// Hub-heavy disk parameters
hub_radius        = 18;   // mm — radius of the thick central hub
hub_extra_height  = 4;    // mm — extra thickness added to hub above disk surface

// Stand parameters
stand_width       = outer_diameter + 20;  // mm — bracket width
stand_height      = outer_diameter / 2 + 15; // mm — bracket height
stand_thickness   = 6;    // mm — bracket arm thickness
stand_depth       = 10;   // mm — bracket depth (into page)
axle_slot_width   = center_bore_diam + 1; // mm — slot width for axle

label_font        = "Liberation Sans:style=Bold";
label_size        = 7;    // mm — main label font size
inertia_label_sz  = 5;    // mm — H/M/L indicator font size
label_raise       = 0.8;  // mm — raised height above disk surface

$fn = 32;

// --------------------
// Physics Meaning
// --------------------
// Moment of inertia: I = Σ mᵢ rᵢ²   (kg⋅m²)
// Solid disk:        I = ½MR²              (lowest for a given M and R → fastest on ramp)
// Ring (thin):       I = MR²               (highest → slowest on ramp)
// Spoked disk:       I ≈ between solid and ring
// Cutout disk:       I between solid and spoked (depends on cutout position)
// Hub-heavy disk:    I < solid disk (more mass near center, r² is small there)
// Rolling race: object with lower I reaches bottom of ramp first (energy split favors translation).
// Energy: mgh = ½mv² (1 + I/mR²) — larger I means more energy goes to rotation, less to translation.

// --------------------
// Learning Notes
// --------------------
// 1. Before the ramp race, ask students to rank disks by expected I.
// 2. All disks have identical outer diameter — emphasize that SIZE doesn't determine I.
// 3. The ring and solid disk have similar mass; I difference is purely due to distribution.
// 4. Hub disk accelerates fastest — mass near axis contributes little to I.
// 5. After the race, derive the formula and verify rankings match observed order.
// 6. Axle spin-up test: flick each disk on its axle — lowest I spins fastest for same impulse.

// --------------------
// Print Notes
// --------------------
// CRITICAL: Print ALL disks with 100% infill and the same filament for consistent density.
// Variable infill patterns would shift actual COM and invalidate the experiment.
// Print flat (circular face down). No supports needed for any disk.
// 8 mm bore fits standard 8 mm wooden craft dowels available at hardware stores.
// Print stand separately at 30% infill — it just needs to hold a disk upright.
// Label each disk with a marker after printing, or use filament color to distinguish them.

// --------------------
// Customization Ideas
// --------------------
// - Change outer_diameter to 60 mm for faster printing of classroom sets.
// - Add a groove around the outer rim to hold a rubber band "tire" for traction on ramp.
// - Increase num_spokes to 12 for a bicycle wheel appearance.
// - Print the hub_disk in two filament colors (pause print at hub_extra_height).
// - Scale disk_thickness to 12 mm for more visible mass and better rolling stability.

// ============================================================
// Helper: raised label + I-indicator on disk top surface
// ============================================================
module disk_labels(main_label, inertia_indicator) {
  translate([0, 5, disk_thickness])
    linear_extrude(height = label_raise)
      text(
        main_label,
        size   = label_size,
        halign = "center",
        valign = "center",
        font   = label_font
      );
  translate([0, -6, disk_thickness])
    linear_extrude(height = label_raise)
      text(
        str("I=", inertia_indicator),
        size   = inertia_label_sz,
        halign = "center",
        valign = "center",
        font   = label_font
      );
}

// ============================================================
// Module: solid_disk
// Uniform solid disk — I = ½MR² — medium rotational inertia baseline.
// Label: "Solid", I-indicator: "M" (medium, baseline)
// ============================================================
module solid_disk() {
  difference() {
    cylinder(d = outer_diameter, h = disk_thickness);
    translate([0, 0, -0.1])
      cylinder(d = center_bore_diam, h = disk_thickness + 0.2);
  }
  disk_labels("Solid", "M");
}

// ============================================================
// Module: ring_disk
// Hollow ring — almost all mass at rim, I ≈ MR² — highest inertia.
// Label: "Ring", I-indicator: "H" (high)
// ============================================================
module ring_disk() {
  inner_diam = outer_diameter * ring_inner_frac;

  difference() {
    cylinder(d = outer_diameter, h = disk_thickness);
    // Hollow interior
    translate([0, 0, -0.1])
      cylinder(d = inner_diam, h = disk_thickness + 0.2);
    // Center bore
    translate([0, 0, -0.1])
      cylinder(d = center_bore_diam, h = disk_thickness + 0.2);
  }

  // Small hub bridge for bore (connects bore to ring body)
  for (angle = [0, 120, 240]) {
    rotate([0, 0, angle])
      translate([-1, bore_radius, 0])
        cube([2, (inner_diam / 2 - bore_radius), disk_thickness]);
  }

  disk_labels("Ring", "H");
}

// ============================================================
// Module: spoked_disk
// Outer rim + hub + 6 spokes — mass distributed radially.
// I is between solid disk and ring. Label: "Spoked", I-indicator: "H"
// ============================================================
module spoked_disk() {
  inner_diam = outer_diameter * ring_inner_frac;
  hub_diam   = center_bore_diam * 2.5;

  union() {
    // Outer rim ring
    difference() {
      cylinder(d = outer_diameter, h = disk_thickness);
      translate([0, 0, -0.1])
        cylinder(d = inner_diam, h = disk_thickness + 0.2);
    }

    // Center hub
    difference() {
      cylinder(d = hub_diam, h = disk_thickness);
      translate([0, 0, -0.1])
        cylinder(d = center_bore_diam, h = disk_thickness + 0.2);
    }

    // Spokes
    for (i = [0 : num_spokes - 1]) {
      rotate([0, 0, i * (360 / num_spokes)])
        translate([-spoke_width / 2, hub_diam / 2, 0])
          cube([spoke_width, inner_diam / 2 - hub_diam / 2, disk_thickness]);
    }
  }

  disk_labels("Spoked", "H");
}

// ============================================================
// Module: cutout_disk
// Solid disk with 6 circular cutouts in a ring pattern.
// Removes mid-outer mass, reducing I below ring but above hub.
// Label: "Cutout", I-indicator: "M"
// ============================================================
module cutout_disk() {
  cutout_center_r = outer_radius * cutout_ring_frac;

  difference() {
    cylinder(d = outer_diameter, h = disk_thickness);
    // Center bore
    translate([0, 0, -0.1])
      cylinder(d = center_bore_diam, h = disk_thickness + 0.2);
    // Circular cutouts arranged in a ring
    for (i = [0 : num_cutouts - 1]) {
      angle = i * (360 / num_cutouts);
      translate([
        cutout_center_r * cos(angle),
        cutout_center_r * sin(angle),
        -0.1
      ])
        cylinder(r = cutout_radius, h = disk_thickness + 0.2);
    }
  }

  disk_labels("Cutout", "M");
}

// ============================================================
// Module: hub_heavy_disk
// Solid disk with extra thick center hub — mass concentrated near axis.
// Lowest moment of inertia in this set → fastest on ramp.
// Label: "Hub", I-indicator: "L" (low)
// ============================================================
module hub_heavy_disk() {
  difference() {
    union() {
      // Base disk
      cylinder(d = outer_diameter, h = disk_thickness);
      // Extra thick hub on top
      cylinder(r = hub_radius, h = disk_thickness + hub_extra_height);
    }
    // Center bore through full height
    translate([0, 0, -0.1])
      cylinder(d = center_bore_diam, h = disk_thickness + hub_extra_height + 0.2);
  }

  // Label on top of hub
  translate([0, 4, disk_thickness + hub_extra_height])
    linear_extrude(height = label_raise)
      text("Hub", size = label_size, halign = "center", valign = "center", font = label_font);
  translate([0, -5, disk_thickness + hub_extra_height])
    linear_extrude(height = label_raise)
      text("I=L", size = inertia_label_sz, halign = "center", valign = "center", font = label_font);
}

// ============================================================
// Module: comparison_stand
// U-shaped bracket to hold one disk upright on an axle for display
// or spin-up comparison. The axle rests in open slots at top.
// ============================================================
module comparison_stand() {
  arm_h = stand_height;
  arm_t = stand_thickness;

  // Left arm
  translate([-stand_width / 2, 0, 0])
    cube([arm_t, arm_h, stand_depth]);

  // Right arm
  translate([stand_width / 2 - arm_t, 0, 0])
    cube([arm_t, arm_h, stand_depth]);

  // Base connecting the two arms
  translate([-stand_width / 2, 0, 0])
    cube([stand_width, arm_t, stand_depth]);

  // Axle slots at the top of each arm (open U-slots)
  slot_z = stand_depth / 2 - axle_slot_width / 2;
  translate([-stand_width / 2, arm_h - axle_slot_width, slot_z])
    cube([arm_t, axle_slot_width + 0.1, axle_slot_width]);
  translate([stand_width / 2 - arm_t, arm_h - axle_slot_width, slot_z])
    cube([arm_t, axle_slot_width + 0.1, axle_slot_width]);
}

// ============================================================
// Module: print_set
// Arranges all 5 disks on the build plate for a single print.
// ============================================================
module print_set() {
  gap = 10; // mm gap between disks
  spacing = outer_diameter + gap;

  // Row 1: Solid, Ring, Spoked
  solid_disk();
  translate([spacing, 0, 0])
    ring_disk();
  translate([spacing * 2, 0, 0])
    spoked_disk();

  // Row 2: Cutout, Hub-heavy
  translate([spacing * 0.5, -(outer_diameter + gap), 0])
    cutout_disk();
  translate([spacing * 1.5, -(outer_diameter + gap), 0])
    hub_heavy_disk();
}

// ============================================================
// Demo Modules
// ============================================================

// demo_default: all 5 disks laid out for printing
module demo_default() {
  print_set();
}

// demo_single: render just one variant by name
// variant: "solid", "ring", "spoked", "cutout", "hub"
module demo_single(variant = "solid") {
  if      (variant == "solid")   solid_disk();
  else if (variant == "ring")    ring_disk();
  else if (variant == "spoked")  spoked_disk();
  else if (variant == "cutout")  cutout_disk();
  else if (variant == "hub")     hub_heavy_disk();
  else                           solid_disk(); // default fallback
}

// ============================================================
// Default render — uncomment one demo to view it
// ============================================================
demo_default();
// demo_single("ring");
// demo_single("hub");
// comparison_stand();
