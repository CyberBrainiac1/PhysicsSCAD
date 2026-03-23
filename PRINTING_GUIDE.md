# PhysicsSCAD Printing Guide

This guide covers everything you need to know to successfully print PhysicsSCAD models on a standard consumer FDM 3D printer. All models are designed with practical printability as a hard requirement — not an afterthought.

---

## Default Assumptions

Unless a model's `Print Notes` section specifies otherwise, all models are designed for:

| Assumption | Value |
|------------|-------|
| Material | PLA |
| Bed size | 220×220 mm minimum |
| Nozzle diameter | 0.4 mm |
| Printer type | Standard FDM (Cartesian or CoreXY) |
| Slicer | Any (Cura, PrusaSlicer, Bambu Studio, OrcaSlicer, etc.) |
| Print orientation | As rendered (no rotation required) |
| Supports | Not required for most models |

If you have a different setup, see the notes below for how to adapt.

---

## Layer Height Recommendations

| Model Type | Recommended Layer Height | Notes |
|------------|--------------------------|-------|
| Display models (sit on desk) | 0.2 mm | Standard quality; fast to print |
| Manipulative sets (frequently handled) | 0.2 mm | Prioritize strength over surface finish |
| Models with fine label text | 0.15 mm | Smaller layer height improves text legibility |
| Large display boards | 0.25–0.3 mm | Speed-optimize large flat areas |
| Token sets (small, handled heavily) | 0.2 mm | Consistency across a set matters more than finish |
| Graph tiles (flat snap-together pieces) | 0.2 mm | 0.15 mm if snap features need precision |

**Avoid 0.1 mm layer height** unless you specifically need it for fine text. The added print time is rarely worth it for educational manipulatives, and the part will be handled roughly anyway.

---

## Wall Thickness and Infill

### Wall count (perimeters)

| Use | Minimum Walls |
|-----|---------------|
| Display only (not handled) | 2 perimeters |
| Occasionally handled | 3 perimeters |
| Classroom manipulatives (frequent handling) | 3–4 perimeters |
| Tokens (dropped, stacked, carried in bags) | 4 perimeters |

**For thin-walled models** (e.g., orbit ring arcs, frame structures), the slicer may fill entirely with perimeters regardless of infill setting. This is correct — let it happen.

### Infill percentage

| Use | Infill | Reason |
|-----|--------|--------|
| Display model (sits on a shelf) | 10–15% | Lightweight; shape only needs to hold itself |
| Demonstration model (shown to class) | 15–20% | Light handling; needs to survive being passed around once |
| Student manipulative (used daily) | 35–50% | Must survive repeated drops, stacking, and bag storage |
| Balance beam (torque manipulation) | 40% | Needs consistent mass distribution; avoid hollow sections |
| Token sets | 50–100% | Tokens must have consistent mass; solid fill is ideal |
| Structural connectors | 50%+ | Functional parts under load need density |

### Infill pattern

- **Grid or gyroid** for general use — both are strong and fast
- **Cubic or gyroid** for tokens — more isotropic strength; better for pieces that absorb impacts from all directions
- **Lines or rectilinear** for flat display boards — fastest and sufficient

---

## Support Guidance

**The vast majority of PhysicsSCAD models are designed to print without supports.**

This is a hard design requirement: overhangs are avoided by design, and models are oriented so the natural print direction avoids support-requiring angles.

### When supports ARE noted in a model

If a model's `Print Notes` say supports are required:
- Enable "support on build plate only" first — avoid support touching the model surface where possible
- Use tree supports (PrusaSlicer, OrcaSlicer) to minimize support contact area
- Print support interface layers at 0.1 mm for easier removal

### Common support-free design choices you'll notice

- Arcs are printed as stepped approximations that avoid overhangs
- Hollow cavities are avoided unless accessed from below
- Thin vertical features are designed to be at least 1.5 mm thick
- Channels and slots are oriented to open downward or to the side

If a model you've downloaded requires supports and the `Print Notes` say it shouldn't, open an issue in the repository — it may indicate a slicer-specific problem or a design issue worth fixing.

---

## Scaling Notes

All models are designed at 1:1 scale for standard classroom use. You can scale freely within these guidelines:

### Scaling up (larger prints)

| Scale | Good for | Watch for |
|-------|---------|-----------|
| 1.5× | Large classroom demonstrations | Check bed size; may need to split and glue |
| 2× | Wall displays; visibility from 5m+ | Text may become illegible at thick layer heights; reduce layer height |
| 3× | Science fair display boards | Split print required; plan joints |

For large prints, increase wall count to 4+ perimeters to maintain structural feel.

### Scaling down (smaller prints)

| Scale | Good for | Watch for |
|-------|---------|-----------|
| 0.75× | Compact desk versions | Check text legibility; embossed text may disappear |
| 0.5× | Pocket-sized study models | Thin walls may drop below minimum printable thickness; check before slicing |
| 0.25× | Miniature display sets | Many features will not print cleanly; test first |

**Critical rule for scaling down:** Before printing, check that all walls are at least 1.0 mm thick at the scaled size. In your slicer, look for areas where the slicer shows missing perimeters — this indicates the feature is too thin to print.

### Scaling for different physics models

For models where the parametric geometry represents a physical relationship (like the torque balance beam), scaling the model uniformly preserves the physics relationships — the balance condition is dimensionless. You can safely scale these.

For models where the physical size matters (like pendulum period comparison), do not scale — the geometry encodes the actual physical dimensions being compared.

---

## Durability Notes

### Display models

Intended to sit on a desk, bookshelf, or pegboard. Handled only occasionally (picking up and setting down). Use:
- 15% infill
- 3 perimeters
- 0.2 mm layer height
- PLA is fine

### Classroom manipulatives

Intended to be passed between students, stacked, compared, dropped accidentally. Use:
- 40%+ infill
- 4 perimeters
- 0.2 mm layer height
- PLA works; PETG is better for high-traffic classrooms
- Consider printing 2–3 spares per set (some will be lost or damaged)

### Token sets

Tokens are the most-handled items in the repo. They live in bags, get sorted, dropped, and occasionally thrown. Use:
- 80–100% infill (solid tokens have consistent mass properties — this matters for the physics)
- 4 perimeters
- 0.2 mm layer height
- PLA works; ASA is best for long-term durability

### Reference boards

Flat boards meant to stay in one place and be read from. Handle like display models:
- 15% infill
- 3 perimeters
- 0.25 mm layer height acceptable for faster printing

---

## Printing Classroom Sets

For classroom use, you will often want multiple copies of the same model. A typical classroom set might be:
- 8 copies of a token set (one per student pair)
- 4 copies of a balance beam (one per group of 4)
- 30 copies of a small token (one per student)

### Multi-copy strategies

**Stack multiple copies in slicer:** Import the model file multiple times and arrange on the build plate. Printing 4 at once is usually faster than 4 separate prints (less nozzle travel, fewer heat-up cycles).

**Batch script for many copies:**
```bash
# Render all .scad files in a folder to STL
for f in *.scad; do openscad -o "${f%.scad}.stl" "$f"; done
```

Then import all STLs into your slicer in one session.

### Color coding by filament

Color coding makes classroom management dramatically easier:
- **Different colors for different masses** in token sets (e.g., red = 1 unit, blue = 2 units, yellow = 3 units)
- **Different colors for different teams** when printing group sets
- **Contrasting color for base vs. pieces** (e.g., white balance beam base, colored tokens)
- **Axis color coding** for vector boards (x-axis in one color, y-axis in another)

### Organizing classroom sets

Print a labeled tray or organizer for each set. A flat tray with labeled slots takes one additional print per set but dramatically reduces setup and cleanup time. Label slots with physics quantities where possible (not just "A" and "B").

---

## Special Notes for Token and Manipulative Sets

### Consistent mass in tokens

When tokens are meant to represent mass (as in the torque balance beam), **print at 100% infill** and use identical settings for all tokens in a set. Mass consistency is physics-critical here. Even small differences in infill produce measurable mass variation.

Verify your token set with a kitchen scale before using it for physics activities. A well-printed 100% infill PLA token should have consistent mass within ±1%.

### Flat bottom surfaces

Tokens and manipulatives that stack or balance must have flat, clean bottom surfaces. Use:
- Smooth PEI, glass, or textured sheet (your preference — all work)
- No brim on tokens (brim adds a flange that affects stacking and seating in slots)
- First layer at 0.25 mm for better adhesion without over-squish

### Snap and friction fits

Graph tiles and other snap-together pieces rely on dimensional accuracy. For best results:
- Use 0.2 mm layer height (not 0.3 mm — thicker layers reduce XY dimensional accuracy)
- Calibrate your printer's XY scaling if snap fits are too loose or too tight
- Print a single tile pair as a test before printing a full set

---

## Bed Adhesion Tips

PLA on a clean, room-temperature PEI sheet works reliably for all models in this repo:
- **Wipe the bed** with isopropyl alcohol before each session
- **No glue stick needed** for PLA on PEI — it can actually make removal harder
- **First layer temperature:** 215°C nozzle, 60°C bed is a reliable starting point for PLA
- **Brim:** Use a 3–5 mm brim for tall narrow pieces (e.g., pivot posts, arrow shafts). Not needed for flat models.

For ABS or ASA (higher-traffic classroom use):
- Enclosed printer recommended
- 235–245°C nozzle, 100–110°C bed
- Brim of 5+ mm to prevent warping on large flat boards

---

## Post-Processing Notes

### Removing brim/skirt

Use flush cutters and a hobby knife. A light pass with 400-grit sandpaper smooths any brim remnants on flat surfaces.

### Improving label legibility

- Embossed (sunken) labels: wipe a contrasting color paint over the surface and immediately wipe off — paint stays in the recesses and makes text pop
- Raised labels: lightly sand raised letters with 600-grit and paint the raised surface only

### Sanding and finishing

Most PhysicsSCAD models do not need sanding. If you want a cleaner surface for display:
- Start with 220-grit, finish with 400-grit
- Do not sand any surface that is a reference dimension (balance beam slots, grid spacings)

### Joining large models

For models printed in sections (large display boards, extended beam sets):
- Use cyanoacrylate (CA glue) for permanent joins
- Use friction/press fits with a thin bead of CA for semi-permanent joins
- Sand mating surfaces flat before gluing

---

## Recommended Printer Hardware

All models are designed to print on consumer-grade FDM printers. Tested on and known to work well with:
- Prusa MK3S / MK4
- Bambu Lab P1S / X1C
- Creality Ender 3 series (with proper bed leveling)
- Any printer with a 220×220 mm or larger bed

No specialty hardware is required. Dual extrusion is not needed (but can be used for color-coded models if you have it).
