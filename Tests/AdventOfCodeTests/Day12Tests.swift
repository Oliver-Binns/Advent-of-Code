import XCTest
@testable import AdventOfCode

fileprivate typealias Instruction = Day12.Instruction
fileprivate typealias Direction = Day12.Direction
fileprivate typealias Ship = Day12.Ship

final class Day12Tests: XCTestCase, SolutionTest {
    let day = 12
    
    func testPartOne() throws {
        try XCTAssertEqual(Day12(input: getTestData()).calculatePartOne(), 25)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day12(input: getTestData()).calculatePartTwo(), 0)
    }
}

extension Day12Tests {
    func testParsing() throws {
        let instructions = try Day12(input: getTestData()).instructions
        
        XCTAssertEqual(instructions.first?.direction, .forwards)
        XCTAssertEqual(instructions.first?.amount, 10)
        
        XCTAssertEqual(instructions.last?.direction, .forwards)
        XCTAssertEqual(instructions.last?.amount, 11)
        
        XCTAssertEqual(instructions.count, 5)
    }
    
    func testRotating() {
        XCTAssertEqual(Direction.east.rotated(by: .init(direction: .left, amount: 90)),
                       .north)
        
        XCTAssertEqual(Direction.east.rotated(by: .init(direction: .right, amount: 270)),
                       .north)
    }
    
    func testApplyingInstructions() {
        var ship = Ship()
        XCTAssertEqual(ship.orientation, .east)
        XCTAssertEqual(ship.xPosition, 0)
        XCTAssertEqual(ship.yPosition, 0)
        
        ship = ship.applyingInstruction(.init(direction: .forwards, amount: 10))
        XCTAssertEqual(ship.orientation, .east)
        XCTAssertEqual(ship.xPosition, 10)
        XCTAssertEqual(ship.yPosition, 0)
        
        ship = ship.applyingInstruction(.init(direction: .north, amount: 3))
        XCTAssertEqual(ship.orientation, .east)
        XCTAssertEqual(ship.xPosition, 10)
        XCTAssertEqual(ship.yPosition, 3)
        
        ship = ship.applyingInstruction(.init(direction: .forwards, amount: 7))
        XCTAssertEqual(ship.orientation, .east)
        XCTAssertEqual(ship.xPosition, 17)
        XCTAssertEqual(ship.yPosition, 3)
        
        ship = ship.applyingInstruction(.init(direction: .right, amount: 90))
        XCTAssertEqual(ship.orientation, .south)
        XCTAssertEqual(ship.xPosition, 17)
        XCTAssertEqual(ship.yPosition, 3)
        
        ship = ship.applyingInstruction(.init(direction: .forwards, amount: 11))
        XCTAssertEqual(ship.orientation, .south)
        XCTAssertEqual(ship.xPosition, 17)
        XCTAssertEqual(ship.yPosition, -8)
    }
}
