import XCTest
@testable import VanligaOrd

final class VanligaOrdTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(VanligaOrd().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
