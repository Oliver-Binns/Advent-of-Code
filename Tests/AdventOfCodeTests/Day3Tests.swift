import XCTest
@testable import AdventOfCode

final class Day3Tests: XCTestCase, SolutionTest {
    let day = 3
    
    func testPartOne() throws {
        try XCTAssertEqual(Day3(input: getTestData()).calculatePartOne(), "7")
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day3(input: getTestData()).calculatePartTwo(), "336")
    }
}
