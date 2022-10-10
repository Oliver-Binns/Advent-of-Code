import XCTest
@testable import AdventOfCode

final class Day14Tests: XCTestCase, SolutionTest {
    let day = 14
    
    func testPartOne() throws {
        try XCTAssertEqual(Day14(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day14(input: getTestData()).calculatePartTwo(), 0)
    }
}
