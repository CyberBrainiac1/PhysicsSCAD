# Circular Motion Disk

Model: `circular_motion_disk.scad`

## What This Is
A disk-based visual aid with radius, tangential direction, and inward acceleration markers.

## What It Teaches
Geometry of circular motion and direction relationships among v, a_c, and net force.

## Why This Matters
Circular motion misconceptions are common and leak into rotation/robotics analysis.

## How To Print
Print flat; use contrasting colors for tangential arrows vs centripetal markers.

## Quick Start
Pick one point on orbit, place tangential velocity arrow, then place inward acceleration arrow.

## How to Learn With This
### Student mode
- Rotate point markers around the disk and keep arrow-direction rules consistent.

### Mentor mode
- Ask “what changes: direction, speed, or both?” at each position.

### Hands-on learning tasks
1. Mark v and a_c at 4 cardinal points.
2. Compare single-radius and multi-radius versions for same angular speed intuition.
3. Build constant-speed circular case vs speeding-up circular case.
4. Use radius markers to discuss how required inward acceleration scales.

## Things to Predict Before Using
- Where does centripetal acceleration point at every location?
- If radius doubles at same speed, does required inward acceleration increase or decrease?
- Can tangential velocity point toward center?

## Challenge Prompts
- Construct two cases with same inward acceleration but different speed/radius combinations.
- Explain why “centrifugal force pushes outward” fails in inertial-frame analysis.

## Explanation Prompts
- Why is acceleration inward even when speed is constant?
- Why are velocity and centripetal acceleration perpendicular for uniform circular motion?

## Common Mistakes / Misconceptions
- Confusing centripetal (center-seeking) with tangential directions.
- Thinking constant speed implies zero acceleration.
- Treating centrifugal as a real interaction force in inertial frames.

## Physics 1 Connection
Uniform circular motion and Newton’s 2nd law in curved paths.

## F=ma Connection
Direction-first reasoning and parameter tradeoffs between v, r, and inward force needs.

## Robotics Connection
Useful for turn-radius planning, wheel slip limits, and drivetrain cornering intuition.

## Related Models
`../11_rotational_dynamics`, `../13_rolling_motion`, `../17_robotics_applications`
