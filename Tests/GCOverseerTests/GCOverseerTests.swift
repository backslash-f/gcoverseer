import XCTest
@testable import GCOverseer

final class GCOverseerTests: XCTestCase {
    func testIsLoggingEnabledByDefault() {
        XCTAssertTrue(GCOverseer().isLoggingEnabled)
    }

    static let allTests = [
        ("testIsLoggingEnabledByDefault", testIsLoggingEnabledByDefault)
    ]
}
