import XCTest
@testable import AdventOfCode

final class Day2Tests: XCTestCase, SolutionTest {
    let day = 2
    
    func testPartOne() throws {
        try XCTAssertEqual(Day2(input: getTestData()).calculatePartOne(), "2")
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day2(input: getTestData()).calculatePartTwo(), "1")
    }
}
