# Projectile Motion — Fan-Out Angle Dial

Model: `projectile_motion_template.scad`

## What This Is
A **handheld rotating dial mechanism** — a circular base plate with a parabolic arch arm that pivots at the launch point. Rotating the arm to each of the five detent positions (15°, 30°, 45°, 60°, 75°) shows how range and peak height depend on launch angle. The arm **clicks** at each angle so students feel the angle change, not just see it.

## What It Teaches
Launch angle, range, complementary angle symmetry, and the equation `R = v₀²sin(2θ)/g`.

## Why This Matters
Projectile motion is an early AP Physics 1 synthesis topic that blends vectors and kinematics. Having an angle you can *feel click into place* makes the 45° maximum range a tactile discovery, not just a calculus result.

## Parts to Print
| Part | Qty | Notes |
|------|-----|-------|
| `base_plate()` | 1 | Circular dial with angle markings and range arc grooves |
| `arch_arm(45)` | 1 | Default 45° trajectory arch |
| `snap_pin()` | 1 | Pivot post, press-fits into base |
| `detent_ring()` | 1 | Bump ring that creates clicks at each 15° position |

## How To Print
- Print all parts flat on build plate, no supports needed.
- Use 4 perimeters/walls on the arch arm for durability.
- Recommended: PLA, 0.2 mm layer height, 20% infill on base plate.

## Assembly Order
1. Press `snap_pin` into base plate centre hole (firm push or light hammer tap).
2. Slide `detent_ring` over pin and seat flat against base.
3. Press `arch_arm` pivot hole over pin tip — should rotate freely.
4. Rotate arm and feel it click at 15°, 30°, 45°, 60°, 75°.

## Tolerance Adjustment
If the arm is too stiff: increase `slide_tol` by 0.1 mm and reprint the arm only.
If the pin is loose in the base: decrease `press_fit_tol` by 0.05 mm and reprint the pin.

## How to Learn With This
### Student mode
- Rotate to each click. Predict before rotating: will the range increase or decrease?
- Note that 30° and 60° have the same range — this is complementary angle symmetry.

### Mentor mode
- Ask "which angle gives the farthest landing?" BEFORE the student rotates to 45°.
- Ask "why do 30° and 60° land at the same spot?"

### Hands-on learning tasks
1. Hold dial and rotate arm from 15° to 75°. Feel each click — five distinct experiments.
2. At each angle, sketch or note whether range grows or shrinks.
3. Find the two complementary-angle pairs (15°+75°, 30°+60°).
4. Verify with the equation `R = v₀²sin(2θ)/g` that sin(2·30°) = sin(2·60°).
5. Change `v0_scale` in OpenSCAD and reprint — how does arm shape change?

## Things to Predict Before Using
- At which angle is the range longest?
- Do 30° and 60° have the same maximum height?
- What happens to range as angle approaches 0° or 90°?

## Challenge Prompts
- Print arch arms at both 30° and 60° and lay them side by side — same horizontal range, different shape.
- Measure the peak height on the 45° arm. Does `sin(2·45°) = 1` help explain it?

## Common Mistakes / Misconceptions
- Assuming highest angle = farthest range.
- Forgetting that horizontal velocity is constant (no air resistance).
- Confusing range symmetry with peak height symmetry.

## Related Models
`../02_vectors_components`, `../03_kinematics_graphs`, `../17_robotics_applications`
