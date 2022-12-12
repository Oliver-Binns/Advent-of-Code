import XCTest
@testable import AdventOfCode

final class Day12Tests: XCTestCase, SolutionTest {
    typealias SUT = Day12
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 31)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 29)
    }
}

extension Day12Tests {
    func testInitialisation() throws {
        try XCTAssertEqual(sut.map, .init([
            ["S", "a", "b", "q", "p", "o", "n", "m"],
            ["a", "b", "c", "r", "y", "x", "x", "l"],
            ["a", "c", "c", "s", "z", "E", "x", "k"],
            ["a", "c", "c", "t", "u", "v", "w", "j"],
            ["a", "b", "d", "e", "f", "g", "h", "i"]
        ]))
        try XCTAssertEqual(sut.map.height, 5)
        try XCTAssertEqual(sut.map.width, 8)
    }
    
    func testCanMoveUpwards() throws {
        let map = try sut.map
        let origin = Position(x: 2, y: 1)
        XCTAssertTrue(map.canMove(from: origin, to: origin.up))
        XCTAssertTrue(map.canMove(from: origin, to: origin.left))
        XCTAssertTrue(map.canMove(from: origin, to: origin.down))
        XCTAssertFalse(map.canMove(from: origin, to: origin.right))
    }
    
    func testCanMoveDownwards() throws {
        let map = try sut.map
        let origin = Position(x: 3, y: 1)
        XCTAssertTrue(map.canMove(from: origin, to: origin.up,
                                  isClimbing: false))
        XCTAssertFalse(map.canMove(from: origin, to: origin.left,
                                  isClimbing: false))
        XCTAssertTrue(map.canMove(from: origin, to: origin.down,
                                  isClimbing: false))
        XCTAssertTrue(map.canMove(from: origin, to: origin.right,
                                   isClimbing: false))
    }
    
    func testState() throws {
        let map = try sut.map
        let position = try XCTUnwrap(map.findPosition(of: "S"))
        let initialState = SUT.State(map: map,
                                     startPosition: position)
        
        XCTAssertEqual(initialState.visited, [.origin])
        XCTAssertEqual(initialState.routes, [0: [.origin]])
    }
    
    func testIterate() throws {
        let map = try sut.map
        let position = try XCTUnwrap(map.findPosition(of: "S"))
        let secondState = SUT.State(map: map,
                                    startPosition: position).iterate()
        
        XCTAssertEqual(secondState.map, .init([
            ["S", "a", "b", "q", "p", "o", "n", "m"],
            ["a", "b", "c", "r", "y", "x", "x", "l"],
            ["a", "c", "c", "s", "z", "E", "x", "k"],
            ["a", "c", "c", "t", "u", "v", "w", "j"],
            ["a", "b", "d", "e", "f", "g", "h", "i"]
        ]))
        
        XCTAssertEqual(secondState.visited, [
            .origin, .init(x: 0, y: 1), .init(x: 1, y: 0)
        ])
        
        XCTAssertEqual(secondState.routes, [
            1: [.init(x: 0, y: 1), .init(x: 1, y: 0)]
        ])
    }
}
