import XCTest
@testable import TPPDF

class TPPDFTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(TPPDF().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
