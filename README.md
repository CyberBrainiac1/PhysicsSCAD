# PhysicsSCAD

PhysicsSCAD is a mechanics-first OpenSCAD repository of printable learning tools for AP Physics 1, early F=ma preparation, and FTC-style robotics intuition.

## Who This Is For
- Motivated high school students (especially freshmen/sophomores)
- Physics 1 learners who want tactile intuition
- F=ma beginners building mechanics instincts
- Robotics students who want to connect equations to mechanisms

## Why OpenSCAD for Physics Learning
OpenSCAD encourages parameterized thinking: when learners change one variable and regenerate a model, they directly see how geometry and physical interpretation change together.

## What Makes PhysicsSCAD Different
- One physics idea per object or mini-kit
- Mechanics dominates the collection
- Educational notes are embedded in every model file
- Common helper library keeps geometry and visual language consistent
- Robotics models are included, but kept secondary to core mechanics

## Topic Map (Folders)
1. `01_units_scaling` Units, scale, approximation
2. `02_vectors_components` Vector boards and arrow kits
3. `03_kinematics_graphs` x-t, v-t, a-t graph manipulatives
4. `04_projectile_motion` Launch-angle and trajectory templates
5. `05_forces_free_body` Force placement and FBD reasoning
6. `06_friction_contact` Ramp/contact and friction intuition
7. `07_circular_motion` Radius, tangent, centripetal direction
8. `08_energy_work_power` Height-energy and conservation demos
9. `09_momentum_impulse` Collision lanes and momentum tokens
10. `10_torque_statics` Lever arm and equilibrium kits
11. `11_rotational_dynamics` Moment-of-inertia comparisons
12. `12_center_of_mass` Balancing and COM location challenges
13. `13_rolling_motion` Rolling without slipping visual aids
14. `14_gravitation_orbits` Orbit geometry templates
15. `15_fluids_pressure` Pressure-depth and buoyancy sets
16. `16_oscillations_shm` Pendulum and phase geometry tools
17. `17_robotics_applications` FTC-linked mechanics tools
18. `18_advanced_electromechanics` Small advanced conceptual section


## Interactive Learning Layer
- `INTERACTIVE_LEARNING_GUIDE.md`: how to study actively (Predict -> Manipulate -> Explain).
- `CHALLENGE_SETS.md`: beginner/intermediate/harder model-based prompts by topic.
- `MODEL_ACTIVITY_TEMPLATE.md`: reusable template for future model activity sections.
- Folder READMEs now include Quick Start, prediction prompts, hands-on tasks, misconception checks, and challenge prompts.

## Model Highlights
- Vector Board + Arrow Kit
- Kinematics Graph Tile Set
- Free Body Diagram Board
- Friction Ramp Kit
- Torque Balance Beam
- Moment of Inertia Comparison Set
- FTC Gear Ratio Visualizer

## Suggested Progression
### AP Physics 1
`01 -> 02 -> 03 -> 04 -> 05 -> 06 -> 07 -> 08 -> 09 -> 10 -> 11 -> 12 -> 16 -> 15`

### F=ma Mechanics Prep
`02 -> 05 -> 06 -> 07 -> 08 -> 09 -> 10 -> 11 -> 12 -> 13 -> 14`

### Robotics Learners
`05 -> 10 -> 11 -> 12 -> 17 (+ selected 18 models)`

## How to Render `.scad`
1. Open file in OpenSCAD.
2. Press **F5** for preview or **F6** for CGAL render.
3. Choose desired demo module/preset in the file.

## How to Export STL
- In OpenSCAD: **File -> Export -> Export as STL**
- Export one module at a time for classroom batching.

## Slicer Assumptions
- PLA, 0.2 mm layers
- 0.4 mm nozzle
- 3 perimeters, 15-25% infill for boards
- Most models designed to print with minimal supports

## Contributing
See `CONTRIBUTING.md`, `STYLE_GUIDE.md`, and folder README files for standards.

## Disclaimer
These are educational models and conceptual manipulatives, not certified laboratory instruments unless explicitly labeled otherwise.
