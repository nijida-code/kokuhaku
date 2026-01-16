# Watch Face Presets (`.watchface`)

Place exported watch face preset files here.

## Naming
Use a stable naming scheme:

- `Kokuhaku_<Name>.watchface`

Examples:
- `Kokuhaku_Focus.watchface`
- `Kokuhaku_Minimal.watchface`
- `Kokuhaku_Training.watchface`

## What a preset contains
A `.watchface` preset is a configuration snapshot of an existing Apple Watch face, including:
- selected face type (e.g., Modular, Modular Ultra, etc.)
- color/style options
- complication placements (including Kokuhaku complications)

## Creation workflow (manual)
1. Configure a watch face on the Apple Watch (or in Watch app on iPhone).
2. Place Kokuhaku complications in the desired slots.
3. Share/export the watch face (creates a `.watchface` file).
4. Save the exported `.watchface` file into this directory.
5. Add a matching screenshot to `../Screenshots/`.

## Usage in Kokuhaku (future)
Kokuhaku iOS may later provide a “Watch Faces” gallery:
- show screenshot + explanation
- share the `.watchface` preset via Share Sheet
User must explicitly install/apply the preset (Apple requires user interaction).

