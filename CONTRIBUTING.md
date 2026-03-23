# Contributing to PhysicsSCAD

Thank you for your interest in contributing to PhysicsSCAD. This guide explains what we expect from every contribution and how to structure your work so it fits naturally into the library.

---

## Philosophy

**Every model in PhysicsSCAD must teach something specific.**

Before writing a single line of OpenSCAD, ask yourself:

- What physics concept does this model make visible, tangible, or comparable?
- What would a student do with this model in their hands?
- What would they notice that they could not notice from a diagram alone?
- Does the parametric nature of the model let them explore a relationship (change a variable → see the physics change)?

If you cannot answer all four questions concisely, the model is not ready to be contributed.

We are not building physics-themed art. We are building **teaching manipulatives, reference boards, comparison sets, and concept models** designed to make mechanics feel real to a hands-on learner.

---

## What Models Are NOT Appropriate

Do not open a PR for:

- **Decorative art** that happens to have a physics name (e.g., a printed atom ornament, a wave sculpture, a planetary mobile with no educational structure)
- **Physics buzzword junk** — models that use physics terminology in their name but teach nothing (e.g., "quantum dice", "relativity coaster")
- **Overcomplicated assemblies** that require dozens of printed parts, specialty hardware, or skills beyond standard FDM printing
- **Duplicates** of a model already in the repo without meaningfully different pedagogical purpose
- **Precision instruments** presented as lab-grade — all models are conceptual unless explicitly documented otherwise
- **Demonstration-only models** that a student can only watch, not interact with or manipulate

---

## How to Propose a New Model

Before building, open a GitHub Issue using the following template:

```
## Proposed Model

**Folder:** NN_topic_name (existing or proposed new folder)
**File name:** descriptive_model_name.scad
**One-line summary:** What this model is, in plain language.

## Physics Justification

**Concept taught:** (e.g., "torque depends on perpendicular lever arm distance")
**What makes it tangible:** (what a student can physically do with or observe about this model)
**What they cannot get from a diagram:** (why printing it adds value)
**AP Physics 1 alignment:** (which unit/topic)
**F=ma relevance:** (yes/no and brief explanation)
**FTC robotics relevance:** (yes/no and brief explanation)

## Parametric Value

**What parameters will be exposed?**
**What physical relationship changes when those parameters change?**

## Printability

**Estimated size:** (mm)
**Supports required?** (ideally no)
**Fragile parts?** (ideally none)
```

Maintainers will review proposals and provide feedback before you invest time building. This avoids wasted effort.

---

## File Structure Requirements

### Folder naming

```
NN_topic_name/
```

- `NN` is a two-digit zero-padded number matching the learning sequence (e.g., `10_torque_statics`)
- `topic_name` uses lowercase snake_case
- If you are adding to an existing folder, do not create a new one

### File naming

```
descriptive_snake_case.scad
```

- Use specific, descriptive names: `torque_balance_beam.scad` not `beam.scad`
- Include the key physical concept in the name when it helps
- No abbreviations that require prior knowledge to decode

### Module naming

```
module descriptive_snake_case() { ... }
```

- Modules follow the same naming style as files
- Use names that describe what the module renders physically, not abstractly
- Example: `balance_beam_arm()`, `pivot_post()`, `token_slot()` — not `arm()`, `post()`, `slot()`

---

## Required File Header

Every `.scad` file must begin with this header block:

```openscad
// =============================================================================
// Title:       [Human-readable model name]
// Folder:      [NN_folder_name]
// Physics:     [One-line physics topic]
// Difficulty:  [Beginner | Intermediate | Advanced]
// Print Type:  [Display | Manipulative | Token Set | Reference Board]
// Teaches:     [One sentence: what concept this makes tangible]
// Use Case:    [AP Physics 1 | F=ma | FTC Robotics | General]
// =============================================================================
```

---

## Required Comment Sections

Every `.scad` file must contain the following labeled comment sections, in this order, below the header:

### 1. Parameters

```openscad
// =============================================================================
// Parameters
// =============================================================================
```

All user-adjustable variables go here. Each variable must have:
- A descriptive name (see naming conventions below)
- An inline comment with units and brief description
- A sensible default value

**Bad:**
```openscad
l = 150;   // length
m = 50;    // mass
```

**Good:**
```openscad
beam_length_mm    = 150;   // total beam length, millimeters
token_mass_grams  = 50;    // mass represented by each token, grams
pivot_height_mm   = 20;    // height of pivot post above base, millimeters
```

### 2. Physics Meaning

```openscad
// =============================================================================
// Physics Meaning
// =============================================================================
// Explain WHY the geometry encodes physics. Do not just describe the shape.
// Example:
//   The beam is divided at equal intervals because torque = F × d, and the
//   discrete slots let students test whether 2×force at half-distance balances
//   1×force at full distance. The pivot is at center so the baseline torque
//   from the beam itself is zero.
// =============================================================================
```

This section must explain the physics, not just the geometry. A student reading this section should understand what the model demonstrates and why.

### 3. Learning Notes

```openscad
// =============================================================================
// Learning Notes
// =============================================================================
// What should a student do with this model?
// What should they observe?
// What question should they try to answer?
// What prediction should they make before testing?
// Example:
//   Place a heavy token at position 3. Predict which position(s) a lighter
//   token must go to balance it. Test your prediction. Then try to express
//   the balance condition as an equation.
// =============================================================================
```

### 4. Print Notes

```openscad
// =============================================================================
// Print Notes
// =============================================================================
// Layer height: 0.2 mm recommended
// Supports: not required
// Infill: 20% for display; 40% for classroom handling
// Orientation: print flat (no rotation needed)
// Fragile areas: none
// Special: print multiple token sets in different colors to represent
//          different masses
// =============================================================================
```

### 5. Customization Ideas

```openscad
// =============================================================================
// Customization Ideas
// =============================================================================
// - Change beam_length_mm to 200 for a longer range of positions
// - Change slot_count to 11 to create odd/even symmetry experiments
// - Scale the entire model by 0.5 to print a pocket-sized version
// - Print the beam in one color and the tokens in another
// =============================================================================
```

---

## Per-Folder README Requirements

Every folder must contain a `README.md`. Use this template exactly:

```markdown
# [Folder Name — Human-Readable Topic]

## What This Is

[One or two sentences describing what physical objects are in this folder and what they look like.]

## What It Teaches

[Bullet list of specific physics concepts this folder's models make tangible. Be precise — not "Newton's laws" but "how net force direction determines acceleration direction".]

## Why This Matters

[One paragraph explaining why a hands-on model helps here. What does touching or manipulating this model reveal that a diagram cannot? Connect to real-world context where appropriate.]

## How To Print

| Setting | Recommendation |
|---------|---------------|
| Layer height | 0.2 mm |
| Infill | 15–20% (display) or 40%+ (handled) |
| Walls | 3 perimeters |
| Supports | [Yes / No / Optional] |
| Bed size | [fits standard 220×220 mm] |

[Any additional print notes specific to this folder.]

## How To Use

[Step-by-step instructions for a student using these models as learning tools. Be concrete — describe actions, not goals.]

## Things To Notice

[Bullet list of specific observations a student should make. Frame these as "notice that..." statements.]

## Try Changing These Parameters

[Bullet list of specific parameter changes and what physics relationship they explore. For example: "Change `beam_length_mm` from 150 to 300 — does the balance condition change?"]

## Related Models

[Links or references to other folders/models in the repo that connect to the concepts here.]
```

---

## Code Style

### Indentation

Use **2 spaces** per indent level. No tabs.

### Spacing

Put spaces around operators:

```openscad
// Good
width = base_width + 2 * wall_thickness;

// Bad
width=base_width+2*wall_thickness;
```

### No magic numbers

Every literal value that encodes a physical or design decision must be a named variable:

```openscad
// Bad
translate([0, 0, 5]) cylinder(r = 3, h = 20);

// Good
pivot_radius_mm  = 3;
pivot_height_mm  = 20;
base_thickness_mm = 5;

translate([0, 0, base_thickness_mm])
  cylinder(r = pivot_radius_mm, h = pivot_height_mm);
```

### Modular design

Break models into named modules. Do not write a single monolithic `main()` call. Each physically distinct part should be its own module.

```openscad
module balance_beam_arm()    { ... }
module pivot_post()          { ... }
module base_plate()          { ... }
module token_slot(position)  { ... }

// Assembly
base_plate();
pivot_post();
balance_beam_arm();
```

### Descriptive variable names

Use physics-meaningful names, not single letters:

| Bad | Good |
|-----|------|
| `l` | `lever_arm_length_mm` |
| `m` | `token_mass_grams` |
| `r` | `orbit_radius_mm` |
| `h` | `ramp_height_mm` |
| `t` | `wall_thickness_mm` |
| `n` | `slot_count` |
| `a` | `launch_angle_deg` |

---

## Printability Requirements

- **Bed size:** All models must fit on a 220×220 mm print bed at 1:1 scale. If a model is intentionally oversized, document it clearly and explain why.
- **Supports:** Design models to print without supports. If supports are unavoidable, document exactly where and why, and consider whether a redesign could eliminate them.
- **Wall thickness:** No walls thinner than 1.2 mm. Prefer 2 mm or thicker for any surface that will be handled.
- **Fragile features:** Avoid thin pins, sharp protrusions, or any feature that a student could snap off during normal handling.
- **Layer orientation:** Orient models so the weakest print direction does not align with the direction of expected force during use.

---

## How to Submit a Pull Request

1. **Fork** the repository and create a branch named after your model or feature:
   ```
   git checkout -b add/torque-arm-extended-variant
   ```

2. **Build your model** following all requirements in this guide.

3. **Self-review checklist** before opening a PR:
   - [ ] File header is complete and accurate
   - [ ] All five comment sections are present and substantive
   - [ ] All variables are named descriptively with units in comments
   - [ ] No magic numbers
   - [ ] Model is broken into named modules
   - [ ] Folder README exists and uses the standard template
   - [ ] Model fits 220×220 mm bed
   - [ ] No supports required (or documented if unavoidable)
   - [ ] No walls thinner than 1.2 mm
   - [ ] Physics justification is clear and honest

4. **Open the PR** with a description that includes:
   - What concept this model teaches
   - What a student does with it
   - What parameters are exposed and what physics they explore
   - A screenshot or render of the model (use `openscad --render -o preview.png model.scad` or attach a render from the GUI)

5. **Be responsive to review.** Reviewers will check physics accuracy, code quality, and printability. Expect at least one round of feedback.

---

## Questions and Discussion

If you're unsure whether a model idea is appropriate, open a GitHub Discussion before writing code. It's faster to get feedback on an idea than on a full implementation.

We welcome all skill levels — from first-time OpenSCAD writers to experienced parametric designers. The bar is not technical complexity; it is educational clarity.
