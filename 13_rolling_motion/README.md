# Rolling Motion

## What This Is
A set of 3D-printable wheels and a rolling surface that make rolling-without-slipping physics tangible. Includes a spoked wheel, solid disk, and ring wheel for comparison.

## What It Teaches
- Rolling without slipping: v_contact = 0, v_top = 2v_center
- The cycloid path traced by a point on the rim
- How wheel geometry (spoked vs solid vs ring) connects to moment of inertia
- Rolling kinematics: v_cm = ω·R

## Why This Matters
Rolling motion combines translation and rotation simultaneously. The contact point is instantaneously at rest — a surprising result that is hard to visualize without a physical model.

## How To Print
- Print `rolling_wheel_set.scad` flat on the bed; no supports needed for the wheel itself
- The rolling surface prints flat — no supports
- Use 0.2 mm layer height for clean spoke details
- PLA works well; 15–20% infill is sufficient

## How To Use
1. Print the wheel and rolling surface
2. Place the wheel on the surface at the tick-mark origin
3. Roll the wheel one full revolution — the center moves exactly one circumference (π·d)
4. Observe the colored/notched rim point: it traces a cycloid
5. Use the velocity arrows to discuss v=0 at contact, v=2v at top

## Things To Notice
- The contact-point mark touches the surface with zero instantaneous velocity
- After one full roll, the center has moved πd forward
- The top of the wheel moves twice as fast as the center

## Try Changing These Parameters
- `spoke_count` — more spokes make rotation harder to see; fewer look dramatic
- `wheel_diameter` — change and verify the surface tick spacing matches πd
- `show_velocity_arrows` — toggle to quiz students before revealing

## Related Models
- `11_rotational_dynamics/` — moment of inertia disks (solid vs ring)
- `12_center_of_mass/` — combined rotation + translation
- `09_momentum_impulse/` — linear momentum of the rolling center
