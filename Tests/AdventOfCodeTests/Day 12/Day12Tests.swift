import XCTest
@testable import AdventOfCode

final class Day12Tests: XCTestCase, SolutionTest {
    typealias SUT = Day12
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 31)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day12Tests {
    func testInitialisation() throws {
        try XCTAssertEqual(sut.initialState.map, .init([
            ["S", "a", "b", "q", "p", "o", "n", "m"],
            ["a", "b", "c", "r", "y", "x", "x", "l"],
            ["a", "c", "c", "s", "z", "E", "x", "k"],
            ["a", "c", "c", "t", "u", "v", "w", "j"],
            ["a", "b", "d", "e", "f", "g", "h", "i"]
        ]))
        try XCTAssertEqual(sut.initialState.map.height, 5)
        try XCTAssertEqual(sut.initialState.map.width, 8)
        
        try XCTAssertEqual(sut.initialState.visited, [.origin])
        try XCTAssertEqual(sut.initialState.goal, Position(x: 5, y: 2))
        
        try XCTAssertEqual(sut.initialState.routes, [0: [.origin]])
    }
    
    func testIterate() throws {
        let secondState = try sut.initialState.iterate()
        
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
        XCTAssertEqual(secondState.goal, Position(x: 5, y: 2))
        
        XCTAssertEqual(secondState.routes, [
            1: [.init(x: 0, y: 1), .init(x: 1, y: 0)]
        ])
    }
    
    func testBestRoute() {
        XCTAssertEqual(SUT.State(routes: [
            0: [.origin],
            1: [.origin, .origin, .origin],
            2: [.origin, .init(x: 0, y: 3)],
            3: [.origin, .origin, .origin, .origin, .origin]
        ], goal: .init(x: 0, y: 3)).bestRoute, 2)
    }
}
