# Oscillations & Simple Harmonic Motion

## What This Is
Two 3D-printable models: a **Pendulum Geometry Guide Board** showing three pendulums of different lengths with force components and arc paths, and a **SHM Phase Disk** encoding displacement and velocity phase around a circular dial.

## What It Teaches
- Pendulum period depends on length: T = 2π√(L/g), not on mass or amplitude (for small angles)
- The restoring force is the tangential component of gravity: F = −mg·sin(θ) ≈ −mgθ
- Simple harmonic motion: x(t) = A·cos(ωt + φ)
- Phase relationship: velocity leads displacement by 90°
- The connection between circular motion and SHM

## Why This Matters
SHM underlies clocks, musical instruments, molecular vibrations, AC circuits, and quantum mechanics. Understanding the phase relationship between position and velocity is essential for waves, resonance, and signal processing.

## How To Print

### Pendulum Guide Board
- Print flat on bed; no supports needed
- 0.2 mm layer height for clean arc lines
- PLA at 15% infill

### SHM Phase Disk
- Print flat (disk face down)
- 0.15 mm layer height for smoother sine curve profile
- Use a color swap at 1 mm height to highlight the curve

## How To Use
1. **Pendulum board**: measure the three arc lengths; note T ∝ √L by comparing them
2. **Phase disk**: rotate the disk and follow the raised sine curve — at 0° (top), x = max; at 90°, x = 0 and velocity is maximum
3. Print two phase disks; offset one by 90° to show position vs. velocity relationship

## Things To Notice
- On the pendulum board, the restoring force arrow is shortest at equilibrium (zero) and largest at the extreme angle
- On the phase disk, the curve height represents displacement — it is zero where velocity is maximum
- Three different pendulum lengths have noticeably different arc radii

## Try Changing These Parameters
- `pendulum_lengths` — try [30, 60, 120] to make the T ∝ √L ratio more obvious (2× length → √2 × period)
- `swing_angle` — increase to 30° to show when the small-angle approximation starts to fail
- `disk_diameter` — scale up to 150 mm for a large wall display

## Related Models
- `07_circular_motion/` — circular motion connection to SHM
- `11_rotational_dynamics/` — physical pendulum (extended body)
- `16_oscillations_shm/pendulum_guide.scad` and `shm_phase_disk.scad`
