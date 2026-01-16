# Vault / Watch

This directory is the **design and documentation vault** for Kokuhaku’s Apple Watch experience.

It intentionally contains:
- Apple Watch face **preset files** (`.watchface`)
- screenshots used for documentation and later in-app galleries
- written design notes
- complication content definitions (what we want to show, not how we implement it)

It intentionally does **not** contain:
- Swift source code
- build products
- package resources required at runtime

## Why this exists
Kokuhaku’s watch experience is primarily designed around:
- **glanceability** (quickly checking the current step/state)
- **low cognitive load**
- **short interactions**
- a stable, consistent UI surface (the Watch Face)

A watchOS app can be backgrounded quickly; therefore, the Watch Face + Complications
are treated as the primary “always available UI”.

## How to use this directory
- Put exported watch face presets into `Faces/Presets/`
- Put matching screenshots into `Faces/Screenshots/`
- Put design rationale and iteration notes into `Faces/Design/`
- Define complication semantics (states + displayed fields) in `Complications/`

