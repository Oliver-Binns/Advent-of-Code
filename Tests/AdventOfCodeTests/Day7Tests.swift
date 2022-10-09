import XCTest
@testable import AdventOfCode

final class Day7Tests: XCTestCase, SolutionTest {
    let day = 7
    
    func testPartOne() throws {
        try XCTAssertEqual(Day7(input: getTestData()).calculatePartOne(), "4")
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day7(input: getTestData()).calculatePartTwo(), "32")
    }
}
