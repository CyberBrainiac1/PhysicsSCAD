# Vectors and Components — Rotating Arm + Shadow Projector

Models: `vector_board.scad`, `vector_arrow_kit.scad`

## What This Is
A printable vector board with a **rotating arm** that pivots on a snap-pin at the board origin, plus **sliding component shadow arms** that ride in perpendicular channel grooves. As you rotate the main arm, you slide each shadow arm to match the new component length — making `Rx = |R|cos(θ)` and `Ry = |R|sin(θ)` a physical action, not just a formula.

## What It Teaches
Magnitude, direction, components, vector addition/subtraction, and `|R|² = Rx² + Ry²`.

## Why This Matters
This is foundational language for AP Physics 1 force diagrams, velocity/acceleration vectors, and F=ma modeling. When students physically slide the component arms shorter as they rotate the main arm toward 90°, they viscerally understand why a vector pointing straight up has zero x-component.

## Parts to Print
| Part | Qty | Notes |
|------|-----|-------|
| `board()` | 1 | Base board with channel grooves, grid, and degree arc |
| `snap_pivot()` | 1 | Pivot post, press-fits into board origin |
| `rotating_arm(80)` | 1 | Primary vector arm (80 mm long) |
| `rotating_arm(60)` | 1 | Second vector arm for addition experiments (optional) |
| `component_slider("x")` | 1 | Horizontal component shadow arm |
| `component_slider("y")` | 1 | Vertical component shadow arm |

## How To Print
- Print all parts flat, no supports needed.
- Increase `board_thickness` to 5–6 mm for heavy classroom use.
- Recommended: PLA, 0.2 mm layer height.

## Assembly Order
1. Press `snap_pivot` into board origin hole.
2. Place `rotating_arm` pivot hole over snap_pivot shaft — should rotate freely.
3. Insert `component_slider("x")` into horizontal channel groove.
4. Insert `component_slider("y")` into vertical channel groove.
5. Rotate arm; slide each shadow arm to match the component length.

## Tolerance Adjustment
If sliders bind: increase `slide_tol` by 0.1 mm and reprint the slider only.
If arm pivot is stiff: increase `slide_tol` by 0.05 mm and reprint the arm.

## How to Learn With This
### Student mode
- Set arm to a chosen angle. Predict component lengths, then slide the shadow arms to check.
- Notice what happens to each component as you approach 0° or 90°.

### Mentor mode
- Ask "which component shrinks as angle grows?" before student rotates.
- Ask "what angle makes Rx = Ry?" (45°)

### Hands-on learning tasks
1. Set arm to 0° — Ry shadow arm can't extend at all. Why?
2. Set arm to 90° — Rx shadow arm collapses to zero. Explain in words.
3. Find the angle where Rx = Ry and verify it's 45°.
4. Add two arms; estimate the resultant by measuring diagonal on the grid.
5. Verify `|R|² = Rx² + Ry²` with a ruler on the printed model.

## Things to Predict Before Using
- At 60°, which component is larger: x or y?
- If you double arm length, do the components double?
- Can two non-parallel vectors cancel a third?

## Challenge Prompts
- Show one non-trivial triple-vector equilibrium using two arms and the board grid.
- Hold resultant direction fixed while increasing magnitude — what happens to components?

## Common Mistakes / Misconceptions
- Measuring angle from the wrong axis.
- Treating component magnitudes as always positive.
- Assuming bigger angle means bigger vector.

## Related Models
`../05_forces_free_body`, `../03_kinematics_graphs`, `../17_robotics_applications`
