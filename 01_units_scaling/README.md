# 01 — Units & Scaling

## What This Folder Contains

This folder provides printable measurement reference tiles and scale comparison
sets to build physical intuition for the units used throughout AP Physics 1,
F=ma, and FTC robotics. Models give students something tangible to handle and
compare when working through dimensional analysis problems.

| File | Status | Description |
|------|--------|-------------|
| `scale_reference_tile.scad` | ✅ Ready | Flat tile with raised mm and cm rulers plus a tactile 1 cm² reference square |
| `order_of_magnitude_set.scad` | 🔲 TODO | A set of comparison blocks scaled to orders of magnitude (1 mm, 1 cm, 1 dm, 1 m equivalent) |
| `unit_conversion_board.scad` | 🔲 TODO | Board showing common unit conversion chains with raised arrows and labels |

## What It Teaches

- **SI units** — metre, kilogram, second and their standard prefixes (mm, cm, km)
- **Scale and proportion** — what does 1 cm *feel* like versus 1 mm?
- **Fermi estimation** — using reference tiles to sanity-check answers
- **Dimensional thinking** — every number in physics carries a unit; the shape of a formula must be dimensionally consistent
- **Measurement uncertainty** — ruler tick resolution versus reported precision

## Why It Matters

### AP Physics 1
Unit analysis is the first and last check on every free-response answer. Students
who internalize scale avoid common factor-of-10 errors on kinematics and force
problems. The College Board explicitly rewards dimensional analysis work shown
in solutions.

### F=ma / Science Olympiad
Rapid unit conversion under competition conditions is a core skill. Having
handled physical reference objects that represent exact lengths helps competitors
develop reliable mental benchmarks.

### FTC Robotics
Robot designers work in both metric (OpenSCAD, most sensors) and imperial
(legacy field hardware) units. A tactile centimetre reference tile on the
workbench reduces costly measurement mistakes when cutting or printing parts.

## How To Use This Folder

1. Print `scale_reference_tile.scad` (no supports needed, flat on bed).
2. Keep the tile on your desk while solving problems as a quick sanity-check ruler.
3. When `order_of_magnitude_set.scad` is complete, arrange the blocks in a line
   and ask: *which block represents the length of a finger? a classroom? an atom?*

## Partially Scaffolded

This folder is **partially scaffolded**. `scale_reference_tile.scad` is fully
implemented. The two remaining models (`order_of_magnitude_set.scad` and
`unit_conversion_board.scad`) are planned but not yet implemented — contributions
are welcome! See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidance.

## Planned Models — Details

### `scale_reference_tile.scad` ✅
A flat 100 mm × 60 mm reference tile with:
- Raised millimetre ruler along the bottom edge (tick marks at 1 mm, 5 mm, 10 mm intervals)
- Raised centimetre ruler along the top edge
- A raised 1 cm × 1 cm tactile reference square in one corner
- "1 cm" raised label for identification

Print flat, no supports. Slides into a binder or notebook for field use.

### `order_of_magnitude_set.scad` 🔲
A set of solid cubes or cylinders with edge lengths spanning many orders of
magnitude, labeled with their size and a real-world comparison (e.g., "≈ width
of a human hair"). Intended to be printed as a matching or sorting activity.

### `unit_conversion_board.scad` 🔲
A flat board with chains of raised arrows connecting related units:
`mm → cm → m → km` and `g → kg`. Students trace the arrows and fill in the
multiplication/division factors as a dimensional analysis exercise.

## Related Folders

- **[02_vectors_components](../02_vectors_components/README.md)** — vectors require
  careful attention to units on each component axis; the reference tile is useful
  here too.
- **[03_kinematics_graphs](../03_kinematics_graphs/README.md)** — graph tile axes
  carry units (m, m/s, m/s²); unit awareness prevents mis-reading slope values.
