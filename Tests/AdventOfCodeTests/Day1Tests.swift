import XCTest
@testable import AdventOfCode

final class Day1Tests: XCTestCase, SolutionTest {
    let day = 1
    
    func testPartOne() throws {
        try XCTAssertEqual(Day1(input: getTestData()).calculatePartOne(), "514579")
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day1(input: getTestData()).calculatePartTwo(), "241861950")
    }
}
