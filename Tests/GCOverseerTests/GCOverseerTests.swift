import XCTest
@testable import GCOverseer

final class GCOverseerTests: XCTestCase {
    func testIsLoggingEnabledByDefault() {
        XCTAssertTrue(GCOverseer().isLoggingEnabled)
    }

    static var allTests = [
        ("testIsLoggingEnabledByDefault", testIsLoggingEnabledByDefault)
    ]
}
