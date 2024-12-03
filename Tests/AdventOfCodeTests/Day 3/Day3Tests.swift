import XCTest
@testable import AdventOfCode

final class Day3Tests: XCTestCase, SolutionTest {
    typealias SUT = Day3
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 161)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day3Tests {
    func testParsing() throws {
        try XCTAssertEqual(
            sut.instructions,
            [
                .multiply(2, 4),
                .multiply(5, 5),
                .multiply(11, 8),
                .multiply(8, 5),
            ]
        )
    }
}
