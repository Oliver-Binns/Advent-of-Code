import XCTest
@testable import AdventOfCode

final class Day8Tests: XCTestCase, SolutionTest {
    let day = 8
    
    func testPartOne() throws {
        try XCTAssertEqual(Day8(input: getTestData()).calculatePartOne(), "5")
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day8(input: getTestData()).calculatePartTwo(), "8")
    }
}
