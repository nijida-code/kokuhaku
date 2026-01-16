# KokuhakuFlowCatalog

## Purpose
`KokuhakuFlowCatalog` builds a unified "table view" of available Kokuhaku Flows,
independent of where they come from.

It provides:
- a single catalog model (`FlowCatalogEntry`) suitable for lists and tables
- discovery/browsing of Flow files from multiple sources (local directories, Git working copies, GitHub repositories)
- optional lightweight metadata extraction (filename, timestamps, size, format)
- a foundation for future index files (e.g. `Florist.xml` / `KokuhakuIndex.json`)

This package contains no UI code.

## Why a separate package?
- Keeps management UI simple: it renders one unified model.
- Allows adding new backends (GitLab/Azure/SVN/etc.) without changing list/table logic.
- Keeps runner targets (watchOS/tvOS) minimal by not requiring catalog logic there.

## Intended Targets / Platforms
Recommended usage:
- iOS / iPadOS: Yes (management UI, import selection, deployment marking)
- macOS: Yes (management UI, batch import)
- visionOS: Yes (dashboard-style management)
- watchOS / tvOS: Usually no (runner targets), unless you want on-device browsing

## Dependencies
- Uses `KokuhakuImportLocal` for directory scanning
- Uses `KokuhakuImportGitHub` for GitHub repository browsing
- May use `KokuhakuImportGit` for Git working copies (optional)
- Depends on `KokuhakuCore` for shared domain types

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuFlowCatalog`

Link it to management app targets only.
