# Audio 03 — Drone Layer
**tags:** audio, stage-3
**status:** not started

---

## Goal
Extract the boundary characters from the current message and play them as a slow, sustained chord. This is the harmonic foundation — it sets the mood of the piece and changes with every message.

## Design
- **Source data:** boundary characters (`.!?;,`) found in `currentMsg`
- **How many notes:** deduplicate them — if the message has three periods, that's still one drone note
- **Mapping:** each boundary char → `VALID.indexOf(char)` → `validIndexToFreq()` from stage 2
- **Sound:** one oscillator per note, sine wave, very low gain (~0.05), no sharp attack/release — fade in slowly using a `GainNode`
- **Slow tremolo:** a second low-frequency oscillator (~0.1Hz) modulating the gain gives it a breathing quality

## What to write
A function `startDrone(message, ctx)` that:
1. Finds all unique boundary chars in the message
2. Creates one oscillator + gain node per note
3. Connects them to the AudioContext destination
4. Starts them all (they run indefinitely until stopped)

And a matching `stopDrone()` that disconnects and stops them cleanly.

## Things to figure out
- How do you iterate over a string in JS and check if a character is in a Set?
- How do you fade a gain in over time instead of switching it abruptly? (Hint: `gain.gain.linearRampToValueAtTime`)
- What happens if the message has no boundary characters? Make sure the function handles that gracefully.
