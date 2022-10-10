import XCTest
@testable import AdventOfCode

final class Day24Tests: XCTestCase, SolutionTest {
    let day = 24
    
    func testPartOne() throws {
        try XCTAssertEqual(Day24(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day24(input: getTestData()).calculatePartTwo(), 0)
    }
}
