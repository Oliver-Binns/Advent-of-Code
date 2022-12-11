import XCTest
@testable import AdventOfCode

final class Day9Tests: XCTestCase, SolutionTest {
    typealias SUT = Day9
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 13)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day9Tests {
    func testInitialisation() throws {
        try XCTAssertEqual(sut.motions, [
            .init(direction: .right, amount: 4),
            .init(direction: .up, amount: 4),
            .init(direction: .left, amount: 3),
            .init(direction: .down, amount: 1),
            .init(direction: .right, amount: 4),
            .init(direction: .down, amount: 1),
            .init(direction: .left, amount: 5),
            .init(direction: .right, amount: 2),
        ])
    }
    
    func testApplyMotion() throws {
        XCTAssertEqual(
            Rope()
                .applyMotion(.init(direction: .right, amount: 4)),
            Rope(tail: .origin, head: .init(x: 4, y: 0)))
    }
}
