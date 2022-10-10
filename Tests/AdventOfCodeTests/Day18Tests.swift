import XCTest
@testable import AdventOfCode

final class Day18Tests: XCTestCase, SolutionTest {
    let day = 18
    
    func testPartOne() throws {
        try XCTAssertEqual(Day18(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day18(input: getTestData()).calculatePartTwo(), 0)
    }
}
