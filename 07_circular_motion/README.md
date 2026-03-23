# Circular Motion

## What This Is

This folder contains 3D-printable visual aids for teaching **uniform circular motion** — the physics of objects moving in circles at constant speed. The main disk shows the key vectors at multiple positions around the orbit, making it clear that the velocity is always tangential and the acceleration always points inward toward the center.

Models in this folder:
- **`circular_motion_disk.scad`** — a flat disk with raised orbit ring, centripetal and tangential arrows at multiple positions, tick marks, and angle labels

## What It Teaches

- Objects moving in a circle are **always accelerating**, even at constant speed, because direction is changing
- The **centripetal acceleration** always points toward the center of the circle: **a_c = v²/r**
- The **velocity is always tangential** — perpendicular to the radius at every point
- Centripetal force is not a new force — it's the name for whatever net force points inward (tension, gravity, normal force, etc.)
- The relationship between period, speed, and radius: **v = 2πr/T**
- The centripetal force equation: **F_c = mv²/r = mω²r**
- Angular velocity **ω** and its relationship to linear speed: **v = ωr**
- Why "centrifugal force" is a fictitious force felt in the rotating reference frame

## Why This Matters

Circular motion underlies planetary orbits, satellite trajectories, car turns, centrifuges, motors, and wheels. Every rotating machine is an application of circular motion physics. The key insight — that centripetal acceleration points inward while velocity points tangentially — is notoriously difficult for students to visualize from diagrams. A physical model makes the geometry undeniable.

## How To Print

| Setting | Recommendation |
|---|---|
| Material | PLA |
| Layer Height | 0.2 mm |
| Infill | 20% |
| Supports | Not required |
| Bed Adhesion | Brim recommended |
| Print Orientation | Flat on bed, face up |
| Estimated Time | ~2–3 hours |

- The raised arrows and labels print cleanly without supports when printed face-up
- Use a high-contrast filament for the raised features (arrows, labels, orbit ring)
- The disk makes an excellent classroom reference object — consider printing at 150% scale for group viewing

## How To Use

1. Print the disk and hold it flat
2. Pick any of the four arrow positions on the orbit ring
3. Identify the **tangential arrow** (labeled "v") — trace your finger along the orbit and notice the arrow points in the direction of travel
4. Identify the **centripetal arrow** (labeled "F_c") — notice it always points toward the center hub
5. Rotate the disk and observe: the arrows at every position follow the same pattern
6. Ask: *"If the string breaks, which way does the object go?"* — along the tangent, not outward

**Discussion questions:**
- Why does the centripetal arrow never point outward?
- If speed doubles, what happens to the centripetal force needed? (×4)
- What provides the centripetal force for: a planet? a car on a curve? a ball on a string?
- What is the direction of net force on the object? Does it match the centripetal arrow?

## Things To Notice

- The **tangent arrows and centripetal arrows are always perpendicular** to each other
- The orbit ring shows the circular path — the arrows sit on this ring
- Tick marks every 30° around the orbit match the angular spacing of a clock (useful for relating to period)
- The hub at the center represents the center of rotation — centripetal arrows always point here
- The angle labels (0°, 90°, 180°, 270°) help connect the geometric position to trigonometric functions

## Try Changing These Parameters

```openscad
orbit_radius = 40;            // Change radius — how does this affect v for same ω?
number_of_positions = 6;      // Show more arrow positions around the orbit
show_tangent_arrows = true;   // Toggle tangential velocity arrows
show_centripetal_arrows = true; // Toggle centripetal force/acceleration arrows
tick_angle_spacing = 45;      // Change tick mark density
disk_radius = 55;             // Overall disk size
```

## Related Models

- `02_vectors_components/vector_arrow_kit.scad` — standalone arrows for constructing diagrams
- `14_gravitation_orbits/orbit_simulator.scad` — gravitational orbits as circular/elliptical motion
- `11_rotational_dynamics/rotational_inertia_disks.scad` — rotating rigid bodies
- `05_forces_free_body/free_body_diagram_board.scad` — identify the centripetal force in an FBD
