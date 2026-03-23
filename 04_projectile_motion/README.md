# Projectile Motion Template

Model: `projectile_motion_template.scad`

## What This Is
A launch-angle and trajectory guide board for 2D projectile geometry.

## What It Teaches
Component decomposition, symmetry, peak behavior, and range intuition.

## Why This Matters
Projectile motion is an early AP Physics 1 synthesis topic that blends vectors + kinematics.

## How To Print
Print flat. Use clear or bright filament for overlay arcs if printing multiple angle families.

## Quick Start
Pick 30 degrees and 60 degrees trajectories with same launch speed marker; compare range and peak height.

## How to Learn With This
### Student mode
- Predict first, then trace arc family and check where your mental picture breaks.

### Mentor mode
- Ask “what stays same when angle changes?” and “what swaps between 30 and 60?”

### Hands-on learning tasks
1. Mark launch vector and resolve into horizontal/vertical components.
2. Compare low-angle vs high-angle shots with same speed.
3. Locate symmetry point and discuss vertical velocity there.
4. Build equal-range partner-angle pair.
5. Add range markers and estimate time-of-flight differences qualitatively.

## Things to Predict Before Using
- Which has larger range at same speed: 30 degrees or 60 degrees?
- Where is vertical velocity zero?
- Does horizontal acceleration ever become nonzero (ignoring drag)?

## Challenge Prompts
- Create a setup with same range but different peak height and defend why.
- Explain when complementary-angle symmetry fails (real-world conditions).

## Explanation Prompts
- Why does projectile motion split cleanly into x and y analysis?
- Why is apex not halfway in time for all real trajectories?

## Common Mistakes / Misconceptions
- Treating motion as “force in direction of travel.”
- Assuming speed is constant throughout flight.
- Mixing up equal range with equal flight time.

## Physics 1 Connection
2D kinematics and independent-axis reasoning.

## F=ma Connection
Model assumptions and selecting minimal equations from geometric constraints.

## Robotics Connection
Useful for launcher tuning intuition (tradeoff between arc clearance and travel distance).

## Related Models
`../02_vectors_components`, `../03_kinematics_graphs`, `../17_robotics_applications`
