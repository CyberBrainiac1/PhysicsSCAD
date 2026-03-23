# Robotics Applications (FTC-Style Mechanics)

Models:
- `gear_ratio_visualizer_board.scad`
- `arm_torque_geometry_board.scad`
- `flywheel_energy_comparison_disks.scad`
- `robot_stability_com_board.scad`

## What This Is
Mechanics-first teaching aids that transfer directly to common FTC design tradeoffs.

## What It Teaches
Speed/torque trades, arm loading, flywheel response, and anti-tip stability.

## Why This Matters
These are the same mechanics decisions that separate consistent robots from fragile ones.

## How To Print
Print each board flat and keep token/marker parts in separate labeled bags by subsystem.

## How to Learn With This
### Student mode
- Pick one subsystem per session and finish with one “design decision” statement.

### Mentor mode
- Ask “what are you optimizing: speed, torque, stability, or consistency?” before activities.

---
## Gear Ratio Visualizer Board
### Quick Start
Set one input turn and compare output turn counts for two gear-pair choices.

### Hands-on learning tasks
1. Small-to-large ratio comparison.
2. Large-to-small ratio comparison.
3. Keep output torque target fixed and choose ratio direction.
4. Compare responsiveness vs pushing-force intuition.

### Things to Predict Before Using
- Which ratio increases output torque?
- Which ratio increases output speed?

### Challenge Prompts
- Choose ratio strategy for launcher vs lift and justify.

### Common Mistakes / Misconceptions
- “Higher ratio always better.”
- Ignoring tradeoffs with motor operating range.

---
## Arm Torque Geometry Board
### Quick Start
Place payload at short radius then long radius; predict torque demand change.

### Hands-on learning tasks
1. Compare near-pivot vs far-pivot payload positions.
2. Compare horizontal vs raised arm geometry torque intuition.
3. Identify worst-case holding angle.
4. Test counterbalance concept markers.

### Things to Predict Before Using
- How does required holding torque scale with extension?
- Where is gravity moment arm largest?

### Challenge Prompts
- Propose one geometry change that reduces motor overload without changing payload mass.

### Common Mistakes / Misconceptions
- Assuming payload mass alone determines torque demand.
- Ignoring angle dependence.

---
## Flywheel Energy Comparison Disks
### Quick Start
Rank disk variants for fast spin-up vs steady energy delivery.

### Hands-on learning tasks
1. Compare rim-heavy and center-heavy distributions.
2. Pick design for consistency-focused shooter.
3. Pick design for rapid cycle-time shooter.
4. Discuss recharge time between shots.

### Things to Predict Before Using
- Which geometry best smooths shot-to-shot speed drop?
- Which geometry feels most responsive?

### Challenge Prompts
- Select a compromise flywheel and defend with match-strategy assumptions.

### Common Mistakes / Misconceptions
- “Most inertia is always best.”
- Ignoring acceleration-time penalties.

---
## Robot Stability / COM Board
### Quick Start
Mark baseline COM, then shift payload marker upward and forward.

### Hands-on learning tasks
1. Compare low-COM and high-COM setups.
2. Compare COM shifts during intake extension.
3. Identify likely tipping edge under acceleration.
4. Create safer payload placement alternative.

### Things to Predict Before Using
- Which COM shift increases tip risk most?
- How does wheelbase boundary constrain safe COM projection?

### Challenge Prompts
- Build one stable and one near-critical setup for same wheelbase.

### Common Mistakes / Misconceptions
- Treating static and dynamic tip risk as identical.
- Assuming heavier robot is automatically more stable.

## Explanation Prompts (All Robotics Models)
- What tradeoff did you choose, and what did you sacrifice?
- What failure mode does your choice reduce, and which one might it worsen?

## Physics 1 Connection
Applies forces, torque, rotation, COM, and energy ideas in real mechanism contexts.

## F=ma Connection
Promotes framework selection, constraints, and comparative reasoning under design limits.

## Robotics Connection
Direct FTC transfer: drivetrain tuning, arm design, launcher consistency, and anti-tip strategy.

## Related Models
`../10_torque_statics`, `../11_rotational_dynamics`, `../12_center_of_mass`, `../13_rolling_motion`
