# Audio 05 — Wiring Into the Game
**tags:** audio, stage-5
**status:** not started

---

## Goal
Connect the audio system to the actual game flow. Music starts when the player enters the forest, stops when they leave, and can be muted at any time.

## Design
- **AudioContext lifecycle:** one shared `ctx` instance per session, created on the first user gesture in play mode (not before — browsers block autoplay). In C# terms: lazy initialization, like `Lazy<T>`.
- **Start trigger:** when the player enters play mode (clicks "enter the forest" or loads a shared URL)
- **Stop trigger:** when the player returns to compose mode or the page unloads
- **Mute toggle:** a small button in the HUD (both mobile and desktop). Muting suspends the AudioContext (`ctx.suspend()`) rather than stopping oscillators — so unmuting resumes exactly where it left off.
- **Message change:** if the player hits "new scroll" and enters a new message, the old drone/melody stops and new ones start when they enter again.

## What to add to the HTML
A mute button in `#hud-bar` (mobile) and somewhere in the sidebar (desktop). Suggested label: `♪` when active, `♪̶` or just `mute` when muted. Style it like the existing `#help-btn`.

## What to wire up in JavaScript
- The existing `applyCanopy()` / mode-switching logic as a reference for where play mode starts
- `window.addEventListener('beforeunload', ...)` to stop cleanly on page exit
- The mute button's click handler calling `ctx.suspend()` / `ctx.resume()`

## Things to figure out
- Where in the existing code does play mode actually begin? (Search for where `app` gets the `play-mode` class added.)
- How do you check if an AudioContext is suspended before trying to resume it? (`ctx.state === 'suspended'`)
- What should happen on mobile where the first gesture might be a touch on the canvas rather than a keypress?
