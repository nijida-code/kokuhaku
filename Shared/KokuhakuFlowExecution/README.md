# KokuhakuFlowExecution

## Purpose
`KokuhakuFlowExecution` provides the platform-agnostic runtime state machine for executing Kokuhaku Flows.

It is responsible for:
- step-by-step execution state
- user confirmations (events)
- pause/resume/cancel
- producing run summaries suitable for analytics and (later) HealthKit integration
- requesting immediate feedback/reminders via an abstract notification interface

This package does not contain UI code and does not depend on WatchConnectivity, CloudKit, or HealthKit.

## Why a separate package?
- Prevents duplicating runtime logic across watchOS, tvOS, iOS, macOS, and visionOS apps.
- Keeps `KokuhakuCore` focused on format/runtime primitives while execution policies evolve independently.
- Enables consistent run summaries and analytics inputs across platforms.

## Intended Targets / Platforms
Recommended usage:
- watchOS: Yes (primary runner)
- tvOS: Yes (runner)
- iOS/macOS/visionOS: Optional (runner or preview mode)

## Dependencies
- `KokuhakuCore`: Flow/Step model definitions
- `KokuhakuNotifications`: abstract feedback/reminder requests
- `KokuhakuAnalytics`: run summary DTO compatibility (optional usage)

## Not Included
- No UI rendering
- No sound/haptic implementation (apps provide adapters)
- No persistence (apps store run logs as needed)

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuFlowExecution`

Link it to runner targets (watchOS/tvOS) and optionally to management targets that execute flows.
