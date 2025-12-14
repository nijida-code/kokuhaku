import XCTest
@testable import KokuhakuCore

final class KokuhakuCoreTests: XCTestCase {

    func testValidSet() {
        let engine = KokuhakuEngine()
        let step = KokuhakuStep(title: "Test", durationSeconds: 60)
        let set = KokuhakuSet(name: "Demo", steps: [step])
        XCTAssertTrue(engine.validate(set: set))
    }
}
