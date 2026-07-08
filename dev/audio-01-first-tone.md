# Audio 01 — First Tone
**tags:** audio, stage-1, javascript-basics
**status:** not started

---

## Goal
Get a single tone to play on a keypress. This is a throwaway test — it won't live in the final game. The point is to feel the Web Audio API before building anything real with it.

## What to write
Add this just above the closing `</script>` tag in `index.html`:

```javascript
document.addEventListener('keydown', function(e) {
  if (e.key !== 't') return;

  const ctx = new AudioContext();
  const osc = ctx.createOscillator();
  const gain = ctx.createGain();

  osc.connect(gain);
  gain.connect(ctx.destination);

  osc.frequency.value = 440;
  gain.gain.value = 0.3;

  osc.start();
  osc.stop(ctx.currentTime + 1.0);
});
```

## How to test
Open `index.html` in a browser. Press **T**. You should hear a one-second 440Hz tone (concert A).

## What to understand before moving on
- What is `AudioContext` and why do we create a new one?
- What is an oscillator, and what does `connect()` do?
- Why does `stop()` take `ctx.currentTime + 1.0` instead of just `1.0`?
- Why does this only work after a keypress and not on page load?

*(Make sure each of these is clear before moving on.)*
