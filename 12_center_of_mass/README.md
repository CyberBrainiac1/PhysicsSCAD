# Center of Mass Balancer

Model: `center_of_mass_balancer.scad`

## What This Is
Irregular balancing shapes with visible and hidden COM variants.

## What It Teaches
Center of mass location, stability criteria, and tipping intuition.

## Why This Matters
COM reasoning is critical in statics, rolling, and robotics stability decisions.

## How To Print
Print multiple shape variants. Include at least one hidden-COM version for challenge use.

## Quick Start
Balance a marked-COM shape on a pin/notch; then attempt the hidden-COM version.

## How to Learn With This
### Student mode
- Predict COM location with geometry only before balancing.

### Mentor mode
- Ask “where does COM projection fall relative to support polygon?”

### Hands-on learning tasks
1. Balance marked shapes and verify COM marker alignment.
2. Locate COM on hidden variant by trial and bracketing.
3. Compare stability for low vs high COM mounting points.
4. Test effect of adding small payload clip-on mass.
5. Map tipping edges for different support widths.

## Things to Predict Before Using
- Which orientation is most stable?
- What happens when COM projection crosses support edge?
- Does larger base always prevent tipping?

## Challenge Prompts
- Build a shape stable front-back but unstable side-side.
- Create two payload placements: one safe, one near-critical tipping.

## Explanation Prompts
- Why does COM height affect tipping risk?
- Why can a wider base still tip if COM shifts enough?

## Common Mistakes / Misconceptions
- Equating geometric center with COM always.
- Ignoring orientation-dependent stability.
- Treating support width as the only stability factor.

## Physics 1 Connection
Center of mass, equilibrium, and static stability.

## F=ma Connection
Geometric constraints and critical-threshold reasoning.

## Robotics Connection
Directly relevant to anti-tip design, extension limits, and payload placement.

## Related Models
`../10_torque_statics`, `../13_rolling_motion`, `../17_robotics_applications`
