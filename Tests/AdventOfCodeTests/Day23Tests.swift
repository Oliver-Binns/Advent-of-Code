import XCTest
@testable import AdventOfCode

final class Day23Tests: XCTestCase, SolutionTest {
    let day = 23
    
    func testPartOne() throws {
        try XCTAssertEqual(Day23(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day23(input: getTestData()).calculatePartTwo(), 0)
    }
}
