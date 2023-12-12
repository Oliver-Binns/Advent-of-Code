import XCTest
@testable import AdventOfCode

final class Day10Tests: XCTestCase, SolutionTest {
    typealias SUT = Day10
    
    func testInitialisation() {
        try XCTAssertEqual(sut.map.description, """
        ..F7.
        .FJ|.
        SJ.L7
        |F--J
        LJ...
        """)
        try XCTAssertEqual(
            sut.map.startLocation,
            Coordinate(x: 0, y: 2)
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 8)
    }
    
    func testPartTwo() throws {
        XCTAssertEqual(
            SUT(input: """
            ...........
            .S-------7.
            .|F-----7|.
            .||.....||.
            .||.....||.
            .|L-7.F-J|.
            .|..|.|..|.
            .L--J.L--J.
            ...........
            """).calculatePartTwo(),
            4
        )
        
        XCTAssertEqual(
            SUT(input: """
            .F----7F7F7F7F-7....
            .|F--7||||||||FJ....
            .||.FJ||||||||L7....
            FJL7L7LJLJ||LJ.L-7..
            L--J.L7...LJS7F-7L7.
            ....F-J..F7FJ|L7L7L7
            ....L7.F7||L7|.L7L7|
            .....|FJLJ|FJ|F7|.LJ
            ....FJL-7.||.||||...
            ....L---J.LJ.LJLJ...
            """).calculatePartTwo(),
            8
        )
        
        XCTAssertEqual(
            SUT(input: """
            FF7FSF7F7F7F7F7F---7
            L|LJ||||||||||||F--J
            FL-7LJLJ||||||LJL-77
            F--JF--7||LJLJ7F7FJ-
            L---JF-JLJ.||-FJLJJ7
            |F|F-JF---7F7-L7L|7|
            |FFJF7L7F-JF7|JL---7
            7-L-JL7||F7|L7F-7F7|
            L.L7LFJ|||||FJL7||LJ
            L7JLJL-JLJLJL--JLJ.L
            """).calculatePartTwo(),
            10
        )
    }
}
