import XCTest
@testable import AdventOfCode

final class Day11Tests: XCTestCase, SolutionTest {
    typealias SUT = Day11
    
    func testInitialisation() {
        try XCTAssertEqual(sut.universe.width, 9)
        try XCTAssertEqual(sut.universe.height, 9)
        try XCTAssertEqual(
            sut.universe.galaxyLocations,
            [
                Coordinate(x: 3, y: 0),
                Coordinate(x: 7, y: 1),
                Coordinate(x: 0, y: 2),
                Coordinate(x: 6, y: 4),
                Coordinate(x: 1, y: 5),
                Coordinate(x: 9, y: 6),
                Coordinate(x: 7, y: 8),
                Coordinate(x: 0, y: 9),
                Coordinate(x: 4, y: 9),
            ]
        )
    }
    
    func testOutputString() {
        try XCTAssertEqual(
            sut.universe.description, """
            ...#......
            .......#..
            #.........
            ..........
            ......#...
            .#........
            .........#
            ..........
            .......#..
            #...#.....
            """
        )
    }
    
    func testExpand() {
        try XCTAssertEqual(
            sut.universe.expanded().description, """
            ....#........
            .........#...
            #............
            .............
            .............
            ........#....
            .#...........
            ............#
            .............
            .............
            .........#...
            #....#.......
            """
            
            
        )
    }
    
    func testFindGalaxies() {
        try XCTAssertEqual(
            sut.universe.expanded().galaxyLocations,
            [
                Coordinate(x: 4, y: 0),
                Coordinate(x: 9, y: 1),
                Coordinate(x: 0, y: 2),
                Coordinate(x: 8, y: 5),
                Coordinate(x: 1, y: 6),
                Coordinate(x: 12, y: 7),
                Coordinate(x: 9, y: 10),
                Coordinate(x: 0, y: 11),
                Coordinate(x: 5, y: 11),
            ]
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 374)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(
            sut.calculatePairLengths(age: 9),
            1_030
        )
        try XCTAssertEqual(
            sut.calculatePairLengths(age: 99),
            8_410
        )
    }
}
