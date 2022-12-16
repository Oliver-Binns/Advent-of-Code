import XCTest
@testable import AdventOfCode

final class Day9Tests: XCTestCase, SolutionTest {
    typealias SUT = Day9
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 13)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 1)
        
        XCTAssertEqual(SUT(input: """
        R 5
        U 8
        L 8
        D 3
        R 17
        D 10
        L 25
        U 20
        """).calculatePartTwo(), 36)
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
        let right = Rope().applyMotion(.init(direction: .right, amount: 4)).last
        XCTAssertEqual(right?.head, .init(x: 4, y: 0))
        XCTAssertEqual(right?.tail, .init(x: 3, y: 0))
        
        let left = Rope().applyMotion(.init(direction: .left, amount: 4)).last
        XCTAssertEqual(left?.head, .init(x: -4, y: 0))
        XCTAssertEqual(left?.tail, .init(x: -3, y: 0))
        
        let up = Rope().applyMotion(.init(direction: .up, amount: 4)).last
        XCTAssertEqual(up?.head, .init(x: 0, y: -4))
        XCTAssertEqual(up?.tail, .init(x: 0, y: -3))
        
        let down = Rope().applyMotion(.init(direction: .down, amount: 4)).last
        XCTAssertEqual(down?.head, .init(x: 0, y: 4))
        XCTAssertEqual(down?.tail, .init(x: 0, y: 3))
    }
    
    func testChainedMovement() throws {
        let movedRight = try XCTUnwrap(Rope()
            .applyMotion(.init(direction: .right, amount: 4)).last)
        let finalPosition = try XCTUnwrap(movedRight
            .applyMotion(.init(direction: .up, amount: 1)).last)
        
        XCTAssertEqual(finalPosition.head, .init(x: 4, y: -1))
        XCTAssertEqual(finalPosition.tail, .init(x: 3, y: 0))
        
        let nextStep = try XCTUnwrap(finalPosition
            .applyMotion(.init(direction: .up, amount: 1)).last)
        XCTAssertEqual(nextStep.head, .init(x: 4, y: -2))
        XCTAssertEqual(nextStep.tail, .init(x: 4, y: -1))
    }
    
    func testDistanceFrom() {
        XCTAssertEqual(Position.origin.distanceFrom(position: .origin),
                       .origin)
        
        XCTAssertEqual(Position.origin
            .distanceFrom(position: .init(x: 3, y: 3)),
                       .init(x: -3, y: -3))
        
        XCTAssertEqual(Position.origin
            .distanceFrom(position: .init(x: 3, y: 5)),
                       .init(x: -3, y: -5))
        
        XCTAssertEqual(Position(x: 3, y: 5).distanceFrom(position: .origin),
                       .init(x: 3, y: 5))
    }
}
