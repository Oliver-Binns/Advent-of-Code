import XCTest
@testable import AdventOfCode

final class Day11Tests: XCTestCase, SolutionTest {
    let day = 11
    
    func testPartOne() throws {
        try XCTAssertEqual(Day11(input: getTestData()).calculatePartOne(), 37)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day11(input: getTestData()).calculatePartTwo(), 26)
    }
}

extension Day11Tests {
    func testExampleState() throws {
        let plane = try Day11(input: getTestData())
        
        plane.board()
        
        XCTAssertEqual(plane.state.string, """
        #.##.##.##
        #######.##
        #.#.#..#..
        ####.##.##
        #.##.##.##
        #.#####.##
        ..#.#.....
        ##########
        #.######.#
        #.#####.##
        """)
        
        plane.board()
        
        XCTAssertEqual(plane.state.string, """
        #.LL.L#.##
        #LLLLLL.L#
        L.L.L..L..
        #LLL.LL.L#
        #.LL.LL.LL
        #.LLLL#.##
        ..L.L.....
        #LLLLLLLL#
        #.LLLLLL.L
        #.#LLLL.##
        """)
        
        plane.board()
        
        XCTAssertEqual(plane.state.string, """
        #.##.L#.##
        #L###LL.L#
        L.#.#..#..
        #L##.##.L#
        #.##.LL.LL
        #.###L#.##
        ..#.#.....
        #L######L#
        #.LL###L.L
        #.#L###.##
        """)
    }
    
    func testExampleStatePartTwo() throws {
        let plane = try Day11(input: getTestData())
        
        plane.board(tolerance: 5, directlyAdjacent: false)
        
        XCTAssertEqual(plane.state.string, """
        #.##.##.##
        #######.##
        #.#.#..#..
        ####.##.##
        #.##.##.##
        #.#####.##
        ..#.#.....
        ##########
        #.######.#
        #.#####.##
        """)
        
        plane.board(tolerance: 5, directlyAdjacent: false)
        
        XCTAssertEqual(plane.state.string, """
        #.LL.LL.L#
        #LLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLL#
        #.LLLLLL.L
        #.LLLLL.L#
        """)
        
        plane.board(tolerance: 5, directlyAdjacent: false)
        
        XCTAssertEqual(plane.state.string, """
        #.L#.##.L#
        #L#####.LL
        L.#.#..#..
        ##L#.##.##
        #.##.#L.##
        #.#####.#L
        ..#.#.....
        LLL####LL#
        #.L#####.L
        #.L####.L#
        """)
        
        plane.board(tolerance: 5, directlyAdjacent: false)
        
        XCTAssertEqual(plane.state.string, """
        #.L#.L#.L#
        #LLLLLL.LL
        L.L.L..#..
        ##LL.LL.L#
        L.LL.LL.L#
        #.LLLLL.LL
        ..L.L.....
        LLLLLLLLL#
        #.LLLLL#.L
        #.L#LL#.L#
        """)
    }
}
