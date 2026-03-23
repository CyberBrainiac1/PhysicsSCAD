/*
 * Title: SHM Displacement-Phase Disk
 * Folder: 16_oscillations_shm
 * Physics Topic: Simple Harmonic Motion, Phase, Displacement and Velocity
 * Difficulty: Intermediate
 * Print Type: token
 * Teaches: x(t)=A·cos(ωt), phase relationship between position and velocity, SHM cycle
 * Use Case: Rotate disk to any phase angle; read off displacement from raised curve height
 */

// --------------------
// Parameters
// --------------------
disk_diameter       = 100;   // mm
disk_thickness      = 4;     // mm
show_position_curve = true;  // raised sinusoidal displacement curve
show_velocity_curve = true;  // secondary curve offset 90° (velocity ∝ -sin)
show_phase_marks    = true;  // tick marks every 45°
show_labels         = true;  // key-phase label dots
curve_height        = 1.5;   // mm raised curve above disk surface
inner_ring_diameter = 20;    // mm hub / inner region diameter

// --------------------
// Physics Meaning
// --------------------
// Displacement: x(θ) = A · cos(θ)  where θ is phase angle (0–360°)
// Velocity:     v(θ) = −A·ω · sin(θ) → leads displacement by 90°
// Key phases:
//   θ=0°:   x=+A (max displacement), v=0
//   θ=90°:  x=0,  v=max (fastest, moving negative)
//   θ=180°: x=−A (min displacement), v=0
//   θ=270°: x=0,  v=max (fastest, moving positive)
// The raised curve height encodes displacement at each phase angle.

// --------------------
// Learning Notes
// --------------------
// - Velocity is 90° ahead of displacement in phase
// - When displacement is maximum, velocity is zero (momentarily stopped)
// - When displacement is zero (equilibrium), velocity is maximum
// - Two disks offset by 90° represent position vs. velocity simultaneously

// --------------------
// Print Notes
// --------------------
// - Print flat (disk face down); no supports needed
// - 0.15 mm layer height for smoother sine curve
// - Consider filament color change at 1 mm to highlight curve above disk

// --------------------
// Customization Ideas
// --------------------
// - Increase disk_diameter to 150 mm for a large display version
// - Add a pointer notch at 0° to use as a physical dial indicator
// - Print with a hole in the center to mount on a pencil as a spinning demo

$fn = 64;

disk_radius   = disk_diameter / 2;
inner_radius  = inner_ring_diameter / 2;
curve_pts     = 120;     // number of curve profile points
curve_amp     = (disk_radius - inner_radius - 4) / 2;  // amplitude of raised curve
curve_mid_r   = inner_radius + curve_amp + 2;           // radial center of curve
tick_len_maj  = 5;   // mm major tick (every 90°)
tick_len_min  = 3;   // mm minor tick (every 45°)
tick_w        = 1;   // mm tick width
feature_h     = 1.2; // mm raised feature height

// --------------------
// Disk base
// --------------------
module disk_base() {
  cylinder(h=disk_thickness, d=disk_diameter);
}

// --------------------
// Phase tick marks around rim
// --------------------
module phase_ticks() {
  for (i = [0 : 7]) {
    ang      = i * 45;
    is_major = (i % 2 == 0);
    t_len    = is_major ? tick_len_maj : tick_len_min;
    rotate([0, 0, ang])
      translate([disk_radius - t_len, -tick_w/2, disk_thickness])
        cube([t_len, tick_w, feature_h]);
  }
}

// --------------------
// Direction arrow (phase progression indicator)
// --------------------
module direction_arrow() {
  // Small arc arrow at the rim indicating counterclockwise progression
  translate([0, disk_radius - 8, disk_thickness])
    rotate([0, 0, 0])
      linear_extrude(height=feature_h)
        polygon([[0,0],[-2,4],[0,3],[2,4]]);
}

// --------------------
// Raised sinusoidal position curve (traced around disk in polar coords)
// --------------------
module position_curve() {
  // Each point: r = curve_mid_r + curve_amp * cos(theta)
  // This creates a wave that rises and falls as you go around the disk
  outer_pts = [for (i = [0 : curve_pts])
    let(ang = i * 360 / curve_pts,
        r   = curve_mid_r + curve_amp * cos(ang))
    [r * cos(ang), r * sin(ang)]
  ];
  inner_pts = [for (i = [curve_pts : -1 : 0])
    let(ang = i * 360 / curve_pts,
        r   = curve_mid_r + curve_amp * cos(ang) - 2)
    [r * cos(ang), r * sin(ang)]
  ];
  all_pts = concat(outer_pts, inner_pts);

  translate([0, 0, disk_thickness])
    linear_extrude(height=curve_height)
      polygon(all_pts);
}

// --------------------
// Raised velocity curve (90° phase offset from position)
// --------------------
module velocity_curve() {
  outer_pts = [for (i = [0 : curve_pts])
    let(ang = i * 360 / curve_pts,
        r   = curve_mid_r + curve_amp * cos(ang - 90) - 3)
    [r * cos(ang), r * sin(ang)]
  ];
  inner_pts = [for (i = [curve_pts : -1 : 0])
    let(ang = i * 360 / curve_pts,
        r   = curve_mid_r + curve_amp * cos(ang - 90) - 5)
    [r * cos(ang), r * sin(ang)]
  ];
  all_pts = concat(outer_pts, inner_pts);

  translate([0, 0, disk_thickness])
    linear_extrude(height=curve_height * 0.6)
      polygon(all_pts);
}

// --------------------
// Phase label dots at 0°, 90°, 180°, 270°
// --------------------
module phase_label_dots() {
  label_r = inner_radius + 3;
  for (i = [0 : 3]) {
    ang = i * 90;
    translate([label_r * cos(ang), label_r * sin(ang), disk_thickness])
      cylinder(h=feature_h * 1.5, d=3, $fn=16);
  }
}

// --------------------
// Hub ring
// --------------------
module hub_ring() {
  difference() {
    cylinder(h=disk_thickness + feature_h, d=inner_ring_diameter + 4);
    cylinder(h=disk_thickness + feature_h + 1, d=inner_ring_diameter);
  }
}

// --------------------
// shm_phase_disk() — main model
// --------------------
module shm_phase_disk(phase_offset=0) {
  rotate([0, 0, phase_offset]) {
    union() {
      disk_base();
      phase_ticks();
      direction_arrow();
      if (show_position_curve) position_curve();
      if (show_velocity_curve) velocity_curve();
      if (show_phase_marks)    phase_label_dots();
      hub_ring();
    }
  }
}

// --------------------
// demo_default()
// --------------------
module demo_default() {
  shm_phase_disk(0);
}

// --------------------
// demo_two_phase_comparison() — two disks offset 90° (position vs velocity)
// --------------------
module demo_two_phase_comparison() {
  shm_phase_disk(0);
  translate([disk_diameter + 15, 0, 0])
    shm_phase_disk(90);
}

// Run default demo
demo_default();
