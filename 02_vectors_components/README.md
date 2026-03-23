# 02 — Vectors & Components

## What This Folder Contains

This folder provides physical, printable tools for teaching **vector
decomposition, addition, and direction** — the geometric backbone of all
AP Physics 1 mechanics topics. Two complementary models work together:

| File | Description |
|------|-------------|
| `vector_board.scad` | Flat grid board with raised axes, quadrant labels, and angle marks — the "playing surface" |
| `vector_arrow_kit.scad` | Set of detachable arrows in three lengths plus a right-triangle component piece |

## What It Teaches

- Representing vectors as directed quantities with magnitude and direction
- Decomposing a vector into perpendicular x and y components using trigonometry
  (Fx = F cos θ, Fy = F sin θ)
- Adding vectors graphically (tip-to-tail) and component-wise
- Reading angles from the standard position (measured from positive x-axis)
- The four quadrants and how component signs change in each
- How a right triangle embodies the Pythagorean theorem connecting magnitude
  and components

## Why This Matters

### AP Physics 1
Vectors appear in every mechanics unit: displacement, velocity, acceleration,
force, momentum. Students who cannot decompose vectors reliably struggle with
Newton's second law in two dimensions, circular motion, and projectile motion.
The board gives a hands-on, kinaesthetic alternative to graph-paper sketches.

### F=ma
Many F=ma problems hinge on recognising which component of a force does work or
causes acceleration along a given axis. Physical arrow pieces make this selection
concrete and memorable.

### FTC Robotics
Robot motion is inherently 2-D. Drive train kinematics (holonomic drives,
mecanum wheels) use vector decomposition to compute wheel speeds. Building the
intuition early with physical pieces pays dividends when students write motion
code.

## How To Print

### Vector Board (`vector_board.scad`)
- **Orientation:** flat on bed, no supports needed
- **Layer height:** 0.2 mm
- **Infill:** 15–25 % (decorative, not structural)
- **Material:** white or light grey PLA recommended so the raised grid reads clearly
- **Estimated time:** ~45–60 min at 60 mm/s

### Vector Arrow Kit (`vector_arrow_kit.scad`)
- Use `print_set()` module to export a single plate with all pieces arranged
- **Orientation:** flat on bed
- **Layer height:** 0.15 mm for sharper peg features
- **Infill:** 40 % for peg strength
- **Material:** any colour; use one colour per arrow length to distinguish magnitudes,
  or use a second colour for the component triangle
- **Tip:** print 2–3 sets per lab group so students can represent multiple vectors simultaneously

## How To Use

1. Print one vector board and one arrow kit per lab group.
2. Place an arrow on the board with its tail at the origin.
3. Read the angle from the raised degree marks.
4. Use the component triangle to visualise x and y components.
5. Add two arrows tip-to-tail to find a resultant vector.
6. Rotate the board — notice how the components change but the arrow itself does not.

## Things To Notice

- Short arrow ≈ 1 unit, medium ≈ 2 units, long ≈ 3.5 units (relative magnitudes)
- The degree tick marks are at 0°, 30°, 45°, 60°, 90° — the "nice" angles of trig
- Quadrant II has a negative x-component and positive y-component — check the signs!
- The hypotenuse of the component triangle equals the vector's magnitude

## Try Changing These Parameters

| Parameter | What changes |
|-----------|-------------|
| `board_size` | Make a larger board for whole-class demos |
| `grid_spacing` | Finer grid for more precise angle reading |
| `slot_width` | Adjust to match your specific filament/printer for snug arrow pegs |
| `short_length` / `medium_length` / `long_length` | Change vector magnitude ratios |

## Related Models

- **[01_units_scaling](../01_units_scaling/README.md)** — the reference tile helps
  interpret the axis scale on the vector board
- **[04_projectile_motion](../04_projectile_motion/README.md)** — projectile arcs
  are the result of combining a horizontal and vertical vector
- **[05_forces_free_body](../05_forces_free_body/README.md)** — free body diagrams
  are vector diagrams; the arrow kit works directly with force boards
