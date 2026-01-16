# KokuhakuNotifications

## Purpose
`KokuhakuNotifications` provides shared, platform-agnostic abstractions for delivering
Kokuhaku reminders and immediate feedback to the user.

It supports multiple output modalities depending on the target device:
- watchOS: haptic feedback
- tvOS: audio feedback and/or visual flash
- iOS/macOS/visionOS: notifications, sounds, lightweight UI feedback (app-defined)

This package intentionally avoids UI frameworks and heavy platform dependencies.
Concrete implementations live in app targets or adapter packages.

## Why a separate package?
- Keeps reminder semantics consistent across platforms.
- Allows runner targets (watchOS/tvOS) to remain small while still sharing message formats.
- Makes it easy to add new modalities without touching `KokuhakuCore`.

## Intended Targets / Platforms
Recommended usage:
- watchOS: Yes (primary haptic reminder/feedback output)
- tvOS: Yes (audio/visual feedback output)
- iOS/macOS/visionOS: Optional (management apps may present reminders or test feedback)

## Responsibilities
- Define reminder/feedback request types and levels.
- Provide a small protocol surface for platform implementations.

## Not included
- No UNUserNotificationCenter integration
- No WatchKit haptic calls
- No AVFoundation sound playback
These are platform-specific and implemented outside this package.

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuNotifications`

Link it to targets that need reminder/feedback abstractions.
