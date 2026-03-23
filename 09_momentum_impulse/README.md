# Momentum & Impulse — Collision Tokens

## What This Is

A hands-on token set for exploring conservation of momentum. The set includes cylindrical
pucks of different masses, a collision lane board with tick marks and a center divider, and
velocity-arrow slots so students can physically slide tokens and observe what happens before
and after a collision.

Main model: **momentum_collision_tokens.scad**

---

## What It Teaches

- **Linear momentum** — p = mv, how mass and velocity combine
- **Conservation of momentum** — total momentum before = total momentum after (closed system)
- **Elastic vs. inelastic collisions** — tokens that stick together vs. bounce
- **Impulse** — J = FΔt = Δp, the change in momentum caused by a force over time
- **Newton's Third Law** — equal and opposite forces during a collision
- **Center-of-mass motion** — how the system COM moves at constant velocity

---

## Why This Matters

Momentum conservation governs everything from car crashes to rocket propulsion to particle
physics. Being able to physically manipulate tokens of different masses on a lane and predict
outcomes before sliding them makes the abstract algebra concrete. Students can set up scenarios,
predict the post-collision velocities on paper, then verify by sliding the tokens.

---

## How To Print

| Part | Suggested settings |
|------|--------------------|
| Mass tokens (all) | 0.2 mm layer height, 20% infill, PLA |
| Lane board | 0.2 mm layer height, 15% infill, PLA; print flat |
| Velocity arrows (optional) | 0.15 mm layer height for detail |

- Print tokens in **two different colors** (e.g., white for "1m" tokens, red for "2m", blue for "3m") so mass differences are immediately visible.
- The lane board fits most 200 mm+ build plates; if your printer is smaller, scale `lane_board_width` down or print two halves and glue them.
- Supports are **not needed** for any part — everything is flat or has gentle overhangs.
- Token labels are raised 0.8 mm — a 0.4 mm nozzle handles them cleanly.

---

## How To Use

### Basic elastic collision
1. Place the lane board on a flat surface.
2. Place a "1m" token at the left end of the lane.
3. Place a second "1m" token at the center (collision point).
4. Give the first token a gentle push.
5. Observe: the first token nearly stops and the second moves forward — classic 1D elastic collision between equal masses.

### Unequal mass collision
1. Replace one token with a "2m" token.
2. Predict on paper: if 1m hits stationary 2m at velocity v, what is each post-collision velocity?
3. Slide the 1m token and observe the result.

### Inelastic collision (tokens stuck together)
1. Use a small piece of adhesive putty between two tokens.
2. Slide one token into the stationary token — they stick and move together.
3. Verify: (m₁v₁) = (m₁+m₂)v_final.

### Impulse exploration
1. Push a token from rest to the tick mark at position 5 in 1 second, then again reaching it in 0.5 seconds.
2. Discuss how the same change in momentum (impulse) is achieved with different forces over different times.

---

## Things To Notice

- After a 1m → 1m elastic collision, does the first token completely stop? (It should, approximately.)
- After a 1m → 2m collision, the heavier token moves slower — momentum is conserved, but notice what happens to kinetic energy.
- In an inelastic collision the combined token is slower than you might expect — where did the energy go?
- The tick marks along the lane let you estimate how far each token travels, which connects to velocity.

---

## Try Changing These Parameters

| Parameter | Effect |
|-----------|--------|
| `light_token_diameter` | Change the 1m token size |
| `heavy_token_diameter` | Adjust the 2m token footprint |
| `token_thickness` | Thicker tokens = more stable sliding |
| `lane_board_width` | Longer board = more room for velocity observations |
| `lane_board_height` | Wider board for 2D collision experiments |
| `velocity_slot_width` | Adjust for thicker arrow-card stock |

---

## Related Models

- `08_energy_work_power/` — kinetic energy before and after connects directly to momentum
- `06_friction_contact/` — lane friction affects whether the ideal conservation law holds
- `02_vectors_components/` — 2D collisions require vector momentum addition
- `07_circular_motion/` — angular momentum is the rotational analogue
