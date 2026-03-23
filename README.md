# PhysicsSCAD

A curated, educational OpenSCAD library for building physical intuition through printable models.

---

## What This Is

**PhysicsSCAD** is a parametric OpenSCAD library of printable physics learning tools.

Every model in this repository answers at least one of these questions:

- What physical idea does this help you **see**?
- What physical idea does this help you **touch**?
- What physical idea does this help you **compare**?
- What physical idea does this help you **measure**?
- What physical idea does this help you **understand**?
- What physical idea does this help you **explain to someone else**?
- What physical idea does this help you **connect to robotics**?

This is not a collection of physics-themed decorations. These are teaching manipulatives, reference boards, comparison sets, and concept models — designed to make mechanics feel real.

---

## Who This Is For

- Advanced high school students studying **AP Physics 1**
- Students preparing for **F=ma** and olympiad-style mechanics
- **FTC robotics** builders who want stronger mechanical intuition
- Self-learners who want tactile, concrete physics models
- Teachers building classroom manipulative sets

**Ideal user:** A motivated high school student who learns better by building and holding things than by staring at diagrams.

---

## Why OpenSCAD?

OpenSCAD generates geometry from code. That means:

- **Every parameter is exposed** — you can change mass ratios, angles, arm lengths, and ramp steepness with a single variable edit.
- **Models are educational by design** — reading the code teaches dimensional thinking and geometric reasoning alongside the physics.
- **Variants are free** — generate a 5-position beam, then change one number and generate a 9-position beam.
- **No mystery geometry** — there are no black-box mesh edits. Every shape is defined by a readable equation or a named measurement.
- **Cheap to iterate** — change a parameter, re-render, re-print. Explore the model space physically.

---

## What Makes This Different

Most physics 3D-print repositories are:
- Physics-themed art
- Decorative geometry
- Disconnected gimmicks
- Promotional demonstrations with no real learning value

**PhysicsSCAD is none of those things.**

Every model is grounded in a specific physics concept, supports a specific learning activity, and is printable on standard hobby hardware. The repo is organized around a mechanics-first learning path aligned with AP Physics 1 and F=ma preparation.

---

## Topic Map

| Folder | Topic |
|--------|-------|
| `01_units_scaling` | Measurement, scale, approximation |
| `02_vectors_components` | Vectors, components, addition |
| `03_kinematics_graphs` | x-t, v-t, a-t graph tiles |
| `04_projectile_motion` | Launch geometry, parabolic paths |
| `05_forces_free_body` | Force identification, FBD boards |
| `06_friction_contact` | Inclines, friction, normal force |
| `07_circular_motion` | Centripetal geometry, orbital direction |
| `08_energy_work_power` | Energy landscapes, height-speed trade |
| `09_momentum_impulse` | Collision tokens, impulse visualization |
| `10_torque_statics` | Balance beams, lever arms, equilibrium |
| `11_rotational_dynamics` | Moment of inertia comparison disks |
| `12_center_of_mass` | COM balancers, stability tools |
| `13_rolling_motion` | Rolling wheel geometry |
| `14_gravitation_orbits` | Orbit template, Kepler intuition |
| `15_fluids_pressure` | Pressure-depth board, buoyancy blocks |
| `16_oscillations_shm` | Pendulum guide, SHM phase disk |
| `17_robotics_applications` | Gear ratios, arm torque, flywheels, stability |
| `18_advanced_electromechanics` | Motor torque-speed, field line plate |

---

## Model Highlights

- **Vector Board** — build and decompose force/velocity vectors on a printed xy-grid
- **Kinematics Graph Tiles** — snap together x-t, v-t, and a-t story boards
- **Projectile Template** — overlay launch angles and parabolic arcs on a printed range guide
- **Friction Ramp Kit** — compare incline angles with printed wedges and textured blocks
- **Torque Balance Beam** — physically balance tokens to discover lever-arm relationships
- **Moment of Inertia Set** — same outer diameter, wildly different spin feel
- **Center of Mass Balancer** — find the balance point of irregular shapes, then check your answer
- **Gear Ratio Board** — visualize input/output rotation with simplified gear disks
- **Arm Torque Board** — see how distance from pivot changes required force
- **Flywheel Energy Disks** — feel the difference between rim-heavy and uniform mass

---

## Suggested Learning Progressions

### AP Physics 1 Path

1. `01_units_scaling` — establish measurement habits
2. `02_vectors_components` — build vector intuition early
3. `03_kinematics_graphs` — learn to read motion graphs
4. `04_projectile_motion` — connect 2D kinematics geometrically
5. `05_forces_free_body` → `06_friction_contact` — Newton's laws and friction
6. `07_circular_motion` — centripetal direction and geometry
7. `08_energy_work_power` → `09_momentum_impulse` — energy and momentum
8. `10_torque_statics` — torque and equilibrium
9. `11_rotational_dynamics` → `12_center_of_mass` — rotation essentials
10. `16_oscillations_shm` — simple harmonic motion

### F=ma Mechanics Path

1. Start with `02_vectors_components` — vector algebra is everything
2. `03_kinematics_graphs` — motion in 1D and 2D
3. `05_forces_free_body` + `06_friction_contact` — force modeling
4. `07_circular_motion` — centripetal acceleration
5. `10_torque_statics` — statics problems
6. `11_rotational_dynamics` + `12_center_of_mass` — rotation
7. `13_rolling_motion` — rolling without slipping
8. `14_gravitation_orbits` — orbital mechanics
9. `16_oscillations_shm` — SHM and oscillations

### FTC Robotics Path

1. `02_vectors_components` — force and velocity decomposition
2. `06_friction_contact` — traction and contact forces
3. `10_torque_statics` — motor torque and arm design
4. `17_robotics_applications` — gear ratios, arm torque, flywheels, stability
5. `11_rotational_dynamics` — flywheel intuition
6. `12_center_of_mass` — robot tipping and stability
7. `18_advanced_electromechanics` — motor curves (optional)

---

## How to Render and Export

### Render a model

```bash
openscad -o output.stl model.scad
```

Or open in the OpenSCAD GUI, press **F6** to render, then **File → Export → Export as STL**.

### Customize parameters

Open any `.scad` file. Near the top you will find a clearly labeled `// Parameters` section. Change values there and re-render.

### Batch export all models in a folder

```bash
for f in *.scad; do openscad -o "${f%.scad}.stl" "$f"; done
```

---

## Recommended Slicer Settings

| Setting | Recommendation |
|---------|---------------|
| Material | PLA |
| Layer height | 0.2 mm (0.15 mm for fine detail) |
| Infill | 15–20% for display models; 40%+ for handled pieces |
| Walls | 3 perimeters minimum |
| Supports | Avoid where possible; models are designed to minimize need |
| Bed size | Most models fit 220×220 mm; oversized models are marked |

See `PRINTING_GUIDE.md` for full print guidance.

---

## How to Contribute

See `CONTRIBUTING.md` for full contribution guidelines.

Quick summary:
- Every model must teach a specific physics concept
- Every model must be printable on standard hobby FDM printers
- Every file must include the standard header and section comments
- Follow `STYLE_GUIDE.md` naming and formatting conventions
- Include a per-folder `README.md` using the standard template

---

## Disclaimer

These are **educational models** intended to help students build physical intuition. They are not lab-grade instruments and should not be used for precision scientific measurement unless explicitly stated in the model notes.

The parametric designs are accurate enough for conceptual demonstrations and qualitative comparisons. For quantitative lab work, use calibrated instruments.

---

## License

MIT License — see `LICENSE` for details.
