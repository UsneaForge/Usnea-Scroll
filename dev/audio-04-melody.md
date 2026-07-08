# Audio 04 — Melody Layer
**tags:** audio, stage-4
**status:** not started

---

## Goal
Take the content characters from the message (letters and numbers, in order) and play them as a slow, looping melodic sequence. This is the inscription itself rendered as sound.

## Design
- **Source data:** all characters in `currentMsg` where `VALID.indexOf(char) <= 35` (a–z and 0–9, indices 1–36)
- **Note duration:** driven by the character's VALID index — low index (common letters) = short note, high index = longer note. Suggested range: `0.8 + (index / 36) * 3.0` seconds
- **Spacing between notes:** `hash(hash(currentMsg))` mapped to a range of ~1.8–4.5 seconds. Same message = same spacing, always.
- **Looping:** when the sequence reaches the last character, it starts again from the first
- **Sound:** triangle wave oscillator, slightly higher gain than the drone (~0.15), with a short fade-out at the end of each note

## What to write
A function `startMelody(message, ctx)` that:
1. Builds the array of content characters and their frequencies + durations
2. Schedules the first note immediately using `ctx.currentTime`
3. After each note finishes, schedules the next one (using `setTimeout`)
4. Loops back to index 0 after the last note

And a matching `stopMelody()` that cancels the pending timeout and stops any playing oscillator.

## Things to figure out
- How do you schedule a callback after a note finishes? (The note plays for X seconds — you want to schedule the next note after X + the inter-note gap)
- How do you store a reference to the current timeout so `stopMelody()` can cancel it?
- What should happen if `startMelody` is called while one is already running? (Stop the old one first.)
