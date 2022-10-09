import XCTest
@testable import AdventOfCode

final class Day10Tests: XCTestCase, SolutionTest {
    let day = 10
    
    var sut: Day10 {
        get throws {
            try Day10(input: getTestData())
        }
    }
    
    var sutLarger: Day10 {
        get throws {
            try Day10(input: getTestData(filename: "Day10-Larger"))
        }
    }

    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 0)
        try XCTAssertEqual(sutLarger.calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
        try XCTAssertEqual(sutLarger.calculatePartTwo(), 0)
    }
}
