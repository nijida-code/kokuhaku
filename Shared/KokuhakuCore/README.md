# KokuhakuCore

## Purpose
`KokuhakuCore` is the platform-agnostic foundation of the Kokuhaku project.

It contains all **domain logic and data structures** that define what Kokuhaku *is*,
independent of any Apple service, UI framework, or device.

The core principle of this package is:
> **Meaning and rules live here. Infrastructure does not.**

## Responsibilities
`KokuhakuCore` includes:

- Flow models (Flows, Steps, Flow Sets / Compilations)
- Flow execution logic (start, step confirmation, completion)
- Data validation and invariants
- JSON parsing and versioned mapping (future XML support)
- Core protocols / abstractions, e.g.:
  - `FlowStore` (storage abstraction)
  - `RunEventStore` (execution history)
  - `FlowSource` (abstract flow providers)
  - `Notifier` (abstract feedback/reminder interface)
- Media references as abstract assets (images/videos by identifier, not UI code)

## Explicitly NOT included
`KokuhakuCore` must **not** contain:

- `import CloudKit`
- `import HealthKit`
- any Apple service APIs
- UI code (SwiftUI / UIKit / AppKit)
- platform-specific assumptions

This keeps the core:
- fully testable
- reusable across platforms
- independent from Apple account / entitlement state

## Target Platforms
This package is designed to work on **all platforms** supported by Kokuhaku:

- iOS / iPadOS
- macOS
- watchOS
- tvOS
- visionOS
- CLI tools (macOS)

Every other Kokuhaku package depends (directly or indirectly) on `KokuhakuCore`.

## Architectural Role
In the overall architecture:

- `KokuhakuCore` defines **what a Flow is and how it behaves**
- Other packages implement **how data is stored, synced, collected, or displayed**

All infrastructure packages (CloudKit, HealthKit, Git, local storage, etc.)
adapt themselves to the interfaces defined here.

## Usage
`KokuhakuCore` is added as a local Swift Package dependency:

Project → Package Dependencies → Add Local… → `Shared/KokuhakuCore`

It is typically linked to **all app targets**, including watchOS and tvOS runners.