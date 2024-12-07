import XCTest
@testable import AdventOfCode

final class Day6Tests: XCTestCase, SolutionTest {
    typealias SUT = Day6
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 41)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 6)
    }
}

extension Day6Tests {
    func testParsing() throws {
        try XCTAssertEqual(
            sut.grid.values,
            [
                [".", ".", ".", ".", "#", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", "#"],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                [".", ".", "#", ".", ".", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", "#", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                [".", "#", ".", ".", "^", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", "#", "."],
                ["#", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", "#", ".", ".", "."]
            ]
        )
    }
}
