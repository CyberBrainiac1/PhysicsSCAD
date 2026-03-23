# PhysicsSCAD Roadmap

This document tracks what has been built, what should come next, and where the library can grow. It is meant to guide contributors toward high-value additions and away from duplication or scope creep.

Everything on this list must still satisfy the core rule: **it must teach something specific**.

---

## 1. Currently Implemented

The following topics and model families are represented in the current library:

| Folder | Topic | Model Highlights |
|--------|-------|-----------------|
| `01_units_scaling` | Measurement, scale, approximation | Unit conversion reference board, scale comparison set |
| `02_vectors_components` | Vectors, components, vector addition | Vector board with pegged arrows, component decomposition template |
| `03_kinematics_graphs` | x-t, v-t, a-t graph interpretation | Snap-together graph tile sets for building motion stories |
| `04_projectile_motion` | Launch geometry, parabolic paths | Projectile range template with overlaid launch angles |
| `05_forces_free_body` | Force identification, FBD practice | Free-body diagram board with removable force arrows |
| `06_friction_contact` | Inclines, friction, normal force | Friction incline wedge kit with textured surface blocks |
| `07_circular_motion` | Centripetal geometry, orbital direction | Centripetal direction disk, orbital path arc |
| `08_energy_work_power` | Energy conservation, height-speed trade | Energy landscape ramp profile, height-speed comparison set |
| `09_momentum_impulse` | Collisions, impulse visualization | Collision token set, impulse-momentum bar comparison |
| `10_torque_statics` | Torque, lever arms, rotational equilibrium | Torque balance beam with token slots, pivot post |
| `11_rotational_dynamics` | Moment of inertia, angular acceleration | MOI comparison disk set (solid, ring, partial-rim) |
| `12_center_of_mass` | COM location, stability | Irregular shape COM balancers, stability wedge |
| `13_rolling_motion` | Rolling without slipping, velocity geometry | Rolling wheel cross-section with contact point marker |
| `14_gravitation_orbits` | Orbital mechanics, Kepler's laws | Orbit ellipse template, Kepler equal-areas board |
| `15_fluids_pressure` | Pressure-depth, buoyancy | Pressure-depth reference board, buoyancy block comparison set |
| `16_oscillations_shm` | SHM, pendulum, phase relationships | Pendulum length comparison guide, SHM phase disk |
| `17_robotics_applications` | Gear ratios, arm torque, flywheels, stability | Gear ratio board, arm torque lever, flywheel energy disks |
| `18_advanced_electromechanics` | Motor torque-speed curves, magnetic field geometry | Motor curve reference board, field line plate |

---

## 2. Next Recommended Builds

These additions are high-value, well-scoped, and align directly with the core AP Physics 1 and F=ma curriculum. They are good starting points for new contributors.

### 2a. Atwood Machine Cross-Section
**Folder:** `05_forces_free_body` or new `05b_newtons_laws`  
A cross-section display model of an Atwood machine showing the string, pulley, and two hanging masses. Expose mass ratio as a parameter. Teaches Newton's second law in a two-body system. Students can see why a larger mass difference produces larger acceleration.

### 2b. Impulse-Momentum Bar Graph Set
**Folder:** `09_momentum_impulse`  
A set of tall rectangular bars (like a physical bar chart) representing momentum before and after collisions. Print pairs in different heights to represent elastic vs. inelastic collisions. Students arrange bars to see which conserve total momentum.

### 2c. Conservation of Energy Ramp Profile Set
**Folder:** `08_energy_work_power`  
A graduated set of ramp cross-section tiles with different heights. Pair each tile with a printed "speed indicator" of matching height to show that height determines speed at the bottom. Exposes the connection between gravitational PE and KE concretely.

### 2d. Normal Force Decomposition Wedge
**Folder:** `06_friction_contact`  
A wedge with vector slots showing the normal force perpendicular to the incline surface, gravity straight down, and the component parallel to the surface. Angles are labeled. Students can see the trigonometric decomposition of forces on an incline as a physical geometry lesson.

### 2e. Projectile Motion Phase Tiles
**Folder:** `04_projectile_motion`  
A set of small tiles each showing one phase of projectile motion: velocity vectors at launch, apex, and landing. Pairs with the existing range template. Teaches that horizontal velocity is constant while vertical velocity changes.

### 2f. SHM Position-Velocity Phase Reference Disk
**Folder:** `16_oscillations_shm`  
A two-layer disk: outer ring shows position through one oscillation cycle; inner disk shows velocity phase-shifted by 90°. Physically rotating the inner disk shows the phase relationship between x(t) and v(t).

### 2g. Friction Coefficient Comparison Blocks
**Folder:** `06_friction_contact`  
A set of blocks with different printed surface textures (smooth, ribbed, crosshatched). Print on the same incline wedge. Students tilt the wedge and observe which block slides first, qualitatively comparing coefficients of static friction.

### 2h. Centripetal Acceleration Direction Spinner
**Folder:** `07_circular_motion`  
A spinning arm with a removable arrow peg. As the arm rotates to different positions, students physically point the arrow toward the center to reinforce that centripetal acceleration always points inward, regardless of position on the circle.

### 2i. Kepler's Second Law Area Sweep Board
**Folder:** `14_gravitation_orbits`  
An ellipse template with printed wedge sectors of equal area at different orbital positions. Students see that the narrow, long sector near aphelion and the wide, short sector near perihelion have the same area — making Kepler's equal-area law physical.

### 2j. Static vs. Kinetic Friction Comparison Ramp
**Folder:** `06_friction_contact`  
A ramp with two channels: one with a block starting from rest (tests static friction) and one with a block already in motion (tests kinetic friction). The different critical angles for each case illustrate μₛ > μₖ physically.

### 2k. Buoyancy Graduated Block Set
**Folder:** `15_fluids_pressure`  
A set of blocks of identical outer dimensions but different wall thicknesses (and thus different densities when printed). Students predict which blocks sink and which float, connecting printed geometry to effective density.

### 2l. Work-Energy Theorem Force Profile Tiles
**Folder:** `08_energy_work_power`  
Profile tiles whose height at each horizontal position represents the force at that position. The "area under" the profile is the work done. Teaches that work = area under F-x curve using a tactile, visual model.

### 2m. Orbital Radius vs. Period Comparison Set
**Folder:** `14_gravitation_orbits`  
A set of concentric orbit rings with radii in Kepler T²∝r³ ratios. Students can directly compare orbital radii and see why the outer orbit takes so much longer, reinforcing Kepler's third law without algebra first.

---

## 3. Advanced Stretch Builds

These builds are appropriate for F=ma competitors, advanced AP students, or contributors with stronger physics or OpenSCAD backgrounds. They involve more complex geometry or multi-concept integration.

### 3a. Rotating Reference Frame Accelerometer Arm
**Folder:** `11_rotational_dynamics` or `17_robotics_applications`  
A rotating arm with a bead track. The bead's equilibrium position at different rotation rates demonstrates the effective centrifugal force in a rotating frame. Advanced students connect this to non-inertial reference frames.

### 3b. Elliptical Orbit Mechanical Orrery
**Folder:** `14_gravitation_orbits`  
A multi-piece model showing two bodies orbiting their shared center of mass, with accurate elliptical paths scaled to a simple ratio (e.g., Jupiter/Earth relative distances). Tests both orbital mechanics understanding and multi-part assembly design.

### 3c. Rolling Without Slipping Constraint Demonstrator
**Folder:** `13_rolling_motion`  
A disk with marked contact point and center. A guide rail constrains the center to move linearly while the disk rolls. Physically shows that v_cm = ωR by letting students measure rotations per unit of linear travel.

### 3d. Coupled Oscillator Spring Board
**Folder:** `16_oscillations_shm`  
A flat board with peg-mount slots for small printed "springs" (flexible torsion bars) connecting two mass pendulums. Demonstrates normal modes: in-phase and out-of-phase oscillations. Advanced SHM / waves connection.

### 3e. Rigid Body Rotation Axis Comparator
**Folder:** `11_rotational_dynamics`  
A single dumbbell shape that can be mounted on three different axis pegs: through center, through end, parallel but offset from center. Students spin it on each axis and feel the dramatically different moments of inertia — a tactile parallel-axis theorem demonstration.

### 3f. Energy Dissipation Ramp with Friction Channel
**Folder:** `08_energy_work_power`  
A ramp with two channels: one smooth, one with printed friction fins. A marble or printed bead rolls down each. The height reached at the bottom shows how much energy friction dissipated. Connects work-energy theorem to friction as a non-conservative force.

### 3g. Gravitational Field Line Density Board
**Folder:** `14_gravitation_orbits`  
A flat board with raised "field lines" radiating from a central mass point, spaced so their surface density represents field strength (1/r²). Students observe that field line density decreases with distance, making inverse-square law geometry physical.

---

## 4. Robotics-Heavy Expansions

These builds are directly relevant to FTC robotics design and connect physics concepts to engineering decisions. Appropriate for `17_robotics_applications` or a future `19_advanced_robotics` folder.

### 4a. Two-Stage Gear Train Board
**Folder:** `17_robotics_applications`  
An extension of the existing gear ratio board showing two stages in series. Students calculate the compound gear ratio and compare to a single-stage equivalent. Teaches why multi-stage gearing is used in FTC drivetrains.

### 4b. Four-Bar Linkage Kinematics Model
**Folder:** `17_robotics_applications`  
A printable four-bar linkage with labeled link lengths. Students move the crank and observe how the coupler path changes. Directly relevant to FTC arm and claw mechanisms. Teaches constraint kinematics without calculus.

### 4c. Torque-Speed Motor Curve Reference Set
**Folder:** `17_robotics_applications` or `18_advanced_electromechanics`  
A set of printed linear "curves" (physical line profiles) representing torque-speed trade-offs for different motor configurations. Teaches the operating point concept: where motor output intersects mechanism demand.

### 4d. Differential Drive Turning Geometry Board
**Folder:** `17_robotics_applications`  
A flat board showing a two-wheel robot with printed arc paths for different left/right speed ratios. Students see how speed differential determines turning radius. Directly applicable to FTC drive coding.

### 4e. Robot Tipping Stability Triangle
**Folder:** `12_center_of_mass` or `17_robotics_applications`  
A robot footprint template showing the support polygon and a movable COM marker. Students place the COM marker at various positions and determine when the robot would tip. Teaches stability directly in the FTC context.

### 4f. Flywheel Energy Storage Comparison Disks
**Folder:** `17_robotics_applications`  
An extended version of the MOI disk set tuned to FTC-scale flywheel shooter design. Disks represent different mass distributions matching real FTC launcher configurations. Teaches why rim-heavy flywheels store more energy at the same rotational speed.

### 4g. Lead Screw Linear Actuator Cross-Section
**Folder:** `17_robotics_applications`  
A cross-section display of a lead screw mechanism showing thread pitch, input rotation, and linear output distance. Exposes pitch as a parameter. Teaches the rotational-to-linear conversion used in FTC linear slides and lifts.

### 4h. Pulley Block-and-Tackle Mechanical Advantage Board
**Folder:** `10_torque_statics` or `17_robotics_applications`  
A side-view board showing a block-and-tackle system with 2, 3, and 4 supporting rope strands. Students trace the force paths and verify that mechanical advantage equals the number of supporting strands. Directly relevant to FTC elevator systems.

---

## 5. Classroom and Outreach Builds

These builds target sets, kits, and boards designed for classroom use, lab activities, or science fair demonstrations. Emphasis on durability, color-coding, and sets that can be distributed to many students simultaneously.

### 5a. Forces Card Deck (Physical)
A set of small flat tokens with force arrows in different directions and magnitudes. Students arrange them on a free-body diagram board to practice force identification. Print in sets of 30 for a classroom of students.

### 5b. Unit Conversion Reference Tile Set
A set of flat tiles, each showing one unit conversion factor (1 m = 100 cm, 1 kg = 1000 g, etc.). Students can assemble them into conversion chains. Suitable for grades 9–10 introduction to SI units.

### 5c. Kinematics Story Board Kit
An expanded version of the existing graph tiles with a base board that holds tiles in sequence. A full classroom kit with multiple copies of each tile shape (positive slope, negative slope, flat, parabola, etc.) for group activities.

### 5d. AP Physics 1 Formula Reference Board
A wall-mountable flat board with embossed key formulas from AP Physics 1. Not a replacement for learning them, but a visual anchor during problem-solving sessions. Large enough to read from across a classroom.

### 5e. "Which One Doesn't Belong?" Comparison Sets
Sets of 4 printed objects where 3 share a physics property and 1 does not (e.g., three objects that would have the same period pendulum and one that would not). Used for classroom discussion starters.

---

## 6. Experimental Builds

These ideas are speculative — interesting in theory, but not yet proven to work as printable educational tools. Contributions welcome, but expect more discussion before merging.

### 6a. Wave Superposition Profile Set
Printable curved tiles representing wave profiles (sine waves of different frequencies and amplitudes). Students physically stack them (or lay them side by side) to visualize superposition. Challenge: ensuring profiles are geometrically accurate enough to be educational.

### 6b. Phase Space Trajectory Boards
Flat boards with embossed phase-space trajectories for a simple harmonic oscillator and a damped oscillator. Abstract concept — may be more confusing than clarifying for AP Physics 1 audience. Better fit for F=ma advanced track.

### 6c. Magnetic Field Topology Plates
Raised-line field maps for common configurations (bar magnet, two parallel wires, solenoid cross-section). Connects to `18_advanced_electromechanics`. Field line geometry must be physically accurate.

### 6d. Normal Mode Standing Wave Nodes Set
Physical models of the first five harmonic standing wave patterns on a string (1 node, 2 nodes, etc.). The wavelength-to-string-length relationship is encoded in the geometry. Challenge: making the wave geometry print cleanly at small scales.

### 6e. Chaotic Double Pendulum Trace Board
A flat board with printed traces of double pendulum paths from slightly different initial conditions. Illustrates sensitive dependence on initial conditions visually. Conceptually compelling but requires care to avoid misrepresenting the physics.

---

## Contribution Priority

If you are unsure where to contribute, the highest-impact areas right now are:

1. **Section 2 (Next Recommended Builds)** — these are well-defined, high-value, and ready for implementation
2. **Folder READMEs** — every existing folder needs a complete `README.md` following the standard template
3. **Section 4 (Robotics Expansions)** — high demand from FTC community and currently under-served
4. **Common library modules** — reusable arrows, labels, grids, and token shapes used across multiple folders

See `CONTRIBUTING.md` for full contribution guidelines.
