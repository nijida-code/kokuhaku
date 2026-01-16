import XCTest
@testable import KokuhakuFlowExecution

final class KokuhakuFlowExecutionTests: XCTestCase {
    func testSessionCompletesAllSteps() async throws {
        let session = FlowExecutionSession(flowID: "test", totalSteps: 3, notifier: nil)
        try await session.start()
        try await session.confirmActiveStep()
        try await session.confirmActiveStep()
        try await session.confirmActiveStep()

        let snap = await session.snapshot()
        XCTAssertEqual(snap.result, .completed)
        XCTAssertEqual(snap.totalSteps, 3)
        XCTAssertEqual(snap.stepStates.filter { $0 == .completed }.count, 3)
    }
}
