import XCTest
@testable import AdventOfCode

final class Day25Tests: XCTestCase, SolutionTest {
    let day = 25
    
    func testPartOne() throws {
        try XCTAssertEqual(Day25(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day25(input: getTestData()).calculatePartTwo(), 0)
    }
}
