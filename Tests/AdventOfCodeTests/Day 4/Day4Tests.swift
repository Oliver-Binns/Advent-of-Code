import XCTest
@testable import AdventOfCode

final class Day4Tests: XCTestCase, SolutionTest {
    typealias SUT = Day4
    
    func testInitialisation() {
        try XCTAssertEqual(sut.scratchCards.count, 6)
        try XCTAssertEqual(
            sut.scratchCards[0],
            ScratchCard(winningNumbers: [41, 48, 83, 86, 17],
                        chosenNumbers: [83, 86, 6, 31, 17, 9, 48, 53])
        )
    }
    
    func testValue() {
        XCTAssertEqual(
            ScratchCard(winningNumbers: [41, 48, 83, 86, 17],
                        chosenNumbers: [83, 86, 6, 31, 17, 9, 48, 53]).value,
            8
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 13)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 30)
    }
}
