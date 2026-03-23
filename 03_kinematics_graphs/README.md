# Kinematics Graphs — Sliding Curve Insert System

Model: `kinematics_graph_tile_set.scad`

## What This Is
A **reusable frame tile** with two parallel channel rails, and a set of **swappable curve inserts** that slide in from the side. Each insert carries a different curve profile representing a different motion type. A **snap-in label tab** at the end of the frame identifies the graph axis (x-t, v-t, or a-t). The same frame works for all three graph types — swap both the curve insert and the label tab.

## What It Teaches
- x-t graph slope = velocity; v-t graph slope = acceleration; v-t area = displacement
- How the *shape* of each graph type constrains the shape of the others
- Constant velocity, positive/negative acceleration, thrown-object parabola

## Why This Matters
Kinematics graphs are a gateway concept. Students who can swap a "concave up" insert for a "flat" insert on the x-t frame, then reason about what the v-t graph must look like, have internalized the derivative relationship — without calculus.

## Parts to Print
| Part | Qty | Notes |
|------|-----|-------|
| `frame()` | 1–3 | Reusable frame (print one per axis type, or share) |
| `curve_insert("flat")` | 1 | Insert A: constant velocity (a=0) |
| `curve_insert("gentle")` | 1 | Insert B: gentle positive acceleration |
| `curve_insert("steep")` | 1 | Insert C: steep positive acceleration |
| `curve_insert("down")` | 1 | Insert D: deceleration |
| `curve_insert("parab")` | 1 | Insert E: thrown object (x-t parabola) |
| `label_tab("x-t")` | 1 | Axis label for position-time graph |
| `label_tab("v-t")` | 1 | Axis label for velocity-time graph |
| `label_tab("a-t")` | 1 | Axis label for acceleration-time graph |

## How To Print
- Print frame and all inserts flat, no supports needed.
- Use 4 walls on inserts for durability when sliding repeatedly.
- Print inserts in different filament colours for easy identification.
- Recommended: PLA, 0.2 mm layer height.

## Assembly Order
1. Slide a curve insert into the frame channel from the open end.
2. Snap a label tab into the slot at the closed end of the frame.
3. The insert should slide smoothly — a slight friction fit is normal.
4. Swap inserts to compare motion types side by side.

## Tolerance Adjustment
If inserts are too tight: increase `fit_tolerance` by 0.1 mm and reprint inserts only.
If inserts fall out: decrease `fit_tolerance` by 0.05 mm and reprint inserts.

## How to Learn With This
### Student mode
- Slide in the "gentle" insert and label "x-t". Ask: what must the v-t graph look like?
- Slide in the "parab" insert and label "x-t". What happens at the peak of the parabola?

### Mentor mode
- Hand students two inserts; ask which represents a faster acceleration before they slide either in.

### Hands-on learning tasks
1. Slide "flat" insert into x-t frame. What is the velocity? What does the v-t frame show?
2. Slide "gentle" into x-t. What is the acceleration? Positive or negative?
3. Slide "down" into x-t. Object is slowing down — what sign is acceleration?
4. Slide "parab" into x-t. At the peak, what is velocity? What does v-t graph look like?
5. Challenge: find the insert pair (x-t + v-t) that are consistent with each other.

## Things to Predict Before Using
- If x-t is concave up, is acceleration positive or negative?
- What does a flat x-t line mean about velocity?
- What does an x-t parabola's peak tell you about velocity at that instant?

## Challenge Prompts
- Build a piecewise motion story: "Insert A for 3 seconds, then Insert C" — what does the v-t graph look like?
- Which two inserts represent complementary kinematic sequences (one is the integral of the other)?

## Common Mistakes / Misconceptions
- Confusing slope of x-t with the height of x-t.
- Thinking a steep x-t graph means high acceleration (it means high velocity).
- Forgetting that v-t area is displacement, not distance.

## Related Models
`../04_projectile_motion`, `../08_energy_work_power`, `../03_kinematics_graphs`
