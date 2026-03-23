# Fluids & Pressure

## What This Is
Two complementary 3D-printable models: a **Pressure-Depth Board** that visualises P = ρgh with arrows that grow with depth, and a **Buoyancy Block Set** of four same-size blocks with different internal structures to demonstrate Archimedes' principle.

## What It Teaches
- Pressure increases linearly with depth: P = ρgh
- Pressure acts equally in all directions at a given depth (Pascal's principle)
- Buoyancy force equals the weight of fluid displaced: F_b = ρ_fluid · V_displaced · g
- Why hollow or low-density objects float while dense solid objects sink
- How to measure buoyancy by weighing an object in and out of water

## Why This Matters
Fluid pressure and buoyancy govern ship design, submarine operation, hydraulic systems, blood pressure, and weather patterns. Understanding these principles is foundational to engineering and life sciences.

## How To Print

### Pressure Depth Board
- Print flat; no supports needed
- 0.2 mm layer height; 15% infill
- Consider printing arrows in a contrasting color with a filament swap

### Buoyancy Blocks
- Print all four blocks at the same orientation (label side facing up or forward)
- `dense_block`: solid — increase infill to 80%+ to make it genuinely heavy
- `hollow_block`: print at 0% infill with 2 perimeters (the hollow is built in)
- `foam_block`: print normally; the cylindrical cutouts are part of the design
- `waterline_block`: print solid at 50% infill

## How To Use
1. **Pressure board**: hold vertically, point to each depth level, ask students to predict arrow length before looking
2. **Buoyancy blocks**: hang each block from a string over a scale, lower into water, measure force reduction — this is the buoyancy force

## Things To Notice
- Pressure arrows at the deepest level are the longest
- The hollow block displaces the same volume of water as the solid block, but weighs less
- The waterline mark shows where the block would float at equilibrium

## Try Changing These Parameters
- `arrow_scale_factor` — make pressure increase more dramatic
- `depth_levels` — add more depth increments
- `block_size` — scale up for easier classroom demo

## Related Models
- `08_energy_work_power/` — work done against pressure
- `05_forces_free_body/` — buoyancy as an upward force in FBDs
- `15_fluids_pressure/pressure_depth_board.scad` and `buoyancy_blocks.scad`
