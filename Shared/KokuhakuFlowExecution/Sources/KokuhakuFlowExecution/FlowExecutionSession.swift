import Foundation
import KokuhakuNotifications

/// A concurrency-safe execution session for a Flow.
///
/// This actor implements a small state machine:
/// - start
/// - step activation
/// - step confirmation
/// - pause/resume
/// - end (completed/cancelled/aborted)
///
/// The session does not depend on UI frameworks. Apps may observe events and update UI accordingly.
public actor FlowExecutionSession {
    public struct Snapshot: Sendable, Codable, Hashable {
        public let flowID: String
        public let startedAt: Date?
        public let endedAt: Date?
        public let totalSteps: Int
        public let activeStepIndex: Int?
        public let stepStates: [StepExecutionState]
        public let isPaused: Bool
        public let result: FlowExecutionResult?

        public init(
            flowID: String,
            startedAt: Date?,
            endedAt: Date?,
            totalSteps: Int,
            activeStepIndex: Int?,
            stepStates: [StepExecutionState],
            isPaused: Bool,
            result: FlowExecutionResult?
        ) {
            self.flowID = flowID
            self.startedAt = startedAt
            self.endedAt = endedAt
            self.totalSteps = totalSteps
            self.activeStepIndex = activeStepIndex
            self.stepStates = stepStates
            self.isPaused = isPaused
            self.result = result
        }
    }

    private let flowID: String
    private let totalSteps: Int
    private let notifier: (any NotificationDelivering)?

    private var startedAt: Date?
    private var endedAt: Date?
    private var activeStepIndex: Int?
    private var stepStates: [StepExecutionState]
    private var isPaused: Bool = false
    private var result: FlowExecutionResult?

    private var events: [FlowExecutionEvent] = []

    /// Creates a new session.
    /// - Parameters:
    ///   - flowID: Stable flow identifier.
    ///   - totalSteps: Total number of steps in this flow.
    ///   - notifier: Optional notification adapter for reminders/feedback.
    public init(flowID: String, totalSteps: Int, notifier: (any NotificationDelivering)? = nil) {
        self.flowID = flowID
        self.totalSteps = max(totalSteps, 0)
        self.notifier = notifier
        self.stepStates = Array(repeating: .pending, count: max(totalSteps, 0))
    }

    /// Returns a snapshot of the current state.
    public func snapshot() -> Snapshot {
        Snapshot(
            flowID: flowID,
            startedAt: startedAt,
            endedAt: endedAt,
            totalSteps: totalSteps,
            activeStepIndex: activeStepIndex,
            stepStates: stepStates,
            isPaused: isPaused,
            result: result
        )
    }

    /// Returns all execution events accumulated so far.
    public func allEvents() -> [FlowExecutionEvent] {
        events
    }

    /// Starts the session and activates the first step (if any).
    public func start(at date: Date = Date()) throws {
        if result != nil { throw FlowExecutionError.alreadyEnded }
        startedAt = date
        events.append(.sessionStarted(flowID: flowID, at: date))

        if totalSteps > 0 {
            activateStep(0, at: date)
        }
    }

    /// Pauses the session.
    public func pause(at date: Date = Date()) throws {
        guard startedAt != nil else { throw FlowExecutionError.notStarted }
        if result != nil { throw FlowExecutionError.alreadyEnded }
        isPaused = true
        events.append(.sessionPaused(at: date))
    }

    /// Resumes the session.
    public func resume(at date: Date = Date()) throws {
        guard startedAt != nil else { throw FlowExecutionError.notStarted }
        if result != nil { throw FlowExecutionError.alreadyEnded }
        isPaused = false
        events.append(.sessionResumed(at: date))
    }

    /// Confirms the currently active step and advances to the next one.
    public func confirmActiveStep(at date: Date = Date()) async throws {
        guard startedAt != nil else { throw FlowExecutionError.notStarted }
        if result != nil { throw FlowExecutionError.alreadyEnded }

        guard let i = activeStepIndex else {
            // No active step means nothing to confirm; treat as completed if no steps.
            if totalSteps == 0 {
                try end(result: .completed, at: date)
            }
            return
        }

        guard i >= 0 && i < stepStates.count else { throw FlowExecutionError.invalidStepIndex(i) }

        stepStates[i] = .completed
        events.append(.stepConfirmed(stepIndex: i, at: date))

        // Immediate confirmation feedback (optional).
        if let notifier {
            let request = NotificationRequest(kind: .confirmation, title: nil, body: nil, scheduledAt: nil)
            try? await notifier.deliver(request, plan: .runnerDefault)
        }

        let next = i + 1
        if next < totalSteps {
            activateStep(next, at: date)
        } else {
            try end(result: .completed, at: date)
        }
    }

    /// Cancels the session.
    public func cancel(at date: Date = Date()) throws {
        try end(result: .cancelled, at: date)
    }

    /// Aborts the session due to an error or external condition.
    public func abort(at date: Date = Date()) throws {
        try end(result: .aborted, at: date)
    }

    /// Builds a run summary if the session has ended.
    public func runSummary() throws -> FlowRunSummary {
        guard let startedAt else { throw FlowExecutionError.notStarted }
        guard let endedAt, let result else { throw FlowExecutionError.notEnded }
        let completed = stepStates.filter { $0 == .completed }.count

        return FlowRunSummary(
            flowID: flowID,
            startedAt: startedAt,
            endedAt: endedAt,
            totalSteps: totalSteps,
            completedSteps: completed,
            result: result
        )
    }

    // MARK: - Internals

    private func activateStep(_ index: Int, at date: Date) {
        activeStepIndex = index
        for i in 0..<stepStates.count {
            if stepStates[i] == .active { stepStates[i] = .pending }
        }
        if index >= 0 && index < stepStates.count {
            stepStates[index] = .active
        }
        events.append(.stepBecameActive(stepIndex: index, at: date))
    }

    private func end(result: FlowExecutionResult, at date: Date) throws {
        guard startedAt != nil else { throw FlowExecutionError.notStarted }
        if self.result != nil { throw FlowExecutionError.alreadyEnded }
        self.result = result
        endedAt = date
        activeStepIndex = nil
        events.append(.sessionEnded(result: result, at: date))
    }
}
