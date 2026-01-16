# Kokuhaku Watch Complications (Semantics)

This directory defines what Kokuhaku complications **mean** and what they should display.
It is intentionally **implementation-agnostic**.

Implementation lives in the watchOS Widget/Complication target(s),
but the semantic contract should be documented here.

## Core states to support
At minimum, complications should communicate one of these states:

1. **Idle**
   - No active flow running
   - Show a neutral status (e.g., "Ready") or today's summary

2. **Active**
   - A flow is running
   - Show current step title (short), progress, and optionally next reminder

3. **Paused**
   - Flow paused by the user or by context
   - Show "Paused" and a hint to resume

4. **Overdue / Attention**
   - A step confirmation is late (if the flow defines timing)
   - Show a warning indicator (minimal)

## Recommended data fields
These are suggested fields that the complication view models may use:

- `flowName` (optional, short)
- `stepTitle` (primary when Active)
- `stepIndex` / `stepCount` (progress)
- `progressRatio` (0.0 ... 1.0)
- `nextReminderAt` (optional)
- `status` (idle/active/paused/overdue)
- `updatedAt` (for timeline refresh decisions)

## Update strategy (important)
Complications are throttled by the system.
Avoid frequent updates (e.g., every second).

Preferred update triggers:
- flow started
- step became active
- step confirmed
- flow ended
- pause/resume
- reminder boundary (if applicable)

## Complication families to consider
Later, decide which families Kokuhaku supports, e.g.:
- accessoryCircular
- accessoryRectangular
- accessoryInline

These should align with your chosen watch face presets.

