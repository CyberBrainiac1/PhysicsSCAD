# Rolling Motion Wheel Set

Models: `rolling_motion_wheel_set.scad`, `rolling_energy_transfer_demo.scad`

## What This Is
Wheel families for comparing radius, inertia distribution, and rolling behavior.

## What It Teaches
Rolling constraints, translational-rotational coupling, and radius tradeoffs.

## Why This Matters
Rolling motion integrates linear and rotational ideas in one physical system.

## How To Print
Print wheel variants with consistent outer diameter where possible, except intentional radius-comparison sets.

## Quick Start
Compare two wheels with different radii on same surface and predict travel per rotation.

## How to Learn With This
### Student mode
- Mark one spoke and count rotations over fixed distance.

### Mentor mode
- Ask “what changes in v = omega r when r changes?”

### Hands-on learning tasks
1. Count rotations needed to travel fixed length for each radius.
2. Compare start-up response of light-spoke vs heavy-rim wheel.
3. Test gentle incline roll with multiple wheel types.
4. Compare equal-radius, different-distribution wheels for acceleration feel.
5. Relate rolling without slipping to contact-point behavior.

## Things to Predict Before Using
- Which wheel needs fewer rotations for same distance?
- Which distribution resists speed changes more?
- What happens when rolling constraint is violated (slip)?

## Challenge Prompts
- Design a wheel choice for fast acceleration vs steady cruise and justify.
- Explain force/torque/energy perspectives for one rolling scenario.

## Explanation Prompts
- Why does larger radius alter torque-to-ground-force behavior?
- Why does rim-heavy design feel “sluggish” to spin up?

## Common Mistakes / Misconceptions
- Assuming all equal-mass wheels behave identically.
- Ignoring rotational kinetic energy in rolling systems.
- Confusing instantaneous contact point speed with wheel center speed.

## Physics 1 Connection
Rolling motion and rotational-translational coupling.

## F=ma Connection
Selecting efficient method (force/torque/energy) for mixed-motion systems.

## Robotics Connection
Wheel sizing tradeoffs for speed, pushing force, and control response.

## Related Models
`../11_rotational_dynamics`, `../12_center_of_mass`, `../17_robotics_applications`
