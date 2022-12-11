import XCTest
@testable import AdventOfCode

final class Day8Tests: XCTestCase, SolutionTest {
    typealias SUT = Day8
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 21)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 8)
    }
}

extension Day8Tests {
    func testInitialisation() throws {
        try XCTAssertEqual(sut.grid, [
            [
                Tree(x: 0, y: 0, height: 3),
                Tree(x: 1, y: 0, height: 0),
                Tree(x: 2, y: 0, height: 3),
                Tree(x: 3, y: 0, height: 7),
                Tree(x: 4, y: 0, height: 3)
            ],
            [
                Tree(x: 0, y: 1, height: 2),
                Tree(x: 1, y: 1, height: 5),
                Tree(x: 2, y: 1, height: 5),
                Tree(x: 3, y: 1, height: 1),
                Tree(x: 4, y: 1, height: 2)
            ],
            [
                Tree(x: 0, y: 2, height: 6),
                Tree(x: 1, y: 2, height: 5),
                Tree(x: 2, y: 2, height: 3),
                Tree(x: 3, y: 2, height: 3),
                Tree(x: 4, y: 2, height: 2)
            ],
            [
                Tree(x: 0, y: 3, height: 3),
                Tree(x: 1, y: 3, height: 3),
                Tree(x: 2, y: 3, height: 5),
                Tree(x: 3, y: 3, height: 4),
                Tree(x: 4, y: 3, height: 9)
            ],
            [
                Tree(x: 0, y: 4, height: 3),
                Tree(x: 1, y: 4, height: 5),
                Tree(x: 2, y: 4, height: 3),
                Tree(x: 3, y: 4, height: 9),
                Tree(x: 4, y: 4, height: 0)
            ]
        ])
    }
    
    func testVisibleFromEdge() throws {
        try XCTAssertEqual(sut.visibleFromEdge().symmetricDifference([
            Tree(x: 0, y: 0, height: 3),
            Tree(x: 1, y: 0, height: 0),
            Tree(x: 2, y: 0, height: 3),
            Tree(x: 3, y: 0, height: 7),
            Tree(x: 4, y: 0, height: 3),
            
            Tree(x: 0, y: 1, height: 2),
            Tree(x: 1, y: 1, height: 5),
            Tree(x: 2, y: 1, height: 5),
            Tree(x: 4, y: 1, height: 2),
            
            Tree(x: 0, y: 2, height: 6),
            Tree(x: 1, y: 2, height: 5),
            Tree(x: 3, y: 2, height: 3),
            Tree(x: 4, y: 2, height: 2),
            
            Tree(x: 0, y: 3, height: 3),
            Tree(x: 2, y: 3, height: 5),
            Tree(x: 4, y: 3, height: 9),
            
            Tree(x: 0, y: 4, height: 3),
            Tree(x: 1, y: 4, height: 5),
            Tree(x: 2, y: 4, height: 3),
            Tree(x: 3, y: 4, height: 9),
            Tree(x: 4, y: 4, height: 0)
        ]), [])
    }
    
    func testVisibleInDirectionFromX0Y0() throws {
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: 0, horizontal: 1),
                                fromX: 0, y: 0), [
                Tree(x: 1, y: 0, height: 0),
                Tree(x: 2, y: 0, height: 3)
            ])
        
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: 0, horizontal: -1), fromX: 0, y: 0), [])
        
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: 1, horizontal: 0),
                                fromX: 0, y: 0), [
                Tree(x: 0, y: 1, height: 2),
                Tree(x: 0, y: 2, height: 6)
            ])
        
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: -1, horizontal: 0), fromX: 0, y: 0), [])
    }
    
    func testVisibleInDirectionFromX2Y3() throws {
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: 0, horizontal: 1),
                                fromX: 2, y: 3), [
                Tree(x: 3, y: 3, height: 4),
                Tree(x: 4, y: 3, height: 9)
            ])
        
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: 0, horizontal: -1), fromX: 2, y: 3), [
                Tree(x: 1, y: 3, height: 3)
            ])
        
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: 1, horizontal: 0),
                                fromX: 2, y: 3), [
                Tree(x: 2, y: 4, height: 3)
            ])
        
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: -1, horizontal: 0),
                                fromX: 2, y: 3), [
                Tree(x: 2, y: 2, height: 3),
                Tree(x: 2, y: 1, height: 5)
            ])
    }
    
    func testVisibleInDirectionFromX3Y2() throws {
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: 0, horizontal: 1),
                                fromX: 3, y: 2), [
                Tree(x: 4, y: 2, height: 2)
            ])
        
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: 0, horizontal: -1),
                                fromX: 3, y: 2), [
                Tree(x: 2, y: 2, height: 3)
            ])
        
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: 1, horizontal: 0),
                                fromX: 3, y: 2), [
                Tree(x: 3, y: 3, height: 4)
            ])
        
        try XCTAssertEqual(sut
            .visibleInDirection(direction: (vertical: -1, horizontal: 0),
                                fromX: 3, y: 2), [
                Tree(x: 3, y: 1, height: 1),
                Tree(x: 3, y: 0, height: 7)
            ])
    }
    
    func testScenicScore() throws {
        try XCTAssertEqual(sut.scenicScore(atX: 2, y: 1), 4)
        try XCTAssertEqual(sut.scenicScore(atX: 2, y: 3), 8)
    }
}
