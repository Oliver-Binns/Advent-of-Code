import XCTest
@testable import AdventOfCode

final class Day20Tests: XCTestCase, SolutionTest {
    let day = 20
    
    func testPartOne() throws {
        try XCTAssertEqual(Day20(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day20(input: getTestData()).calculatePartTwo(), 0)
    }
}
