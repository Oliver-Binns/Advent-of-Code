import XCTest
@testable import AdventOfCode

final class Day4Tests: XCTestCase, SolutionTest {
    let day = 4
    
    func testPartOne() throws {
        try XCTAssertEqual(Day4(input: getTestData()).calculatePartOne(), "2")
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day4(input: getTestData()).calculatePartTwo(), "2")
    }
}
