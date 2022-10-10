import XCTest
@testable import AdventOfCode

final class Day19Tests: XCTestCase, SolutionTest {
    let day = 19
    
    func testPartOne() throws {
        try XCTAssertEqual(Day19(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day19(input: getTestData()).calculatePartTwo(), 0)
    }
}
