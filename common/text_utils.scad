// =============================================================================
// text_utils.scad — Text helper modules for PhysicsSCAD
// =============================================================================
// Reusable raised and engraved text modules for adding labels, axis annotations,
// and multi-line explanatory text to physics educational models.
//
// Usage:
//   include <../common/text_utils.scad>;
//
// Modules:
//   raised_text     — embossed (positive) text geometry
//   engraved_text   — recessed text shape for use in difference()
//   axis_label      — single-character axis or variable label
//   multi_line_text — block of multiple text lines spaced vertically
// =============================================================================

// -----------------------------------------------------------------------------
// raised_text
// Raised (embossed) text geometry extruded upward in +Z.
// Place directly on a surface at Z = surface_height.
// Text is centred on the origin in XY by default.
//
// Parameters:
//   label_text — string to render
//   size       — character height (mm)
//   height     — extrusion height above placement surface (mm)
//   font       — OpenSCAD font string (name:style=Style)
// -----------------------------------------------------------------------------
module raised_text(
  label_text = "F",
  size       = 5,
  height     = 0.8,
  font       = "Liberation Sans:style=Bold"
) {
  linear_extrude(height = height)
    text(label_text, size = size,
         halign = "center", valign = "center",
         font = font);
}

// -----------------------------------------------------------------------------
// engraved_text
// Recessed text shape suitable for use inside a difference() call.
// Produces the same geometry as raised_text but intended to be subtracted
// from a solid to create an inset label.
//
// Parameters:
//   label_text — string to engrave
//   size       — character height (mm)
//   depth      — how deep the engraving cuts into the surface (mm)
//   font       — OpenSCAD font string
// -----------------------------------------------------------------------------
module engraved_text(
  label_text = "F",
  size       = 5,
  depth      = 0.5,
  font       = "Liberation Sans:style=Bold"
) {
  // Add a tiny Z offset so the cutter breaks cleanly through the surface
  translate([0, 0, -0.1])
    linear_extrude(height = depth + 0.1)
      text(label_text, size = size,
           halign = "center", valign = "center",
           font = font);
}

// -----------------------------------------------------------------------------
// axis_label
// Convenience wrapper for a single raised character used as an axis or
// variable label (e.g. "x", "F", "v", "θ").
// Centred on the origin in XY.
//
// Parameters:
//   label_text — single character (or short string) to display
//   size       — character height (mm)
//   height     — extrusion height (mm)
// -----------------------------------------------------------------------------
module axis_label(
  label_text = "x",
  size       = 4,
  height     = 0.8
) {
  raised_text(
    label_text = label_text,
    size       = size,
    height     = height,
    font       = "Liberation Sans:style=Bold Italic"
  );
}

// -----------------------------------------------------------------------------
// multi_line_text
// Block of raised text with multiple lines, stacked downward in -Y.
// The first element of lines[] is the topmost line.
// The entire block is centred horizontally on the origin.
//
// Parameters:
//   lines        — list (vector) of strings, one per line
//   size         — character height for each line (mm)
//   line_spacing — centre-to-centre vertical distance between lines (mm)
//   height       — extrusion height (mm)
// -----------------------------------------------------------------------------
module multi_line_text(
  lines        = ["Force", "= ma"],
  size         = 3.5,
  line_spacing = 5,
  height       = 0.8
) {
  total_height = (len(lines) - 1) * line_spacing;

  for (i = [0 : len(lines) - 1]) {
    // Start at top, step down by line_spacing for each subsequent line
    y_pos = total_height / 2 - i * line_spacing;

    translate([0, y_pos, 0])
      linear_extrude(height = height)
        text(lines[i], size = size,
             halign = "center", valign = "center",
             font = "Liberation Sans");
  }
}
