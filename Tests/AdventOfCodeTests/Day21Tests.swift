import XCTest
@testable import AdventOfCode

final class Day21Tests: XCTestCase, SolutionTest {
    let day = 21
    
    func testPartOne() throws {
        try XCTAssertEqual(Day21(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day21(input: getTestData()).calculatePartTwo(), 0)
    }
}
