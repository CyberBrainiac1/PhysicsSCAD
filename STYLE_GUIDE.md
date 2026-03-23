# PhysicsSCAD Style Guide

This guide defines the coding, naming, commenting, and documentation conventions for every file in this repository. Consistent style makes models easier to read, remix, and use in the classroom.

---

## Repository Philosophy

PhysicsSCAD models are **educational artifacts first and printable geometry second.**

A student or teacher should be able to open any `.scad` file and immediately understand:
- What physics concept this model demonstrates
- What the named variables represent physically
- What they should do with the printed object
- How to adjust the model to explore a related variation

Code that is clever but opaque fails this test. Code that is slightly verbose but immediately clear succeeds. **Prefer clarity over cleverness at every decision point.**

---

## File Naming Conventions

### `.scad` files

```
descriptive_snake_case.scad
```

- All lowercase
- Words separated by underscores
- Name should describe the physical object or concept, not the abstract geometry
- Include the key teaching concept when it helps distinguish the file

| Bad | Good |
|-----|------|
| `beam.scad` | `torque_balance_beam.scad` |
| `disk.scad` | `moment_of_inertia_disk_set.scad` |
| `ramp.scad` | `friction_incline_wedge.scad` |
| `model1.scad` | `projectile_range_template.scad` |
| `v2.scad` | `pendulum_length_guide.scad` |

### Folders

```
NN_topic_name/
```

- Two-digit zero-padded prefix: `01`, `02`, ..., `18`
- Lowercase snake_case topic name
- Prefix reflects the recommended learning order

### READMEs and documentation

- `README.md` — one per folder, required
- Follow the standard per-folder template exactly (see below)

---

## Module Naming Conventions

```openscad
module descriptive_snake_case() { ... }
module descriptive_snake_case(parameter) { ... }
```

- Describe the physical part rendered, not an abstract geometric operation
- Use the same vocabulary as the physics topic being taught

| Bad | Good |
|-----|------|
| `arm()` | `balance_beam_arm()` |
| `post()` | `pivot_post()` |
| `make_slot(n)` | `token_slot(position_index)` |
| `draw()` | `friction_block()` |
| `thing(r, h)` | `flywheel_disk(radius_mm, thickness_mm)` |

Module parameters follow the same descriptive naming rules as variables (see below).

---

## Variable Naming Conventions

**Use physics-meaningful names. Never use single-letter variable names.**

Include units in the variable name when the variable has physical dimensions:

```openscad
// Good — intent is unambiguous
beam_length_mm       = 150;
pivot_height_mm      = 20;
token_mass_grams     = 50;
launch_angle_deg     = 30;
orbit_radius_mm      = 80;
ramp_height_mm       = 40;
wall_thickness_mm    = 2;
slot_count           = 9;    // dimensionless counts need no unit suffix
slot_spacing_mm      = 15;
```

```openscad
// Bad — ambiguous, requires context to decode
l  = 150;
h  = 20;
m  = 50;
a  = 30;
r  = 80;
t  = 2;
n  = 9;
s  = 15;
```

### Unit suffix conventions

| Suffix | Meaning |
|--------|---------|
| `_mm` | millimeters |
| `_deg` | degrees |
| `_grams` | grams (for token/mass labels) |
| `_ratio` | dimensionless ratio |
| `_count` or plain noun | dimensionless integer |

### Boolean flags

Use positive-assertion names:

```openscad
show_labels       = true;
include_base_plate = true;
show_grid_lines   = false;
```

Not:
```openscad
no_labels   = false;   // confusing double negative
hide_base   = false;   // confusing
```

---

## Required File Header Format

Every `.scad` file must begin with this exact header block as the first non-blank content:

```openscad
// =============================================================================
// Title:       [Human-readable model name]
// Folder:      [NN_folder_name]
// Physics:     [One-line physics topic — the concept, not the object]
// Difficulty:  [Beginner | Intermediate | Advanced]
// Print Type:  [Display | Manipulative | Token Set | Reference Board]
// Teaches:     [One sentence: what physical idea this makes tangible]
// Use Case:    [AP Physics 1 | F=ma | FTC Robotics | General | All]
// =============================================================================
```

**Difficulty definitions:**
- **Beginner** — single concept, straightforward geometry, usable in isolation
- **Intermediate** — relates two or more concepts, requires some context to use
- **Advanced** — multi-concept, targets F=ma or FTC audiences, may require explanation to use

**Print Type definitions:**
- **Display** — meant to sit on a desk or be held briefly; handled gently
- **Manipulative** — meant to be picked up, stacked, slid, or repeatedly handled
- **Token Set** — a collection of small identical or graduated pieces used together
- **Reference Board** — a flat plate or board with printed labels or grids

---

## Required Comment Sections

Every `.scad` file must contain all five of the following comment sections, in this order, immediately after the header and before any code:

### Section 1: Parameters

```openscad
// =============================================================================
// Parameters
// =============================================================================
```

All user-adjustable variables must be declared here. Requirements:
- One variable per line
- Inline unit comment for every dimensioned variable
- No magic numbers anywhere else in the file — if a value encodes a design or physics decision, it belongs here with a name

### Section 2: Physics Meaning

```openscad
// =============================================================================
// Physics Meaning
// =============================================================================
// [Explain WHY the geometry encodes the physics. Describe what relationship
//  the physical dimensions represent. Connect dimensions to equations where
//  natural. Do not just describe the shape — explain what the shape means.]
//
// Example (torque beam):
//   The beam slots are spaced at equal intervals of slot_spacing_mm.
//   Placing a token at position n represents a torque of:
//     τ = F × (n × slot_spacing_mm)
//   where F is the weight of the token. When both sides balance,
//   the torques are equal: F₁d₁ = F₂d₂.
//   The model makes this equation tangible — balance IS the equation.
// =============================================================================
```

**How to write this section:**
- Reference the relevant physics equation(s)
- Explain what each geometric dimension represents in that equation
- Describe what happens physically when a parameter changes
- Write for a student who has seen the equation but may not have physical intuition for it

### Section 3: Learning Notes

```openscad
// =============================================================================
// Learning Notes
// =============================================================================
// [Describe what a student should do, observe, and think about when using
//  this printed model. Frame as a sequence of activities where possible.]
//
// Example:
//   1. Place a single token at position 6. Predict where a single token on
//      the other side must go to balance. Test your prediction.
//   2. Replace one token with two stacked tokens. Does your balance equation
//      still predict the correct position?
//   3. Can you balance three tokens on one side against one on the other?
//      What equation do you use?
// =============================================================================
```

**How to write this section:**
- Write specific, actionable steps — not vague goals
- Include at least one prediction task ("predict before testing")
- Include at least one open-ended exploration
- Connect the activity to a physics equation or relationship

### Section 4: Print Notes

```openscad
// =============================================================================
// Print Notes
// =============================================================================
// Layer height:  0.2 mm recommended; 0.15 mm for fine label text
// Supports:      Not required
// Infill:        20% for display; 40% for classroom handling
// Walls:         3 perimeters minimum
// Orientation:   Print flat (longest face down); no rotation needed
// Fragile areas: None
// Color tip:     Print beam in one color, tokens in a contrasting color
//                to visually distinguish mass vs. distance
// =============================================================================
```

**How to write this section:**
- Always specify layer height, support status, infill, orientation
- Note any fragile areas and how to handle them
- Include color-coding tips for classroom sets where appropriate

### Section 5: Customization Ideas

```openscad
// =============================================================================
// Customization Ideas
// =============================================================================
// - Set slot_count = 13 to create an extended range of positions
// - Set beam_length_mm = 200 for a classroom demonstration version
// - Set show_labels = false to print a clean version for assessment use
// - Scale to 0.5× for a pocket-sized version of the model
// - Print a 3× version as a wall display
// =============================================================================
```

---

## Presets

For models with multiple common configurations, define named preset blocks at the top of the Parameters section:

```openscad
// --- Preset: Standard Classroom Set ---
beam_length_mm  = 150;
slot_count      = 9;
token_diameter_mm = 18;

// --- Preset: Pocket Version (uncomment to use) ---
// beam_length_mm  = 80;
// slot_count      = 7;
// token_diameter_mm = 12;

// --- Preset: Large Display (uncomment to use) ---
// beam_length_mm  = 250;
// slot_count      = 11;
// token_diameter_mm = 25;
```

Use block comments to make it obvious that only one preset should be active at a time.

---

## Code Formatting Standards

### Indentation

**2 spaces per indent level. No tabs.**

```openscad
// Good
module pivot_post() {
  cylinder(
    r = pivot_radius_mm,
    h = pivot_height_mm,
    $fn = 32
  );
}

// Bad
module pivot_post() {
    cylinder(r=pivot_radius_mm,h=pivot_height_mm,$fn=32);
}
```

### Spaces around operators

```openscad
// Good
total_width = beam_length_mm + 2 * end_cap_mm;
offset = (slot_count - 1) / 2 * slot_spacing_mm;

// Bad
total_width=beam_length_mm+2*end_cap_mm;
offset=(slot_count-1)/2*slot_spacing_mm;
```

### One statement per line

```openscad
// Good
translate([x_offset, 0, 0])
  rotate([0, 0, angle_deg])
    token_slot(slot_index);

// Bad
translate([x_offset,0,0]) rotate([0,0,angle_deg]) token_slot(slot_index);
```

### Argument alignment (optional but encouraged for readability)

```openscad
cylinder(
  r  = orbit_radius_mm,
  h  = orbit_ring_thickness_mm,
  $fn = 64
);
```

---

## Module Structure

Break every model into named modules. The top level of the file should read like an assembly list, not a blob of geometry calls.

**Required structure:**

```openscad
// [header]
// [parameter section]

// ---- Modules ----

module part_one() {
  // ...
}

module part_two() {
  // ...
}

module assembly() {
  part_one();
  translate([0, 0, some_offset]) part_two();
}

// ---- Render ----
assembly();
```

**Rules:**
- Every physically distinct part gets its own module
- The final assembly module(s) call part modules only — no raw geometry at top level
- Module order: smallest/simplest parts first, assembly last

---

## Using the `/common` Library

The `common/` folder contains shared utility modules used across the repo. Always `use` rather than `include` to avoid variable namespace collisions:

```openscad
use <../common/labels.scad>
use <../common/grid_base.scad>
use <../common/arrow.scad>
```

### Available common modules (example conventions)

| Module file | Purpose |
|-------------|---------|
| `labels.scad` | Embossed or raised text labels |
| `grid_base.scad` | Flat grid plate with optional tick marks |
| `arrow.scad` | Parametric 3D arrow for force/velocity vectors |
| `token.scad` | Standard token shapes for manipulative sets |

When adding a new utility that would be useful across multiple folders, add it to `common/` rather than duplicating it.

---

## Per-Folder README Template

Every folder must contain a `README.md` using this exact template:

```markdown
# [Folder Name — Human-Readable Topic]

## What This Is

[One or two sentences describing what physical objects are in this folder.]

## What It Teaches

- [Specific concept 1]
- [Specific concept 2]
- [Specific concept 3]

## Why This Matters

[One paragraph: why does a physical model help here? What does holding or 
manipulating this reveal that a diagram cannot? Optional: real-world context.]

## How To Print

| Setting | Recommendation |
|---------|---------------|
| Layer height | 0.2 mm |
| Infill | 15–20% (display) or 40%+ (handled) |
| Walls | 3 perimeters |
| Supports | No |
| Bed size | Fits 220×220 mm |

## How To Use

[Step-by-step student activity. Be concrete and specific.]

## Things To Notice

- Notice that ...
- Notice that ...
- Notice that ...

## Try Changing These Parameters

- `parameter_name` — what physics this changes
- `parameter_name` — what physics this changes

## Related Models

- `../NN_folder/` — why it connects
```

---

## Physics Accuracy Standard

Models must be physically honest:

- **Proportions must reflect the physics.** If a model shows that a longer lever arm reduces required force, the proportions must actually demonstrate this — not just suggest it loosely.
- **Labels must be correct.** Any engraved units, axis labels, or quantity names must match standard physics convention (SI units preferred; US customary with clear labels if used).
- **Do not overstate precision.** Models are conceptual unless explicitly documented as measurement tools. Do not label a printed model as a "precision instrument."
- **Equations in comments must be correct.** If you write a physics equation in a `Physics Meaning` comment, verify it.

---

## Summary Checklist

Before submitting any `.scad` file, verify:

- [ ] Standard header block present and complete
- [ ] Parameters section: all variables named descriptively with unit comments
- [ ] Physics Meaning section: explains the physics, not just the geometry
- [ ] Learning Notes section: specific student activities included
- [ ] Print Notes section: layer height, supports, infill, orientation all specified
- [ ] Customization Ideas section: at least 3 concrete suggestions
- [ ] No magic numbers in geometry code
- [ ] 2-space indentation throughout
- [ ] Spaces around all operators
- [ ] Model broken into named modules
- [ ] Folder README present and uses standard template
- [ ] Model fits 220×220 mm bed
- [ ] Physics is accurate and proportions are honest
