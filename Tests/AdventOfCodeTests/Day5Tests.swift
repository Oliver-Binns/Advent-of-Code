import XCTest
@testable import AdventOfCode

final class Day5Tests: XCTestCase {
    func testPartOne() {
        XCTAssertEqual(Day5(input: "BFFFBBFRRR").calculatePartOne(), "567")
        XCTAssertEqual(Day5(input: "FFFBBBFRRR").calculatePartOne(), "119")
        XCTAssertEqual(Day5(input: "BBFFBBFRLL").calculatePartOne(), "820")
    }
}
