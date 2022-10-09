import XCTest
@testable import AdventOfCode

final class Day9Tests: XCTestCase, SolutionTest {
    let day = 9
    
    var sut: Day9 {
        get throws {
            try Day9(input: getTestData())
        }
    }

    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(preambleLength: 5), 127)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(preambleLength: 5), 62)
    }
}

extension Day9Tests {
    func testPreviousNumbers() throws {
        try XCTAssertEqual(
            sut.previousNumbers(at: 5, length: 5),
            [35, 20, 15, 25, 47]
        )
        
        try XCTAssertEqual(
            sut.previousNumbers(at: 6, length: 5),
            [20, 15, 25, 47, 40]
        )
        
        try XCTAssertEqual(
            sut.previousNumbers(at: 14, length: 5),
            [182, 150, 117, 102, 95]
        )
    }
    
    func testPossibleCombinations() throws {
        try XCTAssertEqual(
            sut.possibleValues(for: 2, preambleLength: 2),
            [55]
        )
        
        try XCTAssertEqual(
            sut.possibleValues(for: 3, preambleLength: 3),
            [55, 35, 50]
        )
    }
}
