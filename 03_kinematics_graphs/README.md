# 03 — Kinematics Graphs

## What This Folder Contains

This folder provides a modular tile system for building **position-time (x-t),
velocity-time (v-t), and acceleration-time (a-t)** graph stories. Each tile
represents one segment of motion; tiles snap together to tell a complete kinematic
narrative that students can physically rearrange and discuss.

| File | Description |
|------|-------------|
| `kinematics_graph_tiles.scad` | Six tile types covering all common motion segments, with snap-together alignment pegs |

## What It Teaches

- Reading and interpreting x-t, v-t, and a-t graphs
- Relating the *slope* of one graph to the *value* on the next (slope of x-t = v; slope of v-t = a)
- Identifying motion phases: constant velocity, acceleration, deceleration, rest
- Understanding that the same tile shape has different physical meaning depending
  on which graph type (x-t vs v-t vs a-t) it represents
- Graph continuity: why adjacent tiles must connect smoothly (no teleportation!)
- Area under a v-t curve equals displacement; area under a-t curve equals Δv

## Why It Matters

### AP Physics 1
Kinematics graphs appear on every AP Physics 1 exam. Students must:
- Identify motion type from graph shape
- Calculate slope (= rate of change) and area (= accumulated quantity)
- Match a graph to a verbal description of motion
- Sketch a graph from a scenario description

The tile system makes the *connection between graph segments* tactile. When a
student picks up a "positive slope" v-t tile and places it next to a "constant"
v-t tile, they immediately ask: "what does the x-t graph look like for each?"

### F=ma
Kinematics problems on F=ma competitions frequently involve piecewise motion
(object accelerates, then cruises, then brakes). Building the graph tile story
first clarifies the problem structure before any equations are written.

### FTC Robotics
Robot motion profiles — trapezoidal velocity curves, S-curve profiles — are
exactly the sequences described by these tiles: accelerate → cruise → decelerate.
Connecting this abstraction to the physical tiles helps students design and
debug autonomous programs.

## How To Print

- Use `demo_print_all()` to export all 6 tiles on one plate
- **Orientation:** flat on bed
- **Layer height:** 0.2 mm (0.15 mm for crisper curve profiles)
- **Infill:** 20 %
- **Material:** PLA, any colour; consider using one colour for x-t tiles and a
  second colour for v-t tiles to emphasise the graph-type distinction
- Peg tolerance: if snaps are loose, reduce `snap_peg_diameter` by 0.1 mm;
  if too tight, increase `snap_hole_diameter` by 0.1 mm
- Estimated time: ~15 min per tile at 60 mm/s

## How To Use

1. Print one or two complete sets (6 tiles each).
2. Give students a verbal motion description (e.g., "object moves at constant
   speed, then speeds up, then stops").
3. Students select and snap together the correct tiles to build the graph.
4. Discuss: *what does the corresponding a-t graph look like?* Then build it.
5. Rearrange tiles to explore: "what if the object slowed down first?"

## Things To Notice

- The snap peg is on the **left** edge; the snap hole is on the **right** edge —
  tiles always connect left-to-right (increasing time)
- The curve on each tile must end at the same height the next tile begins —
  this enforces graph *continuity* (physical quantities don't jump)
- A horizontal tile (constant) on a v-t graph corresponds to a sloped tile
  (positive slope) on the x-t graph — the connection is the derivative relationship
- A concave-up v-t tile means constant *positive* acceleration: on the a-t graph,
  that segment would be a horizontal tile at a positive value

## Try Changing These Parameters

| Parameter | What changes |
|-----------|-------------|
| `tile_width` | Wider tiles give more room for curve detail |
| `tile_height` | Taller tiles let you show larger amplitude changes |
| `snap_peg_diameter` / `snap_hole_diameter` | Adjust for your printer's tolerance |
| `line_thickness` | Thicker for bold demo models; thinner for precise graphs |
| `show_labels` | Toggle tile type labels on or off |

## Related Models

- **[02_vectors_components](../02_vectors_components/README.md)** — velocity and
  acceleration are vectors; the v-t graph shows the x-component of velocity
- **[04_projectile_motion](../04_projectile_motion/README.md)** — a projectile has
  a constant-slope v-t tile (linear deceleration) in the vertical direction and a
  constant v-t tile (horizontal) — combine the two stories!
- **[08_energy_work_power](../08_energy_work_power/README.md)** — the area under a
  force-displacement graph equals work, the same "area = quantity" reasoning
