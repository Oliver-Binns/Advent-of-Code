import XCTest
@testable import AdventOfCode

final class Day1Tests: XCTestCase, SolutionTest {
    typealias SUT = Day1
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 11)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 31)
    }
}

extension Day1Tests {
    func testParsing() {
        try XCTAssertEqual(
            sut.lists.0,
            [3, 4, 2, 1, 3, 3]
        )

        try XCTAssertEqual(
            sut.lists.1,
            [4, 3, 5, 3, 9, 3]
        )
    }
}
