import XCTest
@testable import CoronaTrackerClient

final class CoronaTrackerClientTests: XCTestCase {

    func testExample() {
        XCTAssertEqual(CoronaTrackerClient().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
