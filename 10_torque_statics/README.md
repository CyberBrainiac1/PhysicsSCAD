# Torque & Statics — Balance Beam

## What This Is

A printable lever-and-fulcrum system for exploring torque, rotational equilibrium, and the
law of the lever. The beam has raised distance tick marks and pegs for hanging mass tokens
at measured positions. A triangular pivot stand (the fulcrum) supports the beam at its center.

Main model: **torque_balance_beam.scad**

---

## What It Teaches

- **Torque** — τ = r × F, how force and distance from pivot combine
- **Rotational equilibrium** — Σ τ = 0 for a balanced beam
- **The law of the lever** — F₁d₁ = F₂d₂ (Archimedes' principle)
- **Center of gravity** — where the beam's own weight acts
- **Mechanical advantage** — how a lever multiplies force
- **Static equilibrium conditions** — both Σ F = 0 and Σ τ = 0

---

## Why This Matters

The lever is one of humanity's oldest simple machines. Every wrench, seesaw, crowbar, and
bicycle brake uses torque. Understanding rotational equilibrium is foundational for
structural engineering, robotics joint design, and biomechanics (think of your forearm as a
lever with your elbow as the pivot). This model makes the algebra of torque physically
testable — students place tokens, predict balance conditions, then verify by letting go.

---

## How To Print

| Part | Suggested settings |
|------|--------------------|
| Balance beam | 0.2 mm layers, 25% infill, PLA; print flat |
| Pivot stand | 0.2 mm layers, 40% infill for stability |
| Mass tokens (×6 or more) | 0.2 mm layers, 100% infill (heavier = better) |

- Print the beam **flat on the build plate** — no supports needed.
- Print **multiple sets of tokens** in different colors to represent different masses (e.g., white = "1" unit, blue = "2" units).
- The pivot stand's knife-edge should face up; use 40%+ infill so it doesn't compress under repeated use.
- A slightly rough print surface on the pivot groove helps prevent the beam from sliding off.
- Total print time for one full set: approximately 2–3 hours on a typical FDM printer.

---

## How To Use

### Basic equilibrium
1. Place the pivot stand on a flat table.
2. Rest the beam on the pivot at its center notch.
3. The beam should balance horizontally by itself (it is symmetric).
4. Hang one "1" token on peg position 3 on the left side.
5. Predict: where must you hang a "1" token on the right to balance? (Answer: position 3.)
6. Verify by releasing the beam.

### Mechanical advantage
1. Hang a "2" token at position 2 on the left (torque = 2 × 2 = 4 units).
2. Predict: where must a single "1" token go on the right to balance? (Answer: position 4.)
3. Verify.

### Multiple tokens
1. Hang tokens at multiple positions on both sides.
2. Calculate: Σ τ_left = Σ τ_right?
3. This extends to real structures with distributed loads.

### Finding the beam's own center of gravity
1. Remove all tokens.
2. Slide the beam sideways on the pivot until it balances — that point is the beam's COM.
3. It should be very close to the geometric center (confirming uniform density).

---

## Things To Notice

- Doubling the distance has the same effect as doubling the mass.
- The beam tips toward the side with greater **total torque**, not greater total mass.
- Even a small token far from the pivot can balance a large token close to the pivot.
- If you add equal tokens at equal distances on both sides, the balance is undisturbed.

---

## Try Changing These Parameters

| Parameter | Effect |
|-----------|--------|
| `beam_length` | Longer beam = more positions, larger torque range |
| `tick_spacing` | Finer marks = more resolution for measurements |
| `peg_height` | Taller pegs = easier to hang tokens |
| `mass_token_diameter` | Larger tokens = easier to label and handle |
| `pivot_base_height` | Taller pivot = more visible tip when out of balance |
| `mass_token_thickness` | Thicker tokens = heavier (with 100% infill) |

---

## Related Models

- `12_center_of_mass/` — COM determines where the beam's weight acts
- `10_torque_statics/` — extends to 2D statics and structural analysis
- `11_rotational_dynamics/` — torque causes angular acceleration (dynamic case)
- `05_forces_free_body/` — free-body diagram for the beam includes the normal force at the pivot
