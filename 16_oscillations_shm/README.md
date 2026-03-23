# Oscillations and SHM — Adjustable Pendulum Stand + Phase Dial

Models: `spring_mass_phase_slider.scad`, `pendulum_geometry_guide.scad`, `shm_displacement_phase_disk.scad`

## What This Is
Two physical mechanisms for simple harmonic motion:

1. **Adjustable Pendulum Stand** (`spring_mass_phase_slider.scad`) — a vertical mast with a T-slot channel and a sliding clamp. Move the clamp up or down to change pendulum length L; swing the bob and count seconds to measure the period. The mast is engraved with `T = 2π√(L/g)` and pre-computed period values at L = 50, 100, 150, 200 mm.

2. **Phase Portrait Dial** (`spring_mass_phase_slider.scad`) — a flat circular dial with an ellipse groove cut into it representing the SHM phase portrait. A small bead rides in the groove; rotating the bead around traces `x = Acos(φ)` and `v = −Aωsin(φ)` simultaneously.

## What It Teaches
- Pendulum period `T = 2π√(L/g)` and its √L dependence
- Phase portrait: position and velocity as projections of circular motion
- How changing ω (frequency) changes the ellipse shape on the phase dial

## Why This Matters
SHM is abstract. Physically sliding a clamp and timing a swing makes the √L dependence felt, not just known. Rotating a bead around an ellipse groove makes the 90° phase lag between position and velocity tangible.

## Parts to Print
| Part | Qty | Notes |
|------|-----|-------|
| `mast(200)` | 1 | Vertical post with T-slot and engraved period scale |
| `sliding_clamp()` | 1 | U-shaped clip that grips T-slot; has hook for string |
| `bob()` | 1 | Pendulum bob with string hole at top |
| `phase_dial(30, 1)` | 1 | Phase portrait ellipse dial |
| `bead()` | 1 | Peg that rides in ellipse groove |

## How To Print
- **Mast**: print upright; enable supports for T-slot overhang.
- **Clamp**: print flat (C-shape facing up), no supports.
- **Bob**: print upright, no supports.
- **Phase dial**: print flat, no supports.
- **Bead**: print flat side down.

## Assembly Order
1. Slide clamp onto mast T-slot from the top.
2. Thread string/cord through clamp hook; tie to bob.
3. Set clamp at a desired height mark (50, 100, 150, or 200 mm).
4. Swing bob and count oscillations per 30 seconds; compute period.
5. Move clamp to a new height; repeat and compare.
6. On the phase dial, drop bead in ellipse groove and rotate it through 360°.

## Tolerance Adjustment
If clamp slides too freely: decrease `slide_tol` by 0.05 mm and reprint clamp.
If clamp won't slide: increase `slide_tol` by 0.05 mm and reprint clamp.
If bead falls out of groove: decrease `slide_tol` for the bead or increase `groove_d` by 0.2 mm.

## How to Learn With This
### Student mode
- Start at L=50 mm. Record period. Move to L=200 mm. Record period. Why is the ratio ≈2?

### Mentor mode
- Ask "if I move the clamp to four times the height, what do you predict for the period?"

### Hands-on learning tasks
1. Time 10 swings at L=100 mm; compute T. Compare to `T = 2π√(0.1/9.81)`.
2. Double L — does T double? (It increases by √2 ≈ 1.41)
3. On the phase dial at φ=0°: read x and v. At φ=90°: what happened to each?
4. The bead moves fastest through the narrow ends of the ellipse (v maximum). Why?
5. Change `omega` in OpenSCAD and reprint the dial — how does the ellipse change?

## Things to Predict Before Using
- If L doubles, does T double?
- At maximum displacement, is velocity maximum, zero, or somewhere in between?
- What shape is the phase portrait of SHM? (Ellipse — why?)

## Challenge Prompts
- Print two phase dials with ω=1 and ω=2; compare ellipse widths.
- Predict the clamp position that gives T=1 second (L ≈ 248 mm).

## Common Mistakes / Misconceptions
- Thinking heavier bob = faster swing (mass cancels from T=2π√(L/g)).
- Assuming T is proportional to L (it's proportional to √L).
- Confusing amplitude with frequency.

## Related Models
`../14_gravitation_orbits`, `../03_kinematics_graphs`
