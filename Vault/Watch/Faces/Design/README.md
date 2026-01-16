# Watch Face Design Notes

This directory is for **design rationale** and iteration notes around Kokuhaku’s recommended watch face presets.

## Goals
- Glanceable: 1–2 seconds to understand current state
- Low cognitive load
- Step-oriented: current step + next step + progress
- Works reliably when the watch app is backgrounded
- Supports both "active flow running" and "idle" states

## Non-goals
- Creating new watch face types (not permitted for third-party apps)
- High-frequency animations or continuous updates (system throttles complications)
- Replacing the watchOS app (the app remains important for deeper interaction)

## Suggested contents
You can add files like:
- `principles.md`  (rules and guiding principles)
- `states.md`      (idle/active/paused/overdue)
- `face-choices.md` (why a specific Apple face family was chosen)
- `slots.md`       (which complication family maps to which UI intention)

