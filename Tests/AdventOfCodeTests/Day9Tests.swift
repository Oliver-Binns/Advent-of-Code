import XCTest
@testable import AdventOfCode

final class Day9Tests: XCTestCase, SolutionTest {
    let day = 9
    
    var sut: Day9!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = try Day9(input: getTestData())
    }

    func testPartOne() {
        XCTAssertEqual(sut.calculatePartOne(preambleLength: 5), 127)
    }
    
    func testPartTwo() {
        XCTAssertEqual(sut.calculatePartTwo(preambleLength: 5), 62)
    }
}

extension Day9Tests {
    func testPreviousNumbers() {
        XCTAssertEqual(
            sut.previousNumbers(at: 5, length: 5),
            [35, 20, 15, 25, 47]
        )
        
        XCTAssertEqual(
            sut.previousNumbers(at: 6, length: 5),
            [20, 15, 25, 47, 40]
        )
        
        XCTAssertEqual(
            sut.previousNumbers(at: 14, length: 5),
            [182, 150, 117, 102, 95]
        )
    }
    
    func testPossibleCombinations() {
        XCTAssertEqual(sut.possibleValues(for: 2, preambleLength: 2),
                       [55])
        
        XCTAssertEqual(sut.possibleValues(for: 3, preambleLength: 3),
                       [55, 35, 50])
    }
}
