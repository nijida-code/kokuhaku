# KokuhakuHealthKit

## Purpose
`KokuhakuHealthKit` provides HealthKit integration for the Kokuhaku project.

This package contains only HealthKit communication concerns:
- requesting authorization
- reading HealthKit samples (context data)
- optionally writing samples (summaries) back to HealthKit
- mapping HealthKit types into Kokuhaku-neutral data structures

It does not perform analytics or long-term storage.

## Why a separate package?
- Keeps `KokuhakuCore` free of platform services and entitlements.
- Allows runner targets (tvOS) to remain HealthKit-free.
- Centralizes HealthKit permissions and query logic for iOS/watchOS/macOS/visionOS.

## Supported Platforms
HealthKit is supported on:
- iOS / iPadOS
- watchOS
- macOS (14+)
- visionOS

HealthKit is not available on tvOS.
(See Apple HealthKit framework documentation and HealthKit entitlement docs.)

## App Requirements (Entitlements)
Each app target that uses HealthKit must enable the HealthKit capability in Xcode:
Target → Signing & Capabilities → `+` → HealthKit

Apple also provides HealthKit entitlements that are automatically managed by Xcode
when enabling the capability.

## Responsibilities
- Authorization requests
- Query helpers (e.g. sample queries)
- Mapping to neutral DTOs for downstream analytics

## Not included
- No UI code
- No local database/storage
- No CloudKit sync logic

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuHealthKit`

Link it only to targets that actually use HealthKit (iOS/watchOS/macOS/visionOS).
