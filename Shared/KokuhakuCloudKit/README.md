# KokuhakuCloudKit

## Purpose
`KokuhakuCloudKit` provides the CloudKit (iCloud) integration for the Kokuhaku project.

This package is responsible for **communication with Apple CloudKit only**.
It implements storage and synchronization adapters based on the protocols
defined in `KokuhakuCore`.

The guiding rule is:
> **CloudKit is transport, not meaning.**

## Responsibilities
This package contains:

- CloudKit container and database access
- CRUD operations for Kokuhaku data in CloudKit
- Mapping between CloudKit records and Core data formats
- Error handling and retry logic (future)
- Optional CloudKit features such as:
  - subscriptions
  - background updates
  - sharing (future)

## Explicitly NOT included
`KokuhakuCloudKit` does **not** contain:

- Flow parsing or business rules
- Validation logic
- UI code
- HealthKit access
- Local-only storage

All domain logic remains in `KokuhakuCore`.

## Dependencies
- Depends on `KokuhakuCore`
- Imports `CloudKit`
- Requires CloudKit entitlements at the **app target level**

## Target Platforms
Intended usage by platform:

- **iOS / iPadOS**: Yes  
  Primary sync and backup platform.
- **macOS**: Yes  
  Management, diagnostics, and sync.
- **visionOS**: Yes  
  Dashboard and management use cases.
- **watchOS**: Optional  
  Typically syncs indirectly via iPhone.
- **tvOS**: No (by design)  
  tvOS acts primarily as a Flow runner; sync should be handled by iOS/macOS.

## Architectural Role
In the overall architecture:

- `KokuhakuCore` defines *what* data exists
- `KokuhakuCloudKit` defines *how* that data is synced via iCloud
- App targets decide **whether** CloudKit is enabled and which container is used

This separation allows Kokuhaku to:
- support offline-only modes
- replace or extend CloudKit later
- keep watchOS and tvOS targets lightweight

## Usage
Add as a local Swift Package dependency:

Project → Package Dependencies → Add Local… → `Shared/KokuhakuCloudKit`

Then link it to the relevant app targets:
Target → General → Frameworks, Libraries, and Embedded Content → `+` → `KokuhakuCloudKit`

CloudKit must be enabled per app target:
Target → Signing & Capabilities → iCloud → CloudKit → select container