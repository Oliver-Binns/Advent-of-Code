import XCTest
@testable import AdventOfCode

final class Day2Tests: XCTestCase, SolutionTest {
    typealias SUT = Day2
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 2)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 4)
    }
}

extension Day2Tests {
    func testInputParsing() throws {
        try XCTAssertEqual(sut.reports, [
            [7, 6, 4, 2, 1],
            [1, 2, 7, 8, 9],
            [9, 7, 6, 2, 1],
            [1, 3, 2, 4, 5],
            [8, 6, 4, 4, 1],
            [1, 3, 6, 7, 9]
        ])
    }
}
