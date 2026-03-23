# PhysicsSCAD Common Library

Reusable OpenSCAD helper modules shared across the PhysicsSCAD educational model collection. These files provide consistent geometry primitives—arrows, axes, labels, grids, and more—so individual model files stay focused on the physics concept rather than low-level geometry.

---

## How to use

In any `.scad` file within this repository, include the helpers you need with a relative path:

```scad
include <../common/arrows.scad>;
include <../common/labels.scad>;
include <../common/geometry_utils.scad>;
```

Then call any module by name:

```scad
color("red")
  translate([0, 0, 0])
    arrow_2d(length=30, shaft_width=2, head_length=6, head_width=6, thickness=2);

label_plate(label_text="F = ma", plate_width=30, plate_height=10);
```

All modules are self-contained; include only the files you need.

---

## File reference

### `arrows.scad`
Arrow geometry for representing vectors, forces, and velocities.

| Module | Description |
|---|---|
| `arrow_2d(length, shaft_width, head_length, head_width, thickness)` | Flat extruded arrow pointing in +X; shaft origin at `[0,0]` |
| `arrow_3d(length, shaft_diameter, head_length, head_diameter)` | Cylindrical arrow along +Z axis |
| `double_arrow_2d(length, shaft_width, head_length, head_width, thickness)` | Double-headed arrow for dimension lines, centred on origin |
| `curved_arrow_2d(radius, angle_deg, shaft_width, head_length, head_width, thickness)` | Arc arrow sweeping from 0° to `angle_deg` for rotational quantities |

---

### `axes.scad`
Coordinate axis sets and quadrant labels.

| Module | Description |
|---|---|
| `axis_2d(x_len, y_len, shaft_width, tick_spacing, tick_length, thickness)` | x-y axis pair with tick marks, centred on origin |
| `axis_3d(x_len, y_len, z_len, shaft_diameter)` | 3D xyz axes with end cap disks |
| `axis_labels_2d(x_len, y_len, label_size, thickness)` | ±x and ±y raised text labels at axis ends |
| `quadrant_labels(size, label_size, thickness)` | I / II / III / IV quadrant labels |

---

### `ticks.scad`
Tick mark sets and angle arc indicators.

| Module | Description |
|---|---|
| `tick_marks_linear(length, spacing, tick_length, tick_width, thickness)` | Evenly spaced ticks along the +X axis |
| `numbered_tick_marks(count, spacing, tick_length, tick_width, number_size, thickness)` | Ticks with numeric labels underneath |
| `radial_ticks(radius, spacing_deg, tick_length, tick_width, thickness)` | Ticks distributed around a full circle |
| `angle_arc(radius, angle_deg, shaft_width, thickness)` | Filled arc ring sector from 0° to `angle_deg` |

---

### `labels.scad`
Embossed text plates and annotation objects.

| Module | Description |
|---|---|
| `label_plate(label_text, plate_width, plate_height, plate_thickness, text_size, text_depth)` | Rectangular plate with raised text |
| `label_tag(label_text, tag_width, tag_height, tag_thickness, text_size, hole_diameter)` | Hanging tag with mounting hole |
| `physics_unit_plate(value_text, unit_text, plate_width, plate_height, thickness)` | Two-line value + unit label plate |
| `direction_label(label_text, arrow_length, text_size, thickness)` | Short arrow with text label at tail |

---

### `grids.scad`
Grid bases, dot arrays, slots, and pegs for token boards and graphs.

| Module | Description |
|---|---|
| `grid_plate(width, height, spacing, line_width, plate_thickness, line_height)` | Base plate with raised orthogonal grid lines |
| `grid_plate_with_border(width, height, spacing, line_width, plate_thickness, border_width)` | Grid plate with a solid perimeter border |
| `dot_grid(width, height, spacing, dot_diameter, plate_thickness, dot_height)` | Base plate with a regular stud/dot array |
| `slot_array(count, spacing, slot_width, slot_length, slot_depth, base_thickness)` | Row of rectangular slots for token/arrow cards |
| `peg_array(count, spacing, peg_diameter, peg_height, base_thickness)` | Row of cylindrical pegs for hanging tokens |

---

### `dimension_helpers.scad`
Technical annotation geometry: dimension lines, angle marks, and crosshairs.

| Module | Description |
|---|---|
| `dimension_line(len, thickness, end_tick_height, line_thickness)` | Horizontal dimension line with perpendicular end ticks |
| `angle_indicator(radius, angle_deg, arc_width, thickness)` | Arc with end marks indicating an angle |
| `right_angle_mark(size, line_width, thickness)` | Square corner symbol (first quadrant, rotate as needed) |
| `center_mark(size, line_width, thickness)` | Crosshair centre indicator |
| `circular_marker(radius, ring_width, thickness)` | Thin ring highlighting a circle or radius |

---

### `geometry_utils.scad`
General-purpose 3D primitives for physics models.

| Module | Description |
|---|---|
| `rounded_plate(width, height, thickness, corner_radius)` | Rectangle with rounded corners |
| `hexagonal_prism(circumradius, height)` | Regular hexagonal prism |
| `regular_polygon_prism(sides, circumradius, height)` | Regular n-sided polygon prism |
| `ring(outer_radius, inner_radius, height)` | Hollow cylinder / washer |
| `sector(radius, angle_deg, height)` | Pie-slice sector prism |
| `parabola_profile(width, height, thickness, resolution)` | Parabolic arc cross-section plate |
| `isosceles_triangle_prism(base, height, thickness)` | Triangular ramp prism |

---

### `cutout_utils.scad`
Negative-space cutout shapes for use inside `difference()`.

| Module | Description |
|---|---|
| `oval_cutout(width, height, depth)` | Stadium-shaped oval cutout |
| `arrow_cutout(length, shaft_width, head_length, head_width, depth)` | Arrow-shaped through-hole |
| `text_cutout(label_text, text_size, depth)` | Text-shaped cutout (engraved negative text) |
| `slot_cutout(slot_width, slot_length, depth, corner_radius)` | Rounded rectangular slot |
| `keyhole_cutout(circle_diameter, slot_width, slot_length, depth)` | Keyhole mount cutout for panel hanging |

---

### `text_utils.scad`
Raised and engraved text primitives.

| Module | Description |
|---|---|
| `raised_text(label_text, size, height, font)` | Embossed text on a surface |
| `engraved_text(label_text, size, depth, font)` | Recessed text for use in `difference()` |
| `axis_label(label_text, size, height)` | Single variable/axis label in bold italic |
| `multi_line_text(lines, size, line_spacing, height)` | Multi-line raised text block |

---

## Conventions

- All modules default to `$fn = 32` or `$fn = 64` for smooth circles.
- 2-space indentation throughout.
- Parameters always have sensible defaults so modules can be called with no arguments for quick prototyping.
- Arrows point in **+X** (2D) or **+Z** (3D) by default — use `rotate()` in your scene.
- Grid and slot origins are at the **bottom-left corner** of the plate; axis origins are **centred**.
- Cutout modules (`cutout_utils.scad`) add a small `0.1 mm` Z offset so Boolean operations render cleanly in OpenSCAD preview.
