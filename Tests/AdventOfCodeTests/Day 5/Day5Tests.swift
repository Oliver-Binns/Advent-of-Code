import XCTest
@testable import AdventOfCode

final class Day5Tests: XCTestCase, SolutionTest {
    typealias SUT = Day5
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), "CMZ")
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), "MCD")
    }
}

extension Day5Tests {
    func testStacksInitialisation() {
        try XCTAssertEqual(sut.stacks, [
            ["Z", "N"],
            ["M", "C", "D"],
            ["P"]
        ])
    }
    
    func testInstructionsInitialisation() {
        try XCTAssertEqual(sut.instructions, [
            .init(count: 1, origin: 2, destination: 1),
            .init(count: 3, origin: 1, destination: 3),
            .init(count: 2, origin: 2, destination: 1),
            .init(count: 1, origin: 1, destination: 2)
        ])
    }
    
    func testParseInstruction() {
        XCTAssertEqual(
            Instruction(input: "move 1 from 2 to 1"),
            .init(count: 1, origin: 2, destination: 1)
        )
    }
    
    func testParseInstructions() {
        XCTAssertEqual(
            SUT.parseInstructions(input: """
            move 1 from 2 to 1
            move 3 from 1 to 3
            move 2 from 2 to 1
            move 1 from 1 to 2
            """),
            [
                .init(count: 1, origin: 2, destination: 1),
                .init(count: 3, origin: 1, destination: 3),
                .init(count: 2, origin: 2, destination: 1),
                .init(count: 1, origin: 1, destination: 2)
            ]
        )
    }
    
    func testParseCrates() {
        XCTAssertEqual(
            SUT.parseCrates(input: """
                [D]
            [N] [C]
            [Z] [M] [P]
             1   2   3
            """), [
                ["Z", "N"],
                ["M", "C", "D"],
                ["P"]
            ])
    }
}
