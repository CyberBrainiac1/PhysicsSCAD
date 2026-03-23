/*
 * Title: Rolling Wheel Set
 * Folder: 13_rolling_motion
 * Physics Topic: Rolling Without Slipping, Cycloid Motion, Rolling Kinematics
 * Difficulty: Intermediate
 * Print Type: flat/freestanding
 * Teaches: v_contact=0, v_top=2v, cycloid rim path, rolling kinematics v=ωR
 * Use Case: Place wheel on surface, roll one revolution, observe contact point and velocity arrows
 */

// --------------------
// Parameters
// --------------------
wheel_diameter          = 60;   // mm — main wheel outer diameter
wheel_thickness         = 12;   // mm — wheel depth (axle direction)
hub_diameter            = 12;   // mm — central hub diameter
spoke_count             = 6;    // number of spokes
show_contact_mark       = true; // raised notch at rim showing instantaneous contact point
show_velocity_arrows    = true; // arrows: v=0 at bottom, v=2v at top
rolling_surface_width   = 180;  // mm — length of the flat rolling surface board
rolling_surface_thickness = 4;  // mm — thickness of rolling surface board

// --------------------
// Physics Meaning
// --------------------
// Rolling without slipping means the contact point velocity is zero.
// v_contact = v_cm - ω·R = 0  →  v_cm = ω·R
// The top of the wheel moves at v_top = v_cm + ω·R = 2·v_cm
// A point on the rim traces a CYCLOID as the wheel rolls.
// One full revolution moves the center by exactly 2π·R = π·d.

// --------------------
// Learning Notes
// --------------------
// - Spokes make rotation visually obvious when rolling
// - The rim notch (contact mark) shows the cycloid tracing point
// - Solid disk, spoked wheel, and ring have same mass but different moments of inertia
// - I_solid = (1/2)mR²,  I_ring = mR²,  I_spoked ≈ between these two

// --------------------
// Print Notes
// --------------------
// - Print wheel flat (face down); spokes bridge cleanly at 0.2 mm layers
// - Rolling surface prints flat; no supports needed
// - Use 20% infill for the wheel body
// - Increase $fn for smoother wheels if needed

// --------------------
// Customization Ideas
// --------------------
// - Change spoke_count to 3 for dramatic look or 12 for fine detail
// - Adjust wheel_diameter and update rolling_surface_width to match new πd
// - Add a second notch 180° from the first to show two cycloid points simultaneously

$fn = 32;

wheel_radius   = wheel_diameter / 2;
spoke_width    = 2.5;   // mm
spoke_height   = wheel_thickness;
rim_thickness  = 4;     // mm
arrow_height   = 2;     // mm raised above wheel face
arrow_width    = 3;     // mm
arrow_length   = 12;    // mm base arrow length

// --------------------
// Wheel rim helper
// --------------------
module wheel_rim() {
  difference() {
    cylinder(h=wheel_thickness, d=wheel_diameter, center=true);
    cylinder(h=wheel_thickness + 1, d=wheel_diameter - 2*rim_thickness, center=true);
  }
}

// --------------------
// Hub
// --------------------
module wheel_hub() {
  cylinder(h=wheel_thickness, d=hub_diameter, center=true);
}

// --------------------
// Single spoke
// --------------------
module spoke() {
  spoke_len = wheel_radius - hub_diameter/2 - rim_thickness;
  translate([hub_diameter/2, -spoke_width/2, -wheel_thickness/2])
    cube([spoke_len, spoke_width, wheel_thickness]);
}

// --------------------
// Contact point mark (notch on rim)
// --------------------
module contact_mark() {
  // Raised rectangular tab on rim at bottom (θ = -90°, i.e. contact point position)
  translate([0, -wheel_radius + rim_thickness/2, wheel_thickness/2])
    cylinder(h=3, d=5, $fn=16);
}

// --------------------
// Velocity arrow (simple raised wedge)
// --------------------
module velocity_arrow(length, label_side=1) {
  // Shaft
  translate([-arrow_width/2, 0, 0])
    cube([arrow_width, length, arrow_height]);
  // Head
  translate([0, length, 0])
    linear_extrude(height=arrow_height)
      polygon([[0, 0], [-arrow_width, 0], [0, arrow_width*1.5], [arrow_width, 0]]);
}

// --------------------
// rolling_wheel() — main spoked wheel
// --------------------
module rolling_wheel() {
  difference() {
    union() {
      wheel_rim();
      wheel_hub();
      for (i = [0 : spoke_count - 1]) {
        rotate([0, 0, i * 360 / spoke_count])
          spoke();
      }
      if (show_contact_mark) {
        contact_mark();
      }
      if (show_velocity_arrows) {
        // v=0 arrow at contact point (bottom) — tiny stub
        translate([0, -wheel_radius - 2, wheel_thickness/2])
          rotate([0, 0, 90])
            velocity_arrow(3);
        // v=2v arrow at top — full length arrow pointing forward
        translate([0, wheel_radius + 2, wheel_thickness/2])
          rotate([0, 0, 90])
            velocity_arrow(arrow_length);
        // v=v arrow at center — medium arrow
        translate([wheel_radius + 2, 0, wheel_thickness/2])
          rotate([0, 0, 90])
            velocity_arrow(arrow_length / 2);
      }
    }
    // Axle hole through center
    cylinder(h=wheel_thickness + 2, d=6, center=true);
  }
}

// --------------------
// solid_rolling_disk() — no spokes, for moment of inertia comparison
// --------------------
module solid_rolling_disk() {
  difference() {
    cylinder(h=wheel_thickness, d=wheel_diameter, center=true);
    cylinder(h=wheel_thickness + 2, d=6, center=true);
  }
}

// --------------------
// ring_wheel() — rim only, no spokes
// --------------------
module ring_wheel() {
  difference() {
    cylinder(h=wheel_thickness, d=wheel_diameter, center=true);
    cylinder(h=wheel_thickness + 2, d=wheel_diameter - 2*rim_thickness, center=true);
    cylinder(h=wheel_thickness + 2, d=6, center=true);
  }
}

// --------------------
// rolling_surface() — flat board with tick marks
// --------------------
module rolling_surface() {
  circumference = PI * wheel_diameter;
  tick_spacing  = circumference;   // one full revolution
  tick_height   = 1.5;
  tick_width    = 1;
  tick_depth    = rolling_surface_thickness + tick_height;

  difference() {
    // Base board
    cube([rolling_surface_width, wheel_thickness + 20, rolling_surface_thickness]);
    // Center groove line
    translate([0, (wheel_thickness + 20)/2 - 0.5, rolling_surface_thickness - 0.8])
      cube([rolling_surface_width, 1, 1]);
  }
  // Origin tick
  translate([10, 0, rolling_surface_thickness])
    cube([tick_width, wheel_thickness + 20, tick_height]);
  // One-revolution tick at πd from origin
  translate([10 + circumference, 0, rolling_surface_thickness])
    cube([tick_width, wheel_thickness + 20, tick_height]);
}

// --------------------
// wheel_and_surface() — combined display
// --------------------
module wheel_and_surface() {
  rolling_surface();
  translate([10 + wheel_radius, (wheel_thickness + 20)/2, rolling_surface_thickness + wheel_radius])
    rolling_wheel();
}

// --------------------
// demo_default()
// --------------------
module demo_default() {
  wheel_and_surface();
}

// --------------------
// demo_comparison() — solid, spoked, ring side by side
// --------------------
module demo_comparison() {
  spacing = wheel_diameter + 20;

  translate([0, 0, 0])       solid_rolling_disk();
  translate([spacing, 0, 0]) rolling_wheel();
  translate([spacing*2, 0, 0]) ring_wheel();
}

// Run default demo
demo_default();
