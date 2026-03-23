# Forces & Free Body Diagrams

## What This Is

This folder contains 3D-printable tools for teaching and learning **free body diagrams (FBDs)** — the cornerstone skill of Newtonian mechanics. The main model is a physical board that holds labeled force arrows around a central object, letting students physically assemble diagrams rather than just drawing them.

Models in this folder:
- **`free_body_diagram_board.scad`** — the main FBD board with a central object and directional arrow slots
- **`incline_fbd.scad`** *(TODO)* — a variant board pre-tilted at a ramp angle with rotated axis labels

## What It Teaches

- What a free body diagram represents and why we draw them
- The difference between contact forces (normal, friction, tension) and field forces (gravity/weight)
- That every force has a direction — represented by arrows pointing away from the object
- Newton's First Law: when all forces balance (net force = 0), the object is in equilibrium
- Newton's Second Law: a net force causes acceleration in the same direction
- How to identify which forces act in which direction for a given physical scenario
- Standard physics notation: **W** or **F_g** for weight, **N** for normal force, **f** for friction, **T** for tension, **F_app** for applied force

## Why This Matters

Free body diagrams are used in every branch of engineering and physics. A student who cannot draw a correct FBD cannot solve force problems. Making a *physical* board forces students to make deliberate choices — "what forces act on this object?" — rather than copying from a textbook. The slots accept arrow pegs (see `02_vectors_components/vector_arrow_kit.scad`) so students can build real diagrams.

## How To Print

| Setting | Recommendation |
|---|---|
| Material | PLA |
| Layer Height | 0.2 mm |
| Infill | 20% |
| Supports | Not required |
| Bed Adhesion | Brim recommended (large flat part) |
| Print Orientation | Flat on bed (face up) |
| Estimated Time | ~2–3 hours |

- Print the board face-up so the raised labels and slots come out cleanly
- Use a contrasting filament color for the force arrows if printing a set
- The `object_style = "circle"` variant works well as a "puck" for lab demonstrations

## How To Use

1. Print the board and a set of force arrows (pegs) from `vector_arrow_kit.scad`
2. Place the board on the table — the raised object in the center represents the body being analyzed
3. Present a physical scenario: *"A book sits on a table"* or *"A box is pushed across the floor"*
4. Ask students to select which arrows to insert and which slots to use
5. Discuss: Is the diagram in equilibrium? Which direction is the net force?
6. Rotate or tilt the scenario and repeat

**Scenarios to try:**
- Book resting on a table (Normal up, Weight down — balanced)
- Box sliding to the right (Applied force right, Friction left, Normal up, Weight down)
- Hanging mass on a rope (Tension up, Weight down — balanced)
- Car accelerating forward (Engine/applied force forward, friction/drag backward)

## Things To Notice

- The **weight arrow always points straight down** regardless of the surface angle
- The **normal force is always perpendicular to the contact surface**, not necessarily straight up
- Friction **opposes the direction of motion** (or potential motion), not the applied force
- When an object is in equilibrium, every arrow has an equal and opposite partner
- The object in the center is treated as a **point mass** — its shape and size don't matter for the force diagram

## Try Changing These Parameters

```openscad
board_size = 120;         // Make larger for classroom display
object_style = "circle";  // Switch between "block", "circle", "puck"
object_size = 25;         // Scale the central object
slot_count = 8;           // Number of directional slots (4 = cardinal only)
incline_angle = 30;       // Tilt the whole board to simulate a ramp scenario
show_labels = true;       // Toggle force labels on/off for quiz mode
```

## Related Models

- `02_vectors_components/vector_arrow_kit.scad` — arrow pegs that fit the slots on this board
- `06_friction_contact/friction_ramp_kit.scad` — ramp system where FBD skills are applied
- `10_torque_statics/torque_balance_beam.scad` — static equilibrium with torques
- `05_forces_free_body/incline_fbd.scad` *(TODO)* — pre-angled board for incline problems
