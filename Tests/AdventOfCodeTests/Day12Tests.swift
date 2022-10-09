import XCTest
@testable import AdventOfCode

final class Day12Tests: XCTestCase, SolutionTest {
    let day = 12
    
    func testPartOne() throws {
        try XCTAssertEqual(Day12(input: getTestData()).calculatePartOne(), 37)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day12(input: getTestData()).calculatePartTwo(), 26)
    }
}
