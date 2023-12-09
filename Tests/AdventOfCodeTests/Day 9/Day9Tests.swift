import XCTest
@testable import AdventOfCode

final class Day9Tests: XCTestCase, SolutionTest {
    typealias SUT = Day9
    
    func testInitialisation() {
        try XCTAssertEqual(
            sut.report, [
                [0, 3, 6, 9, 12, 15],
                [1, 3, 6, 10, 15, 21],
                [10, 13, 16, 21, 30, 45]
            ]
        )
    }
    
    func testFindNextValue() {
        try XCTAssertEqual(
            sut.findNextValue(row: [0, 3, 6, 9, 12, 15]),
            18
        )
        try XCTAssertEqual(
            sut.findNextValue(row: [1, 3, 6, 10, 15, 21]),
            28
        )
        try XCTAssertEqual(
            sut.findNextValue(row: [10, 13, 16, 21, 30, 45]),
            68
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 114)
    }
    
    func testFindNewValuePart2() {
        try XCTAssertEqual(
            sut.findNextValue(row: [0, 3, 6, 9, 12, 15],
                              direction: .down),
            -3
        )
        try XCTAssertEqual(
            sut.findNextValue(row: [1, 3, 6, 10, 15, 21],
                              direction: .down),
            0
        )
        try XCTAssertEqual(
            sut.findNextValue(row: [10, 13, 16, 21, 30, 45],
                              direction: .down),
            5
        )
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 2)
    }
}
