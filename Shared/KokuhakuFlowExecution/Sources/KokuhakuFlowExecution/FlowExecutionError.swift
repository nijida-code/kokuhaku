import Foundation

/// Errors thrown by `KokuhakuFlowExecution`.
public enum FlowExecutionError: Error, Sendable, LocalizedError, Hashable {
    case invalidStepIndex(Int)
    case alreadyEnded
    case notStarted

    public var errorDescription: String? {
        switch self {
        case .invalidStepIndex(let i):
            return "Invalid step index \(i)."
        case .alreadyEnded:
            return "The execution session has already ended."
        case .notStarted:
            return "The execution session has not started."
        }
    }
}
