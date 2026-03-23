# Rotational Dynamics — Moment of Inertia Set

## What This Is

A family of five disks with identical outer diameters but different mass distributions for
comparing rotational inertia. Roll them down a ramp — the disk that reaches the bottom first
has the lowest moment of inertia. A simple bracket stand holds any disk upright on a shared
axle rod.

Main model: **moment_of_inertia_set.scad**

---

## What It Teaches

- **Moment of inertia** — I = Σ mr², how mass distribution affects resistance to rotation
- **Rolling motion** — K_total = ½mv² + ½Iω², both translational and rotational kinetic energy
- **Angular acceleration** — α = τ/I, how torque produces rotation
- **Mass vs. mass distribution** — two objects with identical mass can have very different I
- **Energy conservation** — trading gravitational PE for translational and rotational KE
- **Comparison of I formulas** — solid disk (½MR²), ring (MR²), spoked disk, etc.

---

## Why This Matters

Moment of inertia determines how quickly a flywheel spins up, how a gymnast tucks to rotate
faster, and how a car's wheels affect acceleration. Engineers designing any rotating component
— motors, turbines, wheels, joints — must account for I. This set lets students directly
observe and compare the effect of mass distribution without complex instrumentation.

---

## How To Print

| Part | Suggested settings |
|------|--------------------|
| All disks | 0.2 mm layers, **100% infill** (mass matters!), PLA |
| Comparison stand | 0.2 mm layers, 30% infill |

- **100% infill is essential** — the whole point is consistent, predictable mass distribution. Variable infill would randomize results.
- Print all disks in the **same filament** to keep density consistent.
- The center bore (8 mm) fits a standard 8 mm wooden dowel or M8 rod as an axle.
- For the ramp experiment, a smooth, flat board propped at 10–20° works well.
- Print the comparison stand with supports if needed for the overhang on the bracket arms.
- Label each disk with a marker or use different filament colors for quick identification.

---

## How To Use

### Ramp race experiment
1. Print all five disks with 100% infill in the same filament.
2. Build a simple ramp (a board propped on books, ~20° angle, at least 400 mm long).
3. Hold two disks side-by-side at the top, release simultaneously.
4. Observe which reaches the bottom first.
5. **Prediction before racing:** rank the disks by expected I from lowest to highest.

### Expected ramp order (fastest to slowest):
1. **Hub-heavy disk** — most mass near center, lowest I → fastest
2. **Solid disk** — uniform, I = ½MR²
3. **Cutout disk** — some mass removed from mid-outer region
4. **Spoked disk** — mass at rim and spokes
5. **Ring disk** — all mass at rim, highest I → slowest

### Axle spin-up experiment
1. Thread all disks onto a common 8 mm axle (wooden dowel).
2. Apply the same brief torque (flick with a finger).
3. Observe which spins fastest — the one with the lowest I accelerates most.

---

## Things To Notice

- The ring and solid disk have the same outer diameter and approximately similar mass — yet the ring rolls much slower. Why? (Almost all its mass is at maximum radius.)
- The hub-heavy disk may look "beefier" near the center yet rolls fastest — because that central mass contributes little to I (r² is small).
- The difference in ramp finish times is surprisingly large — a great demonstration that I is a "real" measurable quantity.

---

## Try Changing These Parameters

| Parameter | Effect |
|-----------|--------|
| `outer_diameter` | Scales all disks; keep consistent across the set |
| `disk_thickness` | Thicker = more mass, but I ratios stay the same |
| `center_bore_diameter` | Match to your axle rod diameter |
| `inner_radius` factor | In `ring_disk()`, controls how thin the ring is |
| Number of spokes | In `spoked_disk()`, more spokes → approaches solid disk |
| Cutout size | In `cutout_disk()`, larger cutouts → approaches ring |

---

## Related Models

- `10_torque_statics/` — torque is what causes the angular acceleration α = τ/I
- `13_rolling_motion/` — rolling without slipping connects v and ω
- `16_oscillations_shm/` — rotational oscillations of a disk (physical pendulum)
- `12_center_of_mass/` — COM of symmetric disks is at geometric center
