# Audio 02 — Pentatonic Mapping
**tags:** audio, stage-2, music-theory
**status:** not started

---

## Goal
Write a function that takes a character's index in `VALID` (1–92) and returns a frequency in Hz that is guaranteed to sound musical. This is the core math that everything else depends on.

## Background
A pentatonic scale has 5 notes per octave. Any combination of pentatonic notes sounds consonant — there are no "wrong" combinations. That's why we use it: the encoding produces arbitrary numbers, and we need those numbers to always sound good.

The five notes in A minor pentatonic are: **A, C, D, E, G**
In Hz (starting from A2 = 110Hz): `110, 130.81, 146.83, 164.81, 196`

Each octave up doubles the frequency. So A3 = 220Hz, A4 = 440Hz, etc.

## What to write
A function `validIndexToFreq(index)` that:
1. Takes a VALID index (1–92)
2. Maps it to one of the 5 pentatonic scale degrees (`index % 5`)
3. Picks an octave from the index (`Math.floor(index / 5) % 3` gives 0, 1, or 2)
4. Returns the corresponding frequency in Hz

## Questions to answer while writing it
- What's the frequency of each of the 5 pentatonic notes at the base octave?
- How do you move up an octave mathematically?
- Test it: what frequency does index 1 give? Index 26? Index 50?

*(Work through the math carefully if you get stuck.)*
