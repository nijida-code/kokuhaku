# KokuhakuDeviceSync

## Purpose
`KokuhakuDeviceSync` defines the shared data contracts and abstractions for deploying
Kokuhaku Flows from "management" devices (iOS/macOS/visionOS) to "runner" devices
(watchOS/tvOS).

It focuses on:
- selecting/marking flows for specific device classes
- sending raw Flow payloads (JSON/XML) plus metadata
- receiving acknowledgements (installed, removed, version/status)

This package is transport-agnostic: it does not depend on WatchConnectivity,
network sockets, CloudKit, or any UI framework.

## Why a separate package?
- Ensures iOS/watchOS/tvOS/macOS/visionOS agree on message formats.
- Allows multiple transport implementations (WatchConnectivity, local network, etc.).
- Keeps runner targets lightweight and focused.

## Intended Targets / Platforms
Recommended usage:
- iOS / iPadOS: Yes (primary sender/manager)
- macOS / visionOS: Yes (optional sender/manager)
- watchOS: Yes (receiver/runner)
- tvOS: Yes (receiver/runner)

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuDeviceSync`

Link it to both management and runner targets that exchange flows.
Transport implementations live in app targets or separate adapter packages.
