# PhysicsSCAD Curriculum Map

This map connects every folder and model in PhysicsSCAD to the curriculum topics most relevant to AP Physics 1, F=ma mechanics preparation, and FTC robotics engineering.

Use this map to:
- Find models that support a specific topic you are teaching or studying
- Build a coherent learning sequence across multiple folders
- Identify gaps where new models would be most valuable

---

## Tag Definitions

| Tag | Meaning |
|-----|---------|
| `AP1-core` | Directly addresses a core AP Physics 1 topic |
| `F=ma-useful` | Adds value for F=ma / olympiad mechanics preparation |
| `robotics-relevant` | Has direct application to FTC or competitive robotics |
| `conceptual` | Primarily teaches physical intuition, not calculation |
| `manipulable` | Designed to be physically handled, rearranged, or stacked |
| `graph-based` | Involves graph reading, graph building, or graph interpretation |
| `advanced` | Appropriate for advanced students; may require extra context |

---

## Learning Phases

---

### Phase 1: Foundations

These folders build the mathematical and perceptual tools needed for all of mechanics. They are appropriate as the very first physical models a student encounters.

---

#### `01_units_scaling` — Measurement, Scale, and Approximation

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Unit conversion reference board | Measurement; SI unit system | Dimensional analysis | Sensor units, encoder counts | `AP1-core` `conceptual` `manipulable` |
| Scale comparison tile set | Orders of magnitude; estimation | Fermi estimation | Mechanism sizing and scaling | `AP1-core` `conceptual` |

**AP Physics 1 alignment:**
- Big Idea 1: Objects and systems have properties such as mass and charge
- Science Practice 2: Use mathematics appropriately (dimensional analysis)

**F=ma alignment:**
- Dimensional analysis is a required skill throughout the exam
- Fermi estimation problems appear in olympiad problem sets

**FTC robotics alignment:**
- Unit conversions appear constantly in FTC code (encoder counts per revolution, mm per tick)
- Scaling intuition helps when sizing mechanisms to fit the robot

---

#### `02_vectors_components` — Vectors, Components, and Addition

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Vector board with pegged arrows | Vectors; vector addition; components | Vector algebra; decomposition | Force analysis on robot mechanisms | `AP1-core` `F=ma-useful` `manipulable` |
| Component decomposition template | Trigonometric decomposition; Pythagoras | 2D force resolution | Arm force analysis at different angles | `AP1-core` `F=ma-useful` `conceptual` |

**AP Physics 1 alignment:**
- All force, velocity, and acceleration quantities are vectors
- Component decomposition is foundational for projectile motion and inclined planes

**F=ma alignment:**
- Vector algebra is the primary mathematical language of mechanics
- 2D problems require fluent decomposition into perpendicular components

**FTC robotics alignment:**
- Mecanum drive requires vector decomposition for strafing and diagonal motion
- Arm and linkage force analysis requires resolving forces along and perpendicular to links

---

#### `03_kinematics_graphs` — Kinematics Graph Interpretation

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| x-t graph tiles | Position-time relationships; slope = velocity | Graphical kinematics | Autonomous path planning | `AP1-core` `graph-based` `manipulable` |
| v-t graph tiles | Velocity-time; slope = acceleration; area = displacement | Graphical kinematics | Velocity profiling for smooth motion | `AP1-core` `F=ma-useful` `graph-based` `manipulable` |
| a-t graph tiles | Constant vs. changing acceleration | Non-constant acceleration | Motor acceleration profiles | `AP1-core` `F=ma-useful` `graph-based` `manipulable` |

**AP Physics 1 alignment:**
- Kinematics is Unit 1 of AP Physics 1
- Graph interpretation is one of the most frequently assessed skills on the AP exam
- Snap-together tiles let students build consistent motion stories across all three graph types

**F=ma alignment:**
- Graphical kinematics problems are common in olympiad style
- Converting between graph representations (x-t ↔ v-t ↔ a-t) is a core skill

**FTC robotics alignment:**
- Trapezoidal velocity profiles for FTC autonomous motion come directly from v-t graph reading
- Understanding a-t graphs helps with motor ramping in autonomous code

---

#### `04_projectile_motion` — Projectile Motion and Launch Geometry

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Projectile range template | 2D kinematics; independence of x/y motion | Projectile range equation | Game piece launching (FTC shooters) | `AP1-core` `F=ma-useful` `robotics-relevant` `conceptual` |
| Launch angle overlay set | Range vs. angle; complementary angle symmetry | Optimization of range | Flywheel shooter angle selection | `AP1-core` `F=ma-useful` `robotics-relevant` `conceptual` |

**AP Physics 1 alignment:**
- Projectile motion is typically the first 2D kinematics problem type
- The template makes horizontal/vertical independence visual and physical

**F=ma alignment:**
- Projectile problems with launch off heights, inclines, and multiple launches are common
- Range optimization (45° for flat ground, different angles for elevated targets) appears frequently

**FTC robotics alignment:**
- FTC games frequently involve launching rings, disks, or balls at targets
- Predicting launch angle and flywheel speed requires projectile intuition

---

### Phase 2: Newton's Laws

These folders develop force intuition, Newton's three laws, and the geometry of contact forces.

---

#### `05_forces_free_body` — Force Identification and Free-Body Diagrams

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Free-body diagram board | Identifying forces; Newton's first and second laws | Force analysis on systems | Arm load analysis; robot on ramp | `AP1-core` `manipulable` `conceptual` |
| Removable force arrow set | Force direction and magnitude representation | Free-body diagrams for complex systems | Joint force identification | `AP1-core` `F=ma-useful` `manipulable` |

**AP Physics 1 alignment:**
- Free-body diagrams are required on virtually every AP Physics 1 free-response problem
- Force identification (what forces act, which pairs are Newton's third law pairs) is core content

**F=ma alignment:**
- Complex multi-body problems require systematic force identification
- FBD practice directly reduces errors in olympiad problem-solving

---

#### `06_friction_contact` — Inclines, Friction, and Normal Force

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Friction incline wedge kit | Normal force; friction force; net force on incline | Static and kinetic friction; angle of repose | Ramp climbing; wheel traction | `AP1-core` `F=ma-useful` `robotics-relevant` `manipulable` |
| Textured surface friction blocks | Coefficient of friction; surface dependence | μₛ vs. μₖ; friction as constraint | Wheel-surface traction coefficient | `AP1-core` `manipulable` `conceptual` |
| Normal force decomposition wedge | Force component geometry; perpendicular vs. parallel | Vector decomposition on incline | Arm contact force analysis | `AP1-core` `conceptual` |

**AP Physics 1 alignment:**
- Friction on inclines is among the most common AP Physics 1 problem types
- The normal force perpendicular to the surface (not vertical) is a persistent student misconception

**F=ma alignment:**
- Problems with friction, multiple surfaces, and blocks on wedges are F=ma staples
- Angle of repose and static friction limit problems appear regularly

**FTC robotics alignment:**
- Wheel traction and robot pushing force depend directly on normal force and friction coefficient
- Ramp climbing requires predicting whether friction is sufficient

---

#### `07_circular_motion` — Centripetal Acceleration and Orbital Direction

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Centripetal direction disk | Centripetal acceleration always points inward; direction at each point | Centripetal force analysis | Robot turning; flywheel | `AP1-core` `conceptual` `manipulable` |
| Orbital path arc | Speed vs. radius in circular orbit; centripetal vs. gravitational | Circular orbit condition | Flywheel rim speed | `AP1-core` `F=ma-useful` `conceptual` |

**AP Physics 1 alignment:**
- Centripetal acceleration direction is a persistent misconception (students often say "outward")
- The centripetal direction disk makes the inward direction undeniable at every orbit position

**F=ma alignment:**
- Non-uniform circular motion, banking angles, and vertical circles are common olympiad topics
- The orbital arc helps with radius-vs-period intuition needed for gravitation problems

**FTC robotics alignment:**
- Robot turning in autonomous involves centripetal geometry
- Flywheel rim speed = ω × r is the circular motion relationship most relevant to FTC launchers

---

### Phase 3: Energy and Momentum

These folders connect force and motion to energy and momentum, and introduce rotational statics.

---

#### `08_energy_work_power` — Energy Conservation, Work, and Power

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Energy landscape ramp profile | Conservation of energy; KE-PE trade-off | Energy methods vs. force methods | Motor power output; elevator energy | `AP1-core` `F=ma-useful` `conceptual` |
| Height-speed comparison set | Speed at bottom of ramp as function of height | Energy conservation with height | Arm drop speed prediction | `AP1-core` `conceptual` `manipulable` |
| Work-energy force profile tiles | Work = area under F-x curve | Work by variable force | Motor torque-speed integration | `AP1-core` `F=ma-useful` `graph-based` |

**AP Physics 1 alignment:**
- Energy methods are often faster than force methods for AP exam problems
- The energy landscape makes conservation physical: going uphill slows down, going downhill speeds up

**F=ma alignment:**
- Energy methods are preferred in olympiad problems with complex paths or non-constant forces
- Work by variable force (area under F-x curve) appears regularly

**FTC robotics alignment:**
- Motor power determines how fast a robot can lift a heavy arm
- Energy conservation predicts whether a falling arm has enough energy to complete a motion

---

#### `09_momentum_impulse` — Collisions and Impulse

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Collision token set | Conservation of momentum; elastic vs. inelastic | Coefficient of restitution; oblique collisions | Robot-robot contact in matches | `AP1-core` `F=ma-useful` `manipulable` |
| Impulse-momentum bar comparison | Impulse = change in momentum; J = FΔt | Impulse approximation; collision forces | Motor startup impulse; bumper design | `AP1-core` `manipulable` `conceptual` |

**AP Physics 1 alignment:**
- Momentum conservation is always valid in collisions (unlike energy)
- The token set makes it physical: arrange tokens before and after, verify momentum is conserved

**F=ma alignment:**
- Oblique collisions and center-of-mass frame analysis appear in olympiad problems
- Impulse approximation (large force, short time) is a key F=ma technique

**FTC robotics alignment:**
- Robot-robot pushing matches involve momentum and impulse
- Bumper compliance changes the collision impulse and peak force on mechanisms

---

#### `10_torque_statics` — Torque, Lever Arms, and Rotational Equilibrium

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Torque balance beam | τ = F × d; rotational equilibrium; lever arm | Static equilibrium of extended bodies | Arm joint torque; motor selection | `AP1-core` `F=ma-useful` `robotics-relevant` `manipulable` |
| Token slot set | Discrete force positions; F₁d₁ = F₂d₂ | Torque balance with multiple forces | Counterweight placement | `AP1-core` `manipulable` `conceptual` |
| Pulley mechanical advantage board | Mechanical advantage; tension in rope | Constraint analysis with pulleys | FTC elevator and pulley systems | `AP1-core` `F=ma-useful` `robotics-relevant` `conceptual` |

**AP Physics 1 alignment:**
- Torque and rotational equilibrium are Unit 7 of AP Physics 1
- The balance beam is perhaps the single most powerful manipulative in the repo

**F=ma alignment:**
- Statics problems with multiple forces and torques are common
- Pulley systems with multiple constraints are F=ma staples

**FTC robotics alignment:**
- Every FTC arm has a joint torque that must be calculated to select the right motor and gear ratio
- Counterweights reduce the effective torque and motor requirement

---

### Phase 4: Rotation and Beyond

These folders address the full rotational mechanics curriculum plus oscillations and fluids.

---

#### `11_rotational_dynamics` — Moment of Inertia and Angular Acceleration

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| MOI comparison disk set | I depends on mass distribution; α = τ/I | Parallel axis theorem; MOI of composite shapes | Flywheel design; wheel selection | `AP1-core` `F=ma-useful` `robotics-relevant` `manipulable` |
| Solid disk vs. ring vs. partial rim | Same mass and radius, different I; feel the difference | MOI formulas for standard shapes | Rim-loaded vs. uniform flywheel | `AP1-core` `conceptual` `manipulable` |
| Rotation axis comparator | Parallel axis theorem demonstrated physically | Moment of inertia about non-CM axes | Rotating arm with off-axis load | `F=ma-useful` `advanced` `manipulable` |

**AP Physics 1 alignment:**
- Rotational dynamics (α = τ/I) is the rotational analog of Newton's second law
- The disk set makes it undeniable that distribution matters, not just total mass

**F=ma alignment:**
- Calculating MOI for composite shapes is a standard F=ma problem type
- The parallel axis theorem is tested explicitly and via application

**FTC robotics alignment:**
- Flywheel energy storage depends on MOI: E = ½Iω²
- Rim-loaded wheels store more energy at the same RPM — physically demonstrable with the disk set

---

#### `12_center_of_mass` — COM Location and Stability

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Irregular shape COM balancers | COM as balance point; COM of composite shapes | COM calculation for irregular shapes | Robot stability analysis | `AP1-core` `F=ma-useful` `robotics-relevant` `manipulable` |
| Stability wedge | Support polygon; tipping condition | Static stability with extended contact base | Robot tipping risk analysis | `AP1-core` `robotics-relevant` `conceptual` `manipulable` |

**AP Physics 1 alignment:**
- Center of mass determines the pivot point for rotation and the balance condition
- COM of composite shapes is a required calculation skill

**FTC robotics alignment:**
- A robot tips when its COM leaves the support polygon (footprint between wheels)
- Calculating robot COM position helps predict tipping risk when extending arms or lifters

---

#### `13_rolling_motion` — Rolling Without Slipping

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Rolling wheel cross-section | v_cm = ωR; contact point velocity = 0 | Rolling constraint; energy of rolling | Drive wheel behavior; traction | `AP1-core` `F=ma-useful` `robotics-relevant` `conceptual` |
| Rolling vs. sliding comparison | Friction in rolling; kinetic vs. static friction roles | Energy split between translation and rotation | Wheel slip in FTC drivetrains | `AP1-core` `F=ma-useful` `robotics-relevant` `conceptual` |

**AP Physics 1 alignment:**
- Rolling without slipping is one of the most conceptually tricky topics in AP Physics 1
- The contact point has zero velocity — this surprises students every time

**F=ma alignment:**
- Rolling with slipping and the transition to rolling without slipping is a common olympiad problem
- Energy of rolling = ½mv² + ½Iω² is required knowledge

**FTC robotics alignment:**
- FTC drive wheels operate in the rolling-without-slipping regime (usually)
- Understanding when wheels slip (and how to prevent it) is directly applicable to drivetrain design

---

#### `14_gravitation_orbits` — Orbital Mechanics and Kepler's Laws

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Orbit ellipse template | Kepler's first law; ellipse geometry; foci | Orbital energy; escape velocity | Not directly applicable | `AP1-core` `F=ma-useful` `conceptual` |
| Kepler equal-areas board | Kepler's second law; angular momentum conservation | Conservation of angular momentum | Arm angular momentum | `AP1-core` `F=ma-useful` `advanced` `conceptual` |
| Orbital radius vs. period set | Kepler's third law; T²∝r³ | Deriving Kepler's third law from Newton's law | Not directly applicable | `AP1-core` `F=ma-useful` `conceptual` |

**AP Physics 1 alignment:**
- Gravitation and orbits are Unit 8 of AP Physics 1
- Kepler's laws are tested conceptually, not just with calculations

**F=ma alignment:**
- Orbital mechanics including energy, angular momentum, and Kepler's laws appear in F=ma
- Escape velocity and circular orbit condition are standard F=ma problem types

---

#### `15_fluids_pressure` — Pressure, Depth, and Buoyancy

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Pressure-depth reference board | P = P₀ + ρgh; pressure increases with depth | Hydrostatic pressure; Pascal's law | Pneumatic actuators (indirectly) | `AP1-core` `conceptual` |
| Buoyancy block comparison set | Archimedes' principle; buoyant force | Buoyancy and density | Subsurface robot components | `AP1-core` `conceptual` `manipulable` |

**AP Physics 1 alignment:**
- Fluids statics is a distinct topic in AP Physics 1 (pressure, buoyancy, continuity)
- The buoyancy blocks make Archimedes' principle tangible: same volume, different weight

---

#### `16_oscillations_shm` — Simple Harmonic Motion and Pendulums

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Pendulum length comparison guide | T = 2π√(L/g); period depends on length not mass | SHM derivation; small angle approximation | Vibration in mechanisms | `AP1-core` `F=ma-useful` `conceptual` `manipulable` |
| SHM phase disk | x(t) and v(t) are 90° out of phase; energy oscillates | Phase space; x-v phase portrait | Resonance in FTC mechanisms | `AP1-core` `F=ma-useful` `advanced` `manipulable` |
| SHM position-velocity reference disk | Relationship between position, velocity, and energy in SHM | Amplitude and energy in SHM | Not directly applicable | `AP1-core` `F=ma-useful` `conceptual` |

**AP Physics 1 alignment:**
- SHM is Unit 6 of AP Physics 1; pendulums and springs are the two canonical examples
- The period independence of mass (for pendulums) surprises students

**F=ma alignment:**
- SHM, damping, and driven oscillations are common olympiad topics
- Phase relationships between x, v, and a in SHM are tested

---

### Phase 5: Robotics Extension

These folders apply the physics of Phases 1–4 directly to engineering design contexts.

---

#### `17_robotics_applications` — Gear Ratios, Arm Torque, Flywheels, Stability

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Gear ratio board | Torque-speed trade-off; rotational kinematics | Mechanical advantage with rotating systems | Motor and gearbox selection | `AP1-core` `robotics-relevant` `manipulable` |
| Arm torque lever | τ = F × d; torque at different arm positions | Static torque balance | Arm motor torque requirement | `AP1-core` `robotics-relevant` `manipulable` |
| Flywheel energy disks | I and E = ½Iω²; rim vs. solid mass distribution | Rotational kinetic energy | FTC launcher flywheel design | `AP1-core` `F=ma-useful` `robotics-relevant` `manipulable` |
| Robot stability triangle | Support polygon; COM position for stability | Static stability criterion | Robot tipping prediction | `AP1-core` `robotics-relevant` `conceptual` `manipulable` |

**FTC robotics alignment — all models in this folder are directly applicable:**
- Gear ratio selection is the first engineering decision in every FTC drivetrain
- Arm torque calculation determines whether a motor is strong enough
- Flywheel design determines launcher ring exit speed
- Stability analysis predicts when the robot tips during field operations

---

### Phase 6: Advanced Topics

These folders target advanced AP students, F=ma competitors, and students with strong algebra/calculus backgrounds.

---

#### `18_advanced_electromechanics` — Motor Physics and Field Geometry

| Model | AP Physics 1 Topics | F=ma Topics | FTC Application | Tags |
|-------|--------------------|-----------|-----------------|----|
| Motor torque-speed curve reference board | Power = τω; torque-speed trade-off | Not core F=ma | Motor operating point selection | `advanced` `robotics-relevant` `graph-based` |
| Magnetic field line plate | Field line geometry; field strength and density | Not core F=ma | Brushless motor intuition | `advanced` `conceptual` |

**AP Physics 1 alignment:**
- Magnetism is not in AP Physics 1 but is referenced in the context of motors and electromechanics
- The motor curve connects rotational mechanics (already covered) to electrical engineering

**FTC robotics alignment:**
- Every FTC robot uses DC motors; understanding the torque-speed curve is essential for motor selection
- Operating point concept: the motor runs where torque demand intersects the motor curve

---

## Cross-Reference by Physics Skill

### Models for understanding vectors and force decomposition
- `02_vectors_components` — vector board, decomposition template
- `05_forces_free_body` — FBD board, force arrow set
- `06_friction_contact` — normal force decomposition wedge
- `07_circular_motion` — centripetal direction disk

### Models for energy methods
- `08_energy_work_power` — energy landscape, work-force tiles
- `11_rotational_dynamics` — rotational KE via disk comparison
- `13_rolling_motion` — translational + rotational energy in rolling
- `17_robotics_applications` — flywheel energy disks

### Models for angular momentum and rotation
- `10_torque_statics` — torque balance beam
- `11_rotational_dynamics` — MOI comparison disks
- `12_center_of_mass` — COM balancers
- `13_rolling_motion` — rolling wheel cross-section
- `17_robotics_applications` — gear ratio board, flywheel disks

### Models most relevant to F=ma olympiad preparation
- `02_vectors_components` — vector algebra
- `06_friction_contact` — friction problems
- `07_circular_motion` — circular motion geometry
- `10_torque_statics` — statics problems
- `11_rotational_dynamics` — MOI and rotational dynamics
- `13_rolling_motion` — rolling constraint problems
- `14_gravitation_orbits` — orbital mechanics
- `16_oscillations_shm` — SHM and oscillations

### Models most relevant to FTC robotics
- `06_friction_contact` — traction and contact
- `10_torque_statics` — arm torque and motor selection
- `11_rotational_dynamics` — flywheel design
- `12_center_of_mass` — robot stability
- `17_robotics_applications` — entire folder
- `18_advanced_electromechanics` — motor curve

---

## AP Physics 1 Unit Coverage Summary

| AP Physics 1 Unit | Primary Folders | Secondary Folders |
|-------------------|----------------|-------------------|
| Unit 1: Kinematics | `03`, `04` | `02` |
| Unit 2: Forces and Newton's Laws | `05`, `06` | `02`, `07` |
| Unit 3: Circular Motion and Gravitation | `07`, `14` | `04` |
| Unit 4: Energy | `08` | `13` |
| Unit 5: Momentum | `09` | `08` |
| Unit 6: Simple Harmonic Motion | `16` | `12` |
| Unit 7: Torque and Rotational Motion | `10`, `11`, `12`, `13` | `17` |
| Unit 8: Electric Charge and Force | — | — |
| Unit 9: DC Circuits | — | — |
| Unit 10: Mechanical Waves | — | `16` (SHM foundation) |
| Fluids (supplemental) | `15` | — |
