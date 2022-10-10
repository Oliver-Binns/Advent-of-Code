import XCTest
@testable import AdventOfCode

final class Day13Tests: XCTestCase, SolutionTest {
    let day = 13
    
    func testPartOne() throws {
        try XCTAssertEqual(Day14(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day14(input: getTestData()).calculatePartTwo(), 0)
    }
}
