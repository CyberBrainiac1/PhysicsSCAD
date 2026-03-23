# 04 — Projectile Motion

## What This Folder Contains

This folder provides a printable board showing **parabolic trajectories** at
three classic launch angles (30°, 45°, 60°). The board is both a visual
reference and a hands-on geometry tool that makes the symmetry of projectile
motion immediately apparent.

| File | Description |
|------|-------------|
| `projectile_template.scad` | Board with three raised parabolic arcs, angle guides, and axis labels |

## What It Teaches

- Projectile motion is the superposition of **constant horizontal velocity** and
  **uniformly accelerated vertical motion** (free fall)
- The trajectory is a **parabola**: x = v₀cosθ · t,  y = v₀sinθ · t − ½g t²
- **Complementary angles** (30° and 60°) produce the **same horizontal range**
- **45°** maximises range (for a given launch speed and flat ground)
- The peak height is determined by the vertical component of initial velocity
- The time of flight depends only on the vertical motion

## Why It Matters

### AP Physics 1
Projectile motion is one of the most heavily tested kinematics topics. Students
must be able to:
- Decompose initial velocity into components
- Treat horizontal and vertical motion as independent
- Find range, peak height, and time of flight
- Explain why 30° and 60° give equal ranges (a common conceptual question)

The physical board makes the 30°/60° symmetry *undeniable* — students can hold
it and trace the arcs with their fingers.

### F=ma
F=ma problems sometimes combine projectile motion with other mechanics (e.g.,
a projectile landing on a ramp, or launched from a moving platform). The board
grounds the geometric reasoning before algebra begins.

### FTC Robotics
Ring-toss and ball-launching games require teams to understand launch angle and
speed trade-offs. The 45° peak-range result and the angle-range symmetry directly
inform mechanism design decisions.

## How To Print

- **Orientation:** flat on bed, no supports needed
- **Layer height:** 0.2 mm (0.15 mm for crisper arc profiles)
- **Infill:** 15–20 % (decorative board, not structural)
- **Material:** white or light grey PLA so raised arcs contrast well
- **Estimated time:** ~50–70 min at 60 mm/s
- The board is 150 mm × 100 mm — ensure bed temperature is uniform to
  prevent warping on a large flat part; use a brim if needed

## How To Use

1. Place the board in front of students before introducing equations.
2. Ask: *"Which arc goes the farthest? Which one is highest?"*
3. Trace the 30° and 60° arcs — notice they land at the same point.
4. Introduce the equations and verify the symmetry algebraically:
   - Range R = v₀² sin(2θ) / g
   - sin(2×30°) = sin(60°) = sin(120°) = sin(2×60°) ✓
5. Use `demo_single_angle(45)` to print only the 45° arc for a focused discussion.

## Things To Notice

- All three arcs start from the **same launch point** (origin) and assume the
  same launch speed — only the angle changes
- The **45° arc** is the tallest *and* widest of the three
- The 30° and 60° **symmetry markers** (raised lines between their landing spots)
  show equal range explicitly
- The angle guide lines from the origin show the initial velocity direction

## Try Changing These Parameters

| Parameter | What changes |
|-----------|-------------|
| `launch_angle_1/2/3` | Show different angle combinations |
| `max_range_mm` | Scale all arcs to fit different board sizes |
| `show_parabola` | Toggle arcs on/off for a blank template |
| `show_angle_guides` | Toggle the launch-direction lines |
| `board_width` / `board_height` | Resize the board for desk or wall display |

## Related Models

- **[02_vectors_components](../02_vectors_components/README.md)** — velocity
  decomposition into components is the essential first step of projectile analysis
- **[03_kinematics_graphs](../03_kinematics_graphs/README.md)** — the horizontal
  direction of a projectile matches a "constant" v-t tile; the vertical direction
  matches a "negative slope" v-t tile
- **[08_energy_work_power](../08_energy_work_power/README.md)** — at the peak of
  a trajectory, all kinetic energy is in the horizontal component (vertical KE = 0)
