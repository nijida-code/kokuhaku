# KokuhakuImportGit

## Purpose
`KokuhakuImportGit` provides Git-based import capabilities for Kokuhaku.

It is responsible for:
- checking out (cloning/opening) Git repositories into a local cache
- updating repositories (fetch/pull)
- providing a local working directory URL that can be scanned for Flow files

This package does not parse Flow data. Actual Flow decoding remains in `KokuhakuCore`,
and directory scanning / local file import is handled by `KokuhakuImportLocal`.

## Why a separate package?
- Separates Git transport mechanics from Flow parsing and UI.
- Enables multiple backends (GitHub/GitLab/Azure DevOps/self-hosted Git) via adapters.
- Keeps runner targets (watchOS/tvOS) lightweight.

## Intended Targets / Platforms
Recommended usage:
- iOS / iPadOS: Yes (management + import)
- macOS: Yes (management + import)
- visionOS: Yes (management + import)
- watchOS / tvOS: No (runner targets should stay minimal)

## Dependencies
- Depends on `KokuhakuCore` for shared domain types and protocols.

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuImportGit`

Link it to management app targets only:
Target → General → Frameworks, Libraries, and Embedded Content → `+` → `KokuhakuImportGit`
