# Friction & Contact Forces

## What This Is

This folder contains 3D-printable tools for exploring **friction** — the contact force that opposes relative sliding between surfaces. The ramp kit lets students measure, predict, and compare how different angles and surface combinations affect whether an object slides, and how fast.

Models in this folder:
- **`friction_ramp_kit.scad`** — a configurable incline/ramp with a sliding block
- **`surface_texture_blocks.scad`** *(TODO)* — a set of blocks with different surface textures (smooth, ridged, bumped) for comparing coefficients of friction

## What It Teaches

- The difference between **static friction** (preventing motion) and **kinetic friction** (opposing motion)
- The coefficient of friction (μ) and how it depends on the surfaces in contact — not the weight
- How to decompose weight into components parallel and perpendicular to the ramp surface
- The critical angle at which an object begins to slide: **θ_critical = arctan(μ_s)**
- Why heavier objects don't slide faster on a frictionless incline (ignoring air resistance)
- How friction force is calculated: **f = μ × N**, where N is the normal force
- Newton's Second Law applied along an incline: **ma = mg sin(θ) − μmg cos(θ)**

## Why This Matters

Friction is responsible for our ability to walk, drive, and hold tools. Engineers must account for friction in every mechanical system — too little causes slipping, too much causes wear and energy loss. Understanding the ramp geometry and friction relationship is a gateway to understanding contact mechanics, tribology, and structural stability.

## How To Print

| Setting | Recommendation |
|---|---|
| Material | PLA (smooth surface) or PETG |
| Layer Height | 0.2 mm for ramp, 0.15 mm for block |
| Infill | 30% for ramp (needs to support weight) |
| Supports | Not required |
| Bed Adhesion | Brim for ramp |
| Print Orientation | Ramp flat on bed; block flat-face down |
| Estimated Time | Ramp ~1.5 hrs, Block ~30 min |

- For friction comparison experiments, print two blocks: one with `block_base_flat = true` (smooth) and one with bumps enabled
- Print the `ramp_family()` set to compare three angles side by side
- Sanding the ramp surface gives a more consistent μ for repeatable lab results

## How To Use

1. Print a ramp and one or more sliding blocks
2. Place the ramp on a flat surface
3. Place the block on the ramp surface at the top
4. Slowly increase the angle (by printing different angle ramps or tilting) until the block slides
5. Record the angle — this is related to the coefficient of static friction
6. Slide the block and observe: does it accelerate? Does it reach a constant speed?

**Lab activities:**
- Compare the critical angle for different block surface textures
- Add known weights on top of the block and check if the critical angle changes
- Time the block sliding down and calculate acceleration; compare to **a = g(sin θ − μ cos θ)**
- Use the `ramp_family()` print to show students three angle scenarios simultaneously

## Things To Notice

- The **angle label arc** on the ramp shows the actual incline angle
- Weight always points straight down — its components along and perpendicular to the ramp change with angle
- At the critical angle, the friction force exactly equals the component of gravity along the ramp
- A rougher surface has a **higher μ** — it can sustain a steeper angle before sliding
- The normal force is **not** equal to the full weight on an incline — it's **N = mg cos(θ)**

## Try Changing These Parameters

```openscad
ramp_angle = 20;              // Change ramp steepness (try 10°–40°)
ramp_base_length = 100;       // Make ramp longer for slower slides
show_component_guide = true;  // Show weight-component construction lines
block_base_flat = false;      // Switch to textured (rough) block base
ramp_width = 40;              // Wider ramp for larger blocks
```

## Related Models

- `05_forces_free_body/free_body_diagram_board.scad` — draw the FBD for a block on this ramp
- `02_vectors_components/vector_arrow_kit.scad` — arrows for labeling force components
- `10_torque_statics/torque_balance_beam.scad` — another static equilibrium scenario
- `06_friction_contact/surface_texture_blocks.scad` *(TODO)* — variable-friction block set
