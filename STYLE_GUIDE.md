# PhysicsSCAD Style Guide

## Repository Philosophy
PhysicsSCAD is a curated educational toolkit. Models should be teachable, printable, and parameterized, not decorative.

## Naming Conventions
- Folders: `NN_topic_name`
- Files: `descriptive_snake_case.scad`
- README per folder: `README.md`

## Module Naming
- Use `snake_case` for modules, e.g. `vector_board()`.
- Use `demo_default()`, `demo_compact()`, `demo_classroom()`, `demo_large()` when relevant.

## Variable Naming
- Descriptive `snake_case` names: `board_size`, `grid_spacing`, `axis_thickness`.
- Avoid single-letter parameters except local loop indices.

## Required File Header
Every major `.scad` must begin with:
- Title
- Folder
- Physics Topic
- Difficulty
- Print Type
- Teaches
- Use Case

## Parameter Block Format
Near top of file:
- grouped by board geometry, markings, options, and tolerance
- comments for units (mm, degrees)

## Comment Standards
Include explicit sections:
- Parameters
- Physics Meaning
- Learning Notes
- Print Notes
- Customization Ideas

## Documentation Standards
Each folder README must include:
1. What This Is
2. What It Teaches
3. Why This Matters
4. How To Print
5. How To Use
6. Things To Notice
7. Try Changing These Parameters
8. Related Models

## Presets
Expose at least one preset module and make default render obvious at bottom of file.

## Physics Meaning Notes
State the physical correspondence (e.g., arrow length = magnitude, slot distance = lever arm).

## Learning Notes
Give 3-5 prompts that can be used by a student or mentor.

## Print Notes
Mention orientation, supports, durability limits, and classroom batching advice.
