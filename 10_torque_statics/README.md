# Torque Balance Beam

Model: `torque_balance_beam.scad`

## What This Is
Lever beam with center pivot, distance marks, and load token positions.

## What It Teaches
Torque as force x lever arm, equilibrium, and balancing strategies.

## Why This Matters
This is the bridge from translational force intuition to rotational statics/dynamics.

## How To Print
Print beam flat for straightness; print pivot and tokens with tighter infill for durability.

## Quick Start
Place equal masses at equal distances from pivot; verify neutral balance.

## How to Learn With This
### Student mode
- Predict rotation direction before every placement change.

### Mentor mode
- Ask “which side has bigger moment arm contribution?”

### Hands-on learning tasks
1. Equal masses, unequal distances comparison.
2. Unequal masses, equal distances comparison.
3. Find two different balanced configurations.
4. Keep one side fixed and solve for minimal counterweight location.
5. Build near-balance case and test sensitivity to one-slot shift.

## Things to Predict Before Using
- Does doubling distance have same torque effect as doubling force?
- Which side wins: heavy-close or light-far?
- What happens if both net force and net torque conditions are not satisfied?

## Challenge Prompts
- Produce three different equilibrium setups using same token set.
- Build a case with zero net force but nonzero net torque and explain outcome.

## Explanation Prompts
- Why can a smaller force dominate if applied farther out?
- Why is pivot choice essential when calculating torques?

## Common Mistakes / Misconceptions
- Ignoring lever arm direction/sign.
- Using distance to load edge instead of line-of-action lever arm.
- Assuming force balance alone guarantees rotational equilibrium.

## Physics 1 Connection
Torque, static equilibrium, rotational analogs of Newtonian thinking.

## F=ma Connection
Constraint-driven setup and quick selection of pivot points to simplify equations.

## Robotics Connection
Directly maps to arm design, payload placement, and motor torque demands in FTC mechanisms.

## Related Models
`../11_rotational_dynamics`, `../12_center_of_mass`, `../17_robotics_applications`
