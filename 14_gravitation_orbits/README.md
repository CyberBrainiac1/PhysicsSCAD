# Gravitation & Orbits

## What This Is
A flat 3D-printable template board showing an elliptical orbit with foci, periapsis/apoapsis markers, velocity arrows, and equal-area sectors to illustrate all three of Kepler's laws.

## What It Teaches
- Kepler's First Law: orbits are ellipses with the central body at one focus
- Kepler's Second Law: equal areas swept in equal times (raised sector outlines)
- Kepler's Third Law: T² ∝ a³ (period relates to semi-major axis)
- Why orbital speed is greatest at periapsis and least at apoapsis
- The geometry of ellipses: semi-major axis, semi-minor axis, foci, eccentricity

## Why This Matters
Gravity drives every orbit from satellites to planets. Understanding orbital geometry is essential for space mission design, understanding seasons, and grasping why GPS satellites need relativistic corrections.

## How To Print
- Print flat on bed; no supports needed
- 0.2 mm layer height for crisp raised lines
- PLA at 10–15% infill; the board is mostly decorative/reference
- Use a contrasting filament color change at layer 2 to highlight the orbit path

## How To Use
1. Print the board
2. Identify the two foci — the central body (star/planet) sits at one focus
3. Trace the orbit with your finger, speeding up near periapsis
4. Compare the two shaded sectors — same area, different arc lengths → different speeds
5. Measure r_min and r_max with a ruler to find eccentricity e = (r_max − r_min)/(r_max + r_min)

## Things To Notice
- The central body is NOT at the center of the ellipse — it is at one focus
- The velocity arrow at periapsis is much longer than at apoapsis
- The two equal-area sectors have very different shapes

## Try Changing These Parameters
- `ellipse_b` — reduce toward zero for a very elongated (high eccentricity) orbit
- `show_area_sectors` — toggle to quiz students on Kepler's second law
- `demo_circular_orbit()` — set a=b to see the special circular case

## Related Models
- `14_gravitation_orbits/` — this folder
- `07_circular_motion/` — circular orbit as special case
- `10_torque_statics/` — angular momentum conservation
