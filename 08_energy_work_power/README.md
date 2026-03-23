# Energy, Work & Power

## What This Is

This folder contains 3D-printable tools for visualizing **energy conservation** — one of the most powerful and universal principles in physics. The main model is a physical "energy landscape" board showing hills and valleys, where a ball's kinetic and potential energy trade off as it rolls along the profile.

Models in this folder:
- **`energy_landscape_board.scad`** — a cross-section board showing a roller-coaster-like height profile with labeled positions and height markers

## What It Teaches

- **Conservation of mechanical energy**: total energy (KE + PE) remains constant in the absence of friction
- **Potential energy** depends on height: **PE = mgh**
- **Kinetic energy** depends on speed: **KE = ½mv²**
- At a peak (high point), PE is maximum and KE is minimum (slow)
- At a valley (low point), PE is minimum and KE is maximum (fast)
- **Work-energy theorem**: the net work done on an object equals its change in kinetic energy
- How friction and air resistance dissipate mechanical energy as thermal energy
- Why a ball cannot roll back up to a height it started from if friction is present

## Why This Matters

Energy conservation is one of the most fundamental laws in all of science — it applies to mechanics, thermodynamics, electromagnetism, chemistry, and beyond. The landscape metaphor is used in physics (potential energy surfaces), chemistry (reaction energy diagrams), and even machine learning (loss landscapes). Understanding how energy converts between forms is essential for engineering, renewable energy design, and understanding natural phenomena.

## How To Print

| Setting | Recommendation |
|---|---|
| Material | PLA |
| Layer Height | 0.2 mm |
| Infill | 15% |
| Supports | Not required |
| Bed Adhesion | Brim recommended |
| Print Orientation | Flat on bed (board face up) |
| Estimated Time | ~2–3 hours |

- Print with the landscape profile facing up so the hills and valleys are clearly visible
- The raised height markers and labels print without supports when oriented correctly
- Consider using a marble or small ball bearing to demonstrate rolling along the landscape

## How To Use

1. Print the board and place it on a flat surface
2. Identify the labeled positions: **A** (start), **B** (first peak), **C** (valley), **D** (second peak), **E** (end)
3. Hold the board at a slight tilt and place a marble at position A
4. Observe: the marble speeds up in valleys, slows at peaks
5. Ask: *"Will the marble make it over the second peak (D)?"* — it depends on starting height vs. D's height
6. Tilt the board more steeply to give the marble more starting energy

**Quantitative activities:**
- Measure heights at each labeled point; calculate PE at each (use a known mass marble)
- Predict where the marble will be fastest using conservation of energy
- Add a rough surface patch (sandpaper) between C and D and observe energy loss
- Calculate the work done by friction from the difference in PE at start and final rest point

## Things To Notice

- Position **B** is the highest point — the marble moves slowest here
- Position **C** is the valley — the marble moves fastest here
- Position **D** is lower than B — a marble released from A **can** make it over D
- The **total height determines total energy** — heavier and lighter objects fall at the same rate
- The profile shape is like an energy diagram used in chemistry for activation energy

## Try Changing These Parameters

```openscad
profile_height_scale = 1.0;    // Scale all hills taller or shorter (try 1.5 or 0.7)
board_width = 160;             // Make board wider for a longer landscape
board_height = 80;             // Make board taller for steeper hills
show_height_markers = true;    // Toggle vertical height reference lines
show_position_markers = true;  // Toggle A/B/C/D/E position labels
line_thickness = 1.5;          // Thickness of raised profile line
```

## Related Models

- `09_momentum_impulse/collision_track.scad` — energy changes in collisions
- `16_oscillations_shm/spring_mass_system.scad` — energy oscillating between KE and PE
- `14_gravitation_orbits/orbit_simulator.scad` — gravitational PE and orbital energy
- `08_energy_work_power/power_lever_arm.scad` *(TODO)* — work done by a force over a distance
