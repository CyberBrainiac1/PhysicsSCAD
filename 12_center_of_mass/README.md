# Center of Mass — Balancer Shapes

## What This Is

A set of five flat irregular shapes for hands-on center-of-mass exploration. Each shape has
hanging holes for the classic string-and-plumb-line method, a small divot at the true COM
for pin balancing, and (optionally) a raised crosshair marker showing the exact COM location.
The "challenge set" hides the COM marker so students must find it experimentally first.

Main model: **center_of_mass_balancer.scad**

---

## What It Teaches

- **Center of mass** — the single point where the total mass can be considered to act
- **COM of composite shapes** — x_com = Σ(mᵢxᵢ)/Σmᵢ applied geometrically
- **COM outside the material** — the boomerang shape demonstrates this dramatically
- **The hanging-string method** — the COM always lies directly below the suspension point
- **Balancing on a single point** — equilibrium when the support is directly below COM
- **Symmetry arguments** — symmetric shapes have COM on the axis of symmetry

---

## Why This Matters

The center of mass governs how objects fall, tumble, balance, and rotate. It is fundamental
to structural engineering (will this tower tip?), vehicle stability (SUV rollover risk),
robotics balance control, and orbital mechanics (tidal locking). The surprising result that
the boomerang shape's COM lies in empty space is a powerful conceptual breakthrough that
students remember long after the class.

---

## How To Print

| Part | Suggested settings |
|------|--------------------|
| All shapes | 0.2 mm layers, **100% infill** (uniform density required!), PLA |

- **100% infill is critical** — the whole experiment depends on uniform density. Variable infill would shift the actual COM away from the calculated position.
- Print flat with no supports needed — all shapes are 4 mm thick.
- Print the "challenge set" (COM markers hidden) for in-class use; print the "answer set" separately for checking or display.
- A smooth surface finish helps with pin balancing — light sanding on the bottom face is helpful.
- The hanging holes (3 mm) fit a standard pushpin or a 3 mm peg on a stand.

---

## How To Use

### String-and-plumb-line method
1. Push a pin or peg through hanging hole #1 and let the shape hang freely.
2. Hold a plumb line (thread + small weight) from the same pin, alongside the shape.
3. Mark the line of the plumb string on the shape with a dry-erase marker or tape.
4. Repeat from hanging hole #2.
5. The two lines intersect at the COM.
6. Check: does this match the raised crosshair (if shown)? Can you balance the shape on a pencil tip at that point?

### Pin balancing
1. Place a pencil eraser or the tip of a pushpin flat on a table.
2. Try to balance the shape on the pencil at the COM divot.
3. On the boomerang, the COM divot may be in empty space — use a thin wire bridge or just observe that you cannot balance it from that point on the material.

### Calculation verification
1. For the L-shape or T-shape, calculate the COM using the composite-body formula.
2. Compare with the experimentally found COM.

---

## Things To Notice

- The L-shape's COM is **not** at the visual "middle" — it is pulled toward the thicker arm.
- The T-shape's COM is on the vertical axis of symmetry but lower than you might guess.
- The boomerang's COM can lie **completely outside the material** — profound for students expecting COM to always be inside the object.
- The cross shape is symmetric in both axes, so its COM is trivially at the center — a good starting sanity check.
- Adding mass to one side of a shape shifts the COM toward that side — testable with adhesive putty.

---

## Try Changing These Parameters

| Parameter | Effect |
|-----------|--------|
| `shape_thickness` | Thicker shapes = heavier, easier to balance |
| `show_com_marker` | `false` = challenge mode (COM hidden) |
| `marker_size` | Larger crosshair = easier to see |
| `balancing_notch_diameter` | Match to your pin/pencil tip size |
| `hanging_hole_diameter` | Match to your peg or pushpin diameter |
| Shape dimensions | Modify L/T/offset-rect proportions to create new puzzles |

---

## Related Models

- `10_torque_statics/` — the balance beam finds COM along one axis
- `12_center_of_mass/` — 3D COM extends these 2D ideas
- `05_forces_free_body/` — free-body diagrams reference the COM as force application point
- `11_rotational_dynamics/` — rotation happens around the COM for free objects
