import XCTest
@testable import AdventOfCode

final class Day18Tests: XCTestCase, SolutionTest {
    typealias SUT = Day18
    
    func testInitialisation() {
        try XCTAssertEqual(
            sut.digPlan,
            [
                DigInstruction(direction: .right, distance: 6),
                DigInstruction(direction: .down, distance: 5),
                DigInstruction(direction: .left, distance: 2),
                DigInstruction(direction: .down, distance: 2),
                DigInstruction(direction: .right, distance: 2),
                DigInstruction(direction: .down, distance: 2),
                DigInstruction(direction: .left, distance: 5),
                DigInstruction(direction: .up, distance: 2),
                DigInstruction(direction: .left, distance: 1),
                DigInstruction(direction: .up, distance: 2),
                DigInstruction(direction: .right, distance: 2),
                DigInstruction(direction: .up, distance: 3),
                DigInstruction(direction: .left, distance: 2),
                DigInstruction(direction: .up, distance: 2),
            ]
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 62)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}
