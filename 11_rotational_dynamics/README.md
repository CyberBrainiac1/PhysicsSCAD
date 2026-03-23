# Moment of Inertia Comparison Set

Model: `moment_of_inertia_comparison_set.scad`

## What This Is
Same-size rotating bodies (disk, ring, spoked, cutout) with different mass distributions.

## What It Teaches
Mass distribution effects on rotational inertia and spin response.

## Why This Matters
Students often equate “same size” with “same rotational behavior,” which is false.

## How To Print
Print all variants at equal thickness for fair comparisons.

## Quick Start
Rank the shapes by predicted resistance to angular acceleration before handling them.

## How to Learn With This
### Student mode
- Compare one pair at a time and justify ranking in words.

### Mentor mode
- Ask “where is the mass relative to the axis?” repeatedly.

### Hands-on learning tasks
1. Compare disk vs ring mass placement.
2. Compare spoked vs cutout variants.
3. Sort all variants by expected spin-up ease under same torque.
4. Sort by expected energy-storage usefulness.
5. Connect each shape to a hypothetical mechanism goal.

## Things to Predict Before Using
- Which shape should resist angular acceleration most?
- Which should spin up fastest for same applied torque?
- Which is better for smoothing output fluctuations?

## Challenge Prompts
- Pick geometry for maximum energy storage with fixed outer radius.
- Pick geometry for fastest speed changes in response-critical design.

## Explanation Prompts
- Why does moving mass outward increase rotational inertia?
- Why can high inertia be beneficial in one design and harmful in another?

## Common Mistakes / Misconceptions
- “Same diameter means same inertia.”
- Confusing mass with inertia distribution effects.
- Assuming highest inertia is always best.

## Physics 1 Connection
Rotational dynamics and rotational kinetic energy intuition.

## F=ma Connection
Constraint comparisons, limiting-case reasoning, and framework choice for rotation problems.

## Robotics Connection
Flywheel shooter tradeoffs: consistency/energy storage versus acceleration responsiveness.

## Related Models
`../10_torque_statics`, `../13_rolling_motion`, `../17_robotics_applications`
