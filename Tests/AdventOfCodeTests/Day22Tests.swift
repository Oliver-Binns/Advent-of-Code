import XCTest
@testable import AdventOfCode

final class Day22Tests: XCTestCase, SolutionTest {
    let day = 13
    
    func testPartOne() throws {
        try XCTAssertEqual(Day22(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day22(input: getTestData()).calculatePartTwo(), 0)
    }
}
