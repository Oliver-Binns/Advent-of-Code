import XCTest
@testable import AdventOfCode

final class Day6Tests: XCTestCase, SolutionTest {
    let day = 6
    
    func testPartOne() throws {
        try XCTAssertEqual(Day6(input: getTestData()).calculatePartOne(), "6")
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day6(input: getTestData()).calculatePartTwo(), "3")
    }
}
