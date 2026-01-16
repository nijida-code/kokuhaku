# KokuhakuAnalytics

## Purpose
`KokuhakuAnalytics` evaluates Flow execution data over time.

It focuses on:
- daily and long-term trends
- personal performance optima
- contextual weighting (weekends, holidays, vacation)
- combining Flow execution data with optional HealthKit-derived context

This package does not access HealthKit directly and does not store data.
It operates purely on provided input models.

## Intended Targets
- iOS / macOS / visionOS: Yes
- watchOS / tvOS: No

## Responsibilities
- Aggregation of Flow run data
- Calculation of trend indicators
- Determination of personal optimum ranges
- Context-aware normalization

## Not Included
- No UI
- No persistence
- No direct HealthKit queries

## Usage
Add as a local Swift Package dependency:
Project → Package Dependencies → Add Local… → `Shared/KokuhakuAnalytics`
