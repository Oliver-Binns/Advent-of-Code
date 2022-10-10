import XCTest
@testable import AdventOfCode

final class Day16Tests: XCTestCase, SolutionTest {
    let day = 16
    
    func testPartOne() throws {
        try XCTAssertEqual(Day16(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day16(input: getTestData()).calculatePartTwo(), 0)
    }
}
