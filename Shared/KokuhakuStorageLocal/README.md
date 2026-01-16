# KokuhakuStorageLocal

## Purpose
`KokuhakuStorageLocal` provides a lightweight local storage layer for Kokuhaku.

It is designed for runner-style targets (watchOS/tvOS) that must:
- store imported Flow files locally
- delete local Flows
- load Flow data quickly and offline

This package stores Flow payloads as raw `Data` (e.g. JSON today, XML later).
Decoding and versioned mapping remain in `KokuhakuCore`.

## Why a separate package?
- Keeps `KokuhakuCore` free of filesystem and platform storage concerns.
- Allows minimal runner targets (watchOS/tvOS) to persist Flows without bringing in cloud/import logic.
- Makes it easy to add alternative stores later (SQLite, CloudKit-backed cache, etc.).

## Intended Targets / Platforms
Recommended usage:
- watchOS: Yes (primary local store for installed Flows)
- tvOS: Yes (primary local store for installed Flows)
- iOS / macOS / visionOS: Optional (cache/offline), typically not required for MVP

## Responsibilities
- Provide a stable on-disk layout (directories / filenames)
- Save / load / list / delete Flow payloads
- Do not interpret or validate Flow domain logic (Core does that)

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuStorageLocal`

Link it to runner targets that need local persistence:
Target → General → Frameworks, Libraries, and Embedded Content → `+` → `KokuhakuStorageLocal`
