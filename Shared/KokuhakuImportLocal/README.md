# KokuhakuImportLocal

## Purpose
`KokuhakuImportLocal` imports Kokuhaku Flows from local files and directories.

It provides:
- File import (JSON now, XML later)
- Directory scanning to build a table-style overview of available Flows
- Lightweight metadata extraction (filename, timestamps, size, format)

This package contains no UI and no cloud/service code.

## Why a separate package?
- Keeps `KokuhakuCore` platform-agnostic and focused on domain logic.
- Allows iOS/macOS/visionOS management apps to add import capabilities without bloating runner targets.
- Makes it easy to add further import backends (Git, GitHub, GitLab, etc.) via other packages.

## Intended Targets / Platforms
Recommended usage:
- iOS / iPadOS: Yes (management + import)
- macOS: Yes (management + import)
- visionOS: Yes (management + import)
- watchOS / tvOS: No (runner targets should stay minimal)

## Dependencies
- Depends on `KokuhakuCore` for decoding and validating Flow data.

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuImportLocal`

Link it to the management app targets that need import:
Target → General → Frameworks, Libraries, and Embedded Content → `+` → `KokuhakuImportLocal`