import XCTest
@testable import AdventOfCode

final class Day17Tests: XCTestCase, SolutionTest {
    let day = 17
    
    func testPartOne() throws {
        try XCTAssertEqual(Day17(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day17(input: getTestData()).calculatePartTwo(), 0)
    }
}
