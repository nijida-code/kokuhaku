# KokuhakuImportGitHub

## Purpose
`KokuhakuImportGitHub` imports Kokuhaku Flows from GitHub repositories using HTTPS.

It provides:
- listing repository directories (table-style flow overview)
- downloading individual files (Flow JSON/XML, media assets later)
- optional authentication via token (future)

This package does NOT perform Git operations (clone/pull) and does not decode Flow data.
Flow decoding and versioned mapping remain in `KokuhakuCore`.

## Why a separate package?
- Works on tvOS/watchOS because it relies on `URLSession`, not on a Git binary.
- Keeps infrastructure code (GitHub API/HTTP) separate from domain logic.
- Allows adding GitLab/Azure adapters later without touching UI code.

## Intended Targets / Platforms
Recommended usage:
- iOS / iPadOS: Yes (management + import)
- macOS: Yes (management + import)
- visionOS: Yes (management + import)
- tvOS: Optional (runner can fetch public flows directly)
- watchOS: Optional (usually receives flows via iOS, but can fetch public flows too)

## Dependencies
- Depends on `KokuhakuCore` for shared domain types and protocols.

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuImportGitHub`

Link it to the targets that should be able to browse and download Flows from GitHub.
