import XCTest
@testable import AdventOfCode

final class Day15Tests: XCTestCase, SolutionTest {
    let day = 15
    
    func testPartOne() throws {
        try XCTAssertEqual(Day15(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day15(input: getTestData()).calculatePartTwo(), 0)
    }
}
